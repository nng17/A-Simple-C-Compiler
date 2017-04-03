allocate:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$allocate.size, %esp
	movl	8(%ebp),%eax
	imull	$4,%eax
	movl	%eax,-16(%ebp)
	pushl	-16(%ebp)
	call	malloc
	addl	$4, %esp
	movl	%eax,-12(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, -8(%ebp)
	movl	$0, %eax
	movl	%eax, -4(%ebp)
.L1:
	movl	-4(%ebp),%eax
	cmpl	8(%ebp),%eax
	setl	%al
	movzbl	%al,%eax
	movl	%eax,-20(%ebp)
	movl	-20(%ebp),%eax
	cmpl	$0,%eax
	je	.L2
	movl	-4(%ebp),%eax
	imull	$4,%eax
	movl	%eax,-24(%ebp)
	movl	-8(%ebp),%eax
	addl	-24(%ebp),%eax
	movl	%eax,-28(%ebp)
	movl	8(%ebp),%eax
	imull	$4,%eax
	movl	%eax,-36(%ebp)
	pushl	-36(%ebp)
	call	malloc
	addl	$4, %esp
	movl	%eax,-32(%ebp)
	movl	-32(%ebp), %eax
	movl	-28(%ebp),%ecx
	movl	%eax,(%ecx)
	movl	-4(%ebp),%eax
	addl	$1,%eax
	movl	%eax,-40(%ebp)
	movl	-40(%ebp), %eax
	movl	%eax, -4(%ebp)
	jmp	.L1
.L2:
	movl	-8(%ebp),%eax
	jmp	.L0
.L0:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	allocate
	.set	allocate.size, 40

initialize:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$initialize.size, %esp
	movl	$0, %eax
	movl	%eax, -4(%ebp)
.L4:
	movl	-4(%ebp),%eax
	cmpl	12(%ebp),%eax
	setl	%al
	movzbl	%al,%eax
	movl	%eax,-12(%ebp)
	movl	-12(%ebp),%eax
	cmpl	$0,%eax
	je	.L5
	movl	$0, %eax
	movl	%eax, -8(%ebp)
.L6:
	movl	-8(%ebp),%eax
	cmpl	12(%ebp),%eax
	setl	%al
	movzbl	%al,%eax
	movl	%eax,-16(%ebp)
	movl	-16(%ebp),%eax
	cmpl	$0,%eax
	je	.L7
	movl	-4(%ebp),%eax
	imull	$4,%eax
	movl	%eax,-20(%ebp)
	movl	8(%ebp),%eax
	addl	-20(%ebp),%eax
	movl	%eax,-24(%ebp)
	movl	-24(%ebp),%eax
	movl	(%eax),%eax
	movl	%eax,-28(%ebp)
	movl	-8(%ebp),%eax
	imull	$4,%eax
	movl	%eax,-32(%ebp)
	movl	-28(%ebp),%eax
	addl	-32(%ebp),%eax
	movl	%eax,-36(%ebp)
	movl	-4(%ebp),%eax
	addl	-8(%ebp),%eax
	movl	%eax,-40(%ebp)
	movl	-40(%ebp), %eax
	movl	-36(%ebp),%ecx
	movl	%eax,(%ecx)
	movl	-8(%ebp),%eax
	addl	$1,%eax
	movl	%eax,-44(%ebp)
	movl	-44(%ebp), %eax
	movl	%eax, -8(%ebp)
	jmp	.L6
.L7:
	movl	-4(%ebp),%eax
	addl	$1,%eax
	movl	%eax,-48(%ebp)
	movl	-48(%ebp), %eax
	movl	%eax, -4(%ebp)
	jmp	.L4
.L5:
.L3:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	initialize
	.set	initialize.size, 48

display:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$display.size, %esp
	movl	$0, %eax
	movl	%eax, -4(%ebp)
.L9:
	movl	-4(%ebp),%eax
	cmpl	12(%ebp),%eax
	setl	%al
	movzbl	%al,%eax
	movl	%eax,-16(%ebp)
	movl	-16(%ebp),%eax
	cmpl	$0,%eax
	je	.L10
	movl	$0, %eax
	movl	%eax, -8(%ebp)
.L11:
	movl	-8(%ebp),%eax
	cmpl	12(%ebp),%eax
	setl	%al
	movzbl	%al,%eax
	movl	%eax,-20(%ebp)
	movl	-20(%ebp),%eax
	cmpl	$0,%eax
	je	.L12
	movl	-4(%ebp),%eax
	imull	$4,%eax
	movl	%eax,-24(%ebp)
	movl	8(%ebp),%eax
	addl	-24(%ebp),%eax
	movl	%eax,-28(%ebp)
	movl	-28(%ebp),%eax
	movl	(%eax),%eax
	movl	%eax,-32(%ebp)
	movl	-32(%ebp), %eax
	movl	%eax, -12(%ebp)
	movl	-8(%ebp),%eax
	imull	$4,%eax
	movl	%eax,-40(%ebp)
	movl	-12(%ebp),%eax
	addl	-40(%ebp),%eax
	movl	%eax,-44(%ebp)
	movl	-44(%ebp),%eax
	movl	(%eax),%eax
	movl	%eax,-48(%ebp)
	pushl	-48(%ebp)
	leal	.L13,%eax
	movl	%eax,-52(%ebp)
	pushl	-52(%ebp)
	call	printf
	addl	$8, %esp
	movl	%eax,-36(%ebp)
	movl	-8(%ebp),%eax
	addl	$1,%eax
	movl	%eax,-56(%ebp)
	movl	-56(%ebp), %eax
	movl	%eax, -8(%ebp)
	jmp	.L11
.L12:
	movl	-4(%ebp),%eax
	addl	$1,%eax
	movl	%eax,-60(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, -4(%ebp)
	leal	.L14,%eax
	movl	%eax,-68(%ebp)
	pushl	-68(%ebp)
	call	printf
	addl	$4, %esp
	movl	%eax,-64(%ebp)
	jmp	.L9
.L10:
.L8:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	display
	.set	display.size, 68

deallocate:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$deallocate.size, %esp
	movl	$0, %eax
	movl	%eax, -4(%ebp)
.L16:
	movl	-4(%ebp),%eax
	cmpl	12(%ebp),%eax
	setl	%al
	movzbl	%al,%eax
	movl	%eax,-8(%ebp)
	movl	-8(%ebp),%eax
	cmpl	$0,%eax
	je	.L17
	movl	-4(%ebp),%eax
	imull	$4,%eax
	movl	%eax,-16(%ebp)
	movl	8(%ebp),%eax
	addl	-16(%ebp),%eax
	movl	%eax,-20(%ebp)
	movl	-20(%ebp),%eax
	movl	(%eax),%eax
	movl	%eax,-24(%ebp)
	pushl	-24(%ebp)
	call	free
	addl	$4, %esp
	movl	%eax,-12(%ebp)
	movl	-4(%ebp),%eax
	addl	$1,%eax
	movl	%eax,-28(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, -4(%ebp)
	jmp	.L16
.L17:
	pushl	8(%ebp)
	call	free
	addl	$4, %esp
	movl	%eax,-32(%ebp)
.L15:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	deallocate
	.set	deallocate.size, 32

main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$main.size, %esp
	leal	-8(%ebp),%eax
	movl	%eax,-16(%ebp)
	pushl	-16(%ebp)
	leal	.L19,%eax
	movl	%eax,-20(%ebp)
	pushl	-20(%ebp)
	call	scanf
	addl	$8, %esp
	movl	%eax,-12(%ebp)
	pushl	-8(%ebp)
	call	allocate
	addl	$4, %esp
	movl	%eax,-24(%ebp)
	movl	-24(%ebp), %eax
	movl	%eax, -4(%ebp)
	pushl	-8(%ebp)
	pushl	-4(%ebp)
	call	initialize
	addl	$8, %esp
	movl	%eax,-28(%ebp)
	pushl	-8(%ebp)
	pushl	-4(%ebp)
	call	display
	addl	$8, %esp
	movl	%eax,-32(%ebp)
	pushl	-8(%ebp)
	pushl	-4(%ebp)
	call	deallocate
	addl	$8, %esp
	movl	%eax,-36(%ebp)
.L18:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	main
	.set	main.size, 36

.L13:	.asciz	"%d "
.L14:	.asciz	"\n"
.L19:	.asciz	"%d"
