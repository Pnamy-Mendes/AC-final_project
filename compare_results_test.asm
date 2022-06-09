  .data
prompt:     .asciiz     "Enter your number (3-30):"
message:    .asciiz     "\n Your number is "
message2:   .asciiz     "\n Your number is less than 3"
message3:   .asciiz     "\n Your number is more than 30"

    .text
    .globl  main
main:
    # Prompt the user to enter the number
    li      $v0,4
    la      $a0,prompt
    syscall

    # Get the number
    li      $v0,5                   # get an integer from the user
    syscall

    # Store the result in t0
    move    $t0,$v0

    addi    $t1,$zero,0
    addi    $t2,$zero,3
    addi    $t3,$zero,30

    blt     $t0,$t2,numberSmaller
    bgt     $t0,$t3,numberLarger

    # output message to show the number
    li      $v0,4
    la      $a0,message
    syscall

    # show the number
    li      $v0,1
    move    $a0,$t0
    syscall

exit:
    li      $v0,10                  # syscall to end the program
    syscall

numberSmaller:
    li      $v0,4
    la      $a0,message2
    syscall
    j       exit

numberLarger:
    li      $v0,4
    la      $a0,message3
    syscall
    j       exit
Here's a slightly tighter version:

    .data
prompt:     .asciiz     "Enter your number (3-30):"
message:    .asciiz     "\n Your number is "
message2:   .asciiz     "\n Your number is less than 3"
message3:   .asciiz     "\n Your number is more than 30"

    .text
    .globl  main
main:
    # Prompt the user to enter the number
    li      $v0,4
    la      $a0,prompt
    syscall

    # Get the number
    li      $v0,5                   # get an integer from the user
    syscall

    # Store the result in t0
    move    $t0,$v0

    li      $t1,3
    blt     $t0,$t1,numberSmaller

    li      $t1,30
    bgt     $t0,$t1,numberLarger

    # output message to show the number
    li      $v0,4
    la      $a0,message
    syscall

    # show the number
    li      $v0,1
    move    $a0,$t0
    syscall

exit:
    li      $v0,10                  # syscall to end the program
    syscall

numberSmaller:
    li      $v0,4
    la      $a0,message2
    syscall
    j       exit

numberLarger:
    li      $v0,4
    la      $a0,message3
    syscall
    j       exit