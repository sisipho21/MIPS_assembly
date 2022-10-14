.data
	promptStr: .asciiz "Enter n and formulae:\n"
	outputStr: .asciiz "The value is:\n"
	.align 2
	numArray: .space 20000
	
.text
main:
	#Printing out prompt
	li $v0, 4
	la $a0, promptStr 
	syscall
	
	# READING IN INTEGER #
	li $v0, 5 	#load service 5 (read integer)
	syscall
	
	move $s0, $v0	#number of cells to expect
	
	addi $t0, $zero, 0	#counter value starts at 0
	addi $t1, $zero, 0 	#offset value starts at 0
	
readerLoop:
	beq $t0, $s0, next
	
	li $v0, 5 		#load service 5 (read integer)
	syscall
	move $t2, $v0
	
	sw $t2, numArray($t1)
	
	addi $t0, $t0, 1	#increment counter 
	addi $t1, $t1, 4	#increment offset value by 4
	
	j readerLoop

next:
	li $v0, 4
	la $a0, outputStr 
	syscall
	
	addi $t1, $zero, 0	#reset counter to 0 for output loop
	addi $t3, $zero, 0	#running sum of values
	
outputLoop:
	beq $t1, $s0, exit
	
	lw $t4, numArray($t1)
	
	add $t3, $t3, $t4	#add array value to running total
	
	li $v0, 1
	move $a0, $t4
	syscall
	
	addi $t1, $t1, 4
	
	j outputLoop
	
exit:
	li $v0, 1
	move $a0, $t3
	syscall
	
	li $v0, 10
	syscall