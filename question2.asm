.data
	promptStr: .asciiz "Enter a sum:\n"
	outputStr: .asciiz "The value is:\n"
	input: .space 1240
	.align 2
	numArray: .space 20000

.text
main:
	#Printing out prompt
	li $v0, 4
	la $a0, promptStr 
	syscall

	#Reading in and storing input
	li $a1, 1240
	la $a0, input
	li $v0, 8
	syscall
	la $t0, input

	addi $t1, $zero, 0	#running sum variable - initialise to 0
	addi $t2, $zero, 0	#counter variable for storing into array - initialise to 0
	
createSumLoop:
	lb $t3, ($t0)		#load current byte from input string
	addu $t0, $t0, 1	#increment input string

	beq $t3, 10, Last	#condition for end of string
	beq $t3, '+', Store	#condition for end of current number
	
	mul $t1, $t1, 10	# $t1 *= 10
	sub $t3, $t3, '0' 	# converting byte to integer
	add $t1, $t1, $t3	# adding to the current sum

	j createSumLoop

	
Store:
	sw $t1, numArray($t2)	#store current sum into array address
	addi $t2, $t2, 4	#increment counter variable for storing into array
	addi $t1, $zero, 0	#re-initialise sum to zero
	j createSumLoop			#jump back to the Loop

Last:
	sw $t1, numArray($t2)	#store last current sum into array address
	addi $t2, $t2, 4
	li $v0, 4
	la $a0, outputStr
	syscall
	
	addi $t4, $zero, 0	#initialising the TOTALSUM
	
outputLoop:
	beqz $t2, Exit
	sub $t2, $t2, 4		#decrement the counter variable
	lw $t5, numArray($t2)	#load the numbers in the array
	add $t4, $t4, $t5	# adding to running total what we get from the array
	
	j outputLoop

Exit:	
	li $v0, 1
	move $a0, $t4
	syscall
	
	li $v0, 10
	syscall
