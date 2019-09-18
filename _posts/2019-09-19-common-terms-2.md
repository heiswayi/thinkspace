---
layout: post
title: "Common terms in Statistics ii"
description: "Degrees of Freedom, F-statistic, P-value, R^2 statistic"
comments: true
keywords: "ISLR, statistics"
mathjax: true
---

Here's a sample data matrix,
```
x = 2, 6, 8,
    56, 13, 8,
    4, 6, 23    
Sample groups, m = 3, number of observation in each group, n = 3.
Groups are column wise, i.e (2,56,4) is group 1 and so on.
```
## Degrees of Freedom
Number of independent variables in data.

## F-statistic
F-statistic is the ration of two quantities that are expected to be roughly equal under null hypothesis which makes F-statistic approximately 1. Now the numerator is the sum of square between the groups(SSB) and the denumerator is the sum of square within the groups (SSW). Notice that, these two are variances and calculated as-

**SSW:** Sum of \\((eachObservation - localMean)^2\\). In x, eachObservation are 2,6,8 and so on. localmean is mean of each group. For group 1, localMean = (2+56+4) / 3 = 20.33. Here DF is n-1 = 2

**SSB:** Sum of \\((localMean - globalMean)^2\\). In x, globalMean is mean of all observation. globalMean= (2+6+8+56+13+8+4+6+23)/9 = 14. DF = m*(n-1) = 3*2 = 6

Now,
\\[
F= \frac{\frac{SSB}{m*(n-1)}}{\frac{SSW}{n-1}}
\\]
F-value is large when SSB is larger than SSW, meaning the variability between the groups is larger. If that is the case, null hypothesis can be rejected.

A single F-value is harder to interpret. Multiple random samples of the same size will produce multiple F-statistic.

- https://blog.minitab.com/blog/adventures-in-statistics-2/understanding-analysis-of-variance-anova-and-the-f-test explains well.


## P-value
P value is used in [hypothesis](https://www.statisticshowto.datasciencecentral.com/probability-and-statistics/hypothesis-testing/) testing to help support or reject the null hypothesis. P value is expressed in decimal. But if expressed in percentage, it is easier to understand. For example, a p value of 0.0254 is 2.54%. It means there's a 2.54% chance that the result is random, which is really small. A small p-value (typically ≤ 0.05) indicates strong evidence against the null hypothesis, so we reject can null hypothesis. A large p-value indicates strong against for the null hypothesis. So, in a sense, p-value tells us how random our result is.


## \\(R^{2}\\) -statistic
$R^2$ represents the accuracy of the model. It is the proportion of variance and is independent of \\(\bar{y}\\)
\\[R^2 = (TSS - RSS)/TSS = 1- RSS/TSS\\] TSS is the variance in Y before the fit, and RSS is variance after the fit. So TSS-RSS measures the amount of variability in the response that is explained by performing the regression.

If \\(R^2\\) statistic is close to 1, the variability in the response is explained by the model, else it isn't explained and the model is wrong.



---
Visit the followings for more knowledge:
- https://www.statisticshowto.datasciencecentral.com
