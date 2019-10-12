---
title: "Chapter 03 - Linear Regression - Exercises"
commments: true
mathjax: true
---
# Conceptual

# Applied
## 8
### a
```
lm.fit = lm(mpg~horsepower, data = Auto);
summary(lm.fit);
confint(lm.fit);
```
i. Yes, since P-value is small.\
ii. Really strong, since p-value< 2.2e-16\
iii. Negative.
iv.
```newData= data.frame(horsepower=98);
predict(lm.fit,newData);
predict(lm.fit,newData,interval = "confidence");
predict(lm.fit,newData,interval= "prediction");
```
### b
```
plot(Auto$mpg, Auto$horsepower);
abline(lm.fit);
```
### c
```
par(mfrow=c(2,2));
plot(lm.fit);
```
from the plot Residual vs Fitted: the relationship is nonlinear.
## 9
### a



