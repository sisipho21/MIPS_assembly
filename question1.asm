.data
	output: .ascii "The values are:\n"
	random: .space 20
	prompt: .ascii "Enter n, followed by n lines of text:\n"	#Prompt string to user
	
	
.text #coding section

.globl main


main:
	# PRINTING OUT PROMPT STRING#
	li $v0, 4 	#load service 4 (print string)
	la $a0, prompt	#String to print is 'prompt'
	syscall
	
	# READING IN INTEGER #
	li $v0, 5 	#load service 5 (read integer)
	syscall
	
	move $s0, $v0	#move integer in $v0 into $s0
	
	# PRINTING OUT OUTPUT STRING #
	la $a0, output	#string to print is 'output'
	li $v0, 4	#load sevice 1 (print string)
	syscall
	
	# PRINTING OUT INTEGER #
	move $a0, $s0 	#mave integer from $s0 into $a0 for printing
	li $v0, 1	#load sevice 1 (print integer)
	syscall 
	
exit:
	li $v0, 10	#load service 10 (exit programme)
	syscall