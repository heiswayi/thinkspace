---
title: "Next Smallest Palindrome"
comments: True
---
Given a number, we have to find the next smallest [palindrome](https://en.wikipedia.org/wiki/Palindromic_number) which is larger than this number. 

The input can be arbitrarily large. We'll store the input in an array. e.g. if input is  1259,
array will be, `int k[]= {1,2,5,9}`. To find the next smallest palindrome, we have to generalize the input. There can be three types of input, 
* All digits are 9. e.g. 999
* Input is not a palindrome. e.g 12942
* The input itself a palindrome number. e.g. 1221
Algorithm for the first type is easy. Expand the array length by one and put boundary digits as 1 & all other digits will be 0. 
```
Input:   999
Output: 1001
```
 
# Left half & Right half
Left half of 522665 is 522 and left half of 52123 is 52. Right half of 522665 is 665 & right half of 52123 is 23.  

## Iteration
We'll compare between left half and right half, starting from middle. For example, two variable i and j will indicate to 2 & 4 respectively, if the input is 1 2 2 4 2 and i and j will indicate to 9 & 3 respectively if the input is 5 6 9 3 2 5. For each iteration i will decrement and j will increment.

Comparison outcomes.
k[i] == k[j] if this is true, do nothing.
k[i] > k[j] if this is true, then stop comparing and just copy left half to right half.
k[i] < k[j] if this is true, follow the procedure below.

Add and Copy: Add 1 to middle digit & propagate carry to the left half and simultaneously copy left half to right half.
Input: 5 2 1 1 6 5
n is even. so middle digit is 1 of left half. Perform (1+1) . 
summation 2, carry 0.
X X 2 2 X X
X 2 2 2 2 X
5 2 2 2 2 5

Output: 5 2 2 2 2 5
Input: 1 2 9 4 5
middle digit is 9. add 1 to it. propagate carry to left half and copy to right half simultaneously.
X X 0 X X
 X 3 0 3 X
1 3 0 3 1
Output: 1 3 0 3 1

#type 3: For all iterations, k[i] == k[j]. It means the input is palindromic. To find the next smallest palindrome, follow the same procedure as before. add 1 to middle digit and copy from left to right simultaneously. 

