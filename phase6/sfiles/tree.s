_insert:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$insert.size, %esp
	movl	8(%ebp), %eax
	cmpl	$0, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -4(%ebp)
	movl	-4(%ebp), %eax
	cmpl	$0, %eax
	je	.L1
	movl	$3, %eax
	imull	$4, %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_malloc
	movl	%eax, -8(%ebp)
	movl	-8(%ebp), %eax
	movl	%eax, 8(%ebp)
	movl	$0, %eax
	imull	$4, %eax
	movl	%eax, -16(%ebp)
	movl	8(%ebp), %eax
	addl	-16(%ebp), %eax
	movl	%eax, -20(%ebp)
	movl	12(%ebp), %eax
	movl	-20(%ebp), %ecx
	movl	%eax, (%ecx)
	movl	$1, %eax
	imull	$4, %eax
	movl	%eax, -24(%ebp)
	movl	8(%ebp), %eax
	addl	-24(%ebp), %eax
	movl	%eax, -28(%ebp)
	movl	_null, %eax
	movl	-28(%ebp), %ecx
	movl	%eax, (%ecx)
	movl	$2, %eax
	imull	$4, %eax
	movl	%eax, -32(%ebp)
	movl	8(%ebp), %eax
	addl	-32(%ebp), %eax
	movl	%eax, -36(%ebp)
	movl	_null, %eax
	movl	-36(%ebp), %ecx
	movl	%eax, (%ecx)
	jmp	.L2
.L1:
	movl	$0, %eax
	imull	$4, %eax
	movl	%eax, -40(%ebp)
	movl	8(%ebp), %eax
	addl	-40(%ebp), %eax
	movl	%eax, -44(%ebp)
	movl	-44(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -48(%ebp)
	movl	12(%ebp), %eax
	cmpl	-48(%ebp), %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -52(%ebp)
	movl	-52(%ebp), %eax
	cmpl	$0, %eax
	je	.L3
	movl	$1, %eax
	imull	$4, %eax
	movl	%eax, -56(%ebp)
	movl	8(%ebp), %eax
	addl	-56(%ebp), %eax
	movl	%eax, -60(%ebp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$1, %eax
	imull	$4, %eax
	movl	%eax, -68(%ebp)
	movl	8(%ebp), %eax
	addl	-68(%ebp), %eax
	movl	%eax, -72(%ebp)
	movl	-72(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -76(%ebp)
	movl	-76(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_insert
	movl	%eax, -64(%ebp)
	movl	-64(%ebp), %eax
	movl	-60(%ebp), %ecx
	movl	%eax, (%ecx)
	jmp	.L4
.L3:
	movl	$0, %eax
	imull	$4, %eax
	movl	%eax, -80(%ebp)
	movl	8(%ebp), %eax
	addl	-80(%ebp), %eax
	movl	%eax, -84(%ebp)
	movl	-84(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -88(%ebp)
	movl	12(%ebp), %eax
	cmpl	-88(%ebp), %eax
	setg	%al
	movzbl	%al, %eax
	movl	%eax, -92(%ebp)
	movl	-92(%ebp), %eax
	cmpl	$0, %eax
	je	.L5
	movl	$2, %eax
	imull	$4, %eax
	movl	%eax, -96(%ebp)
	movl	8(%ebp), %eax
	addl	-96(%ebp), %eax
	movl	%eax, -100(%ebp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$2, %eax
	imull	$4, %eax
	movl	%eax, -108(%ebp)
	movl	8(%ebp), %eax
	addl	-108(%ebp), %eax
	movl	%eax, -112(%ebp)
	movl	-112(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -116(%ebp)
	movl	-116(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_insert
	movl	%eax, -104(%ebp)
	movl	-104(%ebp), %eax
	movl	-100(%ebp), %ecx
	movl	%eax, (%ecx)
	jmp	.L6
.L5:
.L6:
.L4:
.L2:
	movl	8(%ebp), %eax
	jmp	.L0
.L0:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	_insert
	.set	insert.size, 136

_search:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$search.size, %esp
	movl	8(%ebp), %eax
	cmpl	$0, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -4(%ebp)
	movl	-4(%ebp), %eax
	cmpl	$0, %eax
	je	.L8
	movl	$0, %eax
	jmp	.L7
	jmp	.L9
.L8:
.L9:
	movl	$0, %eax
	imull	$4, %eax
	movl	%eax, -8(%ebp)
	movl	8(%ebp), %eax
	addl	-8(%ebp), %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -16(%ebp)
	movl	12(%ebp), %eax
	cmpl	-16(%ebp), %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -20(%ebp)
	movl	-20(%ebp), %eax
	cmpl	$0, %eax
	je	.L10
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$1, %eax
	imull	$4, %eax
	movl	%eax, -28(%ebp)
	movl	8(%ebp), %eax
	addl	-28(%ebp), %eax
	movl	%eax, -32(%ebp)
	movl	-32(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -36(%ebp)
	movl	-36(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_search
	movl	%eax, -24(%ebp)
	movl	-24(%ebp), %eax
	jmp	.L7
	jmp	.L11
.L10:
.L11:
	movl	$0, %eax
	imull	$4, %eax
	movl	%eax, -40(%ebp)
	movl	8(%ebp), %eax
	addl	-40(%ebp), %eax
	movl	%eax, -44(%ebp)
	movl	-44(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -48(%ebp)
	movl	12(%ebp), %eax
	cmpl	-48(%ebp), %eax
	setg	%al
	movzbl	%al, %eax
	movl	%eax, -52(%ebp)
	movl	-52(%ebp), %eax
	cmpl	$0, %eax
	je	.L12
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$2, %eax
	imull	$4, %eax
	movl	%eax, -60(%ebp)
	movl	8(%ebp), %eax
	addl	-60(%ebp), %eax
	movl	%eax, -64(%ebp)
	movl	-64(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -68(%ebp)
	movl	-68(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_search
	movl	%eax, -56(%ebp)
	movl	-56(%ebp), %eax
	jmp	.L7
	jmp	.L13
.L12:
.L13:
	movl	$1, %eax
	jmp	.L7
.L7:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	_search
	.set	search.size, 88

_preorder:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$preorder.size, %esp
	movl	8(%ebp), %eax
	cmpl	$0, %eax
	je	.L15
	movl	$0, %eax
	imull	$4, %eax
	movl	%eax, -8(%ebp)
	movl	8(%ebp), %eax
	addl	-8(%ebp), %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	movl	%eax, -4(%ebp)
	movl	-4(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -24(%ebp)
	movl	-24(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	.L17, %eax
	movl	%eax, -28(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_printf
	movl	%eax, -20(%ebp)
	movl	$1, %eax
	imull	$4, %eax
	movl	%eax, -36(%ebp)
	movl	8(%ebp), %eax
	addl	-36(%ebp), %eax
	movl	%eax, -40(%ebp)
	movl	-40(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -44(%ebp)
	movl	-44(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_preorder
	movl	%eax, -32(%ebp)
	movl	$2, %eax
	imull	$4, %eax
	movl	%eax, -52(%ebp)
	movl	8(%ebp), %eax
	addl	-52(%ebp), %eax
	movl	%eax, -56(%ebp)
	movl	-56(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -60(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_preorder
	movl	%eax, -48(%ebp)
	jmp	.L16
.L15:
.L16:
.L14:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	_preorder
	.set	preorder.size, 72

_inorder:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$inorder.size, %esp
	movl	8(%ebp), %eax
	cmpl	$0, %eax
	je	.L19
	movl	$0, %eax
	imull	$4, %eax
	movl	%eax, -8(%ebp)
	movl	8(%ebp), %eax
	addl	-8(%ebp), %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	movl	%eax, -4(%ebp)
	movl	$1, %eax
	imull	$4, %eax
	movl	%eax, -24(%ebp)
	movl	8(%ebp), %eax
	addl	-24(%ebp), %eax
	movl	%eax, -28(%ebp)
	movl	-28(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -32(%ebp)
	movl	-32(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_inorder
	movl	%eax, -20(%ebp)
	movl	-4(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -40(%ebp)
	movl	-40(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	.L21, %eax
	movl	%eax, -44(%ebp)
	movl	-44(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_printf
	movl	%eax, -36(%ebp)
	movl	$2, %eax
	imull	$4, %eax
	movl	%eax, -52(%ebp)
	movl	8(%ebp), %eax
	addl	-52(%ebp), %eax
	movl	%eax, -56(%ebp)
	movl	-56(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -60(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_inorder
	movl	%eax, -48(%ebp)
	jmp	.L20
.L19:
.L20:
.L18:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	_inorder
	.set	inorder.size, 72

_main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$main.size, %esp
	movl	$0, %eax
	movl	%eax, -48(%ebp)
.L24:
	movl	-48(%ebp), %eax
	cmpl	$8, %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -52(%ebp)
	movl	-52(%ebp), %eax
	cmpl	$0, %eax
	je	.L23
	leal	-44(%ebp), %eax
	movl	%eax, -56(%ebp)
	movl	-48(%ebp), %eax
	imull	$4, %eax
	movl	%eax, -60(%ebp)
	movl	-56(%ebp), %eax
	addl	-60(%ebp), %eax
	movl	%eax, -64(%ebp)
	movl	-48(%ebp), %eax
	movl	-64(%ebp), %ecx
	movl	%eax, (%ecx)
	movl	-48(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -68(%ebp)
	movl	-68(%ebp), %eax
	movl	%eax, -48(%ebp)
	jmp	.L24
.L23:
	movl	_null, %eax
	movl	%eax, -4(%ebp)
	leal	-44(%ebp), %eax
	movl	%eax, -76(%ebp)
	movl	$7, %eax
	imull	$4, %eax
	movl	%eax, -80(%ebp)
	movl	-76(%ebp), %eax
	addl	-80(%ebp), %eax
	movl	%eax, -84(%ebp)
	movl	-84(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-4(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_insert
	movl	%eax, -72(%ebp)
	movl	-72(%ebp), %eax
	movl	%eax, -4(%ebp)
	leal	-44(%ebp), %eax
	movl	%eax, -92(%ebp)
	movl	$4, %eax
	imull	$4, %eax
	movl	%eax, -96(%ebp)
	movl	-92(%ebp), %eax
	addl	-96(%ebp), %eax
	movl	%eax, -100(%ebp)
	movl	-100(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-4(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_insert
	movl	%eax, -88(%ebp)
	movl	-88(%ebp), %eax
	movl	%eax, -4(%ebp)
	leal	-44(%ebp), %eax
	movl	%eax, -108(%ebp)
	movl	$1, %eax
	imull	$4, %eax
	movl	%eax, -112(%ebp)
	movl	-108(%ebp), %eax
	addl	-112(%ebp), %eax
	movl	%eax, -116(%ebp)
	movl	-116(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-4(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_insert
	movl	%eax, -104(%ebp)
	movl	-104(%ebp), %eax
	movl	%eax, -4(%ebp)
	leal	-44(%ebp), %eax
	movl	%eax, -124(%ebp)
	movl	$0, %eax
	imull	$4, %eax
	movl	%eax, -128(%ebp)
	movl	-124(%ebp), %eax
	addl	-128(%ebp), %eax
	movl	%eax, -132(%ebp)
	movl	-132(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-4(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_insert
	movl	%eax, -120(%ebp)
	movl	-120(%ebp), %eax
	movl	%eax, -4(%ebp)
	leal	-44(%ebp), %eax
	movl	%eax, -140(%ebp)
	movl	$5, %eax
	imull	$4, %eax
	movl	%eax, -144(%ebp)
	movl	-140(%ebp), %eax
	addl	-144(%ebp), %eax
	movl	%eax, -148(%ebp)
	movl	-148(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-4(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_insert
	movl	%eax, -136(%ebp)
	movl	-136(%ebp), %eax
	movl	%eax, -4(%ebp)
	leal	-44(%ebp), %eax
	movl	%eax, -156(%ebp)
	movl	$2, %eax
	imull	$4, %eax
	movl	%eax, -160(%ebp)
	movl	-156(%ebp), %eax
	addl	-160(%ebp), %eax
	movl	%eax, -164(%ebp)
	movl	-164(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-4(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_insert
	movl	%eax, -152(%ebp)
	movl	-152(%ebp), %eax
	movl	%eax, -4(%ebp)
	leal	-44(%ebp), %eax
	movl	%eax, -172(%ebp)
	movl	$3, %eax
	imull	$4, %eax
	movl	%eax, -176(%ebp)
	movl	-172(%ebp), %eax
	addl	-176(%ebp), %eax
	movl	%eax, -180(%ebp)
	movl	-180(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-4(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_insert
	movl	%eax, -168(%ebp)
	movl	-168(%ebp), %eax
	movl	%eax, -4(%ebp)
	leal	-44(%ebp), %eax
	movl	%eax, -188(%ebp)
	movl	$6, %eax
	imull	$4, %eax
	movl	%eax, -192(%ebp)
	movl	-188(%ebp), %eax
	addl	-192(%ebp), %eax
	movl	%eax, -196(%ebp)
	movl	-196(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-4(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_insert
	movl	%eax, -184(%ebp)
	movl	-184(%ebp), %eax
	movl	%eax, -4(%ebp)
	leal	.L25, %eax
	movl	%eax, -204(%ebp)
	movl	-204(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_printf
	movl	%eax, -200(%ebp)
	movl	-4(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_preorder
	movl	%eax, -208(%ebp)
	leal	.L26, %eax
	movl	%eax, -216(%ebp)
	movl	-216(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_printf
	movl	%eax, -212(%ebp)
	movl	-4(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_inorder
	movl	%eax, -220(%ebp)
.L22:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	_main
	.set	main.size, 232

	.data
	.comm	_null, 4, 4
.L17:	.asciz	"%d\n"
.L21:	.asciz	"%d\n"
.L25:	.asciz	"preorder traversal:\n"
.L26:	.asciz	"inorder traversal:\n"
