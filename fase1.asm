.data 
	
	$questions_arr:       .word q0, q1, q2, q3
	q0:     .asciiz "question 1\n"
	q1:     .asciiz "question 2\n"
	q2:	.asciiz "question 3\n"
	q3:	.asciiz "question 4\n"


	$options_arr:         .word q0op, q1op, q2op, q3op
	q0op:   .asciiz "a) 1\nb) 2\nc) 3\nd) 4\n\n"
	q1op:   .asciiz "a) 1\nb) 2\nc) 3\nd) 4\n\n"
	q2op:   .asciiz "a) 1\nb) 2\nc) 3\nd) 4\n\n"
	q3op:   .asciiz "a) 1\nb) 2\nc) 3\nd) 4\n\n"	
			
	$answers_arr:         .word 'a', 'b', 'c', 'd'
	
	size:   .word 4
	
	numbers_generated: .space 4
	
.text 

rng: 
    li $a1, 4     #Here you set $a1 to the max bound.
    li $v0, 42       #generates the random number.
    syscall
    
    #n tests of comparissons until diferent
    #jal testfunction
    
    #beq rng #redo loop
    
    li $t0, 4          #loading 4 to $t0 to multiply by index
    mul $s3, $t0, $a0  #acessing array index 4 by 4 (4,8,12...)
    
main: 
    li $s4, 0
    
    #move $s3, $a0
    #li $v0, 1
    #syscall
    #j exit
    la $s0, $questions_arr # get array address 
    la $s1, $options_arr   # get array address 
    la $s2, $answers_arr   # get array address 
    
    add $t0, $s0, $s3
    #li  $v0, 1
    #syscall
    #j exit
    lw $a0, ($t0) # print value at the array pointer (array is storing the address 4 bits each)	
    li $v0, 4
    
    syscall																																

exit: #end program
    li $v0, 10		
    syscall						