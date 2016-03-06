
obj/schedos-3:     file format elf32-i386


Disassembly of section .text:

00400000 <start>:
 *   Set p_priority of process to status
 *****************************************************************************/
static inline void
sys_priority(int status)
{
	asm volatile("int %0\n"
  400000:	b8 01 00 00 00       	mov    $0x1,%eax
  400005:	cd 32                	int    $0x32
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  400007:	cd 30                	int    $0x30
  400009:	31 d2                	xor    %edx,%edx
 *   Print Process Number(status) to screen
 *****************************************************************************/
static inline void
sys_write(int status)
{
	asm volatile("int %0\n"
  40000b:	66 b8 33 09          	mov    $0x933,%ax
  40000f:	cd 33                	int    $0x33
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  400011:	cd 30                	int    $0x30
{
	// Exercise 4A Code
	sys_priority(1);
	sys_yield();
	int i;
	for (i = 0; i < RUNCOUNT; i++) {
  400013:	42                   	inc    %edx
  400014:	83 fa 0a             	cmp    $0xa,%edx
  400017:	75 f6                	jne    40000f <start+0xf>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  400019:	31 c0                	xor    %eax,%eax
  40001b:	cd 31                	int    $0x31
  40001d:	eb fe                	jmp    40001d <start+0x1d>
