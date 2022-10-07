.data
	prompt: .ascii "Enter n, followed by n lines of text:\n"	#Prompt string to user
	num: .space 5    						#Allocating 5 bytes to num for the number

.text #coding section

.globl main


main:
	la $a0, num	#load address of num in $a0
	li $v0, 5 	#load service 5 (read integer)
	li $a1, 3	#Max number of characters to read