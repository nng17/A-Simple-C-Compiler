_lexan:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$lexan.size, %esp
	movl	_c, %eax
	cmpl	$0, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	cmpl	$0, %eax
	je	.L1
	call	_getchar
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	movl	%eax, _c
	jmp	.L2
.L1:
.L2:
.L4:
	movl	_c, %eax
	movl	%eax, 0(%esp)
	call	_isspace
	movl	%eax, -24(%ebp)
	movl	-24(%ebp), %eax
	cmpl	$0, %eax
	je	.L5
	movl	_c, %eax
	cmpl	_LF, %eax
	setne	%al
	movzbl	%al, %eax
	movl	%eax, -28(%ebp)
	movl	-28(%ebp), %eax
	cmpl	$0, %eax
.L5:
	setne	%al
	movzbl	%al, %eax
	movl	%eax, -20(%ebp)
	movl	-20(%ebp), %eax
	cmpl	$0, %eax
	je	.L3
	call	_getchar
	movl	%eax, -32(%ebp)
	movl	-32(%ebp), %eax
	movl	%eax, _c
	jmp	.L4
.L3:
	movl	_c, %eax
	movl	%eax, 0(%esp)
	call	_isdigit
	movl	%eax, -36(%ebp)
	movl	-36(%ebp), %eax
	cmpl	$0, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -40(%ebp)
	movl	-40(%ebp), %eax
	cmpl	$0, %eax
	je	.L6
	movl	_c, %eax
	movl	%eax, -8(%ebp)
	movl	$0, %eax
	movl	%eax, _c
	movl	-8(%ebp), %eax
	jmp	.L0
	jmp	.L7
.L6:
.L7:
	movl	$0, %eax
	movl	%eax, -4(%ebp)
.L9:
	movl	_c, %eax
	movl	%eax, 0(%esp)
	call	_isdigit
	movl	%eax, -44(%ebp)
	movl	-44(%ebp), %eax
	cmpl	$0, %eax
	je	.L8
	movl	-4(%ebp), %eax
	imull	$10, %eax
	movl	%eax, -48(%ebp)
	movl	-48(%ebp), %eax
	addl	_c, %eax
	movl	%eax, -52(%ebp)
	movl	-52(%ebp), %eax
	subl	$48, %eax
	movl	%eax, -56(%ebp)
	movl	-56(%ebp), %eax
	movl	%eax, -4(%ebp)
	movl	_c, %eax
	movl	%eax, 0(%esp)
	call	_getchar
	movl	%eax, -60(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, _c
	jmp	.L9
.L8:
	movl	-4(%ebp), %eax
	movl	%eax, _lexval
	movl	_NUM, %eax
	jmp	.L0
.L0:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	_lexan
	.set	lexan.size, 72

_match:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$match.size, %esp
	movl	_lookahead, %eax
	cmpl	8(%ebp), %eax
	setne	%al
	movzbl	%al, %eax
	movl	%eax, -4(%ebp)
	movl	-4(%ebp), %eax
	cmpl	$0, %eax
	je	.L11
	movl	_lookahead, %eax
	movl	%eax, 4(%esp)
	leal	.L13, %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_printf
	movl	%eax, -8(%ebp)
	movl	$1, %eax
	movl	%eax, 0(%esp)
	call	_exit
	movl	%eax, -16(%ebp)
	jmp	.L12
.L11:
.L12:
	call	_lexan
	movl	%eax, -20(%ebp)
	movl	-20(%ebp), %eax
	movl	%eax, _lookahead
.L10:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	_match
	.set	match.size, 40

_factor:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$factor.size, %esp
	movl	_lookahead, %eax
	cmpl	_LPAREN, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -8(%ebp)
	movl	-8(%ebp), %eax
	cmpl	$0, %eax
	je	.L15
	movl	_LPAREN, %eax
	movl	%eax, 0(%esp)
	call	_match
	movl	%eax, -12(%ebp)
	call	_expr
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	movl	%eax, -4(%ebp)
	movl	_RPAREN, %eax
	movl	%eax, 0(%esp)
	call	_match
	movl	%eax, -20(%ebp)
	movl	-4(%ebp), %eax
	jmp	.L14
	jmp	.L16
.L15:
.L16:
	movl	_lexval, %eax
	movl	%eax, -4(%ebp)
	movl	_NUM, %eax
	movl	%eax, 0(%esp)
	call	_match
	movl	%eax, -24(%ebp)
	movl	-4(%ebp), %eax
	jmp	.L14
.L14:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	_factor
	.set	factor.size, 40

_term:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$term.size, %esp
	call	_factor
	movl	%eax, -8(%ebp)
	movl	-8(%ebp), %eax
	movl	%eax, -4(%ebp)
.L19:
	movl	_lookahead, %eax
	cmpl	_MUL, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	cmpl	$0, %eax
	jne	.L20
	movl	_lookahead, %eax
	cmpl	_DIV, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -20(%ebp)
	movl	-20(%ebp), %eax
	cmpl	$0, %eax
.L20:
	setne	%al
	movzbl	%al, %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	cmpl	$0, %eax
	je	.L18
	movl	_lookahead, %eax
	cmpl	_MUL, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -24(%ebp)
	movl	-24(%ebp), %eax
	cmpl	$0, %eax
	je	.L21
	movl	_MUL, %eax
	movl	%eax, 0(%esp)
	call	_match
	movl	%eax, -28(%ebp)
	call	_factor
	movl	%eax, -32(%ebp)
	movl	-4(%ebp), %eax
	imull	-32(%ebp), %eax
	movl	%eax, -36(%ebp)
	movl	-36(%ebp), %eax
	movl	%eax, -4(%ebp)
	jmp	.L22
.L21:
	movl	_DIV, %eax
	movl	%eax, 0(%esp)
	call	_match
	movl	%eax, -40(%ebp)
	call	_factor
	movl	%eax, -44(%ebp)
	movl	-4(%ebp), %eax
	movl	-44(%ebp), %ecx
	cltd	
	idivl	%ecx
	movl	%eax, -48(%ebp)
	movl	-48(%ebp), %eax
	movl	%eax, -4(%ebp)
.L22:
	jmp	.L19
.L18:
	movl	-4(%ebp), %eax
	jmp	.L17
.L17:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	_term
	.set	term.size, 56

_expr:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$expr.size, %esp
	call	_term
	movl	%eax, -8(%ebp)
	movl	-8(%ebp), %eax
	movl	%eax, -4(%ebp)
.L25:
	movl	_lookahead, %eax
	cmpl	_ADD, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	cmpl	$0, %eax
	jne	.L26
	movl	_lookahead, %eax
	cmpl	_SUB, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -20(%ebp)
	movl	-20(%ebp), %eax
	cmpl	$0, %eax
.L26:
	setne	%al
	movzbl	%al, %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	cmpl	$0, %eax
	je	.L24
	movl	_lookahead, %eax
	cmpl	_ADD, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -24(%ebp)
	movl	-24(%ebp), %eax
	cmpl	$0, %eax
	je	.L27
	movl	_ADD, %eax
	movl	%eax, 0(%esp)
	call	_match
	movl	%eax, -28(%ebp)
	call	_term
	movl	%eax, -32(%ebp)
	movl	-4(%ebp), %eax
	addl	-32(%ebp), %eax
	movl	%eax, -36(%ebp)
	movl	-36(%ebp), %eax
	movl	%eax, -4(%ebp)
	jmp	.L28
.L27:
	movl	_SUB, %eax
	movl	%eax, 0(%esp)
	call	_match
	movl	%eax, -40(%ebp)
	call	_term
	movl	%eax, -44(%ebp)
	movl	-4(%ebp), %eax
	subl	-44(%ebp), %eax
	movl	%eax, -48(%ebp)
	movl	-48(%ebp), %eax
	movl	%eax, -4(%ebp)
.L28:
	jmp	.L25
.L24:
	movl	-4(%ebp), %eax
	jmp	.L23
.L23:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	_expr
	.set	expr.size, 56

_main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$main.size, %esp
	movl	$10, %eax
	movl	%eax, _LF
	movl	$40, %eax
	movl	%eax, _LPAREN
	movl	$41, %eax
	movl	%eax, _RPAREN
	movl	$42, %eax
	movl	%eax, _MUL
	movl	$43, %eax
	movl	%eax, _ADD
	movl	$45, %eax
	movl	%eax, _SUB
	movl	$47, %eax
	movl	%eax, _DIV
	movl	$256, %eax
	movl	%eax, _NUM
	call	_lexan
	movl	%eax, -8(%ebp)
	movl	-8(%ebp), %eax
	movl	%eax, _lookahead
.L31:
	movl	$1, %eax
	negl	%eax
	movl	%eax, -12(%ebp)
	movl	_lookahead, %eax
	cmpl	-12(%ebp), %eax
	setne	%al
	movzbl	%al, %eax
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	cmpl	$0, %eax
	je	.L30
	call	_expr
	movl	%eax, -20(%ebp)
	movl	-20(%ebp), %eax
	movl	%eax, -4(%ebp)
	movl	-4(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	.L32, %eax
	movl	%eax, -28(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, 0(%esp)
	call	_printf
	movl	%eax, -24(%ebp)
.L34:
	movl	_lookahead, %eax
	cmpl	_LF, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -32(%ebp)
	movl	-32(%ebp), %eax
	cmpl	$0, %eax
	je	.L33
	movl	_LF, %eax
	movl	%eax, 0(%esp)
	call	_match
	movl	%eax, -36(%ebp)
	jmp	.L34
.L33:
	jmp	.L31
.L30:
.L29:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	_main
	.set	main.size, 56

	.data
	.comm	_ADD, 4, 4
	.comm	_SUB, 4, 4
	.comm	_MUL, 4, 4
	.comm	_DIV, 4, 4
	.comm	_NUM, 4, 4
	.comm	_LF, 4, 4
	.comm	_LPAREN, 4, 4
	.comm	_RPAREN, 4, 4
	.comm	_lookahead, 4, 4
	.comm	_c, 4, 4
	.comm	_lexval, 4, 4
.L13:	.asciz	"syntax error at %d\n"
.L32:	.asciz	"%d\n"
