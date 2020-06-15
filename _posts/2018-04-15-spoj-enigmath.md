---
title: "SPOJ ENIGMATH Solution"
mathjax: true
comments: true
---

**Problem Statement** [ENIGMATH - PLAY WITH MATH](http://www.spoj.com/problems/ENIGMATH/)

**Heuristic**

Ax - By = 0  has two possible cases:

1. a can divide b or if b can divide a and you can figure out the rest.
2. a or b cannot divide the other so it will be A B - B A = 0, but we still have to find the minimum x & y.

```cpp
#include<stdio.h>
#include<math.h>
int main()
{
    int t;
    long long a,b;
    scanf("%d",&t);
    while(t--)
    {
        scanf("%lld%lld",&a,&b);
        if(a%b==0||b%a==0)
        {
            if(a>b) printf("1 %lld\n",a/b);
            else if(a<b) printf("%lld 1\n",b/a );
            else printf("1 1\n");
        }
        else
        {
            while(a%2==0&&b%2==0)
            {
                a=a/2;
                b=b/2;
            }
            int lim=(a<b)? sqrt(a):sqrt(b);
            for(int i=3;i<=lim;i+=2)
            {
                while(a%i==0&&b%i==0)
                {
                    a=a/i;
                    b=b/i;
                }
            }
            printf("%lld %lld\n",b,a);
        }
    }
}
```
