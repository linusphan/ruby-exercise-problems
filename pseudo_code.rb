# Pseudo-Code Practice

# a method that returns the sum of two integers
# casual
Given two integers
Add the two integers
Return the result

# formal
START

SET sum method that takes two integers
SET result = integer_1 + integer_2
return result

END


# a method that takes an array of strings, and
# returns a string that is all those strings concatenated together
# casual
Given array of strings.
Create a new and empty string
Iterate over the array of strings
-concatenate each step with the empty string
then return the string

# formal
START

SET concatenate method that takes an array of strings
SET empty string literal
WHILE stepping through array
  concatenate empty string with each element in array
return variable holding the final result of the concatenated string

END


# a method that takes an array of integers, and
# returns a new array with every other element
# casual
Given array of integers
iterate through elements of the array
alternate between steps by looking at the index and append every other one to new array
return the new array with every other element

#formal
START

SET method that takes an array as argument
SET empty array literal
SET index_counter = 0

WHILE index_counter < array.size
  IF index_counter is even (or odd)
    append to the empty array/push
  ELSE
    next

return the new resulted array

END

