
obj/schedos-kern:     file format elf32-i386


Disassembly of section .text:

00100000 <multiboot>:
  100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
  100006:	00 00                	add    %al,(%eax)
  100008:	fe 4f 52             	decb   0x52(%edi)
  10000b:	e4 bc                	in     $0xbc,%al

0010000c <multiboot_start>:
# The multiboot_start routine sets the stack pointer to the top of the
# SchedOS's kernel stack, then jumps to the 'start' routine in schedos-kern.c.

.globl multiboot_start
multiboot_start:
	movl $0x180000, %esp
  10000c:	bc 00 00 18 00       	mov    $0x180000,%esp
	pushl $0
  100011:	6a 00                	push   $0x0
	popfl
  100013:	9d                   	popf   
	call start
  100014:	e8 39 02 00 00       	call   100252 <start>
  100019:	90                   	nop

0010001a <clock_int_handler>:
# Interrupt handlers
.align 2

	.globl clock_int_handler
clock_int_handler:
	pushl $0		// error code
  10001a:	6a 00                	push   $0x0
	pushl $32		// trap number
  10001c:	6a 20                	push   $0x20
	jmp _generic_int_handler
  10001e:	eb 40                	jmp    100060 <_generic_int_handler>

00100020 <sys_int48_handler>:

sys_int48_handler:
	pushl $0
  100020:	6a 00                	push   $0x0
	pushl $48
  100022:	6a 30                	push   $0x30
	jmp _generic_int_handler
  100024:	eb 3a                	jmp    100060 <_generic_int_handler>

00100026 <sys_int49_handler>:

sys_int49_handler:
	pushl $0
  100026:	6a 00                	push   $0x0
	pushl $49
  100028:	6a 31                	push   $0x31
	jmp _generic_int_handler
  10002a:	eb 34                	jmp    100060 <_generic_int_handler>

0010002c <sys_int50_handler>:

sys_int50_handler:
	pushl $0
  10002c:	6a 00                	push   $0x0
	pushl $50
  10002e:	6a 32                	push   $0x32
	jmp _generic_int_handler
  100030:	eb 2e                	jmp    100060 <_generic_int_handler>

00100032 <sys_int51_handler>:

sys_int51_handler:
	pushl $0
  100032:	6a 00                	push   $0x0
	pushl $51
  100034:	6a 33                	push   $0x33
	jmp _generic_int_handler
  100036:	eb 28                	jmp    100060 <_generic_int_handler>

00100038 <sys_int52_handler>:

sys_int52_handler:
	pushl $0
  100038:	6a 00                	push   $0x0
	pushl $52
  10003a:	6a 34                	push   $0x34
	jmp _generic_int_handler
  10003c:	eb 22                	jmp    100060 <_generic_int_handler>

0010003e <sys_int53_handler>:

sys_int53_handler:
	pushl $0
  10003e:	6a 00                	push   $0x0
	pushl $53
  100040:	6a 35                	push   $0x35
	jmp _generic_int_handler
  100042:	eb 1c                	jmp    100060 <_generic_int_handler>

00100044 <sys_int54_handler>:

sys_int54_handler:
	pushl $0
  100044:	6a 00                	push   $0x0
	pushl $54
  100046:	6a 36                	push   $0x36
	jmp _generic_int_handler
  100048:	eb 16                	jmp    100060 <_generic_int_handler>

0010004a <sys_int55_handler>:

sys_int55_handler:
	pushl $0
  10004a:	6a 00                	push   $0x0
	pushl $55
  10004c:	6a 37                	push   $0x37
	jmp _generic_int_handler
  10004e:	eb 10                	jmp    100060 <_generic_int_handler>

00100050 <sys_int56_handler>:

sys_int56_handler:
	pushl $0
  100050:	6a 00                	push   $0x0
	pushl $56
  100052:	6a 38                	push   $0x38
	jmp _generic_int_handler
  100054:	eb 0a                	jmp    100060 <_generic_int_handler>

00100056 <sys_int57_handler>:

sys_int57_handler:
	pushl $0
  100056:	6a 00                	push   $0x0
	pushl $57
  100058:	6a 39                	push   $0x39
	jmp _generic_int_handler
  10005a:	eb 04                	jmp    100060 <_generic_int_handler>

0010005c <default_int_handler>:

	.globl default_int_handler
default_int_handler:
	pushl $0
  10005c:	6a 00                	push   $0x0
	jmp _generic_int_handler
  10005e:	eb 00                	jmp    100060 <_generic_int_handler>

00100060 <_generic_int_handler>:
	# When we get here, the processor's interrupt mechanism has
	# pushed the old task status and stack registers onto the kernel stack.
	# Then one of the specific handlers pushed the trap number.
	# Now, we complete the 'registers_t' structure by pushing the extra
	# segment definitions and the general CPU registers.
	pushl %ds
  100060:	1e                   	push   %ds
	pushl %es
  100061:	06                   	push   %es
	pushal
  100062:	60                   	pusha  

	# Load the kernel's data segments into the extra segment registers
	# (although we don't use those extra segments!).
	movl $0x10, %eax
  100063:	b8 10 00 00 00       	mov    $0x10,%eax
	movw %ax, %ds
  100068:	8e d8                	mov    %eax,%ds
	movw %ax, %es
  10006a:	8e c0                	mov    %eax,%es

	# Call the kernel's 'interrupt' function.
	pushl %esp
  10006c:	54                   	push   %esp
	call interrupt
  10006d:	e8 58 01 00 00       	call   1001ca <interrupt>

00100072 <sys_int_handlers>:
  100072:	20 00                	and    %al,(%eax)
  100074:	10 00                	adc    %al,(%eax)
  100076:	26 00 10             	add    %dl,%es:(%eax)
  100079:	00 2c 00             	add    %ch,(%eax,%eax,1)
  10007c:	10 00                	adc    %al,(%eax)
  10007e:	32 00                	xor    (%eax),%al
  100080:	10 00                	adc    %al,(%eax)
  100082:	38 00                	cmp    %al,(%eax)
  100084:	10 00                	adc    %al,(%eax)
  100086:	3e 00 10             	add    %dl,%ds:(%eax)
  100089:	00 44 00 10          	add    %al,0x10(%eax,%eax,1)
  10008d:	00 4a 00             	add    %cl,0x0(%edx)
  100090:	10 00                	adc    %al,(%eax)
  100092:	50                   	push   %eax
  100093:	00 10                	add    %dl,(%eax)
  100095:	00 56 00             	add    %dl,0x0(%esi)
  100098:	10 00                	adc    %al,(%eax)
  10009a:	90                   	nop
  10009b:	90                   	nop

0010009c <rand_num>:
pid_t lottery_tickets[N_TICKETS];
// Random Number Generator
static unsigned long int next_num = 1;
int rand_num( int max ) 
{
	next_num = next_num * 1024510653 + 12345;
  10009c:	69 05 e4 1b 10 00 bd 	imul   $0x3d10cabd,0x101be4,%eax
  1000a3:	ca 10 3d 
  1000a6:	b9 81 1e 01 00       	mov    $0x11e81,%ecx
  1000ab:	31 d2                	xor    %edx,%edx
  1000ad:	05 39 30 00 00       	add    $0x3039,%eax
  1000b2:	a3 e4 1b 10 00       	mov    %eax,0x101be4
  1000b7:	f7 f1                	div    %ecx
  1000b9:	31 d2                	xor    %edx,%edx
  1000bb:	f7 74 24 04          	divl   0x4(%esp)
	return (unsigned int)(next_num / 73345) % max;
}
  1000bf:	89 d0                	mov    %edx,%eax
  1000c1:	c3                   	ret    

001000c2 <schedule>:
 *****************************************************************************/

void
schedule(void)
{
	pid_t pid = current->p_pid;
  1000c2:	a1 80 8c 10 00       	mov    0x108c80,%eax
 *
 *****************************************************************************/

void
schedule(void)
{
  1000c7:	57                   	push   %edi
  1000c8:	56                   	push   %esi
  1000c9:	53                   	push   %ebx
	pid_t pid = current->p_pid;
  1000ca:	8b 18                	mov    (%eax),%ebx
	if (scheduling_algorithm == 0) // Round Robin
  1000cc:	a1 84 8c 10 00       	mov    0x108c84,%eax
  1000d1:	85 c0                	test   %eax,%eax
  1000d3:	75 1b                	jne    1000f0 <schedule+0x2e>
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000d5:	b9 05 00 00 00       	mov    $0x5,%ecx
  1000da:	8d 43 01             	lea    0x1(%ebx),%eax
  1000dd:	99                   	cltd   
  1000de:	f7 f9                	idiv   %ecx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000e0:	6b c2 54             	imul   $0x54,%edx,%eax
schedule(void)
{
	pid_t pid = current->p_pid;
	if (scheduling_algorithm == 0) // Round Robin
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000e3:	89 d3                	mov    %edx,%ebx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000e5:	83 b8 f0 7a 10 00 01 	cmpl   $0x1,0x107af0(%eax)
  1000ec:	75 ec                	jne    1000da <schedule+0x18>
  1000ee:	eb 23                	jmp    100113 <schedule+0x51>
				run(&proc_array[pid]);
		}
	if (scheduling_algorithm == 1) // Strict Priority
  1000f0:	83 f8 01             	cmp    $0x1,%eax
  1000f3:	75 2b                	jne    100120 <schedule+0x5e>
  1000f5:	ba 01 00 00 00       	mov    $0x1,%edx
		while (1) {
			pid = 1;
			while (proc_array[pid].p_state != P_RUNNABLE)
				pid = (pid + 1) % NPROCS;
  1000fa:	b9 05 00 00 00       	mov    $0x5,%ecx
  1000ff:	eb 06                	jmp    100107 <schedule+0x45>
  100101:	8d 42 01             	lea    0x1(%edx),%eax
  100104:	99                   	cltd   
  100105:	f7 f9                	idiv   %ecx
				run(&proc_array[pid]);
		}
	if (scheduling_algorithm == 1) // Strict Priority
		while (1) {
			pid = 1;
			while (proc_array[pid].p_state != P_RUNNABLE)
  100107:	6b c2 54             	imul   $0x54,%edx,%eax
  10010a:	83 b8 f0 7a 10 00 01 	cmpl   $0x1,0x107af0(%eax)
  100111:	75 ee                	jne    100101 <schedule+0x3f>
				pid = (pid + 1) % NPROCS;
			while (proc_array[pid].p_state == P_RUNNABLE) 
				run(&proc_array[pid]);
  100113:	83 ec 0c             	sub    $0xc,%esp
  100116:	05 a4 7a 10 00       	add    $0x107aa4,%eax
  10011b:	e9 83 00 00 00       	jmp    1001a3 <schedule+0xe1>
			
		}	
	if (scheduling_algorithm == 2) // Strict Priority Number Based Priority Scheduling
  100120:	83 f8 02             	cmp    $0x2,%eax
  100123:	75 53                	jne    100178 <schedule+0xb6>
			// If more than one has the same priority #, it will run() the first one
			// and schedule() will return to this function with the same pid.
			// schedule will then increment the pid. This guarantees that you won't
			// keep running the same process if there is more than one proc. with the 	
			// same priority #.
			pid = (pid + 1) % NPROCS;
  100125:	b9 05 00 00 00       	mov    $0x5,%ecx
  10012a:	8d 43 01             	lea    0x1(%ebx),%eax
  10012d:	be 04 00 00 00       	mov    $0x4,%esi
  100132:	99                   	cltd   
  100133:	f7 f9                	idiv   %ecx
  100135:	31 c0                	xor    %eax,%eax
  100137:	89 d3                	mov    %edx,%ebx

			// Find the currently highest priority #
			while (new < NPROCS) {
				if (proc_array[new].p_state == P_RUNNABLE)
  100139:	83 b8 f0 7a 10 00 01 	cmpl   $0x1,0x107af0(%eax)
  100140:	75 0c                	jne    10014e <schedule+0x8c>
  100142:	8b b8 a8 7a 10 00    	mov    0x107aa8(%eax),%edi
  100148:	39 fe                	cmp    %edi,%esi
  10014a:	7e 02                	jle    10014e <schedule+0x8c>
  10014c:	89 fe                	mov    %edi,%esi
  10014e:	83 c0 54             	add    $0x54,%eax
			// keep running the same process if there is more than one proc. with the 	
			// same priority #.
			pid = (pid + 1) % NPROCS;

			// Find the currently highest priority #
			while (new < NPROCS) {
  100151:	3d a4 01 00 00       	cmp    $0x1a4,%eax
  100156:	75 e1                	jne    100139 <schedule+0x77>
				if ( (proc_array[new].p_state == P_RUNNABLE) && (proc_array[new].p_priority < n_priority) )
					n_priority = proc_array[new].p_priority;
			}*/
			
			// If the current pid is Runnable and has the right priority #, run() it.
			if (proc_array[pid].p_state == P_RUNNABLE)
  100158:	6b d2 54             	imul   $0x54,%edx,%edx
  10015b:	83 ba f0 7a 10 00 01 	cmpl   $0x1,0x107af0(%edx)
  100162:	75 c6                	jne    10012a <schedule+0x68>
				if (proc_array[pid].p_priority <= n_priority) 
  100164:	39 b2 a8 7a 10 00    	cmp    %esi,0x107aa8(%edx)
  10016a:	7f be                	jg     10012a <schedule+0x68>
					run(&proc_array[pid]);
  10016c:	83 ec 0c             	sub    $0xc,%esp
  10016f:	81 c2 a4 7a 10 00    	add    $0x107aa4,%edx
  100175:	52                   	push   %edx
  100176:	eb 2c                	jmp    1001a4 <schedule+0xe2>

		}
	if (scheduling_algorithm == 4)
  100178:	83 f8 04             	cmp    $0x4,%eax
  10017b:	75 2c                	jne    1001a9 <schedule+0xe7>
		while (1) {
			int rand = rand_num(N_TICKETS);
  10017d:	83 ec 0c             	sub    $0xc,%esp
  100180:	68 f4 01 00 00       	push   $0x1f4
  100185:	e8 12 ff ff ff       	call   10009c <rand_num>
			process_t *proc;
			if ((proc = &proc_array[lottery_tickets[rand]])->p_state==P_RUNNABLE)
  10018a:	83 c4 10             	add    $0x10,%esp
  10018d:	6b 04 85 b0 84 10 00 	imul   $0x54,0x1084b0(,%eax,4),%eax
  100194:	54 
  100195:	05 a4 7a 10 00       	add    $0x107aa4,%eax
  10019a:	83 78 4c 01          	cmpl   $0x1,0x4c(%eax)
  10019e:	75 dd                	jne    10017d <schedule+0xbb>
				run(proc);
  1001a0:	83 ec 0c             	sub    $0xc,%esp
  1001a3:	50                   	push   %eax
  1001a4:	e8 28 04 00 00       	call   1005d1 <run>
			
		}
	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  1001a9:	8b 15 00 80 19 00    	mov    0x198000,%edx
  1001af:	50                   	push   %eax
  1001b0:	68 90 0b 10 00       	push   $0x100b90
  1001b5:	68 00 01 00 00       	push   $0x100
  1001ba:	52                   	push   %edx
  1001bb:	e8 b6 09 00 00       	call   100b76 <console_printf>
  1001c0:	83 c4 10             	add    $0x10,%esp
  1001c3:	a3 00 80 19 00       	mov    %eax,0x198000
  1001c8:	eb fe                	jmp    1001c8 <schedule+0x106>

001001ca <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  1001ca:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  1001cb:	a1 80 8c 10 00       	mov    0x108c80,%eax
  1001d0:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  1001d5:	56                   	push   %esi
  1001d6:	53                   	push   %ebx
  1001d7:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  1001db:	8d 78 08             	lea    0x8(%eax),%edi
  1001de:	89 de                	mov    %ebx,%esi
  1001e0:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  1001e2:	8b 53 28             	mov    0x28(%ebx),%edx
  1001e5:	83 fa 31             	cmp    $0x31,%edx
  1001e8:	74 1f                	je     100209 <interrupt+0x3f>
  1001ea:	77 0c                	ja     1001f8 <interrupt+0x2e>
  1001ec:	83 fa 20             	cmp    $0x20,%edx
  1001ef:	74 5a                	je     10024b <interrupt+0x81>
  1001f1:	83 fa 30             	cmp    $0x30,%edx
  1001f4:	74 0e                	je     100204 <interrupt+0x3a>
  1001f6:	eb 58                	jmp    100250 <interrupt+0x86>
  1001f8:	83 fa 32             	cmp    $0x32,%edx
  1001fb:	74 23                	je     100220 <interrupt+0x56>
  1001fd:	83 fa 33             	cmp    $0x33,%edx
  100200:	74 2b                	je     10022d <interrupt+0x63>
  100202:	eb 4c                	jmp    100250 <interrupt+0x86>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  100204:	e8 b9 fe ff ff       	call   1000c2 <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100209:	a1 80 8c 10 00       	mov    0x108c80,%eax
		current->p_exit_status = reg->reg_eax;
  10020e:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100211:	c7 40 4c 03 00 00 00 	movl   $0x3,0x4c(%eax)
		current->p_exit_status = reg->reg_eax;
  100218:	89 50 50             	mov    %edx,0x50(%eax)
		schedule();
  10021b:	e8 a2 fe ff ff       	call   1000c2 <schedule>

	case INT_SYS_PRIORITY: // Handler for sys_priority()
		current->p_priority = reg->reg_eax;
  100220:	a1 80 8c 10 00       	mov    0x108c80,%eax
  100225:	8b 53 1c             	mov    0x1c(%ebx),%edx
  100228:	89 50 04             	mov    %edx,0x4(%eax)
  10022b:	eb 15                	jmp    100242 <interrupt+0x78>
		run(current);

	case INT_SYS_WRITE: // Handler for sys_print()
		*cursorpos++ = reg->reg_eax;
  10022d:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100233:	8b 4b 1c             	mov    0x1c(%ebx),%ecx
  100236:	66 89 0a             	mov    %cx,(%edx)
  100239:	83 c2 02             	add    $0x2,%edx
  10023c:	89 15 00 80 19 00    	mov    %edx,0x198000
		run(current);
  100242:	83 ec 0c             	sub    $0xc,%esp
  100245:	50                   	push   %eax
  100246:	e8 86 03 00 00       	call   1005d1 <run>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  10024b:	e8 72 fe ff ff       	call   1000c2 <schedule>
  100250:	eb fe                	jmp    100250 <interrupt+0x86>

00100252 <start>:
 *
 *****************************************************************************/

void
start(void)
{
  100252:	57                   	push   %edi
	// Guarantee each process will get at least 1 ticket
	// so it will be completed and get some percent of the 
	// processor quanta.
	int tickets_used = 0;
	for (i = 0; i < NPROCS; i++) {
		lottery_tickets[i] = proc_array[i].p_pid;
  100253:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  100258:	56                   	push   %esi
	// Guarantee each process will get at least 1 ticket
	// so it will be completed and get some percent of the 
	// processor quanta.
	int tickets_used = 0;
	for (i = 0; i < NPROCS; i++) {
		lottery_tickets[i] = proc_array[i].p_pid;
  100259:	be 01 00 00 00       	mov    $0x1,%esi
 *
 *****************************************************************************/

void
start(void)
{
  10025e:	53                   	push   %ebx
	// Guarantee each process will get at least 1 ticket
	// so it will be completed and get some percent of the 
	// processor quanta.
	int tickets_used = 0;
	for (i = 0; i < NPROCS; i++) {
		lottery_tickets[i] = proc_array[i].p_pid;
  10025f:	bb f8 7a 10 00       	mov    $0x107af8,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  100264:	e8 47 01 00 00       	call   1003b0 <segments_init>
	interrupt_controller_init(0);
  100269:	83 ec 0c             	sub    $0xc,%esp
  10026c:	6a 00                	push   $0x0
  10026e:	e8 38 02 00 00       	call   1004ab <interrupt_controller_init>
	console_clear();
  100273:	e8 bc 02 00 00       	call   100534 <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  100278:	83 c4 0c             	add    $0xc,%esp
  10027b:	68 a4 01 00 00       	push   $0x1a4
  100280:	6a 00                	push   $0x0
  100282:	68 a4 7a 10 00       	push   $0x107aa4
  100287:	e8 88 04 00 00       	call   100714 <memset>
	// Guarantee each process will get at least 1 ticket
	// so it will be completed and get some percent of the 
	// processor quanta.
	int tickets_used = 0;
	for (i = 0; i < NPROCS; i++) {
		lottery_tickets[i] = proc_array[i].p_pid;
  10028c:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10028f:	c7 05 a4 7a 10 00 00 	movl   $0x0,0x107aa4
  100296:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100299:	c7 05 f0 7a 10 00 00 	movl   $0x0,0x107af0
  1002a0:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002a3:	c7 05 f8 7a 10 00 01 	movl   $0x1,0x107af8
  1002aa:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002ad:	c7 05 44 7b 10 00 00 	movl   $0x0,0x107b44
  1002b4:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002b7:	c7 05 4c 7b 10 00 02 	movl   $0x2,0x107b4c
  1002be:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002c1:	c7 05 98 7b 10 00 00 	movl   $0x0,0x107b98
  1002c8:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002cb:	c7 05 a0 7b 10 00 03 	movl   $0x3,0x107ba0
  1002d2:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002d5:	c7 05 ec 7b 10 00 00 	movl   $0x0,0x107bec
  1002dc:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002df:	c7 05 f4 7b 10 00 04 	movl   $0x4,0x107bf4
  1002e6:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002e9:	c7 05 40 7c 10 00 00 	movl   $0x0,0x107c40
  1002f0:	00 00 00 
	// Guarantee each process will get at least 1 ticket
	// so it will be completed and get some percent of the 
	// processor quanta.
	int tickets_used = 0;
	for (i = 0; i < NPROCS; i++) {
		lottery_tickets[i] = proc_array[i].p_pid;
  1002f3:	c7 05 b0 84 10 00 00 	movl   $0x0,0x1084b0
  1002fa:	00 00 00 
  1002fd:	c7 05 b4 84 10 00 01 	movl   $0x1,0x1084b4
  100304:	00 00 00 
  100307:	c7 05 b8 84 10 00 02 	movl   $0x2,0x1084b8
  10030e:	00 00 00 
  100311:	c7 05 bc 84 10 00 03 	movl   $0x3,0x1084bc
  100318:	00 00 00 
  10031b:	c7 05 c0 84 10 00 04 	movl   $0x4,0x1084c0
  100322:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  100325:	83 ec 0c             	sub    $0xc,%esp
  100328:	53                   	push   %ebx
  100329:	e8 ba 02 00 00       	call   1005e8 <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  10032e:	58                   	pop    %eax
  10032f:	5a                   	pop    %edx
  100330:	8d 43 38             	lea    0x38(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  100333:	89 7b 44             	mov    %edi,0x44(%ebx)

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100336:	50                   	push   %eax
  100337:	8d 46 ff             	lea    -0x1(%esi),%eax
  10033a:	50                   	push   %eax
  10033b:	e8 e4 02 00 00       	call   100624 <program_loader>

		// Initialize Priority Number
		proc->p_priority = 0;

		// Initialize Number of Tickets
		int rand = rand_num(N_TICKETS - tickets_used - 1);
  100340:	c7 04 24 ee 01 00 00 	movl   $0x1ee,(%esp)

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100347:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)

		// Initialize Priority Number
		proc->p_priority = 0;
  10034e:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)

		// Initialize Number of Tickets
		int rand = rand_num(N_TICKETS - tickets_used - 1);
  100355:	e8 42 fd ff ff       	call   10009c <rand_num>
		// If last process, give rest of available tickets
		// Not ideal, but simple way to implement lottery scheduling
		if(i == NPROCS-1) {
  10035a:	83 c4 10             	add    $0x10,%esp
  10035d:	83 fe 04             	cmp    $0x4,%esi
  100360:	75 05                	jne    100367 <start+0x115>
  100362:	b8 ef 01 00 00       	mov    $0x1ef,%eax
  100367:	ba 05 00 00 00       	mov    $0x5,%edx
			rand = N_TICKETS - tickets_used;
		}
		int j;
		for (j = tickets_used; j < (tickets_used + rand); j++) {
  10036c:	83 c0 05             	add    $0x5,%eax
  10036f:	eb 0a                	jmp    10037b <start+0x129>
			lottery_tickets[j] = proc->p_pid;
  100371:	8b 0b                	mov    (%ebx),%ecx
  100373:	89 0c 95 b0 84 10 00 	mov    %ecx,0x1084b0(,%edx,4)
		// Not ideal, but simple way to implement lottery scheduling
		if(i == NPROCS-1) {
			rand = N_TICKETS - tickets_used;
		}
		int j;
		for (j = tickets_used; j < (tickets_used + rand); j++) {
  10037a:	42                   	inc    %edx
  10037b:	39 c2                	cmp    %eax,%edx
  10037d:	7c f2                	jl     100371 <start+0x11f>
		lottery_tickets[i] = proc_array[i].p_pid;
		tickets_used++;
	}
	
	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  10037f:	46                   	inc    %esi
  100380:	83 c3 54             	add    $0x54,%ebx
  100383:	81 c7 00 00 10 00    	add    $0x100000,%edi
  100389:	83 fe 05             	cmp    $0x5,%esi
  10038c:	75 97                	jne    100325 <start+0xd3>
	//   42 = p_share algorithm (exercise 4.b)
	//    4 = Lottery Scheduling
	scheduling_algorithm = 4;

	// Switch to the first process.
	run(&proc_array[1]);
  10038e:	83 ec 0c             	sub    $0xc,%esp
  100391:	68 f8 7a 10 00       	push   $0x107af8
		}
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  100396:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  10039d:	80 0b 00 
	//    0 = round robin scheduling (original)
	//    1 = strict priority scheduling (exercise 2)
	//    2 = p_priority algorithm (exercise 4.a)
	//   42 = p_share algorithm (exercise 4.b)
	//    4 = Lottery Scheduling
	scheduling_algorithm = 4;
  1003a0:	c7 05 84 8c 10 00 04 	movl   $0x4,0x108c84
  1003a7:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  1003aa:	e8 22 02 00 00       	call   1005d1 <run>
  1003af:	90                   	nop

001003b0 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003b0:	b8 48 7c 10 00       	mov    $0x107c48,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003b5:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003ba:	89 c2                	mov    %eax,%edx
  1003bc:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  1003bf:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003c0:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  1003c5:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003c8:	66 a3 22 1c 10 00    	mov    %ax,0x101c22
  1003ce:	c1 e8 18             	shr    $0x18,%eax
  1003d1:	88 15 24 1c 10 00    	mov    %dl,0x101c24
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003d7:	ba b0 7c 10 00       	mov    $0x107cb0,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003dc:	a2 27 1c 10 00       	mov    %al,0x101c27
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003e1:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003e3:	66 c7 05 20 1c 10 00 	movw   $0x68,0x101c20
  1003ea:	68 00 
  1003ec:	c6 05 26 1c 10 00 40 	movb   $0x40,0x101c26
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  1003f3:	c6 05 25 1c 10 00 89 	movb   $0x89,0x101c25

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  1003fa:	c7 05 4c 7c 10 00 00 	movl   $0x180000,0x107c4c
  100401:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  100404:	66 c7 05 50 7c 10 00 	movw   $0x10,0x107c50
  10040b:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10040d:	66 89 0c c5 b0 7c 10 	mov    %cx,0x107cb0(,%eax,8)
  100414:	00 
  100415:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  10041c:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100421:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  100426:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  10042b:	40                   	inc    %eax
  10042c:	3d 00 01 00 00       	cmp    $0x100,%eax
  100431:	75 da                	jne    10040d <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100433:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100438:	ba b0 7c 10 00       	mov    $0x107cb0,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  10043d:	66 a3 b0 7d 10 00    	mov    %ax,0x107db0
  100443:	c1 e8 10             	shr    $0x10,%eax
  100446:	66 a3 b6 7d 10 00    	mov    %ax,0x107db6
  10044c:	b8 30 00 00 00       	mov    $0x30,%eax
  100451:	66 c7 05 b2 7d 10 00 	movw   $0x8,0x107db2
  100458:	08 00 
  10045a:	c6 05 b4 7d 10 00 00 	movb   $0x0,0x107db4
  100461:	c6 05 b5 7d 10 00 8e 	movb   $0x8e,0x107db5

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100468:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  10046f:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100476:	66 89 0c c5 b0 7c 10 	mov    %cx,0x107cb0(,%eax,8)
  10047d:	00 
  10047e:	c1 e9 10             	shr    $0x10,%ecx
  100481:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100486:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  10048b:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  100490:	40                   	inc    %eax
  100491:	83 f8 3a             	cmp    $0x3a,%eax
  100494:	75 d2                	jne    100468 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  100496:	b0 28                	mov    $0x28,%al
  100498:	0f 01 15 e8 1b 10 00 	lgdtl  0x101be8
  10049f:	0f 00 d8             	ltr    %ax
  1004a2:	0f 01 1d f0 1b 10 00 	lidtl  0x101bf0
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  1004a9:	5b                   	pop    %ebx
  1004aa:	c3                   	ret    

001004ab <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  1004ab:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  1004ac:	b0 ff                	mov    $0xff,%al
  1004ae:	57                   	push   %edi
  1004af:	56                   	push   %esi
  1004b0:	53                   	push   %ebx
  1004b1:	bb 21 00 00 00       	mov    $0x21,%ebx
  1004b6:	89 da                	mov    %ebx,%edx
  1004b8:	ee                   	out    %al,(%dx)
  1004b9:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  1004be:	89 ca                	mov    %ecx,%edx
  1004c0:	ee                   	out    %al,(%dx)
  1004c1:	be 11 00 00 00       	mov    $0x11,%esi
  1004c6:	bf 20 00 00 00       	mov    $0x20,%edi
  1004cb:	89 f0                	mov    %esi,%eax
  1004cd:	89 fa                	mov    %edi,%edx
  1004cf:	ee                   	out    %al,(%dx)
  1004d0:	b0 20                	mov    $0x20,%al
  1004d2:	89 da                	mov    %ebx,%edx
  1004d4:	ee                   	out    %al,(%dx)
  1004d5:	b0 04                	mov    $0x4,%al
  1004d7:	ee                   	out    %al,(%dx)
  1004d8:	b0 03                	mov    $0x3,%al
  1004da:	ee                   	out    %al,(%dx)
  1004db:	bd a0 00 00 00       	mov    $0xa0,%ebp
  1004e0:	89 f0                	mov    %esi,%eax
  1004e2:	89 ea                	mov    %ebp,%edx
  1004e4:	ee                   	out    %al,(%dx)
  1004e5:	b0 28                	mov    $0x28,%al
  1004e7:	89 ca                	mov    %ecx,%edx
  1004e9:	ee                   	out    %al,(%dx)
  1004ea:	b0 02                	mov    $0x2,%al
  1004ec:	ee                   	out    %al,(%dx)
  1004ed:	b0 01                	mov    $0x1,%al
  1004ef:	ee                   	out    %al,(%dx)
  1004f0:	b0 68                	mov    $0x68,%al
  1004f2:	89 fa                	mov    %edi,%edx
  1004f4:	ee                   	out    %al,(%dx)
  1004f5:	be 0a 00 00 00       	mov    $0xa,%esi
  1004fa:	89 f0                	mov    %esi,%eax
  1004fc:	ee                   	out    %al,(%dx)
  1004fd:	b0 68                	mov    $0x68,%al
  1004ff:	89 ea                	mov    %ebp,%edx
  100501:	ee                   	out    %al,(%dx)
  100502:	89 f0                	mov    %esi,%eax
  100504:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  100505:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  10050a:	89 da                	mov    %ebx,%edx
  10050c:	19 c0                	sbb    %eax,%eax
  10050e:	f7 d0                	not    %eax
  100510:	05 ff 00 00 00       	add    $0xff,%eax
  100515:	ee                   	out    %al,(%dx)
  100516:	b0 ff                	mov    $0xff,%al
  100518:	89 ca                	mov    %ecx,%edx
  10051a:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  10051b:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  100520:	74 0d                	je     10052f <interrupt_controller_init+0x84>
  100522:	b2 43                	mov    $0x43,%dl
  100524:	b0 34                	mov    $0x34,%al
  100526:	ee                   	out    %al,(%dx)
  100527:	b0 a9                	mov    $0xa9,%al
  100529:	b2 40                	mov    $0x40,%dl
  10052b:	ee                   	out    %al,(%dx)
  10052c:	b0 04                	mov    $0x4,%al
  10052e:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  10052f:	5b                   	pop    %ebx
  100530:	5e                   	pop    %esi
  100531:	5f                   	pop    %edi
  100532:	5d                   	pop    %ebp
  100533:	c3                   	ret    

00100534 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  100534:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100535:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  100537:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100538:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  10053f:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  100542:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100548:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  10054e:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  100551:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  100556:	75 ea                	jne    100542 <console_clear+0xe>
  100558:	be d4 03 00 00       	mov    $0x3d4,%esi
  10055d:	b0 0e                	mov    $0xe,%al
  10055f:	89 f2                	mov    %esi,%edx
  100561:	ee                   	out    %al,(%dx)
  100562:	31 c9                	xor    %ecx,%ecx
  100564:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  100569:	88 c8                	mov    %cl,%al
  10056b:	89 da                	mov    %ebx,%edx
  10056d:	ee                   	out    %al,(%dx)
  10056e:	b0 0f                	mov    $0xf,%al
  100570:	89 f2                	mov    %esi,%edx
  100572:	ee                   	out    %al,(%dx)
  100573:	88 c8                	mov    %cl,%al
  100575:	89 da                	mov    %ebx,%edx
  100577:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  100578:	5b                   	pop    %ebx
  100579:	5e                   	pop    %esi
  10057a:	c3                   	ret    

0010057b <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  10057b:	ba 64 00 00 00       	mov    $0x64,%edx
  100580:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  100581:	a8 01                	test   $0x1,%al
  100583:	74 45                	je     1005ca <console_read_digit+0x4f>
  100585:	b2 60                	mov    $0x60,%dl
  100587:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  100588:	8d 50 fe             	lea    -0x2(%eax),%edx
  10058b:	80 fa 08             	cmp    $0x8,%dl
  10058e:	77 05                	ja     100595 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  100590:	0f b6 c0             	movzbl %al,%eax
  100593:	48                   	dec    %eax
  100594:	c3                   	ret    
	else if (data == 0x0B)
  100595:	3c 0b                	cmp    $0xb,%al
  100597:	74 35                	je     1005ce <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  100599:	8d 50 b9             	lea    -0x47(%eax),%edx
  10059c:	80 fa 02             	cmp    $0x2,%dl
  10059f:	77 07                	ja     1005a8 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  1005a1:	0f b6 c0             	movzbl %al,%eax
  1005a4:	83 e8 40             	sub    $0x40,%eax
  1005a7:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  1005a8:	8d 50 b5             	lea    -0x4b(%eax),%edx
  1005ab:	80 fa 02             	cmp    $0x2,%dl
  1005ae:	77 07                	ja     1005b7 <console_read_digit+0x3c>
		return data - 0x4B + 4;
  1005b0:	0f b6 c0             	movzbl %al,%eax
  1005b3:	83 e8 47             	sub    $0x47,%eax
  1005b6:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  1005b7:	8d 50 b1             	lea    -0x4f(%eax),%edx
  1005ba:	80 fa 02             	cmp    $0x2,%dl
  1005bd:	77 07                	ja     1005c6 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  1005bf:	0f b6 c0             	movzbl %al,%eax
  1005c2:	83 e8 4e             	sub    $0x4e,%eax
  1005c5:	c3                   	ret    
	else if (data == 0x53)
  1005c6:	3c 53                	cmp    $0x53,%al
  1005c8:	74 04                	je     1005ce <console_read_digit+0x53>
  1005ca:	83 c8 ff             	or     $0xffffffff,%eax
  1005cd:	c3                   	ret    
  1005ce:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  1005d0:	c3                   	ret    

001005d1 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  1005d1:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  1005d5:	a3 80 8c 10 00       	mov    %eax,0x108c80

	asm volatile("movl %0,%%esp\n\t"
  1005da:	83 c0 08             	add    $0x8,%eax
  1005dd:	89 c4                	mov    %eax,%esp
  1005df:	61                   	popa   
  1005e0:	07                   	pop    %es
  1005e1:	1f                   	pop    %ds
  1005e2:	83 c4 08             	add    $0x8,%esp
  1005e5:	cf                   	iret   
  1005e6:	eb fe                	jmp    1005e6 <run+0x15>

001005e8 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  1005e8:	53                   	push   %ebx
  1005e9:	83 ec 0c             	sub    $0xc,%esp
  1005ec:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  1005f0:	6a 44                	push   $0x44
  1005f2:	6a 00                	push   $0x0
  1005f4:	8d 43 08             	lea    0x8(%ebx),%eax
  1005f7:	50                   	push   %eax
  1005f8:	e8 17 01 00 00       	call   100714 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  1005fd:	66 c7 43 3c 1b 00    	movw   $0x1b,0x3c(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  100603:	66 c7 43 2c 23 00    	movw   $0x23,0x2c(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  100609:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  10060f:	66 c7 43 48 23 00    	movw   $0x23,0x48(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  100615:	c7 43 40 00 02 00 00 	movl   $0x200,0x40(%ebx)
}
  10061c:	83 c4 18             	add    $0x18,%esp
  10061f:	5b                   	pop    %ebx
  100620:	c3                   	ret    
  100621:	90                   	nop
  100622:	90                   	nop
  100623:	90                   	nop

00100624 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  100624:	55                   	push   %ebp
  100625:	57                   	push   %edi
  100626:	56                   	push   %esi
  100627:	53                   	push   %ebx
  100628:	83 ec 1c             	sub    $0x1c,%esp
  10062b:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  10062f:	83 f8 03             	cmp    $0x3,%eax
  100632:	7f 04                	jg     100638 <program_loader+0x14>
  100634:	85 c0                	test   %eax,%eax
  100636:	79 02                	jns    10063a <program_loader+0x16>
  100638:	eb fe                	jmp    100638 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  10063a:	8b 34 c5 28 1c 10 00 	mov    0x101c28(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  100641:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  100647:	74 02                	je     10064b <program_loader+0x27>
  100649:	eb fe                	jmp    100649 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10064b:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  10064e:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100652:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  100654:	c1 e5 05             	shl    $0x5,%ebp
  100657:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  10065a:	eb 3f                	jmp    10069b <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  10065c:	83 3b 01             	cmpl   $0x1,(%ebx)
  10065f:	75 37                	jne    100698 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  100661:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100664:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  100667:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  10066a:	01 c7                	add    %eax,%edi
	memsz += va;
  10066c:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  10066e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  100673:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  100677:	52                   	push   %edx
  100678:	89 fa                	mov    %edi,%edx
  10067a:	29 c2                	sub    %eax,%edx
  10067c:	52                   	push   %edx
  10067d:	8b 53 04             	mov    0x4(%ebx),%edx
  100680:	01 f2                	add    %esi,%edx
  100682:	52                   	push   %edx
  100683:	50                   	push   %eax
  100684:	e8 27 00 00 00       	call   1006b0 <memcpy>
  100689:	83 c4 10             	add    $0x10,%esp
  10068c:	eb 04                	jmp    100692 <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  10068e:	c6 07 00             	movb   $0x0,(%edi)
  100691:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  100692:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  100696:	72 f6                	jb     10068e <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  100698:	83 c3 20             	add    $0x20,%ebx
  10069b:	39 eb                	cmp    %ebp,%ebx
  10069d:	72 bd                	jb     10065c <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  10069f:	8b 56 18             	mov    0x18(%esi),%edx
  1006a2:	8b 44 24 34          	mov    0x34(%esp),%eax
  1006a6:	89 10                	mov    %edx,(%eax)
}
  1006a8:	83 c4 1c             	add    $0x1c,%esp
  1006ab:	5b                   	pop    %ebx
  1006ac:	5e                   	pop    %esi
  1006ad:	5f                   	pop    %edi
  1006ae:	5d                   	pop    %ebp
  1006af:	c3                   	ret    

001006b0 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  1006b0:	56                   	push   %esi
  1006b1:	31 d2                	xor    %edx,%edx
  1006b3:	53                   	push   %ebx
  1006b4:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1006b8:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  1006bc:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1006c0:	eb 08                	jmp    1006ca <memcpy+0x1a>
		*d++ = *s++;
  1006c2:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  1006c5:	4e                   	dec    %esi
  1006c6:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  1006c9:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1006ca:	85 f6                	test   %esi,%esi
  1006cc:	75 f4                	jne    1006c2 <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  1006ce:	5b                   	pop    %ebx
  1006cf:	5e                   	pop    %esi
  1006d0:	c3                   	ret    

001006d1 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  1006d1:	57                   	push   %edi
  1006d2:	56                   	push   %esi
  1006d3:	53                   	push   %ebx
  1006d4:	8b 44 24 10          	mov    0x10(%esp),%eax
  1006d8:	8b 7c 24 14          	mov    0x14(%esp),%edi
  1006dc:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  1006e0:	39 c7                	cmp    %eax,%edi
  1006e2:	73 26                	jae    10070a <memmove+0x39>
  1006e4:	8d 34 17             	lea    (%edi,%edx,1),%esi
  1006e7:	39 c6                	cmp    %eax,%esi
  1006e9:	76 1f                	jbe    10070a <memmove+0x39>
		s += n, d += n;
  1006eb:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  1006ee:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  1006f0:	eb 07                	jmp    1006f9 <memmove+0x28>
			*--d = *--s;
  1006f2:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  1006f5:	4a                   	dec    %edx
  1006f6:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  1006f9:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  1006fa:	85 d2                	test   %edx,%edx
  1006fc:	75 f4                	jne    1006f2 <memmove+0x21>
  1006fe:	eb 10                	jmp    100710 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  100700:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  100703:	4a                   	dec    %edx
  100704:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  100707:	41                   	inc    %ecx
  100708:	eb 02                	jmp    10070c <memmove+0x3b>
  10070a:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  10070c:	85 d2                	test   %edx,%edx
  10070e:	75 f0                	jne    100700 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  100710:	5b                   	pop    %ebx
  100711:	5e                   	pop    %esi
  100712:	5f                   	pop    %edi
  100713:	c3                   	ret    

00100714 <memset>:

void *
memset(void *v, int c, size_t n)
{
  100714:	53                   	push   %ebx
  100715:	8b 44 24 08          	mov    0x8(%esp),%eax
  100719:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  10071d:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  100721:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  100723:	eb 04                	jmp    100729 <memset+0x15>
		*p++ = c;
  100725:	88 1a                	mov    %bl,(%edx)
  100727:	49                   	dec    %ecx
  100728:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  100729:	85 c9                	test   %ecx,%ecx
  10072b:	75 f8                	jne    100725 <memset+0x11>
		*p++ = c;
	return v;
}
  10072d:	5b                   	pop    %ebx
  10072e:	c3                   	ret    

0010072f <strlen>:

size_t
strlen(const char *s)
{
  10072f:	8b 54 24 04          	mov    0x4(%esp),%edx
  100733:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100735:	eb 01                	jmp    100738 <strlen+0x9>
		++n;
  100737:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100738:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  10073c:	75 f9                	jne    100737 <strlen+0x8>
		++n;
	return n;
}
  10073e:	c3                   	ret    

0010073f <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  10073f:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  100743:	31 c0                	xor    %eax,%eax
  100745:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100749:	eb 01                	jmp    10074c <strnlen+0xd>
		++n;
  10074b:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  10074c:	39 d0                	cmp    %edx,%eax
  10074e:	74 06                	je     100756 <strnlen+0x17>
  100750:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  100754:	75 f5                	jne    10074b <strnlen+0xc>
		++n;
	return n;
}
  100756:	c3                   	ret    

00100757 <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100757:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  100758:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  10075d:	53                   	push   %ebx
  10075e:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  100760:	76 05                	jbe    100767 <console_putc+0x10>
  100762:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  100767:	80 fa 0a             	cmp    $0xa,%dl
  10076a:	75 2c                	jne    100798 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  10076c:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  100772:	be 50 00 00 00       	mov    $0x50,%esi
  100777:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  100779:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  10077c:	99                   	cltd   
  10077d:	f7 fe                	idiv   %esi
  10077f:	89 de                	mov    %ebx,%esi
  100781:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  100783:	eb 07                	jmp    10078c <console_putc+0x35>
			*cursor++ = ' ' | color;
  100785:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100788:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  100789:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  10078c:	83 f8 50             	cmp    $0x50,%eax
  10078f:	75 f4                	jne    100785 <console_putc+0x2e>
  100791:	29 d0                	sub    %edx,%eax
  100793:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  100796:	eb 0b                	jmp    1007a3 <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  100798:	0f b6 d2             	movzbl %dl,%edx
  10079b:	09 ca                	or     %ecx,%edx
  10079d:	66 89 13             	mov    %dx,(%ebx)
  1007a0:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  1007a3:	5b                   	pop    %ebx
  1007a4:	5e                   	pop    %esi
  1007a5:	c3                   	ret    

001007a6 <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  1007a6:	56                   	push   %esi
  1007a7:	53                   	push   %ebx
  1007a8:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  1007ac:	8d 58 ff             	lea    -0x1(%eax),%ebx
  1007af:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  1007b3:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  1007b8:	75 04                	jne    1007be <fill_numbuf+0x18>
  1007ba:	85 d2                	test   %edx,%edx
  1007bc:	74 10                	je     1007ce <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  1007be:	89 d0                	mov    %edx,%eax
  1007c0:	31 d2                	xor    %edx,%edx
  1007c2:	f7 f1                	div    %ecx
  1007c4:	4b                   	dec    %ebx
  1007c5:	8a 14 16             	mov    (%esi,%edx,1),%dl
  1007c8:	88 13                	mov    %dl,(%ebx)
			val /= base;
  1007ca:	89 c2                	mov    %eax,%edx
  1007cc:	eb ec                	jmp    1007ba <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  1007ce:	89 d8                	mov    %ebx,%eax
  1007d0:	5b                   	pop    %ebx
  1007d1:	5e                   	pop    %esi
  1007d2:	c3                   	ret    

001007d3 <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  1007d3:	55                   	push   %ebp
  1007d4:	57                   	push   %edi
  1007d5:	56                   	push   %esi
  1007d6:	53                   	push   %ebx
  1007d7:	83 ec 38             	sub    $0x38,%esp
  1007da:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  1007de:	8b 7c 24 54          	mov    0x54(%esp),%edi
  1007e2:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  1007e6:	e9 60 03 00 00       	jmp    100b4b <console_vprintf+0x378>
		if (*format != '%') {
  1007eb:	80 fa 25             	cmp    $0x25,%dl
  1007ee:	74 13                	je     100803 <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  1007f0:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1007f4:	0f b6 d2             	movzbl %dl,%edx
  1007f7:	89 f0                	mov    %esi,%eax
  1007f9:	e8 59 ff ff ff       	call   100757 <console_putc>
  1007fe:	e9 45 03 00 00       	jmp    100b48 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100803:	47                   	inc    %edi
  100804:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  10080b:	00 
  10080c:	eb 12                	jmp    100820 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  10080e:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  10080f:	8a 11                	mov    (%ecx),%dl
  100811:	84 d2                	test   %dl,%dl
  100813:	74 1a                	je     10082f <console_vprintf+0x5c>
  100815:	89 e8                	mov    %ebp,%eax
  100817:	38 c2                	cmp    %al,%dl
  100819:	75 f3                	jne    10080e <console_vprintf+0x3b>
  10081b:	e9 3f 03 00 00       	jmp    100b5f <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100820:	8a 17                	mov    (%edi),%dl
  100822:	84 d2                	test   %dl,%dl
  100824:	74 0b                	je     100831 <console_vprintf+0x5e>
  100826:	b9 b4 0b 10 00       	mov    $0x100bb4,%ecx
  10082b:	89 d5                	mov    %edx,%ebp
  10082d:	eb e0                	jmp    10080f <console_vprintf+0x3c>
  10082f:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  100831:	8d 42 cf             	lea    -0x31(%edx),%eax
  100834:	3c 08                	cmp    $0x8,%al
  100836:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  10083d:	00 
  10083e:	76 13                	jbe    100853 <console_vprintf+0x80>
  100840:	eb 1d                	jmp    10085f <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  100842:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  100847:	0f be c0             	movsbl %al,%eax
  10084a:	47                   	inc    %edi
  10084b:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  10084f:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  100853:	8a 07                	mov    (%edi),%al
  100855:	8d 50 d0             	lea    -0x30(%eax),%edx
  100858:	80 fa 09             	cmp    $0x9,%dl
  10085b:	76 e5                	jbe    100842 <console_vprintf+0x6f>
  10085d:	eb 18                	jmp    100877 <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  10085f:	80 fa 2a             	cmp    $0x2a,%dl
  100862:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  100869:	ff 
  10086a:	75 0b                	jne    100877 <console_vprintf+0xa4>
			width = va_arg(val, int);
  10086c:	83 c3 04             	add    $0x4,%ebx
			++format;
  10086f:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  100870:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100873:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  100877:	83 cd ff             	or     $0xffffffff,%ebp
  10087a:	80 3f 2e             	cmpb   $0x2e,(%edi)
  10087d:	75 37                	jne    1008b6 <console_vprintf+0xe3>
			++format;
  10087f:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  100880:	31 ed                	xor    %ebp,%ebp
  100882:	8a 07                	mov    (%edi),%al
  100884:	8d 50 d0             	lea    -0x30(%eax),%edx
  100887:	80 fa 09             	cmp    $0x9,%dl
  10088a:	76 0d                	jbe    100899 <console_vprintf+0xc6>
  10088c:	eb 17                	jmp    1008a5 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  10088e:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  100891:	0f be c0             	movsbl %al,%eax
  100894:	47                   	inc    %edi
  100895:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  100899:	8a 07                	mov    (%edi),%al
  10089b:	8d 50 d0             	lea    -0x30(%eax),%edx
  10089e:	80 fa 09             	cmp    $0x9,%dl
  1008a1:	76 eb                	jbe    10088e <console_vprintf+0xbb>
  1008a3:	eb 11                	jmp    1008b6 <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  1008a5:	3c 2a                	cmp    $0x2a,%al
  1008a7:	75 0b                	jne    1008b4 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  1008a9:	83 c3 04             	add    $0x4,%ebx
				++format;
  1008ac:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  1008ad:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  1008b0:	85 ed                	test   %ebp,%ebp
  1008b2:	79 02                	jns    1008b6 <console_vprintf+0xe3>
  1008b4:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  1008b6:	8a 07                	mov    (%edi),%al
  1008b8:	3c 64                	cmp    $0x64,%al
  1008ba:	74 34                	je     1008f0 <console_vprintf+0x11d>
  1008bc:	7f 1d                	jg     1008db <console_vprintf+0x108>
  1008be:	3c 58                	cmp    $0x58,%al
  1008c0:	0f 84 a2 00 00 00    	je     100968 <console_vprintf+0x195>
  1008c6:	3c 63                	cmp    $0x63,%al
  1008c8:	0f 84 bf 00 00 00    	je     10098d <console_vprintf+0x1ba>
  1008ce:	3c 43                	cmp    $0x43,%al
  1008d0:	0f 85 d0 00 00 00    	jne    1009a6 <console_vprintf+0x1d3>
  1008d6:	e9 a3 00 00 00       	jmp    10097e <console_vprintf+0x1ab>
  1008db:	3c 75                	cmp    $0x75,%al
  1008dd:	74 4d                	je     10092c <console_vprintf+0x159>
  1008df:	3c 78                	cmp    $0x78,%al
  1008e1:	74 5c                	je     10093f <console_vprintf+0x16c>
  1008e3:	3c 73                	cmp    $0x73,%al
  1008e5:	0f 85 bb 00 00 00    	jne    1009a6 <console_vprintf+0x1d3>
  1008eb:	e9 86 00 00 00       	jmp    100976 <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  1008f0:	83 c3 04             	add    $0x4,%ebx
  1008f3:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  1008f6:	89 d1                	mov    %edx,%ecx
  1008f8:	c1 f9 1f             	sar    $0x1f,%ecx
  1008fb:	89 0c 24             	mov    %ecx,(%esp)
  1008fe:	31 ca                	xor    %ecx,%edx
  100900:	55                   	push   %ebp
  100901:	29 ca                	sub    %ecx,%edx
  100903:	68 bc 0b 10 00       	push   $0x100bbc
  100908:	b9 0a 00 00 00       	mov    $0xa,%ecx
  10090d:	8d 44 24 40          	lea    0x40(%esp),%eax
  100911:	e8 90 fe ff ff       	call   1007a6 <fill_numbuf>
  100916:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  10091a:	58                   	pop    %eax
  10091b:	5a                   	pop    %edx
  10091c:	ba 01 00 00 00       	mov    $0x1,%edx
  100921:	8b 04 24             	mov    (%esp),%eax
  100924:	83 e0 01             	and    $0x1,%eax
  100927:	e9 a5 00 00 00       	jmp    1009d1 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  10092c:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  10092f:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100934:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100937:	55                   	push   %ebp
  100938:	68 bc 0b 10 00       	push   $0x100bbc
  10093d:	eb 11                	jmp    100950 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  10093f:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  100942:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100945:	55                   	push   %ebp
  100946:	68 d0 0b 10 00       	push   $0x100bd0
  10094b:	b9 10 00 00 00       	mov    $0x10,%ecx
  100950:	8d 44 24 40          	lea    0x40(%esp),%eax
  100954:	e8 4d fe ff ff       	call   1007a6 <fill_numbuf>
  100959:	ba 01 00 00 00       	mov    $0x1,%edx
  10095e:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100962:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  100964:	59                   	pop    %ecx
  100965:	59                   	pop    %ecx
  100966:	eb 69                	jmp    1009d1 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  100968:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  10096b:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10096e:	55                   	push   %ebp
  10096f:	68 bc 0b 10 00       	push   $0x100bbc
  100974:	eb d5                	jmp    10094b <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  100976:	83 c3 04             	add    $0x4,%ebx
  100979:	8b 43 fc             	mov    -0x4(%ebx),%eax
  10097c:	eb 40                	jmp    1009be <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  10097e:	83 c3 04             	add    $0x4,%ebx
  100981:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100984:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100988:	e9 bd 01 00 00       	jmp    100b4a <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  10098d:	83 c3 04             	add    $0x4,%ebx
  100990:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  100993:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  100997:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  10099c:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  1009a0:	88 44 24 24          	mov    %al,0x24(%esp)
  1009a4:	eb 27                	jmp    1009cd <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  1009a6:	84 c0                	test   %al,%al
  1009a8:	75 02                	jne    1009ac <console_vprintf+0x1d9>
  1009aa:	b0 25                	mov    $0x25,%al
  1009ac:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  1009b0:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  1009b5:	80 3f 00             	cmpb   $0x0,(%edi)
  1009b8:	74 0a                	je     1009c4 <console_vprintf+0x1f1>
  1009ba:	8d 44 24 24          	lea    0x24(%esp),%eax
  1009be:	89 44 24 04          	mov    %eax,0x4(%esp)
  1009c2:	eb 09                	jmp    1009cd <console_vprintf+0x1fa>
				format--;
  1009c4:	8d 54 24 24          	lea    0x24(%esp),%edx
  1009c8:	4f                   	dec    %edi
  1009c9:	89 54 24 04          	mov    %edx,0x4(%esp)
  1009cd:	31 d2                	xor    %edx,%edx
  1009cf:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1009d1:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  1009d3:	83 fd ff             	cmp    $0xffffffff,%ebp
  1009d6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1009dd:	74 1f                	je     1009fe <console_vprintf+0x22b>
  1009df:	89 04 24             	mov    %eax,(%esp)
  1009e2:	eb 01                	jmp    1009e5 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  1009e4:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1009e5:	39 e9                	cmp    %ebp,%ecx
  1009e7:	74 0a                	je     1009f3 <console_vprintf+0x220>
  1009e9:	8b 44 24 04          	mov    0x4(%esp),%eax
  1009ed:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  1009f1:	75 f1                	jne    1009e4 <console_vprintf+0x211>
  1009f3:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1009f6:	89 0c 24             	mov    %ecx,(%esp)
  1009f9:	eb 1f                	jmp    100a1a <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  1009fb:	42                   	inc    %edx
  1009fc:	eb 09                	jmp    100a07 <console_vprintf+0x234>
  1009fe:	89 d1                	mov    %edx,%ecx
  100a00:	8b 14 24             	mov    (%esp),%edx
  100a03:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100a07:	8b 44 24 04          	mov    0x4(%esp),%eax
  100a0b:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  100a0f:	75 ea                	jne    1009fb <console_vprintf+0x228>
  100a11:	8b 44 24 08          	mov    0x8(%esp),%eax
  100a15:	89 14 24             	mov    %edx,(%esp)
  100a18:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  100a1a:	85 c0                	test   %eax,%eax
  100a1c:	74 0c                	je     100a2a <console_vprintf+0x257>
  100a1e:	84 d2                	test   %dl,%dl
  100a20:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  100a27:	00 
  100a28:	75 24                	jne    100a4e <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  100a2a:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100a2f:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  100a36:	00 
  100a37:	75 15                	jne    100a4e <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100a39:	8b 44 24 14          	mov    0x14(%esp),%eax
  100a3d:	83 e0 08             	and    $0x8,%eax
  100a40:	83 f8 01             	cmp    $0x1,%eax
  100a43:	19 c9                	sbb    %ecx,%ecx
  100a45:	f7 d1                	not    %ecx
  100a47:	83 e1 20             	and    $0x20,%ecx
  100a4a:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100a4e:	3b 2c 24             	cmp    (%esp),%ebp
  100a51:	7e 0d                	jle    100a60 <console_vprintf+0x28d>
  100a53:	84 d2                	test   %dl,%dl
  100a55:	74 40                	je     100a97 <console_vprintf+0x2c4>
			zeros = precision - len;
  100a57:	2b 2c 24             	sub    (%esp),%ebp
  100a5a:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100a5e:	eb 3f                	jmp    100a9f <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a60:	84 d2                	test   %dl,%dl
  100a62:	74 33                	je     100a97 <console_vprintf+0x2c4>
  100a64:	8b 44 24 14          	mov    0x14(%esp),%eax
  100a68:	83 e0 06             	and    $0x6,%eax
  100a6b:	83 f8 02             	cmp    $0x2,%eax
  100a6e:	75 27                	jne    100a97 <console_vprintf+0x2c4>
  100a70:	45                   	inc    %ebp
  100a71:	75 24                	jne    100a97 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100a73:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a75:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100a78:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a7d:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a80:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100a83:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100a87:	7d 0e                	jge    100a97 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100a89:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100a8d:	29 ca                	sub    %ecx,%edx
  100a8f:	29 c2                	sub    %eax,%edx
  100a91:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a95:	eb 08                	jmp    100a9f <console_vprintf+0x2cc>
  100a97:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100a9e:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a9f:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100aa3:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100aa5:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100aa9:	2b 2c 24             	sub    (%esp),%ebp
  100aac:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100ab1:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100ab4:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100ab7:	29 c5                	sub    %eax,%ebp
  100ab9:	89 f0                	mov    %esi,%eax
  100abb:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100abf:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100ac3:	eb 0f                	jmp    100ad4 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100ac5:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100ac9:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100ace:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100acf:	e8 83 fc ff ff       	call   100757 <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100ad4:	85 ed                	test   %ebp,%ebp
  100ad6:	7e 07                	jle    100adf <console_vprintf+0x30c>
  100ad8:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100add:	74 e6                	je     100ac5 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100adf:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100ae4:	89 c6                	mov    %eax,%esi
  100ae6:	74 23                	je     100b0b <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100ae8:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100aed:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100af1:	e8 61 fc ff ff       	call   100757 <console_putc>
  100af6:	89 c6                	mov    %eax,%esi
  100af8:	eb 11                	jmp    100b0b <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100afa:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100afe:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100b03:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100b04:	e8 4e fc ff ff       	call   100757 <console_putc>
  100b09:	eb 06                	jmp    100b11 <console_vprintf+0x33e>
  100b0b:	89 f0                	mov    %esi,%eax
  100b0d:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100b11:	85 f6                	test   %esi,%esi
  100b13:	7f e5                	jg     100afa <console_vprintf+0x327>
  100b15:	8b 34 24             	mov    (%esp),%esi
  100b18:	eb 15                	jmp    100b2f <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100b1a:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100b1e:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100b1f:	0f b6 11             	movzbl (%ecx),%edx
  100b22:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b26:	e8 2c fc ff ff       	call   100757 <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100b2b:	ff 44 24 04          	incl   0x4(%esp)
  100b2f:	85 f6                	test   %esi,%esi
  100b31:	7f e7                	jg     100b1a <console_vprintf+0x347>
  100b33:	eb 0f                	jmp    100b44 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100b35:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b39:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100b3e:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100b3f:	e8 13 fc ff ff       	call   100757 <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100b44:	85 ed                	test   %ebp,%ebp
  100b46:	7f ed                	jg     100b35 <console_vprintf+0x362>
  100b48:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100b4a:	47                   	inc    %edi
  100b4b:	8a 17                	mov    (%edi),%dl
  100b4d:	84 d2                	test   %dl,%dl
  100b4f:	0f 85 96 fc ff ff    	jne    1007eb <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100b55:	83 c4 38             	add    $0x38,%esp
  100b58:	89 f0                	mov    %esi,%eax
  100b5a:	5b                   	pop    %ebx
  100b5b:	5e                   	pop    %esi
  100b5c:	5f                   	pop    %edi
  100b5d:	5d                   	pop    %ebp
  100b5e:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100b5f:	81 e9 b4 0b 10 00    	sub    $0x100bb4,%ecx
  100b65:	b8 01 00 00 00       	mov    $0x1,%eax
  100b6a:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100b6c:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100b6d:	09 44 24 14          	or     %eax,0x14(%esp)
  100b71:	e9 aa fc ff ff       	jmp    100820 <console_vprintf+0x4d>

00100b76 <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100b76:	8d 44 24 10          	lea    0x10(%esp),%eax
  100b7a:	50                   	push   %eax
  100b7b:	ff 74 24 10          	pushl  0x10(%esp)
  100b7f:	ff 74 24 10          	pushl  0x10(%esp)
  100b83:	ff 74 24 10          	pushl  0x10(%esp)
  100b87:	e8 47 fc ff ff       	call   1007d3 <console_vprintf>
  100b8c:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100b8f:	c3                   	ret    
