_allocate:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$allocate.size, %esp
	movl	8(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_malloc
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, -8(%ebp)
	movl	$0, %eax
	movl	%eax, -4(%ebp)
.L1:
	movl	-4(%ebp), %eax
	cmpl	8(%ebp), %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -20(%ebp)
	movl	-20(%ebp), %eax
	cmpl	$0, %eax
	je	.L2
	movl	-4(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -24(%ebp)
	movl	-8(%ebp), %eax
	addl	-24(%ebp), %eax
	movl	%eax, -28(%ebp)
	movl	8(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -36(%ebp)
	movl	-36(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_malloc
	movl	%eax, -32(%ebp)
	movl	-32(%ebp), %eax
	movl	-28(%ebp), %ecx
	movl	%eax, (%ecx)
	movl	-4(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -40(%ebp)
	movl	-40(%ebp), %eax
	movl	%eax, -4(%ebp)
	jmp	.L1
.L2:
	movl	-8(%ebp), %eax
	jmp	.L0
.L0:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	_allocate
	.set	allocate.size, 56

_initialize:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$initialize.size, %esp
	movl	$0, %eax
	movl	%eax, -4(%ebp)
.L4:
	movl	-4(%ebp), %eax
	cmpl	12(%ebp), %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	cmpl	$0, %eax
	je	.L5
	movl	$0, %eax
	movl	%eax, -8(%ebp)
.L6:
	movl	-8(%ebp), %eax
	cmpl	12(%ebp), %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	cmpl	$0, %eax
	je	.L7
	movl	-4(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -20(%ebp)
	movl	8(%ebp), %eax
	addl	-20(%ebp), %eax
	movl	%eax, -24(%ebp)
	movl	-24(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -28(%ebp)
	movl	-8(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -32(%ebp)
	movl	-28(%ebp), %eax
	addl	-32(%ebp), %eax
	movl	%eax, -36(%ebp)
	movl	-4(%ebp), %eax
	addl	-8(%ebp), %eax
	movl	%eax, -40(%ebp)
	movl	-40(%ebp), %eax
	movl	-36(%ebp), %ecx
	movl	%eax, (%ecx)
	movl	-8(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -44(%ebp)
	movl	-44(%ebp), %eax
	movl	%eax, -8(%ebp)
	jmp	.L6
.L7:
	movl	-4(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -48(%ebp)
	movl	-48(%ebp), %eax
	movl	%eax, -4(%ebp)
	jmp	.L4
.L5:
.L3:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	_initialize
	.set	initialize.size, 56

_display:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$display.size, %esp
	movl	$0, %eax
	movl	%eax, -4(%ebp)
.L10:
	movl	-4(%ebp), %eax
	cmpl	12(%ebp), %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	cmpl	$0, %eax
	je	.L9
	movl	$0, %eax
	movl	%eax, -8(%ebp)
.L12:
	movl	-8(%ebp), %eax
	cmpl	12(%ebp), %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -20(%ebp)
	movl	-20(%ebp), %eax
	cmpl	$0, %eax
	je	.L11
	movl	-4(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -24(%ebp)
	movl	8(%ebp), %eax
	addl	-24(%ebp), %eax
	movl	%eax, -28(%ebp)
	movl	-28(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -32(%ebp)
	movl	-32(%ebp), %eax
	movl	%eax, -12(%ebp)
	movl	-8(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -40(%ebp)
	movl	-12(%ebp), %eax
	addl	-40(%ebp), %eax
	movl	%eax, -44(%ebp)
	movl	-44(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -48(%ebp)
	movl	-48(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	.L13, %eax
	movl	%eax, -52(%ebp)
	movl	-52(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_printf
	movl	%eax, -36(%ebp)
	movl	-8(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -56(%ebp)
	movl	-56(%ebp), %eax
	movl	%eax, -8(%ebp)
	jmp	.L12
.L11:
	movl	-4(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -60(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, -4(%ebp)
	leal	.L14, %eax
	movl	%eax, -68(%ebp)
	movl	-68(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_printf
	movl	%eax, -64(%ebp)
	jmp	.L10
.L9:
.L8:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	_display
	.set	display.size, 88

_deallocate:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$deallocate.size, %esp
	movl	$0, %eax
	movl	%eax, -4(%ebp)
.L17:
	movl	-4(%ebp), %eax
	cmpl	12(%ebp), %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -8(%ebp)
	movl	-8(%ebp), %eax
	cmpl	$0, %eax
	je	.L16
	movl	-4(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -16(%ebp)
	movl	8(%ebp), %eax
	addl	-16(%ebp), %eax
	movl	%eax, -20(%ebp)
	movl	-20(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -24(%ebp)
	movl	-24(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_free
	movl	%eax, -12(%ebp)
	movl	-4(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -28(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, -4(%ebp)
	jmp	.L17
.L16:
	movl	8(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_free
	movl	%eax, -32(%ebp)
.L15:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	_deallocate
	.set	deallocate.size, 40

_main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$main.size, %esp
	leal	-8(%ebp), %eax
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	.L19, %eax
	movl	%eax, -20(%ebp)
	movl	-20(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_scanf
	movl	%eax, -12(%ebp)
	movl	-8(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_allocate
	movl	%eax, -24(%ebp)
	movl	-24(%ebp), %eax
	movl	%eax, -4(%ebp)
	movl	-8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-4(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_initialize
	movl	%eax, -28(%ebp)
	movl	-8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-4(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_display
	movl	%eax, -32(%ebp)
	movl	-8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-4(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_deallocate
	movl	%eax, -36(%ebp)
.L18:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	_main
	.set	main.size, 56

.L13:	.asciz	"%d "
.L14:	.asciz	"\n"
.L19:	.asciz	"%d"
