.data
	outputStr: .asciiz "The values are:\n"
	prompt: .asciiz "Enter n, followed by n lines of text:\n"	#Prompt string to user
	space: .asciiz "\n"
	inBuffer: .space 20000
	.align 3
	array: .space 20000
	
.text 
main:
	# PRINTING OUT PROMPT STRING #
	li $v0, 4 	#load service 4 (print string)
	la $a0, prompt	#String to print is 'prompt'
	syscall
	
	# READING IN INTEGER #
	li $v0, 5 	#load service 5 (read integer)
	syscall
	
	move $s0, $v0	#move integer in $v0 into $s0, now $s0 contains n
	
	addi $t0, $zero, 0	#counter value starts at 0
	addi $t1, $zero, 0 	#offset value starts at 0
	addi $t7, $zero, 0	#offset for buffer
	

	#After reading in n, must loop n times to get string input
readerLoop:	
	beq $t0, $s0, next	#if counter and n are equal, 
	# READING IN and STORING STRING INPUT #
	la $a0, inBuffer($t7)	#Address of input buffer
	li $a1, 20 		#Maximum characters to read
	li $v0, 8		#load service 8(read string)
	syscall
	move $t5, $a0
	sw $t5, array($t1)
	
	addi $t0, $t0, 1	#increment counter 
	addi $t1, $t1, 120	#increment offset values by 120
	addi $t7, $t7, 120	#increment inBuffer offset by 8 for more space
	j readerLoop
	
	
next:
	# PRINTING OUT OUTPUT STRING #
	la $a0, outputStr	#string to print is 'output'
	li $v0, 4	#load sevice 4 (print string)
	syscall
	
	addi $t2, $zero, 120
	
	
outputLoop:
	# PRINTING OUT STRING #
	beq $t1, $zero, exit
	sub $t1, $t1, $t2	#decrementing the offset
	lw $t3, array($t1)	#taking out the word from the array address
	li $v0, 4		#load service 4 (print string)
	move $a0, $t3
	syscall 
	
	j outputLoop
	
exit:
	li $v0, 10	#load service 10 (exit programme)
	syscall
	

	
