#Joel Tanig 

.data
extraspace: .asciiz "  "
enterPrompt: .asciiz "Enter Starting N: "
iterationPrompt: .asciiz "\nIterations: "

.text 

	addi $s0, $0, 0 #Iterator count
	

first:
	li $v0, 4 #Call this to start printing a string
	la $a0, enterPrompt #Load address into prompt
	syscall


	li $v0, 5 #Read the int the user put
	syscall
	move $s2, $v0 #Save the int to a another var with save qualities
	
	add $s7, $0, $s2 #To get the first number the user put and save it to a dummy to print 
	
braceForImpact:
	add $s4, $0, $s2 #Make a dummy var 
	
	
	move $a0, $s7 #Move the dummy print var to a address register 
	
	li $v0 , 1 #Load up the prompt command for printing a int
	syscall
	
	la $a0, extraspace #Load address of prompt
	li $v0, 4 #Tell the janitor to load the string command and print 
	syscall	
	
	
results: #Do something with the prev saved value
	addi $s0, $s0, 1 #Iterate shit
	beq $s4, 1, final #if its 1, break out of the loop
	andi $s1, $s4, 1 #checks if its even or odd  1= odd ,  0 = even
	beq $s4, 1, final #if its 1, break out of the loop
	jal hailStone #else, run these hailstone algo
	move $a0, $v0 #Take the return value from  hailstone and save it to a0
	#Print stuff for the list of values 
	
	li $v0, 1 #Load up the prompt command for printing a int
	syscall 
	
	la $a0, extraspace #Load address of prompt
	li $v0, 4 #Tell the janitor to load the string command 
	syscall	

	j results
	
hailStone: 
	beq $s1, 1, oddFunction  #If its odd, do a beq
	#Take the user's number and divide it by 2 and do even manipulation here here
	srl $v0, $s4, 1 #N/2 divide use srl
	add $s4, $0, $v0 #Update the iterator breaker 
	jr $ra #return to caller
	
	
oddFunction:
	add $v0, $s4, $s4 #Multiply by 3
	add $s4, $s4, $v0 #Add one more complete 
	add $s4, $s4, 1 #Then add 1 to s4 to complete the formula 
	move $v0, $s4 
	add $s4, $0, $v0 #Update the iterator breaker 
	
	
	move $a0, $v0 
	#Print statements here
	
	li $v0, 1 #Load up the prompt command for printing a int
	syscall 
	
	la $a0, extraspace #Load address of prompt
	li $v0, 4 #Tell the janitor to load the string command 
	syscall	

	
	j results #return to caller

	 
	

final:
	#Add last print statement
	#Print the prompt
	li $v0, 4	#Call a service number of 4 to print the string
	la $a0, iterationPrompt 	#Load address of prompt
	syscall
	
	li $v0, 1	#Call a service number of 1 to print the int
	move $a0, $s0 	#Load address of prompt
	syscall
	
	
	#Ends the program 
	li $v0, 10 #Calls the program to stop with code 10 
	syscall
	
	
