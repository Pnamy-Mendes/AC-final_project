.data 
	n_lvls:                .word 3
	n_ques:                .word 4
	n_ques_to_pass:        .word 2
	
	q_files: .word qfile1, qfile2, qfile3
	qfile1: .asciiz "0.in"
	qfile2: .asciiz "1.in"
	qfile3: .asciiz "2.in"

	#$questions_data:       .word $lvl_1_qs_arr, $lvl_2_qs_arr, $lvl_3_qs_arr
	$options_data:         .word $lvl_1_ops_arr, $lvl_2_ops_arr, $lvl_3_ops_arr
	$answers_data:         .word $lvl_1_answers_arr, $lvl_2_answers_arr, $lvl_3_answers_arr
	$nums_generated_data:  .word $lvl_1_nums_generated, $lvl_2_nums_generated, $lvl_3_nums_generated


	$qs_arr:         .word q0, q1, q2, q3
	q0:              .space 512
	q1:              .space 512
	q2:		         .space 512
	q3:		         .space 512

	$lvl_1_ops_arr:        .word lvl_1_q0op, lvl_1_q1op, lvl_1_q2op, lvl_1_q3op
	lvl_1_q0op:            .asciiz "a) 1\tb) 2\tc) 3\td) 4\te) 5\n"
	lvl_1_q1op:            .asciiz "a) 1\tb) 2\tc) 3\td) 4\te) 5\n"
	lvl_1_q2op:            .asciiz "a) 1\tb) 2\tc) 3\td) 4\te) 5\n"
	lvl_1_q3op:            .asciiz "a) 1\tb) 2\tc) 3\td) 4\te) 5\n"	

	$lvl_2_ops_arr:        .word lvl_2_q0op, lvl_2_q1op, lvl_2_q2op, lvl_2_q3op
	lvl_2_q0op:            .asciiz "a) 1\tb) 2\tc) 3\td) 4\te) 5\n"
	lvl_2_q1op:            .asciiz "a) 1\tb) 2\tc) 3\td) 4\te) 5\n"
	lvl_2_q2op:            .asciiz "a) 1\tb) 2\tc) 3\td) 4\te) 5\n"
	lvl_2_q3op:            .asciiz "a) 1\tb) 2\tc) 3\td) 4\te) 5\n"	

	$lvl_3_ops_arr:        .word lvl_3_q0op, lvl_3_q1op, lvl_3_q2op, lvl_3_q3op
	lvl_3_q0op:            .asciiz "a) 1\tb) 2\tc) 3\td) 4\te) 5\n"
	lvl_3_q1op:            .asciiz "a) 1\tb) 2\tc) 3\td) 4\te) 5\n"
	lvl_3_q2op:            .asciiz "a) 1\tb) 2\tc) 3\td) 4\te) 5\n"
	lvl_3_q3op:            .asciiz "a) 1\tb) 2\tc) 3\td) 4\te) 5\n"	
			
	$lvl_1_answers_arr:    .word 'a', 'b', 'c', 'd'
	$lvl_2_answers_arr:    .word 'a', 'b', 'c', 'd'
	$lvl_3_answers_arr:    .word 'a', 'b', 'c', 'd'

	$lvl_1_nums_generated: .space 16
	$lvl_2_nums_generated: .space 16
	$lvl_3_nums_generated: .space 16

	enter_option_str:      .asciiz "Enter the correct option: "
	ans_success_str:       .asciiz "\nCorrect answer!\n\n"
	ans_failure_str:       .asciiz "\nIncorrect answer!\n\n"
	lvl_failure_str:       .asciiz "\nLevel Failed!\n\n"
	thank_you_str:         .asciiz "\nThank you for playing!\n\n"
	lvl_result_str:        .asciiz "\nCorrectly answered: "
	new_line:              .asciiz "\n"
	slash:                 .asciiz " / "
	
	char_buffer: .space 1

	
.text 
.globl main

main:
	li $s0, 0                     # $s0 - current level (zero-based)stack
	jal load_questions
	j loop_over_lvls
	
	
load_questions:
	move $s7 $ra # save return address

    # open file
    li $v0 13         # syscall for open file
    la $t0 q_files    # question filenames array
    sll $t1 $s0 2     # offset based on curr lvl
    add $t1 $t0 $t1   # $t1 - the address to the address of the filename
    lw $a0 ($t1)      # $a0 - address to the file name
    li $a1 0          # read flag
    li $a2 0          # ignore mode 
    syscall           # open file
    move $t0 $v0      # $t0 - file desciptor 

    # only $t0 is in use at this point, all others can be overwritten
	
    la $t1 $qs_arr  # address to ques array
    lw $t1 0($t1) # $t1 - address to curr ques buffer
    li $t2 0        # current ques number
    li $t3 0        # current ques length

    # only $t0, $t1, $t2 and $t3 are in use

    j read_byte
   

read_byte:
    # read byte from file
    li $v0 14          # syscall for read file
    move $a0 $t0       # file descriptor 
    la $a1 char_buffer # address of dest buffer
    li $a2 1           # buffer length
    syscall            # read byte from file

    # keep reading until bytes read <= 0
    blez $v0 load_done

    # if current byte is a newline, consume line
    lb $t4 char_buffer        # the byte read
    li $t5 13                 # 13 - carriage return
    beq $t4 $t5 consume_line

    # otherwise, append byte to line
    add $t5 $t3 $t1  # address of the space next to the last char in curr ques buffer
    sb $t4 ($t5)     # put the byte read at that space

    addi $t3 $t3 1   # increment ques length

    b read_byte
 
 
consume_line:
    # null terminate line
    add $t4 $t3 $t1 # address of the space next to the last char in curr ques buffer
    sb $zero ($t4)  # put null character at that space

	addi $t2 $t2 1  # increment ques number
    li $t3 0        # reset ques length

    # jump to load_done if all questions read
    lw $t4 n_ques
    beq $t2 $t4 load_done

    # only $t0, $t1, $t2 and $t3 are in use

    # set $t1 to the address to the next question's buffer
    la $t1 $qs_arr  # address to ques array
    sll $t4 $t2 2   # compute offset based on question number
    add $t1 $t1 $t4 # address to the address of the curr ques buffer
    lw $t1 ($t1)    # $t1 - address to curr ques buffer

    b read_byte


load_done:
    # close file
    li $v0 16     # syscall for close file
    move $a0 $t0  # file descriptor to close
    syscall       # close file
    
    move $ra $s7
    jr $ra

		
loop_over_lvls:
	mul $t1, $s0, 4               # calculate offset to access data for this lvl

	la $s1, $qs_arr               # address of the array of questions

	la $t3, $options_data         # $t3 - address of the options_data array
	add $t3, $t3, $t1             # $t3 - adress of the $s0'th item of options_data
	lw $s2, 0($t3)                # $s2 - address of options array for this lvl

	la $t4, $answers_data         # $t4 - address of the answers_data array
	add $t4, $t4, $t1             # $t4 - adress of the $s0'th item of answers_data
	lw $s3, 0($t4)                # $s3 - address of answers array for this lvl

	la $t5, $nums_generated_data  # $t5 - address of the nums_generated_data array
	add $t5, $t5, $t1             # $t5 - adress of the $s0'th item of nums_generated_data
	lw $s4, 0($t5)                # $s4 - address of nums_generated array for this lvl

	li $s5, 0                     # $s5 - current question number (zero based)
	li $s6, 0                     # $s6 - correct answer counter

	j ask_next_q


ask_next_q:
	lw $t0, n_ques                # $t0 - number of questions per level
	beq $s5, $t0, next_lvl        # exit if all questions for level asked

	addi $sp, $sp, -8             # make space in stack
	jal get_rand_num              # $v0 - random number generated (without repitition)
	addi $sp, $sp, 8              # restore space in stack

	mul $t0, $v0, 4               # $t0 - offset
	add $t1, $s1, $t0             # $t1 - address of the question string
	add $t2, $s2, $t0             # $t2 - address of the options string
	add $t3, $s3, $t0             # $t3 - address of the correct answer
	lw $t4, ($t3) 	              # $t4 - correct answer to current ques

	lw $a0, ($t1)                 # print question
	li $v0, 4
	syscall

	lw $a0, ($t2)                 # print options
	li $v0, 4
	syscall

	la $a0, enter_option_str      # print enter option prompt
	li $v0, 4
	syscall

	li $v0, 12                    # 12 - code to read user input char
	syscall                       # $v0 - user input

	addi $s5, $s5, 1              # increment current ques number counter

	beq $v0, $t4, correct_answer  # branch if correct answer
	bne $v0, $t4, wrong_answer    # branch if wrong answer
	

get_rand_num:
	sw $ra, 0($sp)                # save return address in stack


ensure_no_rep:
	# generate random number
	lw $a1, n_ques                # $a1 - upper limit
	li $v0, 42                    # 42 - generate random number
	syscall		                  # $a0 - random number generated

	# check if the generated rand num hasn't been used before
	sw $a0, 4($sp)	  	          # store generated number in stack
	jal is_rand_num_valid         # $v0 = 1 if valid; $v0 = 0 otherwise
	beqz $v0, ensure_no_rep       # regenerate random number

	# update the numbers_generated array by appending the rand num generated
	lw $t1, n_ques
	mul $t0, $s5, $t1             # $t0 - offset based on curr ques number ($s5)
	add $t0, $t0, $s4             # $t0 - address where the number will be stored
	sw $a0, ($t0)	              # save generated number in numbers_generated array

	lw $v0, 4($sp)                # load generated number from stack

	lw $ra, 0($sp)                # load return address from stack
	jr $ra			              # jump back to the line after get_rand_num call in ask_next_q
    

is_rand_num_valid:
	move $t0, $ra                 # $t0 - return address				
	li $t1, 0                     # $t1 - loop variable
	j loop


loop:
	beq $t1, $s5, end_loop        # run loop only curr_ques_num times ($s5)

	lw  $t4, n_ques
	mul $t2, $t1, $t4             # $t2 - offset for nums_generated
	add $t2, $t2, $s4             # $t2 - address of the $t1'th element of nums_generated
	lw $t3, ($t2)                 # $t3 - $t1'th element of nums_generated

	addi $t1, $t1, 1              # increment loop variable

	bne $t3, $a0, loop            # continue if $t1 != rand num generated ($a0)

	li $v0, 0                     # load 0 in $v0 (rand num generated in invalid)

	move $ra, $t0                 # set return address
	jr $ra                        # jump to return address
	

end_loop:
	li $v0, 1                     # load 1 in $v0 (rand num generated is valid)

	move $ra, $t0                 # set return address
	jr $ra                        # jump to return address              
	

correct_answer:
	addi $s6, $s6, 1              # increment correct answer counter

	la $a0, ans_success_str       # print success msg
	li $v0, 4
	syscall

	j ask_next_q                  # ask next question


wrong_answer:
	la $a0, ans_failure_str       # print failure msg
	li $v0, 4
	syscall

	j ask_next_q                  # ask next question
	

next_lvl:
	# print result for level
	li $v0, 4                     # print lvl_result str
	la $a0, lvl_result_str
	syscall

	li $v0, 1                     # print correct answers value
	move $a0, $s6
	syscall

	li $v0, 4                     # print slash
	la $a0, slash
	syscall

	li $v0, 1                     # print total no. of ques
	lw $a0, n_ques
	syscall

	li $v0, 4                     # print new line
	la $a0, new_line
	syscall

	lw $t0, n_ques_to_pass        # $t0 - number of correct answers needed to pass level
	blt $s6, $t0, lvl_failed      # end level if correct answers < correct answers needed
	
	addi $s0, $s0, 1              # increment current level number
	
	lw $t0, n_lvls                # $t0 - number of levels
	beq $s0, $t0, quiz_over       # exit program if all levels done

	jal load_questions            # load questions for next level
	j loop_over_lvls              # next level
	

lvl_failed:
	li $v0, 4                     # print lvl_failure_str
	la $a0, lvl_failure_str
	syscall

	j exit                        # end program
	

quiz_over:
	li $v0, 4                     # print thank you message
	la $a0, thank_you_str
	syscall

	j exit                        # end program


exit:
	li $v0, 10                    # 10 - exit
	syscall
