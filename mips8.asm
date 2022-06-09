#Aaron

.data 
string: .asciiz "Not the same\n"	
arrayA: .word 3, 1, 1, 2  
size:   .word 4				#ArrayA to store the first list 
.text

main:   
	li $t4, 0					#setting $t4 = 0; t4 will serve as a counter
	la $t1, arrayA  				#$t1 = address of arrayA
	li $t2, 3					#$t2 = value to compare
     	
	lw $s1, size					#setting $s1 = 4

	jal for 					#jump to loop
	j final

for:							#for(int i = 0; i<array.length; i++)
	beq $t4, $s1, main				#counter = size então nenhum valor é igual
	lw $t5, 0($t1)	 				#get value from array cell and store in $t6
	
	
	move $a0, $t5 
	li $v0, 1
	syscall
	
	li $a0, 32					#print the ASCII representation of 32 which is space
	li $v0, 11					#system call for printing character
	syscall	
	
	move $a0, $t2 
	li $v0, 1
	syscall
	
	la $a0, string
	li $v0, 4
	syscall
	
						
	bne $t5, $t2, for  
	j sideboard					#go to sideboard

def:
	jr $ra
	
sideboard:						#incrementing stuff
	addi $t1, $t1, 4				#incrementing $t1 by 4
	addi $t4, $t4, 1
	beq $t4, $s1, def				#incrementing $t1 by 1
	j for						#go back to for

	
reset:							#resetting stuff
	li $t4, 0					#resetting t4 = 0
	j print						#go to print


print:							#printing arrayC
	
	
	move $a0, $s2					#move $s2 into $a0
	syscall						#system call
	
	li $a0, 32					#print the ASCII representation of 32 which is space
	li $v0, 11					#system call for printing character
	syscall						#system call

	
final:
	li $v0, 10		
	syscall						#end program
	