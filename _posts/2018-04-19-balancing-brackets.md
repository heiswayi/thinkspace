---
Title: "Minimum Moves for Balancing Brackets"
comments: True
---
## Problem Definition
You’re given a non-empty string made in its entirety from opening and closing braces. Your task is to find the minimum number of “operations” needed to make the string stable. The definition of being stable is as follows:
* An empty string is stable.
* If S is stable, then {S} is also stable.
* If S and T are both stable, then ST (the concatenation of the two) is also stable.
All of these strings are stable: `{}, {}{}`, and `{{}{}}`. But none of these: `}{, {{}{`, nor `{}{`.
The only operation allowed on the string is to replace an opening brace with a closing brace, or vice-versa.

## Solution
Traverse the string. When the number of opening braces `(, {, )` matches the number of closing braces `),},]` the string is balanced. Else it's not balanced. So count both of them. Make a list. Insert only opening braces. If a closing brace is found delete one brace `(` only if the size of the list is > 0. Because they would make a pair. If the list is empty then we'll convert the just found closing brace to opening brace and insert into the list. This will count as a move. When the iteration is finished, we will reverse half of the braces in the list and they will also count as moves. Now, find out the total summation of the moves for result.


## Practice Problem
SPOJ ANARC09A - Seinfeld
