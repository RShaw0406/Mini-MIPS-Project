## Name of Program: CW1B		    Version number: 1.0	            Date last changed: 21/07/22
## Name of Author: Ryan Shaw (B00634437)
## Description of Program: MIPS Mini Project

# -------------------------------------------------------------------- Data -------------------------------------------------------------------
.data

# Numbers Array
array:	.word 0x00, 0x33, 0x44, 0x88, 0x56, 0x45, 0x56, 0x41, 0x00, 0x33, 0x44, 0x88, 0x56, 0x45, 0x56, 0x41, 0x00, 0x33, 0x44, 0x88, 0x56, 0x25, 0x58, 0x51, 0x03, 0x33, 0x24, 0x83, 0x52, 0x72, 0x16, 0x73, 0x85, 0x45, 0x47, 0x86, 0x36, 0x43, 0x52, 0x41, 0x74, 0x32, 0x04, 0x28, 0x26, 0x23, 0x46, 0x46, 0x06, 0x33, 0x34, 0x23, 0x21, 0x53, 0x15, 0x47, 0x77, 0x38, 0x41, 0x89, 0x58, 0x42, 0x51, 0x40, 0x86, 0x53, 0x40, 0x58, 0x36, 0x67, 0x53, 0x71, 0x03, 0x33, 0x74, 0x01, 0x89, 0x45, 0x12, 0x86, 0x60, 0x93, 0x42, 0x34, 0x66, 0x41, 0x51, 0x22, 0x60, 0x73, 0x41, 0x48, 0x46, 0x55, 0x52, 0x21, 0x00, 0x33, 0x64, 0x48, 0x66, 0x95, 0x53, 0x01, 0x03, 0x03, 0x24, 0x18, 0x16, 0x42, 0x53, 0x12, 0x40, 0x27, 0x47, 0x38, 0x56, 0x33, 0x58, 0x49, 0x09, 0x33, 0x04, 0x31, 0x34, 0x02, 0x22, 0x32
arraylength:	.word 0x80

# Array for storing indexes of search results - 512 space - 4 bits per int = 4 x 128 (Potentially could be this big if for example every array element was same number)
indexArray: .space 512

# Array for storing new smoothed numbers - 512 space - 4 bits per int = 4 x 128
smoothedNumbersArray: .space 512 

# -------------------------------------------------------------------- Messages and Text used in program --------------------------------------------------------------------
# Welcome Message
welcomeMsg:.asciiz "Welcome to MIPS Mini Project... please select a function from the Main Menu Options below:\n" # Welcome Message text for program

# Main Menu Options text
mainMenu:.asciiz "\nMain Menu Options\n 
----------------------------------------------------------------------------------\n
1) Display array of numbers\n
2) Display the second largest number and second smallest number in the array\n
3) Search for a number in the array\n
4) Run the smoothing program\n
5) Reverse each number of the array\n
6) Exit program\n
----------------------------------------------------------------------------------\n" 

# User prompt to enter selected function
userSelection:.asciiz "\nEnter option: " 

# User prompted to go again
goAgain:.asciiz "\nDo you want to return to the Main Menu Options? (Enter 1 for yes, any other key to exit program): "

# Exit program message
exitMsg:.asciiz "\n\nExiting program..."

# Headers used for formatting print out of array
indexHeader:.asciiz "Index"
numberHeader:.asciiz "Number"
bitsHeader:.asciiz "Binary"
reversedBitsHeader:.asciiz "Reversed Binary"
underlineHeader:.asciiz "--------------------"
underlineHeaderLarge:.asciiz "------------------------------------------------------------"

# Function messages 
function1Msg:.asciiz "\n\nYou have selected to display array of numbers...\n"
function1Msg1:.asciiz "\nNumbers are shown below with the corresponding indexes in parenthesis:\n\n"
function2Msg:.asciiz "\n\nYou have selected to display the second largest number and second smallest number in the array...\n"
function2Msg1:.asciiz "\nSecond smallest and second largest numbers are shown below with the corresponding indexes in parenthesis:\n"
function2Msg2:.asciiz "\nSecond smallest number:\n"
function2Msg3:.asciiz "\nSecond largest number:\n"
function3Msg:.asciiz "\n\nYou have selected to search for a number in the array...\n"
function3Msg1:.asciiz "\nEnter number to search: "
function3Msg2:.asciiz "\nYou searched for: "
function3Msg3:.asciiz "\n\nNumber not found...\n"
function3Msg4:.asciiz "\n\nDo you want to search again? (Enter 1 for yes, any other key to exit function): "
function3Msg5:.asciiz "\n\nNumber found...\n"
function3Msg6:.asciiz "\nTotal number of times number was found:\n"
function3Msg7:.asciiz "\nThe number was found at the below indexes:\n"
function4Msg:.asciiz "\n\nYou have selected to run the smoothing program...\n"
function4Msg1:.asciiz "\nSmoothed numbers are shown below with the corresponding indexes in parenthesis:\n\n"
function5Msg:.asciiz "\n\nYou have selected to reverse each number of the array...\n"
function5Msg1:.asciiz "\nNumbers are shown below with the corresponding indexes in parenthesis.\n"
function5Msg2:.asciiz "\nThe binary of each number is also displayed along with the binary reversed:\n\n"
.text
.globl main

# ------------------------------------- Main Function -------------------------------------

main:
	
	# Print welcomeMsg
    li $v0, 4 # print_string syscall code = 4
	la $a0, welcomeMsg
	syscall
	
	# Execute menuOptions function
	jal menuOptions
	
# ------------------------------------- Menu Options Function -------------------------------------

menuOptions: # This function is used for displaying the welcome message and the main menu options

	# Print mainMenu
	li $v0, 4 # print_string syscall code = 4
	la $a0, mainMenu
	syscall
			   
	# Print userSelection
	li $v0, 4 # print_string syscall code = 4
	la $a0, userSelection
	syscall

	# Get selected function from user and store
	li $v0, 5 # read_int syscall code = 5
    syscall
			   
	# Store selected function in $t0
    move $t0, $v0 # syscall results returned in $v0
			   
	# If user has entered 1 
	beq $t0, 1, function1 # Execute function1
			   
	# If user has entered 2 
	beq $t0, 2, function2 # Execute function2
			   
	# If user has entered 3 
	beq $t0, 3, function3 # Execute function3
			   
	# If user has entered 4 
	beq $t0, 4, function4 # Execute function4
			   
	# If user has entered 5 
	beq $t0, 5, function5 # Execute function5
			   
	# If user has entered 6
	beq $t0, 6, function6 # Execute function6
			   
	jr $ra
			   			   	   
# ------------------------------------- Function 1 - Display array of numbers -------------------------------------	 

function1: # This function is used for displaying array of numbers

	# Print function1Msg
	li $v0,4 # print_string syscall code = 4
	la $a0, function1Msg
	syscall	

	# Print function1Msg1
	li $v0,4 # print_string syscall code = 4
	la $a0, function1Msg1
	syscall			
		 
	# Print newLine
    li $a0, 10 # new line function = 10
    li $v0, 11 # print_char syscall code = 11
    syscall
	
	# Print indexHeader
	li $v0,4 # print_string syscall code = 4
	la $a0, indexHeader
	syscall	
	
	# Print a tab between headers
    li $a0, 9  # tab function = 9
	li $v0, 11 # print_char syscall code = 11
    syscall
	
	# Print numberHeader
	li $v0,4 # print_string syscall code = 4
	la $a0, numberHeader
	syscall	
	
	# Print newLine
    li $a0, 10 # new line function = 10
    li $v0, 11 # print_char syscall code = 11
    syscall
	
	# Print underlineHeader
	li $v0,4 # print_string syscall code = 4
	la $a0, underlineHeader
	syscall	
	
	# Print newLine
    li $a0, 10 # new line function = 10
    li $v0, 11 # print_char syscall code = 11
    syscall
		 
	# Store array in t1
	la $t1, array
		 
	# Initialize registers
	li $s0, 0 # Reg $s0 counter (i)		
	lw $s1, arraylength # Reg $s1 length of array
		 	 
	# Execute loopArray function
	jal loopArray		 
		 
	jr $ra
		 
# ------------------------------------- loopArray Function -------------------------------------

loopArray: # This function is used for displaying array elements
	
	# Print left bracket for index
    li $a0, 40 # left bracket function = 40
    li $v0, 11 # print_char syscall code = 11
    syscall
				
	# Print index of array element
	# Store $s0 (counter number/index) in $a0
    move $a0, $s0 # $s0 = counter number/index
    li $v0, 1 # print_int syscall code = 1
	syscall
				
	# Print right bracket for index
	li $a0, 41 # right bracket function = 41
    li $v0, 11 # print_char syscall code = 11
    syscall
				
	# Print a tab between index and array element
    li $a0, 9  # tab function = 9
	li $v0, 11 # print_char syscall code = 11
    syscall
				
	# Print the array element
    lw $t2, 0 ($t1) # load first number
	move $a0, $t2 # address of first number
	li $v0, 1 # print_int syscall code = 1
	syscall
				
	# Get the next element in the array
    addi $t1, 4
				
	# Add 1 to counter
    addi $s0, 1
	
	# Print newLine
    li $a0, 10 # new line function = 10
    li $v0, 11 # print_char syscall code = 11
    syscall
		 
	# If $s0 = $s1 (counter = arraylength)
	# Execute exit function
	beq $s0, $s1, exit # Exit loop	

	# Else
	# Execute loopArray function
	j loopArray	
		 
# ------------------------------------- Function 2 - Display the second largest number and second smallest number in the array -------------------------------------	
 
function2: # This function is used for displaying the second largest number and second smallest number in the array

	# Print function2Msg
	li $v0, 4 # print_string syscall code = 4
	la $a0, function2Msg
	syscall
	
	# Print function2Msg1
	li $v0,4 # print_string syscall code = 4
	la $a0, function2Msg1
	syscall

	# Print newLine
    li $a0, 10 # new line function = 10
    li $v0, 11 # print_char syscall code = 11
    syscall
		 
	# Load address array in $t0
	la $t0, array
		 
	# Load address arraylength in $t1
	la $t1, arraylength
		 
	# Load word arraylength in $t1
	lw $t1, 0 ($t1)
		 
	# $t2 = smallest number
	li $t2, 0
		 
	# $t3 = second smallest number
	li $t3, 0
		 
	# $t4 = second smallest number index
	li $t4, 0
		 
	# $t5 = counter (i)
	li $t5, 0
	
	# $t7 = largest number
	li $t7, 0
	
	# $t8 = second largest number
	li $t8, 0
	
	# $t9 = second largest number index
	li $t9, 0

# ------------------------------------- getSecondSmallestLoop function -------------------------------------	
		  		 
getSecondSmallestLoop: # This function is used to loop over the array to get the second smallest number 	
	
	# If $t1 (arraylength) == $t5 (counter)
	# Execute printSecondSmallest function
	beq $t1, $t5, printSecondSmallest	
	
	# Else
	# Load current array number in $t6
	lw $t6, 0 ($t0)
	
	# If $t3 (second smallest number) is not 0
	# Execute secondSmallestNumber function
	bne $t3, 0, secondSmallestNumber 
	
	# If $t2 (smallest number) is not 0
	# Execute smallestNumber function
	bne $t2, 0, smallestNumber 
	
	# Else
	# Set $t2 (smallest number) as $t6 (current array number)
	move $t2, $t6
	
	# Execute getSecondSmallestLoopAgain function
	j getSecondSmallestLoopAgain

# ------------------------------------- smallestNumber function -------------------------------------
	  		
smallestNumber: # This function is used to get the smallest number in the array

	# If $t6 (current array number) is less than $t2 (smallest number)
	# Execute getSmallestNumber function
	blt $t6, $t2, getSmallestNumber
	
	# Else
	# Set $t3 (second smallest number) as $t6 (current array number)
	move $t3, $t6
	
	# Execute getSecondSmallestLoopAgain function
	j getSecondSmallestLoopAgain

# ------------------------------------- secondSmallestNumber function -------------------------------------

secondSmallestNumber: # This function is used to get the second smallest number in the array

	# If $t6 (current array number) is greater than or equal to $t3 (second smallest number)
	# Execute getSecondSmallestLoopAgain function
	bge $t6, $t3, getSecondSmallestLoopAgain
	
	# If $t6 (current array number) is less than $t2 (smallest number)
	# Execute getSmallestNumber function
	blt $t6, $t2, getSmallestNumber
	
	# If $t6 (current array number) is equal to $t2 (smallest number)
	# Execute getSecondSmallestLoopAgain function
	beq $t6, $t2, getSecondSmallestLoopAgain
	
	# Else
	# Set $t3 (second smallest number) as $t6 (current array number)
	move $t3, $t6
	
	# Set $t4 (second smallest number index) as $t5 (count)
	move $t4, $t5
	
	# Execute getSecondSmallestLoopAgain function
	j getSecondSmallestLoopAgain

# -------------------------------------------- getSmallestNumber function --------------------------------------------

getSmallestNumber: # This function moves numbers in order to get the smallest number on each iteration of the array
	
	# Set $t3 (second smallest number) as $t2 (smallest number)
	move $t3, $t2
	
	# Set $t2 (smallest number) as $t6 (current array number)
	move $t2, $t6

# ------------------------------------- getSecondSmallestLoopAgain function -------------------------------------

getSecondSmallestLoopAgain: # This function is used to re-loop over the array to get the second smallest number

	# Add 1 to counter
	addi $t5, 1
		  
	# Get the next number in array
	addi $t0, 4
	
	# Execute getSecondSmallestLoop function
	j getSecondSmallestLoop

# ------------------------------------- getSecondSmallestLoopAgain function -------------------------------------

printSecondSmallest: # This function is used to print the second smallest number

	# Print function2Msg2
	li $v0, 4 # print_string syscall code = 4
	la $a0, function2Msg2
	syscall
	
	# Print left bracket for second smallest number index
    li $a0, 40 # left bracket function = 40
    li $v0, 11 # print_char syscall code = 11
    syscall
				
	# Print index of second smallest number
	# Store $t4 (counter number/index) in $a0
    move $a0, $t4 # $t4 = counter number/index
    li $v0, 1 # print_int syscall code = 1
	syscall
				
	# Print right bracket for second smallest number index
	li $a0, 41 # right bracket function = 41
    li $v0, 11 # print_char syscall code = 11
    syscall
				
	# Print a space between second smallest number index and second smallest number
    li $a0, 32  # space function = 32
	li $v0, 11 # print_char syscall code = 11
    syscall
				
	# Print the second smallest number
	move $a0, $t3
	li $v0, 1 # print_int syscall code = 1
	syscall
	
	# Print newLine
    li $a0, 10 # new line function = 10
    li $v0, 11 # print_char syscall code = 11
    syscall

# -------------------------------------------------------------------------- resetRegisters function --------------------------------------------------------------------------

resetRegisters: # This function is used to rest the registers that are used when getting the second smallest number so they can be re-used to get the second largest number
	
	# Load address array in $t0
	la $t0, array
		 
	# Load address arraylength in $t1
	la $t1, arraylength
		 
	# Load word arraylength in $t1
	lw $t1, 0 ($t1)
		 
	# $t2 = smallest number
	li $t2, 0
		 
	# $t3 = second smallest number
	li $t3, 0
		 
	# $t4 = second smallest number index
	li $t4, 0
		 
	# $t5 = counter (i)
	li $t5, 0
	
	# $t7 = largest number
	li $t7, 0
	
	# $t8 = second largest number
	li $t8, 0
	
	# $t9 = second largest number index
	li $t9, 0
	
# ------------------------------------- getSecondLargestLoop function -------------------------------------
	
getSecondLargestLoop: # This function is used to loop over the array to get the second largest number 	
	
	# If $t1 (arraylength) == $t5 (counter)
	# Execute printSecondLargest function
	beq $t1, $t5, printSecondLargest	
	
	# Else
	# Load current array number in $t6
	lw $t6, 0 ($t0)
	
	# If $t8 (second largest number) is not 0
	# Execute secondLargestNumber function
	bne $t8, 0, secondLargestNumber 
	
	# If $t7 (largest number) is not 0
	# Execute largestNumber function
	bne $t7, 0, largestNumber 
	
	# Else
	# Set $t7 (largest number) as $t6 (current array number)
	move $t7, $t6
	
	# Execute getSecondLargestLoopAgain function
	j getSecondLargestLoopAgain

# ------------------------------------- getSecondLargestLoop function -------------------------------------

largestNumber: # This function is used to get the largest number in the array

	# If $t6 (current array number) is greater than $t7 (largest number)
	# Execute getLargestNumber function
	bgt $t6, $t7, getLargestNumber
	
	# Else
	# Set $t8 (second largest number) as $t6 (current array number)
	move $t8, $t6
	
	# Execute getSecondLargestLoopAgain function
	j getSecondLargestLoopAgain

# ------------------------------------- secondLargestNumber function -------------------------------------

secondLargestNumber: # This function is used to get the second largest number in the array

	# If $t6 (current array number) is less than $t8 (second largest number)
	# Execute getSecondLargestLoopAgain function
	blt $t6, $t8, getSecondLargestLoopAgain
	
	# If $t8 (second largest number) is greater than $t7 (largest number)
	# Execute getLargestNumber function
	bgt $t8, $t7, getLargestNumber
	
	# Else
	# Set $t8 (second largest number) as $t6 (current array number)
	move $t8, $t6
	
	# Set $t9 (second largest number index) as $t5 (count)
	move $t9, $t5
	
	# Execute getSecondLargestLoopAgain function
	j getSecondLargestLoopAgain

# ------------------------------------------ secondLargestNumber function ------------------------------------------

getLargestNumber: # This function moves numbers in order to get the largest number on each iteration of the array
	
	# Set $t7 (largest number) as $t6 (current array number)
	move $t7, $t6

# ------------------------------------- getSecondLargestLoopAgain function -------------------------------------

getSecondLargestLoopAgain: # This function is used to re-loop over the array to get the second largest number

	# Add 1 to counter
	addi $t5, 1
		  
	# Get the next number in array
	addi $t0, 4
	
	# Execute getSecondLargestLoop function
	j getSecondLargestLoop	

# ------------------------------------- printSecondLargest function -------------------------------------

printSecondLargest: # This function is used to print the second largest number

	# Print function2Msg3
	li $v0, 4 # print_string syscall code = 4
	la $a0, function2Msg3
	syscall

	# Print left bracket for second largest number index
    li $a0, 40 # left bracket function = 40
    li $v0, 11 # print_char syscall code = 11
    syscall
				
	# Print index of second largest number
	# Store $t9 (counter number/index) in $a0
    move $a0, $t9 # $t9 = counter number/index
    li $v0, 1 # print_int syscall code = 1
	syscall
				
	# Print right bracket for second largest number index
	li $a0, 41 # right bracket function = 41
    li $v0, 11 # print_char syscall code = 11
    syscall
				
	# Print a space between second largest number index and second largest number
    li $a0, 32  # space function = 32
	li $v0, 11 # print_char syscall code = 11
    syscall
				
	# Print the second largest number
	move $a0, $t8 # address of first number
	li $v0, 1 # print_int syscall code = 1
	syscall
	
	# Print newLine
    li $a0, 10 # new line function = 10
    li $v0, 11 # print_char syscall code = 11
    syscall
	
	# Execute exit function
	jal exit
	
# ------------------------------------- Function 3 - Search for a number in the array -------------------------------------	 

function3: # This function is used for searching for a number in the array

	# $t5 = search value
	add $t5, $zero, $zero
	
	# Print function3Msg
	li $v0, 4 # print_string syscall code = 4
	la $a0, function3Msg
	syscall	
	
	# Print function3Msg1
	li $v0, 4 # print_string syscall code = 4
	la $a0, function3Msg1
	syscall	
	
	# Get selected function from user and store
	li $v0, 5 # read_int syscall code = 5
    syscall
	
	# Load user input in $t5
	move $t5, $v0
	
	# Load address array in $t0
	la $t0, array
		 
	# Load address arraylength in $t1
	la $t1, arraylength
		 
	# Load word arraylength in $t1
	lw $t1, 0 ($t1)
		 
	# $t4 = counter (i)
	li $t4, 0
	
	# $t7 = number of times search was found
	li $t7, 0
	
	# $t2 = search again?
	li $t2, 0
	
	# Load address indexArray in $t3
	la $t3, indexArray
	
	# $t8 = indexArray position
	li $t8, 0
	
	# $s0 = indexArray counter
	li $s0, 0 

# ------------------------------------- searchNumbersLoop function -------------------------------------	

searchNumbersLoop: # This function is used to loop over the array to get the search results

	# If $t1 (arraylength) == $t4 (counter)
	# Execute printSearchResults function
	beq $t1, $t4, printSearchResults	
	
	# Else
	# Load current array number in $t6
	lw $t6, 0 ($t0)
	
	# If $t6 (current array number) is equal to $t5 (user input)
	# Execute foundNumber function
	beq $t6, $t5, foundNumber
	
	# Else
	# Execute getsearchNumbersLoopAgain function
	j getsearchNumbersLoopAgain

# ----------------------------------------------------------- foundNumber function -----------------------------------------------------------

foundNumber: # This function is used when a number is found to increase the count of numbers found and add indexes of numbers to indexArray
	
	# Add 1 to number of times search was found
	addi $t7, 1
	
	# Add index to indexArray
	sw $t4, indexArray($t8) 	  
	
	# Get the next position in the indexArray
	addi $t8, 4
	
	# Execute getsearchNumbersLoopAgain function
	j getsearchNumbersLoopAgain

# ---------------------------------------- noNumberFound function ----------------------------------------

noNumberFound: # This function is used when a number is not found to print messages and exit function 3
	
	# Print function3Msg3
	li $v0, 4 # print_string syscall code = 4
	la $a0, function3Msg3
	syscall	
	
	# Print function3Msg4
	li $v0, 4 # print_string syscall code = 4
	la $a0, function3Msg4
	syscall
	
	# Get search again choice from user and load in $t2
    li $v0, 5 # read_int syscall code = 5
    syscall
    move $t2, $v0 # syscall results returned in $v0
	
	# If user has entered 1
	# Execute function3 function
	beq $t2, 1, function3 
	
	# Else
	# Execute exit function
	jal exit

# -------------------------------------------------- getsearchNumbersLoopAgain function --------------------------------------------------
	
getsearchNumbersLoopAgain: # This function is used to re-loop over the array to get search results

	# Add 1 to counter
	addi $t4, 1
				  
	# Get the next number in array
	addi $t0, 4
	
	# Execute searchNumbersLoop function
	j searchNumbersLoop	

# ---------------------------------------- printSearchResults function ----------------------------------------

printSearchResults: # This function is used to print the results of the user search
	
	# Print function3Msg2
	li $v0, 4 # print_string syscall code = 4
	la $a0, function3Msg2
	syscall
	
	# Print number user entered
	move $a0, $t5 # address of number user entered
	li $v0, 1 # print_int syscall code = 1
	syscall
	
	# If $t7 (number of times search was found) = 0
	# Execute noNumberFound function
	beq $t7, 0, noNumberFound

	# Else
	# Print function3Msg5
	li $v0, 4 # print_string syscall code = 4
	la $a0, function3Msg5
	syscall	
	
	# Print newLine
    li $a0, 10 # new line function = 10
    li $v0, 11 # print_char syscall code = 11
    syscall
	
	# Print function3Msg6
	li $v0, 4 # print_string syscall code = 4
	la $a0, function3Msg6
	syscall	
	
	# Print newLine
    li $a0, 10 # new line function = 10
    li $v0, 11 # print_char syscall code = 11
    syscall
	
	# Print number of times search was found
	move $a0, $t7 # address of number of times search was found
	li $v0, 1 # print_int syscall code = 1
	syscall
	
	# Print newLine
    li $a0, 10 # new line function = 10
    li $v0, 11 # print_char syscall code = 11
    syscall
	
	# Print function3Msg7
	li $v0, 4 # print_string syscall code = 4
	la $a0, function3Msg7
	syscall	

	# Print newLine
    li $a0, 10 # new line function = 10
    li $v0, 11 # print_char syscall code = 11
    syscall
	
	j printIndexResults
	
# ---------------------------------------- printIndexResults function ----------------------------------------
	
printIndexResults: # This function is used to print the indexes of the results of the user search

	# If $s0 (indexArray counter) = $t7 (indexArray count)
	# Execute exitFucntion3 function
	beq $s0, $t7, exitFucntion3 # Exit loop
	
	# Print the indexArray element
    lw $t9, 0 ($t3) # load first index
	move $a0, $t9 # address of first index
	li $v0, 1 # print_int syscall code = 1
	syscall
	
	# Print newLine
    li $a0, 10 # new line function = 10
    li $v0, 11 # print_char syscall code = 11
    syscall
	
	# Get the next element in the indexArray
    addi $t3, 4
				
	# Add 1 to indexArray counter
    addi $s0, 1
	
	j printIndexResults

# ---------------------------------------- exitFucntion3 function ----------------------------------------

exitFucntion3: # This function is used to exit function 3
	
	# Print function3Msg4
	li $v0, 4 # print_string syscall code = 4
	la $a0, function3Msg4
	syscall
	
	# Get search again choice from user and load in $t2
    li $v0, 5 # read_int syscall code = 5
    syscall
    move $t2, $v0 # syscall results returned in $v0
	
	# If user has entered 1
	# Execute function3 function
	beq $t2, 1, function3 
	
	# Else
	# Execute exit function
	jal exit
	
# ------------------------------------- Function 4 - Run the smoothing program -------------------------------------	 

function4: # This function is used for running the smoothing program

	# Print function4Msg
	li $v0,4 # print_string syscall code = 4
	la $a0, function4Msg
	syscall	
	
	# Print function4Msg1
	li $v0,4 # print_string syscall code = 4
	la $a0, function4Msg1
	syscall	
	
	# Print newLine
    li $a0, 10 # new line function = 10
    li $v0, 11 # print_char syscall code = 11
    syscall
	
	# Print indexHeader
	li $v0,4 # print_string syscall code = 4
	la $a0, indexHeader
	syscall	
	
	# Print a tab between headers
    li $a0, 9  # tab function = 9
	li $v0, 11 # print_char syscall code = 11
    syscall
	
	# Print numberHeader
	li $v0,4 # print_string syscall code = 4
	la $a0, numberHeader
	syscall	
	
	# Print newLine
    li $a0, 10 # new line function = 10
    li $v0, 11 # print_char syscall code = 11
    syscall
	
	# Print underlineHeader
	li $v0,4 # print_string syscall code = 4
	la $a0, underlineHeader
	syscall	
	
	# Print newLine
    li $a0, 10 # new line function = 10
    li $v0, 11 # print_char syscall code = 11
    syscall
		 
	# Initialize registers
	li $s0, 0 # Reg $s0 counter (i)		
	lw $s1, arraylength # Reg $s1 length of array
	li $s2, 2 # Divide by 2
	li $s3, 4 # Divide by 4
	li $s4, 0 # New smoothed number
	
	# Load address array in $t0
	la $t0, array
	
	# Load address smoothedNumbersArray in $t1
	la $t1, smoothedNumbersArray
	
	# $t2 = smoothedNumbersArray position
	li $t2, 0
	
	# $t3 = smoothedNumbersArray counter
	li $t3, 0 
	
# ---------------------------------------- numberSmoothingLoop function ----------------------------------------
	
numberSmoothingLoop: # This function is used for looping over the array in order to smooth the numbers

	# If $s1 (arraylength) == $s0 (counter)
	# Execute printSmoothedNumbers function
	beq $s1, $s0, printSmoothedNumbers	
	
	# Load current array number in $t6
	lw $t6, 0 ($t0)
	
	# Add 1 to counter
	addi $s0, 1
				  
	# Get the next number in array
	addi $t0, 4
	
	# If $s0 (counter) = 1 
	# Execute saveFirstLastNumbers function (this gets the first number)
	beq $s0, 1, saveFirstLastNumbers
	
	# Get the next poisition in the smoothedNumbersArray
	addi $t2, 4
	
	# If $s1 (arraylength) == $s0 (counter)
	# Execute saveFirstLastNumbers function (this gets the last number)
	beq $s1, $s0, saveFirstLastNumbers
	
	# If $s1 (counter) is greater than 0 
	# Excute smoothNumbers function
	bgt $s0, 0, smoothNumbers
	
# -------------------------------------------------------------------------------- saveFirstLastNumbers function -------------------------------------------------------------------------------
	
saveFirstLastNumbers: # This function is used to storing the first and last numbers of the array as they act as the corners of the image in this case, therefore they do not need smoothed
	
	# Add $t6 (current number) to smoothedNumbersArray
	sw $t6, smoothedNumbersArray($t2) 	  
	
	# Execute numberSmoothingLoop function
	j numberSmoothingLoop
	
# ---------------------------------------- smoothNumbers function ----------------------------------------
	
smoothNumbers: # This function is used for calculations that are performed in order to smooth numbers

	# Get the previous number in array
	addi $t0, -8
	
	# Load the previous number into $t7
	lw $t7, 0 ($t0)
	
	# Divide $t7 (previous number) by 4 to get 1/4 of $t7 
	div $t7, $s3
	
	# As result will fit in 32-bits retrive only the LO bits
	mflo $t7
	
	# Divide $t6 (current number) by 2 to get 1/2 of $t6 
	div $t6, $s2
	
	# As result will fit in 32-bits retrive only the LO bits
	mflo $t6
	
	# Get the next number in array
	addi $t0, 8
	
	# Load the next number into $t8
	lw $t8, 0 ($t0)
	
	# Divide $t8 (next number) by 4 to get 1/4 of $t8 
	div $t8, $s3
	
	# As result will fit iin 32-bits retrive only the LO bits
	mflo $t8
	
	# Add result of $t7 (previous number) division to result of $t6 (current number) division
	# Sum = $t9 (new smoothed number)
	add $t9, $t7, $t6
	
	# Add $t9 (new smoothed number) to result of $t8 (next number) division
	# Sum = $t9 (new smoothed number)
	add $t9, $t9, $t8
	
	# Add new smoothedNumber to smoothedNumbersArray
	sw $t9, smoothedNumbersArray($t2)
	
	# Execute numberSmoothingLoop function
	j numberSmoothingLoop
	
# ---------------------------------------- printSmoothedNumbers function ----------------------------------------
	
printSmoothedNumbers: # This function is used for printing out each element of the smoothedNumbersArray

	# If $t3 (smoothedNumbersArray counter) = $s1 (arraylength count)
	# Execute exit function
	beq $t3, $s1, exit # Exit loop
	
	# Print left bracket for index
    li $a0, 40 # left bracket function = 40
    li $v0, 11 # print_char syscall code = 11
    syscall
	
	# Print the smoothedNumbersArray element index
	move $a0, $t3 # address of first smoothedNumbersArray element index
	li $v0, 1 # print_int syscall code = 1
	syscall
	
	# Print right bracket for index
	li $a0, 41 # right bracket function = 41
    li $v0, 11 # print_char syscall code = 11
    syscall
	
	# Print a tab between index and array element
    li $a0, 9  # tab function = 9
	li $v0, 11 # print_char syscall code = 11
    syscall
	
	# Print the smoothedNumbersArray element
    lw $s4, 0 ($t1) # load first smoothedNumbersArray element
	move $a0, $s4 # address of first smoothedNumbersArray element
	li $v0, 1 # print_int syscall code = 1
	syscall
	
	# Print newLine
    li $a0, 10 # new line function = 10
    li $v0, 11 # print_char syscall code = 11
    syscall
	
	# Get the next element in the smoothedNumbersArray
    addi $t1, 4
				
	# Add 1 to smoothedNumbersArray counter
    addi $t3, 1
	
	# Execute printSmoothedNumbers function
	j printSmoothedNumbers
	
# ------------------------------------- Function 5 - Reverse each number of the array -------------------------------------	 

function5: # This function is used for reversing each number of the array

	# Print function5Msg
	li $v0,4 # print_string syscall code = 4
	la $a0, function5Msg
	syscall	
	
	# Print function5Msg1
	li $v0,4 # print_string syscall code = 4
	la $a0, function5Msg1
	syscall	
	
	# Print function5Msg2
	li $v0,4 # print_string syscall code = 4
	la $a0, function5Msg2
	syscall	
	
	# Initialize registers
	li $s0, 0 # Reg $s0 counter (i)		
	lw $s1, arraylength # Reg $s1 length of array
	
	# Load address array in $t0
	la $t0, array
	
	# Shift amount counter
	li $t1, 0
	
	# Current bit
	li $t2, 0
	
	# Amount of bits before most significant
	li $t3, 0
	
	# Max amount of bits in a word
	li $t4, 0
	
	# Counter for finishing reversal of bits
	li $t7, 0
	
	# Print newLine
    li $a0, 10 # new line function = 10
    li $v0, 11 # print_char syscall code = 11
    syscall
	
	# Print indexHeader
	li $v0,4 # print_string syscall code = 4
	la $a0, indexHeader
	syscall	
	
	# Print a tab between headers
    li $a0, 9  # tab function = 9
	li $v0, 11 # print_char syscall code = 11
    syscall
	
	# Print numberHeader
	li $v0,4 # print_string syscall code = 4
	la $a0, numberHeader
	syscall	
	
	# Print a tab between headers
    li $a0, 9  # tab function = 9
	li $v0, 11 # print_char syscall code = 11
    syscall
	
	# Print bitsHeader
	li $v0,4 # print_string syscall code = 4
	la $a0, bitsHeader
	syscall	
	
	# Print a tab between headers
    li $a0, 9  # tab function = 9
	li $v0, 11 # print_char syscall code = 11
    syscall
	
	# Print a tab between headers
    li $a0, 9  # tab function = 9
	li $v0, 11 # print_char syscall code = 11
    syscall
	
	# Print reversedBitsHeader
	li $v0,4 # print_string syscall code = 4
	la $a0, reversedBitsHeader
	syscall	
	
	# Print newLine
    li $a0, 10 # new line function = 10
    li $v0, 11 # print_char syscall code = 11
    syscall
	
	# Print underlineHeaderLarge
	li $v0,4 # print_string syscall code = 4
	la $a0, underlineHeaderLarge
	syscall	
	
	# Execute getNumberBitsLoop function
	j getNumberBitsLoop
	
# ---------------------------------------- getNumberBitsLoop function ----------------------------------------
	
getNumberBitsLoop: # This function is used to loop over the numbers array to get bits

	# If $s1 (arraylength) == $s0 (counter)
	# Execute exit function
	beq $s1, $s0, exit	
	
	# Set shift amount counter (used for shifting through the bits of the number)
	# Set to 31 as we have a word array with each word using a max of 32 bits
	# Setting this to 31 means that we will shift through all bits and also keep the most significant
	li $t1, 31
	
	# Execute getBitsLoop function
	j getBitsLoop
	
# ---------------------------------------- getBitsLoop function ----------------------------------------
	
getBitsLoop: # This function is used to get the binary of the numbers

    # Load current array number in $t6
	lw $t6, 0 ($t0)
	
	# Shift right using $t1 (shift amount counter) 
	# $t2 here will become the current bit shifted
    srl $t2, $t6, $t1
		
	# If $t2 (current bit) is not $zero
	# Execute exitGetBitsLoop function
    bne $t2, $zero, exitGetBitsLoop
		
	# If $t1 (shift amount counter) is $zero 
	# Execute exitGetBitsLoop function
    beq $t1, $zero, exitGetBitsLoop
		
	# Else
	# Subtract 1 from $t1 (shift amount counter) to shift to the next bit in the number
    sub $t1, $t1, 1
	
	# Execute getBitsLoop function
    j getBitsLoop
	
# ---------------------------------------- exitGetBitsLoop function ----------------------------------------

exitGetBitsLoop: # This function is used to print out table info and prep to print bits
	
	# Store $t7 (shift amount counter) in $t3 (amount of bits before most significant)
    move $t3, $t1

	# Print newLine
    li $a0, 10 # new line function = 10
    li $v0, 11 # print_char syscall code = 11
    syscall
	
	# Print left bracket for index
    li $a0, 40 # left bracket function = 40
    li $v0, 11 # print_char syscall code = 11
    syscall
				
	# Print index of array element
	# Store $s0 (counter number/index) in $a0
    move $a0, $s0 # $s0 = counter number/index
    li $v0, 1 # print_int syscall code = 1
	syscall
				
	# Print right bracket for index
	li $a0, 41 # right bracket function = 41
    li $v0, 11 # print_char syscall code = 11
    syscall
	
	# Print a tab between index and array element
    li $a0, 9  # tab function = 9
	li $v0, 11 # print_char syscall code = 11
    syscall
	
	# Print the array element
	move $a0, $t6 # address of first number
	li $v0, 1 # print_int syscall code = 1
	syscall
	
	# Print a tab between array element and $t2 (current bit)
    li $a0, 9  # tab function = 9
	li $v0, 11 # print_char syscall code = 11
    syscall
	
	# Set $t4 (max amount of bits in a word) to 32 
	# 32 is the max amount of bits as we are working with an array of words
    li $t4, 32
	
	# Subtract $t1 (shift amount counter) from $t4 (max amount of bits in a word)
	# By subtracting $t1 (shift amount counter) from $t4 (max amount of bits in a word) we will get the amount of bits before the most significant bit
    sub $t1, $t4, $t1
	
	# Execute printBits function
    j printBits
	
# ---------------------------------------- printBits function ----------------------------------------

printBits: # This function is used to loop over the numbers bits and print them

    # Print out the bits
    move $a0, $t2 # Move $t2 (current bit) to $a0 for printing
	li $v0, 1 # print_int syscall code = 1
    syscall

	# If $t1 (shift amount counter) = $t4 (Max amount of bits in a word)
	# Execute prepForReversingBits
    beq $t1, $t4, prepForReversingBits

    # Load current array number in $t6
	lw $t6, 0 ($t0)
	
	# Shift left over $t6 (current array number) using $t1 (shift amount counter)
    sll $t6, $t6, $t1
	
	# Shift right over $t6 (current array number) to get $t2 (current bit) as most significant bit
    srl $t2, $t6, 31
	
	# Add 1 to $t1 (shift amount counter) to continue shifting over the bits
    add $t1, $t1, 1
	
	# Execute printBits function
    j printBits
	
# ---------------------------------------- prepForReversingBits function ----------------------------------------

prepForReversingBits: # This function is used to prep for reversing the numbers binary

	# Print a tab between numbers binary and reversed binary
    li $a0, 9  # tab function = 9
	li $v0, 11 # print_char syscall code = 11
    syscall
	
	# Print a tab between numbers binary and reversed binary
    li $a0, 9  # tab function = 9
	li $v0, 11 # print_char syscall code = 11
    syscall

    # Subtract 1 from $t4 (max amount of bits in a word) 
	# This will make $t4 31
    sub $t4, $t4, 1
	
	# Set $t1 (shift amount counter) back to $t3 (amount of bits before most significant)
	# This is used when shifting the most siginifcant bit
    move $t1, $t3
	
	# Set $t7 (counter for finishing reversal of bits) to 0
    li $t7, 0
	
    # Load current array number in $t6	
	lw $t6, 0 ($t0)
	
	# Execute reverseBitsLoop function
	j reverseBitsLoop
	
# ---------------------------------------- reverseBitsLoop function ----------------------------------------

reverseBitsLoop: # This function is used for looping over the numbers binary and reverse the bits

	# Subtract $t7 (counter for finishing reversal of bits) from $t4 (max amount of bits in a word)
	# This will get $t3 (amount of bits before most significant) which will be used for shifting below
    sub $t3, $t4, $t7
	
	# Shift left over $t6 (current array number) using $t3 (amount of bits before most significant)
	# This will make $t2 (current bit) the most significant
    sll $t2, $t6, $t3
	
	# Shift right over the bits to the right of $t2 (current bit)
    srl $a0, $t2, 31
	# Print out $t2 (current bit)
	li $v0, 1 # print_int syscall code = 1
    syscall

	# If $t7 (counter for finishing reversal of bits) = $t1 (shift amount counter)
	# Execute getNumberBitsLoopAgain function
    beq $t7, $t1, getNumberBitsLoopAgain
	
	# Else
	# Add 1 to $t3 (amount of bits before most significant) to keep shifting over bits
    add $t3, $t3, 1
	
	# Add 1 to $t7 counter for finishing reversal of bits
    add $t7, $t7, 1
	
	# Execute reverseBitsLoop function
    j reverseBitsLoop
	
# ---------------------------------------- getNumberBitsLoopAgain function ----------------------------------------
		
getNumberBitsLoopAgain: # This function is used to re-loop over the getNumberBitsLoop function
	
	# Add 1 to counter
	addi $s0, 1
				  
	# Get the next number in array
	addi $t0, 4
	
	# Execute getNumberBitsLoop function
	j getNumberBitsLoop

# ------------------------------------- Function 6 - Exit program -------------------------------------	 

function6: # This function is used for exiting the program

	# User has not entered 1 so exit program
	# Print exitMsg
	li $v0, 4 # print_string syscall code = 4
	la $a0, exitMsg
	syscall	
	
	# Print newLine
    li $a0, 10 # new line function = 10
    li $v0, 11 # print_char syscall code = 11
    syscall
	
	# Exit program
	li $v0, 10 # exit syscall code = 10
	syscall	
		 		
# ------------------------------------- Exit functions function -------------------------------------		
 
exit: # This function is used when exiting the program from within functions

	# Print newLine
    li $a0, 10 # new line function = 10
    li $v0, 11 # print_char syscall code = 11
    syscall

	# Print goAgain
	li $v0, 4 # print_string syscall code = 4
	la $a0, goAgain
	syscall
		
	# Get input from user and save
    li $v0, 5 # read_int syscall code = 5
    syscall
    move $t1, $v0 # syscall results returned in $v0
	
	# Print newLine
    li $a0, 10 # new line function = 10
    li $v0, 11 # print_char syscall code = 11
    syscall
	
	# Check if user has entered 1
	beq $t1, 1, menuOptions # Execute menuOptions
	
	# User has not entered 1 so exit program
	# Print exitMsg
	li $v0, 4 # print_string syscall code = 4
	la $a0, exitMsg
	syscall	
	
	# Print newLine
    li $a0, 10 # new line function = 10
    li $v0, 11 # print_char syscall code = 11
    syscall
	
	# Exit program
	li $v0, 10 # exit syscall code = 10
	syscall	