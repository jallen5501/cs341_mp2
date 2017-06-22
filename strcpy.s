# strcpy.s
	.text
	.global mystrcpy
mystrcpy:
	push %ebp
	mov %esp, %ebp
	sub $8, %esp
	movl 8(%ebp), %ecx
	movl %ecx, -8(%ebp)
	movl 12(%ebp), %eax
        movl %eax, -4(%ebp)     # -4(%ebp) holds the pointer to "Hello World"
	xor %edx, %edx
	jmp copystr

copystr:
	movzbl (%eax), %edx	# edx hold the value, "H"
	movb %dl, (%ecx)
	testb %dl, %dl
	je done 
	addl $1, %eax
	addl $1, %ecx
	jmp copystr

done:
	movl -8(%ebp), %eax
	mov %ebp, %esp
        popl %ebp
        ret 
        .end 

