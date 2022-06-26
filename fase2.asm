.data 
	n_lvls:                .word 3
	n_ques:                .word 10
	n_ques_to_pass:        .word 5

	$questions_data:       .word $lvl_1_qs_arr, $lvl_2_qs_arr, $lvl_3_qs_arr
	$options_data:         .word $lvl_1_ops_arr, $lvl_2_ops_arr, $lvl_3_ops_arr
	$answers_data:         .word $lvl_1_answers_arr, $lvl_2_answers_arr, $lvl_3_answers_arr
	$nums_generated_data:  .word $lvl_1_nums_generated, $lvl_2_nums_generated, $lvl_3_nums_generated


	$lvl_1_qs_arr:         .word l1q0, l1q1, l1q2, l1q3, l1q4, l1q5, l1q6, l1q7, l1q8, l1q9
	l1q0:                  .asciiz "\nWhat is a system performance metric?\n"
	l1q1:                  .asciiz "\nWhat does throughput mean?\n"
	l1q2:		           .asciiz "\nProcessor speed is represented in which units?\n"
	l1q3:		           .asciiz "\nWhat is the CPU time dependent on?\n"
	l1q4:		           .asciiz "\nWhen was the first computer invented?\n"
	l1q5:		           .asciiz "\nWhich of these is not a base component of a computer?\n"
	l1q6:		           .asciiz "\nWhat language is this being programmed on?\n"
	l1q7:		           .asciiz "\nFinish this sentence: ...increases the performance of a system\n"
	l1q8:		           .asciiz "\nWhat are the 3 basic operations of a computer?\n"
	l1q9:		           .asciiz "\nWhat are the 2 types of RAM memory?\n"

	$lvl_2_qs_arr:         .word l2q0, l2q1, l2q2, l2q3, l2q4, l2q5, l2q6, l2q7, l2q8, l2q9
	l2q0:                  .asciiz "\nWhat did deMoore predict?\n"
	l2q1:                  .asciiz "\nWhich of these is a type of computer architecture?\n"
	l2q2:		           .asciiz "\nDATAPATH is a component responsible for...\n"
	l2q3:		           .asciiz "\nWhat was so extraordinary about Harvard's Architecture?\n"
	l2q4:		           .asciiz "\nWhich became the most efficient computer architecture?\n"
	l2q5:		           .asciiz "\nWhich of these microprocessors isnt common nowadays?\n"
	l2q6:		           .asciiz "\nWhat is one thing performance depends on?\n"
	l2q7:		           .asciiz "\nWhat does Multicore mean?\n"
	l2q8:		           .asciiz "\nWhat does ISA stand for?\n"
	l2q9:		           .asciiz "\nWhat is the size of common ISA instruction?\n"

	$lvl_3_qs_arr:         .word l3q0, l3q1, l3q2, l3q3, l3q4, l3q5, l3q6, l3q7, l3q8, l3q9
	l3q0:                  .asciiz "\nWhat does CISC stand for?\n"
	l3q1:                  .asciiz "\nWhat does RISC stand for?\n"
	l3q2:		           .asciiz "\nWhich of these is an example of an ISA?\n"
	l3q3:		           .asciiz "\nWhat are the 3 types of instructions of an ISA?\n"
	l3q4:		           .asciiz "\nWhat is the command for an addition?\n"
	l3q5:		           .asciiz "\nWhat is the command to compare if 2 registers are equal?\n"
	l3q6:		           .asciiz "\nWhat is the command to compare if 2 registers are not equal?\n"
	l3q7:		           .asciiz "\nWhat is another command to compare 2 registers and return a 1?\n"
	l3q8:		           .asciiz "\nWhat is the command to load 16 significant bits and passing a literal value?\n"
	l3q9:		           .asciiz "\nWhat is the command to load 16 less significant bits?\n"

	$lvl_1_ops_arr:        .word l1op0, l1op1, l1op2, l1op3, l1op4, l1op5, l1op6, l1op7, l1op8, l1op9
	l1op0:                 .asciiz "a) Execution time\tb) CPU Input\tc) Heat Temp\td) Amount of CPU's\te) Output quality\n"
	l1op1:                 .asciiz "a) Fetch\tb) Decoded\tc) Executed\td) Bandwidth\te) Latency\n"
	l1op2:                 .asciiz "a) Meters per second\tb) Celcius\tc) Newtons\td) Hz\te) GHz\n"
	l1op3:                 .asciiz "a) User Time and System Time\tb) Memory Time and CPU Time\tc) Graphics Time\td) User Input\te) System Output\n"	
	l1op4:                 .asciiz "a) 1822\tb) 1922\tc) 1842\td) 1942\te) 1950\n"	
	l1op5:                 .asciiz "a) Input\tb) Output\tc) Memory\td) Cooling\te) Control\n"	
	l1op6:                 .asciiz "a) Python\tb) Java\tc) C\td) Html\te) MIPS Assembly\n"	
	l1op7:                 .asciiz "a) Optimizing the common\tb) Better cooling\tc) More memory\td) More microprocessors\te) Optimizing the cpu\n"	
	l1op8:                 .asciiz "a) Fetch,Decode,Execute\tb) Decode,Execute,Fetch\tc) Execute,Fetch,Decode\td) Input,Compile,Output\te) Assemble,Compile,Output\n"	
	l1op9:                 .asciiz "a) ROM and Hard Disc\tb) Internet and Cloud\tc) Physical and Virtual\td) Removal Discs\te) USB, Hard Drive\n"	

	$lvl_2_ops_arr:        .word l2op0, l2op1, l2op2, l2op3, l2op4, l2op5, l2op6, l2op7, l2op8, l2op9
	l2op0:                 .asciiz "a) No. of transistors to double\tb) No. of transistors to drop\tc) No. of processors to double\td) No. of processors to drop\te) The future\n"
	l2op1:                 .asciiz "a) DeMoore\tb) Von Neuman\tc) Turing Architecture\td) Charles Architecture\te) ENIAC Architecture\n"
	l2op2:                 .asciiz "a) inputs\tb) saving data\tc) cpu instructions\td) memory instructions\te) the operations over data\n"
	l2op3:                 .asciiz "a) adds numbers\tb)operations\tc) handles instructions\td) seperates physical memory and instructions\te) seperates data\n"	
	l2op4:                 .asciiz "a) Harvard\tb) Hybrid Harvard\tc) Von Neuman\td) Hybrid Von Neuman\te) Turing Architecture\n"	
	l2op5:                 .asciiz "a) Intel Premium series\tb) IBM PowerPC\tc) Sun SPARC\td) MIPS R5000\te) AMD Intel 80386\n"	
	l2op6:                 .asciiz "a) CPU\tb) Memory\tc) Compiler\td) Cooler\te) Inputs\n"	
	l2op7:                 .asciiz "a) Instruction\tb) Low level language\tc) More Virtual memory\td) More physical memory\te) More processors per chip\n"	
	l2op8:                 .asciiz "a) Input Set Application\tb) Intro set Application\tc) Input Set Architecture\td) Instruction Set Architecture\te) Instruction Save Architecture\n"	
	l2op9:                 .asciiz "a) 21\tb) 32\tc) 64\td) 128\te) 15\n"	

	$lvl_3_ops_arr:        .word l3op0, l3op1, l3op2, l3op3, l3op4, l3op5, l3op6, l3op7, l3op8, l3op9
	l3op0:                 .asciiz "a) Complex Inputs\tb) Computer Instructions\tc) Complex Computer\td) Complex Instructions\te) Complex Instruction Set Computing\n"
	l3op1:                 .asciiz "a) Reduced Inputs\tb) Reduced Instruction Set Computing\tc) Complex Computer\td) Reduced Instructions\te) Complex Instruction\n"
	l3op2:                 .asciiz "a) MIPS\tb) MARS\tc) x68\td) MAPS\te) CISC\n"
	l3op3:                 .asciiz "a) R,A,J\tb) P,S,J\tc) R,I,J\td) R,C,B\te) R,L,J\n"	
	l3op4:                 .asciiz "a) ADD\tb) .add\tc) sub\td) add\te) Add\n"	
	l3op5:                 .asciiz "a) slt\tb) if\tc) bne\td) beq\te) lw\n"	
	l3op6:                 .asciiz "a) bne\tb) beq\tc) sw\td) li\te) if\n"	
	l3op7:                 .asciiz "a) stl\tb) slt\tc) slti\td) bgt\te) ble\n"	
	l3op8:                 .asciiz "a) lup\tb) ori\tc) add\td) li\te) lui\n"	
	l3op9:                 .asciiz "a) lup\tb) lui\tc) ori\td) add\te) lw\n"	
			
	$lvl_1_answers_arr:    .word 'a', 'd', 'e', 'a', 'a', 'd', 'e', 'a', 'a', 'c'
	$lvl_2_answers_arr:    .word 'a', 'b', 'e', 'd', 'b', 'e', 'c', 'e', 'c', 'b'
	$lvl_3_answers_arr:    .word 'e', 'b', 'a', 'c', 'd', 'd', 'a', 'b', 'e', 'c'

	$lvl_1_nums_generated: .space 40
	$lvl_2_nums_generated: .space 40
	$lvl_3_nums_generated: .space 40

	enter_option_str:      .asciiz "Enter the correct option: "
	ans_success_str:       .asciiz "\nCorrect answer!\n\n"
	ans_failure_str:       .asciiz "\nIncorrect answer!\n\n"
	lvl_failure_str:       .asciiz "\nLevel Failed!\n\n"
	thank_you_str:         .asciiz "\nThank you for playing!\n\n"
	lvl_result_str:        .asciiz "\nCorrectly answered: "
	new_line:              .asciiz "\n"
	slash:                 .asciiz " / "

	
.text 
.globl main

main:
	li $s0, 0                     # $s0 - current level (zero-based)
	j loop_over_lvls


loop_over_lvls:
	lw $t0, n_lvls                # $t0 - number of levels
	beq $s0, $t0, quiz_over       # break after all levels
				
	mul $t1, $s0, 4               # calculate offset to access data for this lvl

	la $t2, $questions_data       # $t2 - address of the questions_data array
	add $t2, $t2, $t1             # $t2 - adress of the $s0'th item of questions_data
	lw $s1, 0($t2)                # $s1 - address of ques array for this lvl

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
	sll $t0, $s5, 2               # $t0 - offset based on curr ques number ($s5)
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

	sll $t2, $t1, 2               # $t2 - offset based on loop variable
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
	blt $s6, $t0, lvl_failed      # end level if correct answers < correct answersneeded

	addi $s0, $s0, 1              # increment current level number
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
