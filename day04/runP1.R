# R program to read one line at a time
 
# Import libraries
library(readr)
library(stringr)
 
# read_lines() to read one line at a time
myData = read_lines("test.txt")
print(myData[1])

nums = str_split(myData[1], ",")
print(nums)

