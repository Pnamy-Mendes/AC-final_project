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
	
	array: .word 10, 50, 67, 1, 23, 68, 100, 2, -1 # objeto -1 indica o final do vetor
.text
	main:
	
		li $s0, 0 #inicia o contador
		la $s1, array #aponta para o array
		
	loop:
	
		ld $s3,($s1) #pega o valor do array
		blt $s3,0,finaliza # caso seja o final do array(numero menor que 0) ele desvia para finaliza
		addi $s0,$s0,1 #incrementa o contador
		addi $s1,$s1,4 #muda a posicao
		j loop #desvia para o loop
		
	finaliza:
	
		li $v0,1 #comando de impressão de texto na tela
		la $a0, ($s0) #coloca o registrador do contador para ser impresso
		syscall # efetua a chamada ao sistema

		li $v0, 10 # comando de exit
		syscall # efetua a chamada ao sistema