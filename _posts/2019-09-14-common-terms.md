---
layout: post
title: "Common terms in Statistics"
description: ""
comments: true
keywords: "ISLR, statistics"
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
$$Q_{1}=\left(\frac{n+1}{4}\right)^{th}term$$

For x, Q1 = 2
### 2nd Quartile
It's the same as median which is 6.
### 3rd Quartile
$$Q_{3}=\left(\frac{3}{4}(n+1)\right)^{th}term$$
For x, Q3 = 13
## Variance
It explains how far the data is spread out from their mean. Calculated as the average of the squared difference from the mean. For x, do $(2-11)^{2}+ (6-11)^{2} + .... + (23-11)^{2}$ and finally divide the sum by 11. Result is, 247.90
## Standard Deviation (SD)
Square root of variance. Explains if a number is normal or not, it can be big or small compared to the other items of the dataset.

## P-value
P value is used in [hypothesis](https://www.statisticshowto.datasciencecentral.com/probability-and-statistics/hypothesis-testing/) testing to help support or reject the null hypothesis. P value is expressed in decimal. But if expressed in percentage, it is easier to understand. For example, a p value of 0.0254 is 2.54%. It means there's a 2.54% chance that the result is random, which is really small. A small p-value (typically ≤ 0.05) indicates strong evidence against the null hypothesis, so we can null hypothesis. A large p-value indicates strong against for the null hypothesis.

## $R^{2}$ -statistic
$R^2$ represents the accuracy of the model. It is the proportion of variance and is independent of $\bar{y}$
$$R^2 = (TSS - RSS)/TSS = 1- RSS/TSS$$ TSS is the variance in Y before the fit, and RSS is variance after the fit. So TSS-RSS measures the amount of variability in the response that is explained by performing the regression.\
If R^2 statistic is close to 1, the variability in the response is explained by the model, else it isn't explained and the model is wrong.
## F-statistic

Visit the followings for more knowledge:
- https://www.statisticshowto.datasciencecentral.com
