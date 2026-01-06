### The Structure of $\mathbb{Z}_p^*$
For a prime number $p$, the multiplicative group of integers modulo $p$, denoted $\mathbb{Z}_p^*$, is a **cyclic group**. This means there exists at least one element $g \in \mathbb{Z}_p^*$ such that every element in $\mathbb{Z}_p^*$ can be expressed as a power of $g$.
-   The order of the group $\mathbb{Z}_p^*$ is $p-1$.
-   An element $g \in \mathbb{Z}_p^*$ is called a **generator** (or primitive root modulo $p$) if the smallest positive integer $k$ such that $g^k \equiv 1 \pmod p$ is $p-1$. In other words, the powers $g^1, g^2, \dots, g^{p-1}$ produce all distinct elements of $\mathbb{Z}_p^*$.
-   Not every element in $\mathbb{Z}_p^*$ is a generator.
-   **How to find a generator of $\mathbb{Z}_p^*$?**
    To find a generator $g$ for $\mathbb{Z}_p^*$, one typically checks elements $g \in \{2, \dots, p-1\}$. An element $g$ is a generator if and only if $g^{(p-1)/q}ot\equiv 1 \pmod p$ for all prime factors $q$ of $p-1$.
### Exponentiation
In a finite cyclic group $G$, a common operation is exponentiation.
**Goal:** Given a group element $g \in G$ and an integer exponent $x$, compute $g^x$.
This operation can be performed efficiently using the **Repeated Squaring Algorithm**.
### The Repeated Squaring Algorithm
The Repeated Squaring Algorithm (also known as Exponentiation by Squaring) is an efficient method for computing large integer powers of a number, or more generally, powers of an element in a group.
**Input:**
-   A base $g$ (an element in a group $G$)
-   An exponent $x > 0$ (an integer)
-   A modulus $m$ (if working in $\mathbb{Z}_m^*$) 
**Output:** $g^x \pmod m$ (or $g^x$ in $G$)

**Algorithm Steps:**
1.  Initialize `result = 1`.
2.  Set `base = g`.
3.  While `x > 0`:
    a.  If `x` is odd, multiply `result` by `base` (i.e., `result = (result * base) % m`).
    b.  Square `base` (i.e., `base = (base * base) % m`).
    c.  Divide `x` by 2 (integer division, `x = x // 2`).
4.  Return `result`.

**Example:** Compute $3^{13} \pmod{17}$
-   $x = 13$ (binary $1101_2$)
-   `result = 1`, `base = 3`

| x (binary) | x (decimal) | x is odd? | result                                | base                             |
| :--------- | :---------- | :-------- | :------------------------------------ | :------------------------------- |
| $1101_2$   | 13          | Yes       | $1 \cdot 3 = 3$                       | $3^2 = 9$                        |
| $110_2$    | 6           | No        | 3                                     | $9^2 = 81 \equiv 13 \pmod{17}$   |
| $11_2$     | 3           | Yes       | $3 \cdot 13 = 39 \equiv 5 \pmod{17}$  | $13^2 = 169 \equiv 16 \pmod{17}$ |
| $1_2$      | 1           | Yes       | $5 \cdot 16 = 80 \equiv 12 \pmod{17}$ | $16^2 = 256 \equiv 1 \pmod{17}$  |
| $0_2$      | 0           | No        | 12                                    | 1                                |

Final result: $3^{13} \equiv 12\pmod{17}$.
### Intractable Problems in Number Theory
Many cryptographic systems rely on the computational difficulty of certain number-theoretic problems. These are problems for which no efficient (polynomial-time) algorithm is known to exist for large inputs.
#### Intractable Problems with Primes
**Discrete Logarithm (DLog) Problem:**
Let $G$ be a finite cyclic group, and let $g$ be a generator of $G$.
Given an element $h \in G$, the Discrete Logarithm Problem is to find the integer $x$ such that:
$g^x = h$
This $x$ is called the discrete logarithm of $h$ to the base $g$.
-   **In $\mathbb{Z}_p^*$:** Given a prime $p$, a generator $g$ of $\mathbb{Z}_p^*$, and an element $h \in \mathbb{Z}_p^*$, find $x$ such that $g^x \equiv h \pmod p$.
-   While computing $g^x \pmod p$ (exponentiation) is efficient using repeated squaring, computing the discrete logarithm $x$ for large $p$ is computationally very hard.
-   **Best known algorithm:** The General Number Field Sieve (GNFS) is the most efficient algorithm known for solving the discrete logarithm problem in prime fields. Its complexity is sub-exponential.
-   **Cryptographic Relevance:** The difficulty of the DLog problem is the basis for the security of many cryptographic schemes, such as [[ElGamal-Cryptosystem#Diffie Hellman Protocol|Diffie-Hellman]] key exchange and [[ElGamal-Cryptosystem]].
#### Intractable Problems with Composites
**Integer Factorization Problem:**
Given a large composite integer $N$, the Integer Factorization Problem is to find its prime factors.
- **Example:** Given $N = 221$, find $13$ and $17$ such that $13 \times 17 = 221$.
- For very large $N$ (e.g., hundreds of digits), finding the prime factors is computationally infeasible with current algorithms and technology.
- **Best known algorithm:** The General Number Field Sieve (GNFS) is also the most efficient algorithm known for integer factorization. Its complexity is sub-exponential.
- **Cryptographic Relevance:** The difficulty of integer factorization is the cornerstone of the security of the [[RSA-Cryptosystem]]. If an adversary can efficiently factor the public modulus $N$, they can break RSA encryption.
**RSA Problem:**
The RSA problem is closely related to integer factorization. Given a public RSA key $(N, e)$ and a ciphertext $C$, the RSA problem is to find the plaintext $M$ such that $M^eC\pmod N$.
While not strictly equivalent to factoring $N$, any efficient algorithm for factoring $N$ would allow one to solve the RSA problem efficiently. It is generally assumed that the RSA problem is as hard as, or harder than, factoring.