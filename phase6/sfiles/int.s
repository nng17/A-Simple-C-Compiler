_main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$main.size, %esp
	movl	$100, %eax
	movl	%eax, -4(%ebp)
	movl	$30, %eax
	movl	%eax, -8(%ebp)
	movl	$2, %eax
	movl	%eax, -12(%ebp)
	movl	-4(%ebp), %eax
	addl	-8(%ebp), %eax
	movl	%eax, -36(%ebp)
	movl	-36(%ebp), %eax
	addl	-12(%ebp), %eax
	movl	%eax, -40(%ebp)
	movl	-40(%ebp), %eax
	movl	%eax, -16(%ebp)
	movl	-4(%ebp), %eax
	subl	-8(%ebp), %eax
	movl	%eax, -44(%ebp)
	movl	-44(%ebp), %eax
	subl	-12(%ebp), %eax
	movl	%eax, -48(%ebp)
	movl	-48(%ebp), %eax
	movl	%eax, -20(%ebp)
	movl	-4(%ebp), %eax
	imull	-8(%ebp), %eax
	movl	%eax, -52(%ebp)
	movl	-52(%ebp), %eax
	imull	-12(%ebp), %eax
	movl	%eax, -56(%ebp)
	movl	-56(%ebp), %eax
	movl	%eax, -24(%ebp)
	movl	-4(%ebp), %eax
	movl	-8(%ebp), %ecx
	cltd	
	idivl	%ecx
	movl	%eax, -60(%ebp)
	movl	-60(%ebp), %eax
	addl	-12(%ebp), %eax
	movl	%eax, -64(%ebp)
	movl	-64(%ebp), %eax
	movl	%eax, -28(%ebp)
	movl	-4(%ebp), %eax
	movl	-8(%ebp), %ecx
	cltd	
	idivl	%ecx
	movl	%edx, -68(%ebp)
	movl	-68(%ebp), %eax
	subl	-12(%ebp), %eax
	movl	%eax, -72(%ebp)
	movl	-72(%ebp), %eax
	movl	%eax, -32(%ebp)
	movl	-16(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	.L1, %eax
	movl	%eax, -80(%ebp)
	movl	-80(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_printf
	movl	%eax, -76(%ebp)
	movl	-20(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	.L2, %eax
	movl	%eax, -88(%ebp)
	movl	-88(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_printf
	movl	%eax, -84(%ebp)
	movl	-24(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	.L3, %eax
	movl	%eax, -96(%ebp)
	movl	-96(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_printf
	movl	%eax, -92(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	.L4, %eax
	movl	%eax, -104(%ebp)
	movl	-104(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_printf
	movl	%eax, -100(%ebp)
	movl	-32(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	.L5, %eax
	movl	%eax, -112(%ebp)
	movl	-112(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_printf
	movl	%eax, -108(%ebp)
.L0:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	_main
	.set	main.size, 120

.L1:	.asciz	"%d\n"
.L2:	.asciz	"%d\n"
.L3:	.asciz	"%d\n"
.L4:	.asciz	"%d\n"
.L5:	.asciz	"%d\n"
