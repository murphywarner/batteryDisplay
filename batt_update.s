	.file	"batt_update.c"
	.text
	.globl	set_batt_from_ports
	.type	set_batt_from_ports, @function
# set_batt_from_ports:
#.LFB0:
#	.cfi_startproc
#	pushq	%rbp
#	.cfi_def_cfa_offset 16
#	.cfi_offset 6, -16
#	movq	%rsp, %rbp
#	.cfi_def_cfa_register 6
#	movq	%rdi, -8(%rbp)
#	movzwl	BATT_VOLTAGE_PORT(%rip), %eax
#	testw	%ax, %ax
#	jns	.L2
#	movl	$1, %eax
#	jmp	.L3
#.L2:
#	movzwl	BATT_VOLTAGE_PORT(%rip), %eax
#	movl	%eax, %edx
#	shrw	$15, %dx
#	addl	%edx, %eax
#	sarw	%ax
#	movl	%eax, %edx
#	movq	-8(%rbp), %rax
#	movw	%dx, (%rax)
#	movq	-8(%rbp), %rax
#	movzwl	(%rax), %eax
#	cmpw	$3799, %ax
#	jle	.L4
#	movq	-8(%rbp), %rax
#	movb	$100, 2(%rax)
#	jmp	.L5
#.L4:
#	movq	-8(%rbp), %rax
#	movzwl	(%rax), %eax
#	cmpw	$3000, %ax
#	jg	.L6
#	movq	-8(%rbp), %rax
#	movb	$0, 2(%rax)
#	jmp	.L5
#.L6:
#	movq	-8(%rbp), %rax
#	movzwl	(%rax), %eax
#	cwtl
#	subl	$3000, %eax
#	leal	7(%rax), %edx
#	testl	%eax, %eax
#	cmovs	%edx, %eax
#	sarl	$3, %eax
#	movl	%eax, %edx
#	movq	-8(%rbp), %rax
#	movb	%dl, 2(%rax)
#.L5:
#	movzbl	BATT_STATUS_PORT(%rip), %eax
#	shrb	$2, %al
#	movzbl	%al, %eax
#	andl	$1, %eax
#	testl	%eax, %eax
#	je	.L7
#	movq	-8(%rbp), %rax
#	movb	$2, 3(%rax)
#	jmp	.L8
#.L7:
#	movq	-8(%rbp), %rax
#	movb	$1, 3(%rax)
#.L8:
#	movl	$0, %eax
#.L3:
#	popq	%rbp
#	.cfi_def_cfa 7, 8
#	ret
#	.cfi_endproc
#.LFE0:
#	.size	set_batt_from_ports, .-set_batt_from_ports
#	.globl	set_display_from_batt
#	.type	set_display_from_batt, @function
set_display_from_batt:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$112, %rsp
	movl	%edi, -100(%rbp)
	movq	%rsi, -112(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$63, -64(%rbp)
	movl	$6, -60(%rbp)
	movl	$91, -56(%rbp)
	movl	$79, -52(%rbp)
	movl	$102, -48(%rbp)
	movl	$109, -44(%rbp)
	movl	$125, -40(%rbp)
	movl	$7, -36(%rbp)
	movl	$127, -32(%rbp)
	movl	$111, -28(%rbp)
	movl	$0, -24(%rbp)
	movzbl	-97(%rbp), %eax
	cmpb	$1, %al
	jne	.L10
	movzwl	-100(%rbp), %eax
	movswl	%ax, %edx
	imull	$26215, %edx, %edx
	shrl	$16, %edx
	sarw	$2, %dx
	sarw	$15, %ax
	movl	%edx, %ecx
	subl	%eax, %ecx
	movswl	%cx, %eax
	imull	$26215, %eax, %eax
	shrl	$16, %eax
	movl	%eax, %edx
	sarw	$2, %dx
	movl	%ecx, %eax
	sarw	$15, %ax
	subl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	addl	%eax, %eax
	subl	%eax, %ecx
	movl	%ecx, %edx
	movswl	%dx, %eax
	movl	%eax, -76(%rbp)
	movzwl	-100(%rbp), %ecx
	movswl	%cx, %eax
	imull	$26215, %eax, %eax
	shrl	$16, %eax
	movl	%eax, %edx
	sarw	$2, %dx
	movl	%ecx, %eax
	sarw	$15, %ax
	subl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	addl	%eax, %eax
	subl	%eax, %ecx
	movl	%ecx, %edx
	movswl	%dx, %eax
	movl	%eax, -68(%rbp)
	cmpl	$4, -68(%rbp)
	jle	.L11
	addl	$1, -76(%rbp)
.L11:
	movzwl	-100(%rbp), %eax
	movswl	%ax, %edx
	imull	$5243, %edx, %edx
	shrl	$16, %edx
	sarw	$3, %dx
	sarw	$15, %ax
	movl	%edx, %ecx
	subl	%eax, %ecx
	movswl	%cx, %eax
	imull	$26215, %eax, %eax
	shrl	$16, %eax
	movl	%eax, %edx
	sarw	$2, %dx
	movl	%ecx, %eax
	sarw	$15, %ax
	subl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	addl	%eax, %eax
	subl	%eax, %ecx
	movl	%ecx, %edx
	movswl	%dx, %eax
	movl	%eax, -80(%rbp)
	movzwl	-100(%rbp), %eax
	movswl	%ax, %edx
	imull	$-31981, %edx, %edx
	shrl	$16, %edx
	addl	%eax, %edx
	sarw	$9, %dx
	sarw	$15, %ax
	movl	%edx, %ecx
	subl	%eax, %ecx
	movswl	%cx, %eax
	imull	$26215, %eax, %eax
	shrl	$16, %eax
	movl	%eax, %edx
	sarw	$2, %dx
	movl	%ecx, %eax
	sarw	$15, %ax
	subl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	addl	%eax, %eax
	subl	%eax, %ecx
	movl	%ecx, %edx
	movswl	%dx, %eax
	movl	%eax, -84(%rbp)
	jmp	.L12
.L10:
	movzbl	-98(%rbp), %ecx
	movsbw	%cl, %ax
	imull	$103, %eax, %eax
	shrw	$8, %ax
	movl	%eax, %edx
	sarb	$2, %dl
	movl	%ecx, %eax
	sarb	$7, %al
	subl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	addl	%eax, %eax
	subl	%eax, %ecx
	movl	%ecx, %edx
	movsbl	%dl, %eax
	movl	%eax, -76(%rbp)
	movzbl	-98(%rbp), %eax
	movsbw	%al, %dx
	imull	$103, %edx, %edx
	shrw	$8, %dx
	sarb	$2, %dl
	sarb	$7, %al
	movl	%edx, %ecx
	subl	%eax, %ecx
	movsbw	%cl, %ax
	imull	$103, %eax, %eax
	shrw	$8, %ax
	movl	%eax, %edx
	sarb	$2, %dl
	movl	%ecx, %eax
	sarb	$7, %al
	subl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	addl	%eax, %eax
	subl	%eax, %ecx
	movl	%ecx, %edx
	movsbl	%dl, %eax
	movl	%eax, -80(%rbp)
	movzbl	-98(%rbp), %ecx
	movsbw	%cl, %dx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%edx, %eax
	shrw	$8, %ax
	movl	%eax, %edx
	sarb	$4, %dl
	movl	%ecx, %eax
	sarb	$7, %al
	movl	%edx, %ecx
	subl	%eax, %ecx
	movsbw	%cl, %ax
	imull	$103, %eax, %eax
	shrw	$8, %ax
	movl	%eax, %edx
	sarb	$2, %dl
	movl	%ecx, %eax
	sarb	$7, %al
	subl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	addl	%eax, %eax
	subl	%eax, %ecx
	movl	%ecx, %edx
	movsbl	%dl, %eax
	movl	%eax, -84(%rbp)
	cmpl	$0, -84(%rbp)
	jne	.L13
	movl	$10, -84(%rbp)
.L13:
	cmpl	$10, -84(%rbp)
	jne	.L12
	cmpl	$0, -80(%rbp)
	jne	.L12
	movl	$10, -80(%rbp)
.L12:
	movl	$0, -72(%rbp)
	movl	-84(%rbp), %eax
	cltq
	movl	-64(%rbp,%rax,4), %eax
	sall	$14, %eax
	orl	%eax, -72(%rbp)
	movl	-80(%rbp), %eax
	cltq
	movl	-64(%rbp,%rax,4), %eax
	sall	$7, %eax
	orl	%eax, -72(%rbp)
	movl	-76(%rbp), %eax
	cltq
	movl	-64(%rbp,%rax,4), %eax
	orl	%eax, -72(%rbp)
	movzbl	-97(%rbp), %eax
	cmpb	$1, %al
	jne	.L14
	orl	$12582912, -72(%rbp)
	jmp	.L15
.L14:
	orl	$2097152, -72(%rbp)
.L15:
	movzbl	-98(%rbp), %eax
	cmpb	$89, %al
	jle	.L16
	orl	$520093696, -72(%rbp)
	jmp	.L17
.L16:
	movzbl	-98(%rbp), %eax
	cmpb	$89, %al
	jg	.L18
	movzbl	-98(%rbp), %eax
	cmpb	$69, %al
	jle	.L18
	orl	$251658240, -72(%rbp)
	jmp	.L17
.L18:
	movzbl	-98(%rbp), %eax
	cmpb	$69, %al
	jg	.L19
	movzbl	-98(%rbp), %eax
	cmpb	$49, %al
	jle	.L19
	orl	$117440512, -72(%rbp)
	jmp	.L17
.L19:
	movzbl	-98(%rbp), %eax
	cmpb	$49, %al
	jg	.L20
	movzbl	-98(%rbp), %eax
	cmpb	$29, %al
	jle	.L20
	orl	$50331648, -72(%rbp)
	jmp	.L17
.L20:
	movzbl	-98(%rbp), %eax
	cmpb	$29, %al
	jg	.L17
	movzbl	-98(%rbp), %eax
	cmpb	$4, %al
	jle	.L17
	orl	$16777216, -72(%rbp)
.L17:
	movq	-112(%rbp), %rax
	movl	-72(%rbp), %edx
	movl	%edx, (%rax)
	movl	$0, %eax
	movq	-8(%rbp), %rsi
	xorq	%fs:40, %rsi
	je	.L23
	call	__stack_chk_fail@PLT
.L23:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	set_display_from_batt, .-set_display_from_batt
	.globl	batt_update
	.type	batt_update, @function
batt_update:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	-12(%rbp), %rax
	movq	%rax, %rdi
	call	set_batt_from_ports
	movl	%eax, -16(%rbp)
	cmpl	$1, -16(%rbp)
	jne	.L25
	movl	$1, %eax
	jmp	.L27
.L25:
	movl	-12(%rbp), %eax
	leaq	BATT_DISPLAY_PORT(%rip), %rsi
	movl	%eax, %edi
	call	set_display_from_batt
	movl	$0, %eax
.L27:
	movq	-8(%rbp), %rdx
	xorq	%fs:40, %rdx
	je	.L28
	call	__stack_chk_fail@PLT
.L28:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	batt_update, .-batt_update
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
