main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$main.size, %esp
INSIDE FOR
	movl	$0, %eax
	movl	%eax, -4(%ebp)
.L1:
	movl	-4(%ebp), %eax
	cmpl	$5, %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -8(%ebp)
	movl	-4(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, -4(%ebp)
	movl	-8(%ebp), %eax
	cmpl	$0, %eax
	je	.L2
	leal	.L3, %eax
	movl	%eax, -20(%ebp)
	pushl	-20(%ebp)
	call	printf
	addl	$4, %esp
	movl	%eax, -16(%ebp)
	jmp	.L1
.L2:
.L0:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	main
	.set	main.size, 20

.L3:	.asciz	"hey\n"
