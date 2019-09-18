---
layout: post
title: "Common terms in Statistics"
description: "Quartile, Standard Deviation,"
comments: true
keywords: "ISLR, statistics"
mathjax: true
---

Here's a sample data array,
x = [2, 6, 8, 1, 56, 13, 8, -5, 4, 6, 23]. Length n = 11.
## Mean
Average of the data. Add all items, divide by length. For x, mean = 11 (rounded)
## Mode
Most common item. In x, mode = 6.
## Median
The median is the middle number in a data set. Steps to find the median.
* Sort the data. x = [-5, 1, 2, 4, 6, 6, 8, 13, 23, 56]
* If n is odd, find the middle item. If n is even, find the middle two item and calculate their average (add them and divide by 2) Here, since n is 11, 6th item is the median = 6.

## Quartile
Quartiles are values that divide the data in 4 regions. The regions are known as the lowest 25% of numbers, next lowest 25% of numbers(up to median), second highest 25% of numbers (above median), the highest 25% of numbers. So to have 4 region, we need 3 points called as Q1,Q2,Q3. In layman's term, the Q1 is greater than or equal to the lowest 25% of the number and so on. To calculate quartiles, data have to be sorted.
### 1st Quartile
\\[Q_{1}=\left(\frac{n+1}{4}\right)^{th}term\\]

For x, Q1 = 2
### 2nd Quartile
It's the same as median which is 6.
### 3rd Quartile
\\[Q_{3}=\left(\frac{3}{4}(n+1)\right)^{th}term\\]
For x, Q3 = 13
## Variance
It explains how far the data is spread out from their mean. Calculated as the average of the squared difference from the mean. For x, do \\((2-11)^{2}+ (6-11)^{2} + .... + (23-11)^{2}\\) and finally divide the sum by 11. Result is, 247.90
## Standard Deviation (SD)
Square root of variance. Explains if a number is normal or not, it can be big or small compared to the other items of the dataset. It tells us how tightly the data is clustered around the mean (the average). A small SD indicates that your data is tightly clustered. A large SD tells you that your data is more spread apart.

---
Visit the followings for more knowledge:
- https://www.statisticshowto.datasciencecentral.com
