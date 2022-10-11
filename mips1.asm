.data
	array: .space 10000
	prompt: .asciiz "Enter n, followed by n lines of text:\n"
	outputStr: .asciiz "The values are:\n"
	inBuffer1: .space 20000

.text
main:
	li $v0, 4
	la $a0, prompt
	syscall
	
	#storing into array#
	addi $t0, $zero, 0	#offset for array
	addi $t7, $zero, 0	#offset for buffer
	
	
	
	li $v0, 8 #5 	#load service 5 (read integer)
	la $a0, inBuffer1($t7)
	li $a1, 20
	syscall
	move $t1, $a0 #$v0
	sw $t1, array($t0)
	
	addi $t0, $t0, 4
	addi $t7, $t7, 8
	
	li $v0, 8 #5 	#load service 5 (read integer)
	la $a0, inBuffer1($t7)
	li $a1, 20
	syscall
	move $t2, $a0 #$v0
	sw $t2, array($t0)
	
	addi $t0, $t0, 4	#increase offset
	addi $t7, $t7, 8	
	
	li $v0, 8 #5 	#load service 5 (read integer)
	la $a0, inBuffer1($t7)
	li $a1, 20
	syscall
	move $t3, $a0 #$v0
	sw $t3, array($t0)
	
	# Outputting #
	li $v0, 4
	la $a0, outputStr
	syscall
	
	addi $t5, $zero, 0	#another offset
	
	li $v0, 4 #1
	lw $s1, array($t5)
	move $a0, $s1
	syscall
	
	addi $t5, $t5, 4
	lw $s2, array($t5)
	move $a0, $s2
	syscall
	
	addi $t5, $t5, 4
	lw $s3, array($t5)
	move $a0, $s3
	syscall
	
	
	li $v0, 10
	syscall
	
	
	