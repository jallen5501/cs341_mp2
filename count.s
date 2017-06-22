# count.s
	.text
	.global _count
_count:
	push %ebp
	mov %esp, %ebp
	sub $8, %esp			# allocate 12 bytes of memory for the stack
	movl 8(%ebp), %ebx
	movl %eax, -4(%ebp)		#save "Harambe" in ebp-4
	movzbl 12(%ebp), %edx
	movl %edx, -8(%ebp)		#save 'a' in ebp-8
	xorl %ecx, %ecx			#register oints to an int with valur, 0. will be used to represent # of matching characters
	movl -4(%ebp), %eax		#ebx points to "Harambe"
	movzbl (%eax), %eax
	cmpb -8(%ebp),%al
	jne .increment
	je .equal

.increment:
	movl -4(%ebp), %eax
	addl $1, -4(%ebp);
	addl $1, %eax                   #ebx points to next char in "Harambe"
	movzbl (%eax), %eax
	testb %al,%al
	je .return
	cmpb -8(%ebp), %al
        jne .increment
        je .equal


.equal:
	addl $1, %ecx			#increment count
	jmp .increment

.return:
	movl %ecx, %eax
	mov %ebp, %esp
	popl %ebp
	ret
	.end	


