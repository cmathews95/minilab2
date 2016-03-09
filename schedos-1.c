#include "schedos-app.h"
#include "x86sync.h"

/*****************************************************************************
 * schedos-1
 *
 *   This tiny application prints red "1"s to the console.
 *   It yields the CPU to the kernel after each "1" using the sys_yield()
 *   system call.  This lets the kernel (schedos-kern.c) pick another
 *   application to run, if it wants.
 *
 *   The other schedos-* processes simply #include this file after defining
 *   PRINTCHAR appropriately.
 *
 *****************************************************************************/

#ifndef PRINTCHAR
#define PRINTCHAR	('1' | 0x0C00)
#endif

// Values for testing
#ifndef N_PRIORITY
#define N_PRIORITY 1
#endif

#ifndef N_SHARE
#define N_SHARE 1
#endif

// UNCOMMENT THE NEXT LINE TO USE EXERCISE 8 CODE INSTEAD OF EXERCISE 6
// #define __EXERCISE_8__
// Use the following structure to choose between them:
// #infdef __EXERCISE_8__
// (exercise 6 code)
// #else
// (exercise 8 code)
// #endif


void
start(void)
{
	// Exercise 4A Code
	sys_priority(N_PRIORITY);
	// Exercise 4B Code
	sys_share(N_SHARE);
	sys_yield();
	int i;
	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one. Excercise 6
		sys_write(PRINTCHAR);
		sys_yield();
	}
	// Exercise 2 Code
	sys_exit(0);	
}
