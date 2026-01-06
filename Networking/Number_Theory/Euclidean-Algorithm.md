The Euclidian algorithm computes the greatest common denominator between two numbers gcd(a, b). The Extended Euclidian algorithm computes integer x and y such that  $$ ax + by = gcd(a, b) $$
Euclidean Example:
$$
\begin{aligned}
gcd(229,221) = ? \\
229 = 221(1) + 78 \\
221 = 78(2) + 65 \\
78 = 65(1) + 13 \\
65 = 13(5) + 0 \\ 
gcd(229,221) = 13
\end{aligned}
$$
Extended Euclidean Example:
$$
\begin{align}
gcd(226,221) & = 13 = 78 - 65 \\
& =78-(221-2(78))=3(78)-221 \\
& =3(229-(1)221)-221 \\
& =3(229)-4(221)

\end{align}
$$
Pseudocode: 
```
// compute gcd(a, b) where a > b > 1
function gcd(a, b):
  while b is not 0:
    remainder = a mod b
    a = b
    b = remainder
  return a
```

### Number Factorization
To factor a number n as product of other numbers n = a x b x c
Factoring a number is relatively hard compared to multiplying the factors together to generate the number. 
Prime factorization of a number n is when its written as a product of [[#Prime Numbers]] e.g. 91 = 7x13; 3600 = 24x32x52 where 2, 3 and 5 are prime and 4, 2, and 2 are positive integers

### Prime Numbers
Prime numbers only have divisors of 1 and self  
- They cannot be written as a product of other numbers  
- Note: 1 is prime, but is generally not of interest  
- 2,3,5,7 are prime, 4,6,8,9,10 are not  
- Prime numbers are central to number theory  

List of prime number less than 200 is:  
2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97  101 103 107 109 113 127 131 137 139 149 151 157 163 167 173 179 181  191 193 197 199

#### Primality Testing
Division to test if n is prime:
```
for (p =2; p <= n1/2; p++) {
  e = 0;
  If (n % p == 0) {
    While (n%p == 0) {
        e++;
      n /= p;
    }
    Printf(“factor %d power %d\n”, p, e);
  }
