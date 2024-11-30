.data
output1:
    .asciiz "user input value = "
newline:
    .asciiz "\n"
output2:
    .asciiz "the Fibonacci number is "

str: 
     
.text
main:
    li $v0, 8 # read string
    la $a0, str # save string address
    syscall

    li $v0, 4 #
    la $a0, output1 #
    syscall #

    #li $v0, 4 #1
    #la $a0, str #
    #syscall #

    

    #li $v0, 4 #
    #la $a0, output2 #
    #syscall #

    la $a0, str #

    add $s0, $zero, $zero # to hold decimal value
    addi $t1, $zero, 10 # set equal to 10

conversion:
    lb $t0, 0($a0) # get ascii of first character of string
    beq $t0, $t1, exit1 # exit if end of string
    addi $t0, $t0, -48 # get decimal value
    mult $s0, $t1 # multiply by 10
    mflo $s0
    add $s0, $s0, $t0 
    addi $a0, $a0, 1
    j conversion

exit1:
    add $a0, $zero, $s0
    li $v0, 1 #
    syscall #
    li $v0, 4 #
    la $a0, newline #
    syscall #
    add $a0, $zero, $s0
    j fibo

fibo:
    addi $t0, $zero, 1
    bne $a0, $t0, next2
    li $v0, 4 #
    la $a0, output2 #
    syscall #
    addi $a0, $zero, 0 #= 0
    li $v0, 1 # print int
    syscall
    j finish

next2:
    addi $t0, $zero, 2
    bne $a0, $t0, next3
    li $v0, 4 #
    la $a0, output2 #
    syscall #
    addi $a0, $zero, 1 #= 1
    li $v0, 1 # print int
    syscall
    j finish

next3:    
    add $t0, $zero, $zero # fib n=1  =0
    addi $t1, $zero, 1    # fib n=2  =1
    addi $t2, $zero, 2 # counter
    add $s3, $zero, $zero # fib value
    
loop:
    beq $t2, $s0, exit2 # counter = fib n
    addu $s3, $t0, $t1  # add to fib value
    slt $t4, $zero, $s3 
    beq $t4, $zero, overflow
    add $t0, $zero, $t1 # increase first to next value
    add $t1, $zero, $s3 # increase second to next value
    addi $t2, $t2, 1 # increase counter
    j loop

exit2:
    li $v0, 4 #
    la $a0, output2 #
    syscall #
    addi $a0, $s3, 0
    li $v0, 1 # print int
    syscall
    j finish

overflow:
    li $v0, 4 #
    la $a0, output2 #
    syscall #
    addi $a0, $zero, -1
    li $v0, 1
    syscall
    j finish

finish:
    li $v0, 4 #
    la $a0, newline #
    syscall #
    jr $ra
