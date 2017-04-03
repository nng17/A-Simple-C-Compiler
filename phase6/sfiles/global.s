_foo:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$foo.size, %esp
	movl	_x, %eax
	addl	$1, %eax
	movl	%eax, -4(%ebp)
	movl	-4(%ebp), %eax
	movl	%eax, _x
	movl	_x, %eax
	addl	$1, %eax
	movl	%eax, -8(%ebp)
	movl	-8(%ebp), %eax
	jmp	.L0
.L0:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	_foo
	.set	foo.size, 8

_main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$main.size, %esp
	movl	$65, %eax
	movl	%eax, _x
	movl	_x, %eax
	movl	%eax, 0(%esp)
	call	_putchar
	movl	%eax, -4(%ebp)
	call	_foo
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_putchar
	movl	%eax, -8(%ebp)
	movl	_x, %eax
	movl	%eax, 0(%esp)
	call	_putchar
	movl	%eax, -16(%ebp)
	movl	$10, %eax
	movl	%eax, 0(%esp)
	call	_putchar
	movl	%eax, -20(%ebp)
.L1:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	_main
	.set	main.size, 24

	.data
	.comm	_x, 4, 4
