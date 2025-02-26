A simple MPIS project handling user input of numbers.


Function 1 – Display array of numbers: 

This function is used for looping over the provided list of numbers and printing out each number and its position (index) in the list. A basic for loop is used which means that after each number is looped over 1 is added to a counter. Once the value of the counter is equal to the number of elements (numbers) in the list the loop will exit. The output that the user will see if formatted in a tabular style with each number and its index printed on a new row in the table. 


Function 2 – Display the second largest number and the second smallest number in the array:

This function is used for looping over the provided list of numbers and printing out the second smallest and second largest numbers along with their positions (indexes) in the list. This function gets the first number in the list and sets it as the current smallest number. Each number in the list is then compared to the smallest number to get a new smallest and a second smallest number. For example, if the current number being looped over is less than the current smallest number it will be set as the new smallest number and the previous smallest number will be set to the second smallest number. The loop exits when all numbers in the list have been compared. 

When getting the second largest number a similar process is followed. The first number in the list is set as the current largest number. Then each number is compared to the largest number. If the number is greater than the current largest number, then it is set as the new largest number and the previous largest number is set to the second largest number. Again, the loop exits when all numbers in the list have been compared. 


Function 3 – Search for a number in the array:

This function allows a user to input a number that they wish to search for in the list. The number input is stored, and the list is looped over to check if any of the numbers contained in the list match the number input by the user. The loop exits when each number has been looped over. For each match that is found the position (index) of the matched number in the list is stored in a list. The number and each position that it was found at in the list is displayed along with the number of times the number was found. If no match is found, then a message is displayed telling the user that the number they searched for is not in the list.  


Function 4 – Run the smoothing program:

This function mimics the process used to smooth image pixels. This function takes the first number in the list and the last number in the list and stores them. As these two numbers act as the corners of the image they do not need smoothed. Every other number is looped over and divided in 2 to get 50% of its value. This is then added to 25% of the value of the numbers on either side of the current number which gives the user a new smoothed value. Once every number in the list has been looped over the list is printed displaying the new smoothed values. 


Function 5 – Reverse each number of the array:

This function is used to loop over each number in the list and reverse it. Firstly, the binary representation of each number is printed by shifting right over each bit  and printing out the bit once it has been shifted. A shift amount counter is used to specify how many times to shift, this is set to 31 as the list of numbers is in word form meaning each element in the list can have a maximum of 32 bits. We start shifting after the left most bit as it is the most significant bit.  

Next, to reverse each number in the list we simply reverse the binary representation of the numbers. to achieve this, we shift each bit of the number to the left which reverses the number by swapping the position of the bits. This means that the most significant bit in the original number ends up as the right most bit in the new number and so on. Like before, the function then shifts right over the reversed number and prints out each bit after shifting.  

The function outputs in a table format which displays the index of the number in the list, the original value of the number, the binary representation of the number, and the reversed binary representation of the number. 
