.data
	End:    .asciiz "End"
	
	X:       .word Ryan, Tammi, Mike, Jessica
	Ryan:    .asciiz "Ryan\n"
	Tammi:   .asciiz "Tammi\n"
	Mike:    .asciiz "Mike\n"
	Jessica: .asciiz "Jessica\n"
	
size: .word 3

.text 
t:
	la $t1, X # get array address
	
	#addi $t1, $t1, 4
	
	lw $a0, 4($t1) # print value at the array pointer (array is storing the address 4 bits each)	
	#li $v0, 4
	li $v0, 4
	syscall
main:
	j exit
	lw $t3, size
	
	la $t1, X # get array address
	li $t2, 0 # set loop counter
	syscall
	
	addi $t1, $t1, 4
	lw $a0, ($t1)

print_loop:
	beq $t2, $t3, print_loop_end # check for array end
	lw $a0, ($t1) # print value at the array pointer	
	li $v0, 4
	syscall
	addi $t2, $t2, 1 # advance loop counter
	addi $t1, $t1, 4 # advance array pointer
	j print_loop # repeat the loop


print_loop_end:
	
	la $a0, End # print value at the array pointer
	li $v0, 4
	syscall

exit: 
	
	
	
	