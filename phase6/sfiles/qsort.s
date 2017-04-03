_readarray:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$readarray.size, %esp
	movl	$0, %eax
	movl	%eax, -4(%ebp)
.L2:
	movl	-4(%ebp), %eax
	cmpl	_n, %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -8(%ebp)
	movl	-8(%ebp), %eax
	cmpl	$0, %eax
	je	.L1
	movl	-4(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -16(%ebp)
	movl	_a, %eax
	addl	-16(%ebp), %eax
	movl	%eax, -20(%ebp)
	movl	-20(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	.L3, %eax
	movl	%eax, -24(%ebp)
	movl	-24(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_scanf
	movl	%eax, -12(%ebp)
	movl	-4(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -28(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, -4(%ebp)
	jmp	.L2
.L1:
.L0:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	_readarray
	.set	readarray.size, 40

_writearray:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$writearray.size, %esp
	movl	$0, %eax
	movl	%eax, -4(%ebp)
.L6:
	movl	-4(%ebp), %eax
	cmpl	_n, %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -8(%ebp)
	movl	-8(%ebp), %eax
	cmpl	$0, %eax
	je	.L5
	movl	-4(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -16(%ebp)
	movl	_a, %eax
	addl	-16(%ebp), %eax
	movl	%eax, -20(%ebp)
	movl	-20(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -24(%ebp)
	movl	-24(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	.L7, %eax
	movl	%eax, -28(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_printf
	movl	%eax, -12(%ebp)
	movl	-4(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -32(%ebp)
	movl	-32(%ebp), %eax
	movl	%eax, -4(%ebp)
	jmp	.L6
.L5:
	leal	.L8, %eax
	movl	%eax, -40(%ebp)
	movl	-40(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_printf
	movl	%eax, -36(%ebp)
.L4:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	_writearray
	.set	writearray.size, 56

_exchange:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$exchange.size, %esp
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -8(%ebp)
	movl	-8(%ebp), %eax
	movl	%eax, -4(%ebp)
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	8(%ebp), %ecx
	movl	%eax, (%ecx)
	movl	-4(%ebp), %eax
	movl	12(%ebp), %ecx
	movl	%eax, (%ecx)
.L9:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	_exchange
	.set	exchange.size, 24

_partition:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$partition.size, %esp
	movl	12(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -16(%ebp)
	movl	8(%ebp), %eax
	addl	-16(%ebp), %eax
	movl	%eax, -20(%ebp)
	movl	-20(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -24(%ebp)
	movl	-24(%ebp), %eax
	movl	%eax, -12(%ebp)
	movl	12(%ebp), %eax
	subl	$1, %eax
	movl	%eax, -28(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, -4(%ebp)
	movl	16(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -32(%ebp)
	movl	-32(%ebp), %eax
	movl	%eax, -8(%ebp)
.L12:
	movl	-4(%ebp), %eax
	cmpl	-8(%ebp), %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -36(%ebp)
	movl	-36(%ebp), %eax
	cmpl	$0, %eax
	je	.L11
	movl	-8(%ebp), %eax
	subl	$1, %eax
	movl	%eax, -40(%ebp)
	movl	-40(%ebp), %eax
	movl	%eax, -8(%ebp)
.L14:
	movl	-8(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -44(%ebp)
	movl	8(%ebp), %eax
	addl	-44(%ebp), %eax
	movl	%eax, -48(%ebp)
	movl	-48(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -52(%ebp)
	movl	-52(%ebp), %eax
	cmpl	-12(%ebp), %eax
	setg	%al
	movzbl	%al, %eax
	movl	%eax, -56(%ebp)
	movl	-56(%ebp), %eax
	cmpl	$0, %eax
	je	.L13
	movl	-8(%ebp), %eax
	subl	$1, %eax
	movl	%eax, -60(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, -8(%ebp)
	jmp	.L14
.L13:
	movl	-4(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -64(%ebp)
	movl	-64(%ebp), %eax
	movl	%eax, -4(%ebp)
.L16:
	movl	-4(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -68(%ebp)
	movl	8(%ebp), %eax
	addl	-68(%ebp), %eax
	movl	%eax, -72(%ebp)
	movl	-72(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -76(%ebp)
	movl	-76(%ebp), %eax
	cmpl	-12(%ebp), %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -80(%ebp)
	movl	-80(%ebp), %eax
	cmpl	$0, %eax
	je	.L15
	movl	-4(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -84(%ebp)
	movl	-84(%ebp), %eax
	movl	%eax, -4(%ebp)
	jmp	.L16
.L15:
	movl	-4(%ebp), %eax
	cmpl	-8(%ebp), %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -88(%ebp)
	movl	-88(%ebp), %eax
	cmpl	$0, %eax
	je	.L17
	movl	-8(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -96(%ebp)
	movl	8(%ebp), %eax
	addl	-96(%ebp), %eax
	movl	%eax, -100(%ebp)
	movl	-100(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-4(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -104(%ebp)
	movl	8(%ebp), %eax
	addl	-104(%ebp), %eax
	movl	%eax, -108(%ebp)
	movl	-108(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_exchange
	movl	%eax, -92(%ebp)
	jmp	.L18
.L17:
.L18:
	jmp	.L12
.L11:
	movl	-8(%ebp), %eax
	jmp	.L10
.L10:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	_partition
	.set	partition.size, 120

_quicksort:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$quicksort.size, %esp
	movl	16(%ebp), %eax
	cmpl	12(%ebp), %eax
	setg	%al
	movzbl	%al, %eax
	movl	%eax, -8(%ebp)
	movl	-8(%ebp), %eax
	cmpl	$0, %eax
	je	.L20
	movl	16(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_partition
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, -4(%ebp)
	movl	-4(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_quicksort
	movl	%eax, -16(%ebp)
	movl	16(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	-4(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -24(%ebp)
	movl	-24(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_quicksort
	movl	%eax, -20(%ebp)
	jmp	.L21
.L20:
.L21:
.L19:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	_quicksort
	.set	quicksort.size, 40

_main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$main.size, %esp
	movl	$8, %eax
	movl	%eax, _n
	movl	_n, %eax
	imull	$4, %eax
	movl	%eax, -8(%ebp)
	movl	-8(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_malloc
	movl	%eax, -4(%ebp)
	movl	-4(%ebp), %eax
	movl	%eax, _a
	call	_readarray
	movl	%eax, -12(%ebp)
	movl	_n, %eax
	subl	$1, %eax
	movl	%eax, -20(%ebp)
	movl	-20(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	$0, %eax
	movl	%eax, 4(%esp)
	movl	_a, %eax
	movl	%eax, 0(%esp)
	call	_quicksort
	movl	%eax, -16(%ebp)
	call	_writearray
	movl	%eax, -24(%ebp)
.L22:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	_main
	.set	main.size, 40

	.data
	.comm	_n, 4, 4
	.comm	_a, 4, 4
.L3:	.asciz	"%d"
.L7:	.asciz	"%d "
.L8:	.asciz	"\n"
