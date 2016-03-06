
obj/schedos-2:     file format elf32-i386


Disassembly of section .text:

00300000 <start>:
 *   Set p_priority of process to status
 *****************************************************************************/
static inline void
sys_priority(int status)
{
	asm volatile("int %0\n"
  300000:	b8 01 00 00 00       	mov    $0x1,%eax
  300005:	cd 32                	int    $0x32
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  300007:	cd 30                	int    $0x30
  300009:	31 d2                	xor    %edx,%edx
 *   Print Process Number(status) to screen
 *****************************************************************************/
static inline void
sys_write(int status)
{
	asm volatile("int %0\n"
  30000b:	66 b8 32 0a          	mov    $0xa32,%ax
  30000f:	cd 33                	int    $0x33
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  300011:	cd 30                	int    $0x30
{
	// Exercise 4A Code
	sys_priority(1);
	sys_yield();
	int i;
	for (i = 0; i < RUNCOUNT; i++) {
  300013:	42                   	inc    %edx
  300014:	83 fa 0a             	cmp    $0xa,%edx
  300017:	75 f6                	jne    30000f <start+0xf>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  300019:	31 c0                	xor    %eax,%eax
  30001b:	cd 31                	int    $0x31
  30001d:	eb fe                	jmp    30001d <start+0x1d>
