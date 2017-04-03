_main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$main.size, %esp
	leal	.L1, %eax
	movl	%eax, -8(%ebp)
	movl	-8(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_printf
	movl	%eax, -4(%ebp)
.L0:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	_main
	.set	main.size, 24

.L1:	.asciz	"hello world\n"
