_fib:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$fib.size, %esp
	movl	8(%ebp), %eax
	cmpl	$0, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -8(%ebp)
	movl	-8(%ebp), %eax
	cmpl	$0, %eax
	jne	.L3
	movl	8(%ebp), %eax
	cmpl	$1, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	cmpl	$0, %eax
.L3:
	setne	%al
	movzbl	%al, %eax
	movl	%eax, -4(%ebp)
	movl	-4(%ebp), %eax
	cmpl	$0, %eax
	je	.L1
	movl	$1, %eax
	jmp	.L0
	jmp	.L2
.L1:
.L2:
	movl	8(%ebp), %eax
	subl	$1, %eax
	movl	%eax, -20(%ebp)
	movl	-20(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_fib
	movl	%eax, -16(%ebp)
	movl	8(%ebp), %eax
	subl	$2, %eax
	movl	%eax, -28(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_fib
	movl	%eax, -24(%ebp)
	movl	-16(%ebp), %eax
	addl	-24(%ebp), %eax
	movl	%eax, -32(%ebp)
	movl	-32(%ebp), %eax
	jmp	.L0
.L0:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	_fib
	.set	fib.size, 40

_main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$main.size, %esp
	leal	-4(%ebp), %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	.L5, %eax
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_scanf
	movl	%eax, -8(%ebp)
	movl	-4(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_fib
	movl	%eax, -24(%ebp)
	movl	-24(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	.L6, %eax
	movl	%eax, -28(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_printf
	movl	%eax, -20(%ebp)
.L4:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	_main
	.set	main.size, 40

.L5:	.asciz	"%d"
.L6:	.asciz	"%d\n"
