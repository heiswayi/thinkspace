---
title: "Unbounded Knapsack (Minimization) for SPOJ-PIGBANK"
comments: True
mathjax: True
---
## Unbounded Knapsack
Given a knapsack weight W and a set of N items with certain value $$V_i$$ and weight $$W_i$$, we need to calculate minimum amount that could make up this quantity exactly. To have a more clear understanding of this problem, see SPOJ-PIGBANK

## Sample Problem
We're given a box which can hold maximum W weight. There are N various coins each of value $$V_i$$ and Weight $$W_i$$. We need to fill the box with total W weight with any number of coins of any value. Note that coins are unlimited. 

```
100 ----- W 
2 ------- N
1 1 ----- vi,wi    
30 50 --- vi,wi 
```
Answer of the problem above is, 60. If we take 2 coins of value 30, weight 50, we'll get exactly weight 100 with a minimum value of 60.

## Algorithm
This is a DP solution. To get the solution for W=100, we'll solve subproblems first. Let dp[W+1]  be an array which will store the subproblems solutions. In the end, dp[W] will give us the minimum amount. Subproblems soultion will be the minimum of taking the coin $$V_k$$ + solution for dp[weight left after taking that coin] or not taking that coin; where k ranges from 1 to N; meaning loop will run for all types of coins.

## Code
```
#include<bits/stdc++.h>
using namespace std;
#define INTMAX 9999999
void unboundedKnapsack_min(int w,int val[],int wt[],int coin)
{
    int dp[w+1],i,k;
    for(i=1;i<w+1;i++)
        dp[i] = INTMAX;
    dp[0]=0;
    for(i=1;i<=w;i++)
    {
        for(k=0;k<coin;k++)
        {
            if(wt[k]<=i)
            {
                dp[i] = min( dp[i], dp[i-wt[k]]+val[k] );
            }
        }
    }
    if(dp[w]==INTMAX) printf("This is impossible.\n");
    else printf("The minimum amount of money in the piggy-bank is %d.\n",dp[w]);
}

int main()
{
    int t,pig,bank,coin,i;
    scanf("%d",&t);
    while(t--)
    {
        scanf("%d%d%d",&pig,&bank,&coin);
        int val[coin+1],wt[coin+1];
        int w= bank-pig;
        for(i=0;i<coin;i++)
            scanf("%d%d",&val[i],&wt[i]);
        unboundedKnapsack_min(w,val,wt,coin);
    }
}

```
