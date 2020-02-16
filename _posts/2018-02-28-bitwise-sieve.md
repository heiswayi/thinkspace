---
title: "Bitwise Sieve w/ Code"
comments: true
---
Sieve of Eratosthenes is explained [HERE](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes) \
Bitwise sieve is an optimized implementation of  Sieve of Eratosthenes. It does the same thing but more memory efficient because it uses logic operations( &,|,>>,<< ) on binary numbers. \
In normal implementation, we use an array as flag to check if a number is prime or not.we know index of an array ( i.e  myarray[n]  ) is 32 bit long. If an array is 10 index long, that it has 32x10(=320) bits.  We use bits of that array as flag. that way we can flag numbers upto 320 as prime or not prime. i.e, how to check the flag status of 51 in myarray[ n ] ? We'll divide 5 by 32, that will give us the index number of the certain bit, then we'll mod 5 by 32, that will give us the certain bit position to check for 0 or 1. Remember bit positions are defined from right to left, starting from 0. Meaning LST = 0 and MST = 31.
So we need to define two functions, one to set that certain bit as 0 or 1, another to check if  bit is 0 or 1. 
```
#define check(arr,n) ( (arr[n/32]>>(n%32))&1 )
#define sett(arr,n) ( arr[n/32] = arr[n>>5] | (1<<(n%32) ))
```
> I've used macros, but you can write the same code in functions if you want.

**CHECK:** now in case of 51, (51/32)= 1, so the the bit flag is index 1. the bit position is (51%32)=19.
this means we'll have to check 19th bit of myarray[1] . To understand the next part, you need to know [bitwise operation](http://zobayer.blogspot.com/2009/12/bitwise-operations-in-c-part-2.html) and [Bitmasking](http://codeforces.com/blog/entry/18169). Assuming you know bitwise operations, we right shifted myarray[1] 19 times ( myarray[1] >>19 ) and then performed AND operation to see if the bit is 0 or 1. The latter is a bitmask.

**SET:** we use same procedure to find the index number and bit position. Then set that bit as we want by another bitmask.
## Code
```
#include<bits/stdc++.h>
using namespace std;
#define MAX 46340   // to find primes from 2 to 46340
#define MAXh 216    // sqrt of 46340
#define check(arr,n) ( (arr[n/32]>>(n%32))&1 )
#define sett(arr,n) ( arr[n/32] = arr[n>>5] | (1<<(n%32) ))

unsigned int prime[100000], flag[MAX/32];

void sieve()
{
    unsigned int i,j,k,id=0;

    for(i=3;i<=MAXh;i+=2)
    {
        if(!check(flag,i))
        {
            for(j=i*i;j<=MAX;j+=i)
            {
                sett(flag,j);
            }
        }
    }


    prime[id++]=2;
    for(i=3;i<=MAX;i+=2)
    {
        if(!check(flag,i))  prime[id++]=i;
    }

}
```