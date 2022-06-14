.data 
	n_ques:          .word 4
	
	$questions_arr:  .word q0, q1, q2, q3
	q0:              .asciiz "\nquestion 1\n"
	q1:              .asciiz "\nquestion 2\n"
	q2:		         .asciiz "\nquestion 3\n"
	q3:		         .asciiz "\nquestion 4\n"

	$options_arr:    .word q0op, q1op, q2op, q3op
	q0op:            .asciiz "a) 1\tb) 2\tc) 3\td) 4\te) 5\n"
	q1op:            .asciiz "a) 1\tb) 2\tc) 3\td) 4\te) 5\n"
	q2op:            .asciiz "a) 1\tb) 2\tc) 3\td) 4\te) 5\n"
	q3op:            .asciiz "a) 1\tb) 2\tc) 3\td) 4\te) 5\n"	
			
	$answers_arr:    .word 'a', 'b', 'c', 'd'
	
	$nums_generated: .space 16
	
	str1:            .asciiz "Enter the correct option: "
	success_str:     .asciiz "\nCorrect answer!\n\n"
	failure_str:     .asciiz "\nIncorrect answer!\n\n"
	
	
.text 
.globl main
    
main:
    la $s0, $questions_arr  # $s0 - address of question array
    la $s1, $options_arr    # $s1 - address of options array
    la $s2, $answers_arr    # $s2 - address of answers array
    la $s3, $nums_generated # $s3 - address of nums generated array
    li $s4, 4               # $s4 - size of one word
    lw $s5, n_ques			# $s5 - number of questions to ask
	li $s6, 0               # $s6 - current question number (zero based)
	
	j ask_rand_q

ask_rand_q:
	beq $s6, $s5, exit      # exit if all questions asked
	
    addi $sp, $sp, -8       # make space in stack
    jal get_rand_num        # $v0 - random number generated (no repitition)
	addi $sp, $sp, 8        # restore space in stack
	
    mul $t0, $s4, $v0       # $t0 - offset to access random question data
    add $t1, $s0, $t0       # $t1 - address of the rand question
    add $t2, $s1, $t0       # $t2 - address of the rand question's options
    add $t3, $s2, $t0       # $t3 - address of the rand question's answer
    lw $t4, ($t3) 	        # $t4 - correct answer to the rand question chosen
    
    # print question
    lw $a0, ($t1)
    li $v0, 4
    syscall
    
    # print options
    lw $a0, ($t2)
    li $v0, 4
    syscall
    
    # print "Enter the correct option: "
    la $a0, str1
    li $v0, 4
    syscall
    
    # get user input
    li $v0, 12                      # 12 - code to read char
    syscall                         # $v0 - user input
    
    addi $s6, $s6, 1                # increment current question number
    
    beq $v0, $t4, print_success_msg # branch if correct answer
    bne $v0, $t4, print_failure_msg # branch if wrong answer
	
get_rand_num:
	sw $ra, 0($sp) # save return address in stack

ensure_no_rep:
	# generate random number
	move $a1, $s5           # $a1 - upper limit
    li $v0, 42              # 42 - generate random number
    syscall		            # $a0 - random number generated
    
    # check if the generated rand num hasn't been used before
    sw $a0, 4($sp)	  	    # store generated number in stack
    jal is_rand_num_valid   # $v0 = 1 if valid; $v0 = 0 otherwise
    beqz $v0, ensure_no_rep # regenerate random number
    
    # update the numbers_generated array by appending the rand num generated
    mul $t0, $s6, $s4       # $t0 - offset based on curr ques number ($s6)
    add $t0, $t0, $s3       # $t0 - address where the number will be stored
    sw $a0, ($t0)	        # save generated number in numbers_generated array
    
    lw $v0, 4($sp)          # load generated number from stack
    
    lw $ra, 0($sp)          # load return address from stack
    jr $ra			        # jump back to the line after get_rand_num call in ask_rand_q
    
is_rand_num_valid:
	move $t0, $ra           # $t0 - return address				
	li $t1, 0               # $t1 - loop variable

loop:
	beq $t1, $s6, end_loop  # run loop only curr_ques_num times ($s6)
	
	mul $t2, $t1, $s4       # $t2 - offset for nums_generated
	add $t2, $t2, $s3       # $t2 - address of the $t1'th element of nums_generated
	lw $t3, ($t2)           # $t3 - $t1'th element of nums_generated
	
	addi $t1, $t1, 1        # increment loop variable
	
	bne $t3, $a0, loop      # continue if $t1 != rand num generated ($a0)
	
	li $v0, 0               # load 0 in $v0 (rand num generated in invalid)
	
	move $ra, $t0           # set return address
	jr $ra                  # jump to return address
	
end_loop:
	li $v0, 1               # load 1 in $v0 (rand num generated is valid)
	
	move $ra, $t0           # set return address
	jr $ra                  # jump to return address              
	
print_success_msg:
	# print success msg
	la $a0, success_str
	li $v0, 4
	syscall
	
	j ask_rand_q # ask next question

print_failure_msg:
	# print failure msg
	la $a0, failure_str
	li $v0, 4
	syscall
	
	j ask_rand_q # ask next question
 																															
exit:
	li $v0, 10
	syscall
