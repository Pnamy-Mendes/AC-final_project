.data
	answer: .byte 'a','b','c','a','a'
	ask_op: .asciiz"Answer: "
	game: .asciiz"\n\tQUIZ"
	line: .asciiz"______________________________"
	fullmarks: .asciiz"\tF.M=5\n"
	ques1: .asciiz"\n\n1. What is the capital of India ?\n"
	q1opa: .asciiz"a)Delhi\n"
	q1opb: .asciiz"b)Mumbai\n"
	q1opc: .asciiz"c)Agra\n"
	q1opd: .asciiz"d)Bhubaneswar\n"
	
	ques2: .asciiz"\n\n2. What is my name ?\n"
	q2opa: .asciiz"a)A.K.P\n"
	q2opb: .asciiz"b)ASHIS\n"
	q2opc: .asciiz"c)PADHI\n"
	q2opd: .asciiz"d)AK\n"
	
	ques3: .asciiz"\n\n3. What is my age ?\n"
	q3opa: .asciiz"a)19\n"
	q3opb: .asciiz"b)20\n"
	q3opc: .asciiz"c)21\n"
	q3opd: .asciiz"d)24\n"
	
	ques4: .asciiz"\n\n4. What is my NUMBER ?\n"
	q4opa: .asciiz"a)7064247858\n"
	q4opb: .asciiz"b)7124568957\n"
	q4opc: .asciiz"c)6987598545\n"
	q4opd: .asciiz"d)9845687515\n"
	
	ques5: .asciiz"\n\n5. What is my favourite game ?\n"
	q5opa: .asciiz"a)FIFA\n"
	q5opb: .asciiz"b)WWE\n"
	q5opc: .asciiz"c)PUBG\n"
	q5opd: .asciiz"d)CS\n"
	score: .word 0
	box1: .asciiz"\n    -------------\n"
	s_card: .asciiz"    | SCORECARD |\n"
	box2: .asciiz"    -------------\n"
	name: .asciiz"\nNAME:"
	buffer: .space 30
	ask_name: .asciiz"\nEnter your name(30 letters maximum)=>"
	score_out: .asciiz"\nSCORE:"
	percentile: .asciiz"\nPERCENTILE:"

.text
main:
	#li $t6, 5

	la $a0, ask_name
	li $v0, 4
	syscall
	
	li $v0, 8
	
	la $a0, buffer
	li $a1,20
	
	move $t4, $a0
	syscall
		
	
	la $a0, game
	li $v0, 4
	syscall
	
	la  $a0, fullmarks
	li $v0, 4
	syscall
	
	la $a0,line
	li $v0, 4
	syscall

	la $a0, ques1
	li $v0, 4
	syscall
	la $a0, q1opa
	li $v0, 4
	syscall
	la $a0, q1opb
	li $v0, 4
	syscall
	la $a0, q1opc
	li $v0, 4
	syscall
	la $a0, q1opd
	li $v0, 4
	syscall
	
	la $a0, ask_op
	li $v0, 4
	syscall
	li $v0, 12
	syscall
	
	#addi $t6, $t6, -1
	#bnez $t6, EXIT
	la $t0, answer
	lb $t1, 0($t0)
	bne $t1, $v0,L1
		addi $t7,$t7,1

     L1:move $v0, $0
     	la $a0, ques2
	li $v0, 4
	syscall
	la $a0, q2opa
	li $v0, 4
	syscall
	la $a0, q2opb
	li $v0, 4
	syscall
	la $a0, q2opc
	li $v0, 4
	syscall
	la $a0, q2opd
	li $v0, 4
	syscall
	
	la $a0, ask_op
	li $v0, 4
	syscall
	li $v0, 12
	syscall
	
	#addi $t6, $t6, -1
	#bnez $t6, EXIT
	
	lb $t1, 1($t0)
	bne $t1, $v0,L2
		addi $t7,$t7,1

     L2:move $v0, $0
     	la $a0, ques3
	li $v0, 4
	syscall
	la $a0, q3opa
	li $v0, 4
	syscall
	la $a0, q3opb
	li $v0, 4
	syscall
	la $a0, q3opc
	li $v0, 4
	syscall
	la $a0, q3opd
	li $v0, 4
	syscall
	
	la $a0, ask_op
	li $v0, 4
	syscall
	li $v0, 12
	syscall
	
		
	lb $t1, 2($t0)
	bne $t1, $v0,L3
		addi $t7,$t7,1
		
		
     L3:move $v0, $0
     	la $a0, ques4
	li $v0, 4
	syscall
	la $a0, q4opa
	li $v0, 4
	syscall
	la $a0, q4opb
	li $v0, 4
	syscall
	la $a0, q4opc
	li $v0, 4
	syscall
	la $a0, q4opd
	li $v0, 4
	syscall
	
	la $a0, ask_op
	li $v0, 4
	syscall
	li $v0, 12
	syscall
	
	lb $t1, 3($t0)
	bne $t1, $v0,L4
		addi $t7,$t7,1
		
     L4:move $v0, $0
     	la $a0, ques5
	li $v0, 4
	syscall
	la $a0, q5opa
	li $v0, 4
	syscall
	la $a0, q5opb
	li $v0, 4
	syscall
	la $a0, q5opc
	li $v0, 4
	syscall
	la $a0, q5opd
	li $v0, 4
	syscall
	
	la $a0, ask_op
	li $v0, 4
	syscall
	li $v0, 12
	syscall
	
	lb $t1, 4($t0)
	bne $t1, $v0, EXIT
		addi $t7,$t7,1

EXIT:
add $t9,$t9,$t7
sw $t9,score
	
	
la $a0, box1
li $v0, 4
syscall

la $a0, s_card
li $v0, 4
syscall

la $a0, box2
li $v0, 4
syscall

la $a0, name
li $v0, 4
syscall

la $a0, buffer
move $a0, $t4
li $v0, 4
syscall

la $a0, score_out
li $v0, 4
syscall

move $a0, $t9
li $v0, 1
syscall

move $v0, $0
	
li $v0,10
syscall