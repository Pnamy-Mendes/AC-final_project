.data
    n_ques: .word 4

	q_files: .word qfile1, qfile2, qfile3
	qfile1: .asciiz "1.in"
	qfile2: .asciiz "2.in"
	qfile3: .asciiz "3.in"

	op_files: .word opfile0, opfile1, opfile2
	opfile0: .asciiz "op0.in"
	opfile1: .asciiz "op1.in"
	opfile2: .asciiz "op2.in"

	ans_files: .word ansfile0, ansfile1, ansfile2
	ansfile0: .asciiz "ans0.in"
	ansfile1: .asciiz "ans1.in"
	ansfile2: .asciiz "ans2.in"

	$qs_arr:         .word q0, q1, q2, q3
	q0:              .space 512
	q1:              .space 512
	q2:		         .space 512
	q3:		         .space 512

	$opstr_arr:      .word opstr0, opstr1, opstr2, opstr3
	opstr0:          .space 512 
	opstr1:          .space 512 
	opstr2:          .space 512 
	opstr3:          .space 512 

	$ans_arr:        .space 4 
	
	char_buffer: .space 1

.text 
.globl main

main:
	li $s0, 0                     # $s0 - current level (zero-based)
	#jal load_questions
    #jal load_options
    jal load_answers
    
    la $t0 $ans_arr
    lb $a0 3($t0)    #here
    li $v0 11
    syscall
    j exit

    #la $a0 q0
    #li $v0 4
    #syscall

    #la $a0 opstr0
    #li $v0 4
    #syscall
    
    la $s3 $ans_arr
    #addi $t3 $s3 4
    #lw $t3 ($t3)
    #lb $a0 ($t3)
    lw $t3 4($s3)
    lb $a0 ($t3)
    li $v0 11
    syscall

    j exit


load_answers:
	move $s7 $ra # save return address

    # open file
    li $v0 13          # syscall for open file
    la $t0 ans_files   # question filenames array
    sll $t1 $s0 2      # offset based on curr lvl
    add $t1 $t0 $t1    # $t1 - the address to the address of the filename for curr lvl's answers
    lw $a0 ($t1)       # $a0 - address to the filename for curr lvl's answers
    li $a1 0           # read flag
    li $a2 0           # ignore mode 
    syscall            # open file
    move $t0 $v0       # $t0 - file desciptor 

    # only $t0 is in use at this point, all others can be overwritten
	
    la $t1 $ans_arr    # address to answers array
    li $t2 0           # current question number

    j read_byte_2
    
read_byte_2:
	# break if answers to all questions have been read
	lw $t3 n_ques
	beq $t2 $t3 load_done
	
    # read byte from file
    li $v0 14          # syscall for read file
    move $a0 $t0       # file descriptor 
    la $a1 char_buffer # address of dest buffer
    li $a2 1           # buffer length
    syscall            # read byte from file
   
    # keep reading until bytes read <= 0
    blez $v0 load_done

    # read next byte if byte read was carriage character or newline
    lb $t4 char_buffer              # the byte read
    li $t5 13                       # 13 - carriage return
    beq $t4 $t5 read_byte_2         # read next byte if carriage character was read
    li $t5 10                       # 10 - newline char
    beq $t4 $t5 read_byte_2         # read next byte if newline character was read

    # otherwise, put answer in $ans_arr
    add $t3 $t2 $t1  # address of the memory space to put curr question's answer
    sb $t4 ($t3)     # put the byte read at that space

    addi $t2 $t2 1   # increment current answer number

    b read_byte_2
  
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
	
    la $t6 $qs_arr  # $t6 - address to ques array
    lw $t1 0($t6)   # $t1 - address to curr ques buffer
    li $t2 0        # current ques number
    li $t3 0        # current ques length

    # only $t0, $t1, $t2 and $t3 are in use

    j read_byte

load_options:
	move $s7 $ra # save return address

    # open file
    li $v0 13          # syscall for open file
    la $t0 op_files    # question filenames array
    sll $t1 $s0 2      # offset based on curr lvl
    add $t1 $t0 $t1    # $t1 - the address to the address of the filename for curr lvl's options
    lw $a0 ($t1)       # $a0 - address to the filename for curr lvl's option string
    li $a1 0           # read flag
    li $a2 0           # ignore mode 
    syscall            # open file
    move $t0 $v0       # $t0 - file desciptor 

    # only $t0 is in use at this point, all others can be overwritten
	
    la $t6 $opstr_arr  # address to option string array
    lw $t1 0($t6)   # $t1 - address to buffer of the curr ques option string
    li $t2 0        # current option string number
    li $t3 0        # current option string length

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

    # if current byte is a newline or carriage return, consume line
    lb $t4 char_buffer        # the byte read
    #li $t5 13                 # 13 - carriage return
    #beq $t4 $t5 consume_line  # consume line if char read is carriage return
    li $t5 10                 # 10 - newline char
    beq $t4 $t5 consume_line  # consume line if char read is newline

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
    sll $t4 $t2 2   # compute offset based on question number
    add $t1 $t6 $t4 # address to the address of the curr ques buffer
    lw $t1 ($t1)    # $t1 - address to curr ques buffer

    b read_byte

load_done:
    # close file
    li $v0 16     # syscall for close file
    move $a0 $t0  # file descriptor to close
    syscall       # close file
    
    move $ra $s7
    jr $ra
	
exit:
