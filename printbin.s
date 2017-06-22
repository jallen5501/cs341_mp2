# printbin.s
        .data
        result:
                .ascii "0000 0000\0"
        .text
        .global _printbin
_printbin:

	push %ebp
        mov %esp, %ebp
        sub $8, %esp
        movl 8(%ebp), %eax
        movl %eax, -4(%ebp)     # saving unsigned char in -4(%ebp), users original input
	movl $0, -8(%ebp)
	movl %eax, -8(%ebp)
	shrl $4, -8(%ebp)

	movl $result, %edx
	call donibble
	
	addl $1, %edx
	movl -4(%ebp), %eax
	movl %eax, -8(%ebp) 
	call donibble
	movl $result, %eax
	mov %ebp, %esp
        popl %ebp
        ret
	
        movl $result, %eax
        mov %ebp, %esp
        popl %ebp
        ret  

donibble:
	push %ebp
        mov %esp, %ebp
	sub $16, %esp
	movl 8(%ebp), %eax
	xor %eax, %eax
	movb %al, -4(%ebp)	# char passed into function
	movl $4, -12(%ebp)	# -12(%ebp) holds the counter for the loop
	movl $3, -16(%ebp)	# -16(%ebp) hold the number of the right shift
	jmp loop1

loop1:
        movl 8(%ebp),%eax
        movl %eax, -8(%ebp)     # another copy of char passed into donibble, use for shifting
	movl -16(%ebp), %ecx	# I have to move the value in memory to a register in order to use that value for a shift
        shrl %cl, -8(%ebp)
        and $1, -8(%ebp)
        movzbl -8(%ebp), %eax
        addb $0x30, %al 
        movb %al, (%edx)	# ****replace result string with appropriate 0 or 1****
	addl $1, %edx
	sub $1, -16(%ebp) 	# decrement number of shifts for next loop 
	sub $1, -12(%ebp)	# decrement loop iterations
	cmpb $0, -12(%ebp)
	jne loop1
	mov %ebp, %esp
        popl %ebp
        ret 
