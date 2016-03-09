#include "schedos-kern.h"
#include "x86.h"
#include "lib.h"

/*****************************************************************************
 * schedos-kern
 *
 *   This is the schedos's kernel.
 *   It sets up process descriptors for the 4 applications, then runs
 *   them in some schedule.
 *
 *****************************************************************************/

// The program loader loads 4 processes, starting at PROC1_START, allocating
// 1 MB to each process.
// Each process's stack grows down from the top of its memory space.
// (But note that SchedOS processes, like MiniprocOS processes, are not fully
// isolated: any process could modify any part of memory.)

#define NPROCS		5
#define PROC1_START	0x200000
#define PROC_SIZE	0x100000

// +---------+-----------------------+--------+---------------------+---------/
// | Base    | Kernel         Kernel | Shared | App 0         App 0 | App 1
// | Memory  | Code + Data     Stack | Data   | Code + Data   Stack | Code ...
// +---------+-----------------------+--------+---------------------+---------/
// 0x0    0x100000               0x198000 0x200000              0x300000
//
// The program loader puts each application's starting instruction pointer
// at the very top of its stack.
//
// System-wide global variables shared among the kernel and the four
// applications are stored in memory from 0x198000 to 0x200000.  Currently
// there is just one variable there, 'cursorpos', which occupies the four
// bytes of memory 0x198000-0x198003.  You can add more variables by defining
// their addresses in schedos-symbols.ld; make sure they do not overlap!


// A process descriptor for each process.
// Note that proc_array[0] is never used.
// The first application process descriptor is proc_array[1].
static process_t proc_array[NPROCS];

// A pointer to the currently running process.
// This is kept up to date by the run() function, in mpos-x86.c.
process_t *current;

// The preferred scheduling algorithm.
int scheduling_algorithm;

// UNCOMMENT THESE LINES IF YOU DO EXERCISE 4.A
// Use these #defines to initialize your implementation.
// Changing one of these lines should change the initialization.
 #define __PRIORITY_1__ 1
 #define __PRIORITY_2__ 2
 #define __PRIORITY_3__ 3
 #define __PRIORITY_4__ 4

// UNCOMMENT THESE LINES IF YOU DO EXERCISE 4.B
// Use these #defines to initialize your implementation.
// Changing one of these lines should change the initialization.
// #define __SHARE_1__ 1
// #define __SHARE_2__ 2
// #define __SHARE_3__ 3
// #define __SHARE_4__ 4

// USE THESE VALUES FOR SETTING THE scheduling_algorithm VARIABLE.
#define __EXERCISE_1__   0  // the initial algorithm
#define __EXERCISE_2__   1  // strict priority scheduling (exercise 2)
#define __EXERCISE_4A__  2  // p_priority algorithm (exercise 4.a)
#define __EXERCISE_4B__  3  // p_share algorithm (exercise 4.b) For E.C.
#define __EXERCISE_7__   4  // Lottery Scheduling

// LOTTERY SCHEDULING VARIABLES
#define N_TICKETS NPROCS*100
pid_t lottery_tickets[N_TICKETS];
// Random Number Generator
static unsigned long int next_num = 1;
int rand_num( int max ) 
{
	next_num = next_num * 1024510653 + 12345;
	return (unsigned int)(next_num / 73345) % max;
}

/*****************************************************************************
 * start
 *
 *   Initialize the hardware and process descriptors, then run
 *   the first process.
 *
 *****************************************************************************/

void
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
	interrupt_controller_init(1);
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Guarantee each process will get at least 1 ticket
	// so it will be completed and get some percent of the 
	// processor quanta.
	int tickets_used = 0;
	for (i = 0; i < NPROCS; i++) {
		lottery_tickets[i] = proc_array[i].p_pid;
		tickets_used++;
	}
	
	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;

		// Initialize Priority Number
		proc->p_priority = 0;

		// Initialize Share Value & Count
		proc->p_share = 0;
		proc->p_share_count = 0;

		// Initialize Number of Tickets
		int rand = rand_num(N_TICKETS - tickets_used - 1);
		// If last process, give rest of available tickets
		// Not ideal, but simple way to implement lottery scheduling
		if(i == NPROCS-1) {
			rand = N_TICKETS - tickets_used;
		}
		int j;
		for (j = tickets_used; j < (tickets_used + rand); j++) {
			lottery_tickets[j] = proc->p_pid;
		}
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;

	// Initialize the scheduling algorithm.
	// USE THE FOLLOWING VALUES:
	//    0 = round robin scheduling (original)
	//    1 = strict priority scheduling (exercise 2)
	//    2 = p_priority algorithm (exercise 4.a)
	//    3 = p_share algorithm (exercise 4.b) [For Extra Credit]
	//    4 = Lottery Scheduling
	scheduling_algorithm = 3;

	// Switch to the first process.
	run(&proc_array[1]);

	// Should never get here!
	while (1)
		/* do nothing */;
}



/*****************************************************************************
 * interrupt
 *
 *   This is the weensy interrupt and system call handler.
 *   The current handler handles 4 different system calls (two of which
 *   do nothing), plus the clock interrupt.
 *
 *   Note that we will never receive clock interrupts while in the kernel.
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;

	switch (reg->reg_intno) {

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();

	case INT_SYS_EXIT:
		// 'sys_exit' exits the current process: it is marked as
		// non-runnable.
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
		current->p_exit_status = reg->reg_eax;
		schedule();

	case INT_SYS_PRIORITY: // Handler for sys_priority()
		current->p_priority = reg->reg_eax;
		run(current);

	case INT_SYS_WRITE: // Handler for sys_print()
		*cursorpos++ = reg->reg_eax;
		run(current);
	
	case INT_SYS_SHARE:
		current->p_share = reg->reg_eax;
		run(current);

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();

	default:
		while (1)
			/* do nothing */;

	}
}



/*****************************************************************************
 * schedule
 *
 *   This is the weensy process scheduler.
 *   It picks a runnable process, then context-switches to that process.
 *   If there are no runnable processes, it spins forever.
 *
 *   This function implements multiple scheduling algorithms, depending on
 *   the value of 'scheduling_algorithm'.  We've provided one; in the problem
 *   set you will provide at least one more.
 *
 *****************************************************************************/

void
schedule(void)
{
	pid_t pid = current->p_pid;
	if (scheduling_algorithm == 0) // Round Robin
		while (1) {
			pid = (pid + 1) % NPROCS;

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
				run(&proc_array[pid]);
		}
	if (scheduling_algorithm == 1) // Strict Priority
		while (1) {
			pid = 1;
			while (proc_array[pid].p_state != P_RUNNABLE)
				pid = (pid + 1) % NPROCS;
			while (proc_array[pid].p_state == P_RUNNABLE) 
				run(&proc_array[pid]);
			
		}	
	if (scheduling_algorithm == 2) // Strict Priority Number Based Priority Scheduling
		while (1) {
			// Variable to iterate through Processes
			pid_t new = 0;
			// Set to the lowest priority value;
			int n_priority = 4;
			// Keep iterating until you find a process with the lowest priority #
			// If more than one has the same priority #, it will run() the first one
			// and schedule() will return to this function with the same pid.
			// schedule will then increment the pid. This guarantees that you won't
			// keep running the same process if there is more than one proc. with the 	
			// same priority #.
			pid = (pid + 1) % NPROCS;

			// Find the currently highest priority #
			while (new < NPROCS) {
				if (proc_array[new].p_state == P_RUNNABLE)
					if (proc_array[new].p_priority < n_priority)
						n_priority = proc_array[new].p_priority;
				new++;
			}
				
			/*for (new = 0; new < NPROCS; new++) {
				if ( (proc_array[new].p_state == P_RUNNABLE) && (proc_array[new].p_priority < n_priority) )
					n_priority = proc_array[new].p_priority;
			}*/
			
			// If the current pid is Runnable and has the right priority #, run() it.
			if (proc_array[pid].p_state == P_RUNNABLE)
				if (proc_array[pid].p_priority <= n_priority) 
					run(&proc_array[pid]);

		}
	if (scheduling_algorithm == 3) 
		while (1) {
			process_t *proc;
			// Get a runnable process
			while( (proc = &proc_array[pid])->p_state!=P_RUNNABLE )
				pid = (pid + 1) % NPROCS;
		
			// If process share isn't used up yet,
			// run it & increment the share count
			if (proc->p_share_count < proc->p_share) {
				proc->p_share_count = proc->p_share_count+1;
				run(proc);
			}else { 
				// process share count is used up
				proc->p_share_count = 0;
			}
			pid = (pid + 1) % NPROCS;

		}
	if (scheduling_algorithm == 4) //Lottery Scheduling
		while (1) {
			int rand = rand_num(N_TICKETS);
			process_t *proc;
			if ((proc = &proc_array[lottery_tickets[rand]])->p_state==P_RUNNABLE)
				run(proc);
			
		}
	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
	while (1)
		/* do nothing */;
}
