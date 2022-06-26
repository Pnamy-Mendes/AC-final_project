####################################################################
# PROJETO DE ARQUITETURA DE COMPUTADORES 2021/2022 - UAL
#
# TEMA: Jogo de Aprendizagem    Fase: 4
#
# GRUPO:
# Anees Asghar - 30008766
# Diogo Pinto  - 30009004
# João Nunes   - 30008945
# Pedro Mendes - 30009273
#
####################################################################

.data 
	n_lvls:                .word 3   # number of levels
	n_ques:                .word 10  # number of questions per level
	n_ans_to_pass:         .word 5   # number of correct answers needed to pass a level
	
	# files where questions for each level are stored
	$q_files:              .word qfile0, qfile1, qfile2, qfile3, qfile4, qfile5
	qfile0:                .asciiz "files\\LVL0Q.in"
	qfile1:                .asciiz "files\\LVL1Q.in"
	qfile2:                .asciiz "files\\LVL2Q.in"
	qfile3:                .asciiz "files\\LVL3Q.in"
	qfile4:                .asciiz "files\\LVL4Q.in"
	qfile5:                .asciiz "files\\LVL5Q.in"

	# files where options to each level's questions are stored
	$op_files:             .word opfile0, opfile1, opfile2, opfile3, opfile4, opfile5
	opfile0:               .asciiz "files\\LVL0O.in"
	opfile1:               .asciiz "files\\LVL1O.in"
	opfile2:               .asciiz "files\\LVL2O.in"
	opfile3:               .asciiz "files\\LVL3O.in"
	opfile4:               .asciiz "files\\LVL4O.in"
	opfile5:               .asciiz "files\\LVL5O.in"

	# files where answers to each level's questions are stored
	$ans_files:            .word ansfile0, ansfile1, ansfile2, ansfile3, ansfile4, ansfile5
	ansfile0:              .asciiz "files\\LVL0A.in"
	ansfile1:              .asciiz "files\\LVL1A.in"
	ansfile2:              .asciiz "files\\LVL2A.in"
	ansfile3:              .asciiz "files\\LVL3A.in"
	ansfile4:              .asciiz "files\\LVL4A.in"
	ansfile5:              .asciiz "files\\LVL5A.in"

	# buffers to store the questions for current level
	$qs_arr:               .word q0, q1, q2, q3, q4, q5, q6, q7, q8, q9
	q0:                    .space 256
	q1:                    .space 256
	q2:		               .space 256
	q3:		               .space 256
	q4:		               .space 256
	q5:		               .space 256
	q6:		               .space 256
	q7:		               .space 256
	q8:		               .space 256
	q9:		               .space 256

	# buffers to store the option strings for current level's questions
	$opstr_arr:            .word opstr0, opstr1, opstr2, opstr3, opstr4, opstr5, opstr6, opstr7, opstr8, opstr9
	opstr0:                .space 256 
	opstr1:                .space 256 
	opstr2:                .space 256 
	opstr3:                .space 256 
	opstr4:                .space 256 
	opstr5:                .space 256 
	opstr6:                .space 256 
	opstr7:                .space 256 
	opstr8:                .space 256 
	opstr9:                .space 256 

	# buffer to store the answers (chars) for the current level's questions
	$ans_arr:              .space 10
	.align 2

	# buffers to store the random numbers generated for each level (to select questions randomly)
	$rand_nums_generated:  .word l0_rand_nums, l1_rand_nums, l2_rand_nums, l3_rand_nums, l4_rand_nums, l5_rand_nums
	l0_rand_nums:          .space 40
	l1_rand_nums:          .space 40
	l2_rand_nums:          .space 40
	l3_rand_nums:          .space 40
	l4_rand_nums:          .space 40
	l5_rand_nums:          .space 40
	
	# strings to be displayed
	ques_num_str:          .asciiz "Question "
	enter_option_str:      .asciiz "Enter the correct option: "
	ans_success_str:       .asciiz "\nCorrect answer!\n"
	ans_failure_str:       .asciiz "\nIncorrect answer!\n"
	lvl_failure_str:       .asciiz "\nLevel Failed!\n\n"
	thank_you_str:         .asciiz "\nThank you for playing!\n\n"
	lvl_result_str:        .asciiz "\nCorrectly answered: "
	slash:                 .asciiz " / "
	lvl_welcome_start:     .asciiz "\n-------------------- LEVEL "
	lvl_welcome_end:       .asciiz " --------------------\n"
	lvl_promotion_str:     .asciiz "\nYou have been promoted to the next level!\n"
	lvl_demotion_str:      .asciiz "\nYou have been demoted to the previous level!\n"
	
	# buffer to read a character from file
	char_buffer:           .space 1

	
.text 
.globl main

main:
	li $s0, 0          # $s0 - current level (zero-based)
	j loop_over_lvls


loop_over_lvls:
	# print level welcome msg
	la $a0 lvl_welcome_start      # print beginning of lvl welcome msg
	li $v0 4
	syscall
	move $a0 $s0                  # print level number
	li $v0 1
	syscall
	la $a0 lvl_welcome_end        # print end of lvl welcome msg
	li $v0 4
	syscall
	
	jal load_questions            # load questions for level
	jal load_options              # load options for level
	jal load_answers              # load answers for level

	# Note: During the above 3 instructions, when we read data from a file, we differentiate
	# one question's data from the other based on the carriage return character '\r'

	la $s1, $qs_arr               # address of the array of questions
	la $s2, $opstr_arr            # address of the array of option strings
	la $s3, $ans_arr              # address of the array of answers
	
	sll $t1, $s0, 2               # offset based on level number
	la $t5, $rand_nums_generated  # $t5 - address of the rand_nums_generated array
	add $t5, $t5, $t1             # $t5 - adress of the address to the rand nums buffer for current lvl
	lw $s4, 0($t5)                # $s4 - address of rand nums buffer for current lvl

	li $s5, 0                     # $s5 - current question number (zero based)
	li $s6, 0                     # $s6 - correct answer counter

	j ask_next_q

	
load_questions:
	move $s7 $ra                  # save return address

    # open file
    li $v0 13                     # syscall for open file
    la $t0 $q_files               # question files array
    sll $t1 $s0 2                 # offset based on curr lvl
    add $t1 $t0 $t1               # $t1 - the address to the address of the filename for curr lvl's questions
    lw $a0 ($t1)                  # $a0 - address to the file name for curr lvl's questions
    li $a1 0                      # read flag
    li $a2 0                      # ignore mode 
    syscall                       # open file

    move $t0 $v0                  # $t0 - file desciptor 
	
    la $t6 $qs_arr                # $t6 - address to ques array
    lw $t1 0($t6)                 # $t1 - address to buffer of first question
    li $t2 0                      # current ques number
    li $t3 0                      # current ques length

    j read_byte                   # jump to read_byte


read_byte:
    # read byte from file
    li $v0 14                     # syscall for read file
    move $a0 $t0                  # file descriptor 
    la $a1 char_buffer            # address of dest buffer
    li $a2 1                      # buffer length
    syscall                       # read byte from file

    # keep reading until bytes read <= 0
    blez $v0 load_done

    # if current byte is a carraige return, consume line
    lb $t4 char_buffer            # the byte read
    li $t5 13                     # 13 - carriage return
    beq $t4 $t5 consume_line
    
    # if current byte is a newline char, go to next byte
    lb $t4 char_buffer            # the byte read
    li $t5 10                     # 13 - newine char
    beq $t4 $t5 read_byte

    # otherwise, append byte to line
    add $t5 $t3 $t1               # address of the memory space right after the end of the line being read
    sb $t4 ($t5)                  # put the byte read at that space

    addi $t3 $t3 1                # increment line length

    b read_byte                   # continue loop
 
 
consume_line:
    # null terminate line
    add $t4 $t3 $t1               # address of the memory space right after the end of the line being read
    sb $zero ($t4)                # put null character at that space

	addi $t2 $t2 1                # increment line number
    li $t3 0                      # reset line length

    # jump to load_done if all lines read
    lw $t4 n_ques                 # number of questions per level
    beq $t2 $t4 load_done         # jump to load done if content for each question has been loaded

    # set $t1 to the address to the next line's buffer
    sll $t4 $t2 2                 # compute offset based on line number
    add $t1 $t6 $t4               # address to the address of the curr line buffer
    lw $t1 ($t1)                  # $t1 - address to curr line buffer

    b read_byte                   # read next byte


load_done:
    # close file
    li $v0 16                     # syscall for close file
    move $a0 $t0                  # file descriptor to close
    syscall                       # close file
    
    move $ra $s7                  # move saved return address back to $ra
    jr $ra                        # jump return


load_options:
	move $s7 $ra                  # save return address

    # open file
    li $v0 13                     # syscall for open file
    la $t0 $op_files              # option files array
    sll $t1 $s0 2                 # offset based on curr lvl
    add $t1 $t0 $t1               # $t1 - the address to the address of the filename for curr lvl's option string
    lw $a0 ($t1)                  # $a0 - address to the filename for curr lvl's option string
    li $a1 0                      # read flag
    li $a2 0                      # ignore mode 
    syscall                       # open file

    move $t0 $v0                  # $t0 - file desciptor 
	
    la $t6 $opstr_arr             # address to option string array
    lw $t1 0($t6)                 # $t1 - address to first option string buffer
    li $t2 0                      # current option string number
    li $t3 0                      # current option string length

    j read_byte                   # jump to read_byte
  

load_answers:
	move $s7 $ra                  # save return address

    # open file
    li $v0 13                     # syscall for open file
    la $t0 $ans_files             # answer files array
    sll $t1 $s0 2                 # offset based on curr lvl
    add $t1 $t0 $t1               # $t1 - the address to the address of the filename for curr lvl's answers
    lw $a0 ($t1)                  # $a0 - address to the filename for curr lvl's answers
    li $a1 0                      # read flag
    li $a2 0                      # ignore mode 
    syscall                       # open file

    move $t0 $v0                  # $t0 - file desciptor 
	
    la $t1 $ans_arr               # address to answers array
    li $t2 0                      # current answer number

    j read_byte_2                 # jump to read_byte_2
    

read_byte_2:
	# break if answers to all questions have been read
	lw $t3 n_ques                 # number of questions per level
	beq $t2 $t3 load_done         # branch to load_done if all answers read
	
    # read byte from file
    li $v0 14                     # syscall for read file
    move $a0 $t0                  # file descriptor 
    la $a1 char_buffer            # address of dest buffer
    li $a2 1                      # buffer length
    syscall                       # read byte from file
   
    # keep reading until bytes read <= 0
    blez $v0 load_done            # branch to load_done if no bytes read

    # read next byte if byte read was carriage return or newline character
    lb $t4 char_buffer            # the byte read
    li $t5 13                     # 13 - carriage return
    beq $t4 $t5 read_byte_2       # read next byte if carriage return character was read
    li $t5 10                     # 10 - newline char
    beq $t4 $t5 read_byte_2       # read next byte if newline character was read

    # otherwise, put the byte read in $ans_arr
    add $t3 $t2 $t1               # address of the memory space to put curr question's answer
    sb $t4 ($t3)                  # put the byte read at that space

    addi $t2 $t2 1                # increment current answer number

    b read_byte_2                 # read next byte
  

ask_next_q:
	lw $t0, n_ques                # $t0 - number of questions per level
	beq $s5, $t0, next_lvl        # exit if all questions for level asked

	addi $sp, $sp, -8             # make space in stack
	jal get_rand_num              # $v0 - random number generated (without repitition)
	addi $sp, $sp, 8              # restore space in stack

	sll $t0, $v0, 2               # $t0 - offset based on random number generated
	add $t1, $s1, $t0             # $t1 - address of the question string
	add $t2, $s2, $t0             # $t2 - address of the options string
	add $t3, $s3, $v0             # $t3 - address to the the correct answer
	lb  $t4, ($t3)                # $t4 - correct answer
	
	li $a0 10                     # print newline character
	li $v0 11
	syscall
	
	# print question number
	la $a0 ques_num_str           # print 'Question '
	li $v0 4
	syscall
	
	addi $a0 $s5 1                # print the curr question number (not zero based)
	li $v0 1
	syscall
	
	li $a0 10                     # print newline character
	li $v0 11
	syscall

	lw $a0, ($t1)                 # print question
	li $v0, 4
	syscall
	
	li $a0 10                     # print newline character
	li $v0 11
	syscall

	lw $a0, ($t2)                 # print option string
	li $v0, 4
	syscall
	
	li $a0 10                     # print newline character
	li $v0 11
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
	sll $t0, $s5, 2               # $t0 - offset based on curr ques number ($s5)
	add $t0, $t0, $s4             # $t0 - address where the number will be stored
	sw  $a0, ($t0)	              # save generated number in numbers_generated array

	lw $v0, 4($sp)                # load generated number from stack

	lw $ra, 0($sp)                # load return address from stack
	jr $ra			              # jump back to the line after get_rand_num call in ask_next_q
    

is_rand_num_valid:
	move $t0, $ra                 # $t0 - return address				
	li $t1, 0                     # $t1 - loop variable
	j loop


loop:
	beq $t1, $s5, end_loop        # run loop only curr_ques_num times ($s5)

	sll $t2, $t1, 2				  # offset based on loop variable
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

	li $a0 10                     # print newline character
	li $v0 11
	syscall

	lw $t0, n_ans_to_pass         # $t0 - number of correct answers needed to pass level
	blt $s6, $t0, lvl_failed      # end level if correct answers < correct answers needed
	
	addi $s0, $s0, 1              # increment current level number
	
	lw $t0, n_lvls                # $t0 - number of levels
	beq $s0, $t0, quiz_over       # exit program if all levels done
	
	la $a0 lvl_promotion_str      # print promotion string
	li $v0 4
	syscall
	
	j   loop_over_lvls            # next level
	

lvl_failed:
	li $v0, 4                     # print lvl_failure_str
	la $a0, lvl_failure_str
	syscall
	
	addi $s0 $s0 -1               # decrement current level number
	
	bltz $s0 quiz_over            # branch to quiz_over if level num < 0
	
	la $a0 lvl_demotion_str       # print demotion string
	li $v0 4
	syscall

	j loop_over_lvls              # jump to loop_over_lvls
	

quiz_over:
	li $v0, 4                     # print thank you message
	la $a0, thank_you_str
	syscall

	j exit                        # end program


exit:
	li $v0, 10                    # 10 - exit
	syscall
