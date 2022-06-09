.text
    li $a1, 100  #Here you set $a1 to the max bound.
    li $v0, 42  #generates the random number.
    syscall
    #add $a0, $a0, 100  #Here you add the lowest bound
    li $v0, 1   #1 print integer
    syscall