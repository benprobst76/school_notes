### Integers Modulo n
Let $n\ge2$ be an integer.
$a$ is congruent to $b \pmod n$ if $n|(a-b)$, meaning $a$ and $b$ have the same remainder when divided by $n$.
The notation for this is $a \equiv b \pmod n$. Which is different than $a = b \pmod n$
A **residue class** modulo $n$, denoted $[a]_n$, is the set of all integers congruent to $a$ modulo $n$.
$[a]_n = \{x \in \mathbb{Z} \mid x \equiv a \pmod n\}$
$[a]_n$ is also called a congruence class $a \equiv b \pmod n$.
$[a]_n= [b]_n$ iff $a \equiv b \pmod n$.
There are exactly $n$ residue classes modulo $n$: $[0], [1], \dots, [n-1]$.
The set of these residue classes is denoted as $\mathbb{Z}_n$.
If $x\in[a],y\in[b]$ then $x+y\in[a+b]$ and $x*y\in[a*b]$  
Addition and multiplication for residue classes are defined as follows:
- $[a]_n + [b]_n = [a+b]_n$
- $[a]_n \times [b]_n = [a \times b]_n$
### Groups in Modular Arithmetic
A **group** $(G, \circ)$ is a set $G$ with a binary operation $\circ$ that satisfies four properties:
1.  **Closure**: For all $a, b \in G$, $a \circ b \in G$.
2.  **Associativity**: For all $a, b, c \in G$, $(a \circ b) \circ c = a \circ (b \circ c)$.
3.  **Identity Element**: There exists an element $e \in G$ such that for all $a \in G$, $a \circ e = e \circ a = a$.
4.  **Inverse Element**: For each $a \in G$, there exists an element $a^{-1} \in G$ such that $a \circ a^{-1} = a^{-1} \circ a = e$.
If the operation is also commutative ($a \circ b = b \circ a$ for all $a, b \in G$), the group is called an **Abelian group**.

The **order of an element** $a$ in a group $G$, denoted $\text{ord}(a)$, is the smallest positive integer $t$ such that $a^t = e$, where $e$ is the identity element of the group.
**Example:** Consider the multiplicative group $(\mathbb{Z}_7^*, \times) = \{1, 2, 3, 4, 5, 6\}$. The identity element is $e=1$.
- $\text{ord}(1)$: $1^1 = 1$, so $\text{ord}(1) = 1$.
- $\text{ord}(2)$: $2^1 = 2$, $2^2 = 4$, $2^3 = 8 \equiv 1 \pmod 7$. So $\text{ord}(2) = 3$.
- $\text{ord}(3)$: $3^1 = 3$, $3^2 = 9 \equiv 2$, $3^3 = 2 \times 3 = 6$, $3^4 = 6 \times 3 = 18 \equiv 4$, $3^5 = 4 \times 3 = 12 \equiv 5$, $3^6 = 5 \times 3 = 15 \equiv 1 \pmod 7$. So $\text{ord}(3) = 6$.
- For all $a\in\mathbb{Z}_7^*$ we have $a^{\phi(7)}=a^6=1$ ($\phi(n)$ is [[#Euler's Totient Function]]). In other words for any number $a$ in the multiplicative group $\mathbb{Z}_n$, $a^{\phi(n)}\pmod n=1$
Theorem: For any element $a\in G,\text{ord}(a)|\text{ord}(G)$ 
Corollary: For any element $a\in G, a^{\text{ord}(G)}=e$ 
#### Additive Group $(\mathbb{Z}_n, +)$
The set of integers modulo $n$, $(\mathbb{Z}_n, +)$, forms an abelian additive group. For $a,b\in Z_n$
- The identity element is $[0]_n$.
- $a+b=(a+b)\pmod n$ or $[a]+[b]=[a+b]=[a+b\pmod n]$  
- The inverse of $[a]_n$ is $[-a]_n$, which is equivalent to $[n-a]_n$.
- When performing addition/subtraction in $\mathbb{Z}_n$, you perform the regular operation and then reduce the result modulo $n$.
#### Multiplicative Group $(\mathbb{Z}_n^*, \times)$
The set $(\mathbb{Z}_n, \times)$ is **not** a group because the inverse of $[0]_n$ does not exist.
Even if we exclude $[0]_n$, the set $(\mathbb{Z}_n \setminus \{[0]_n\}, \times)$ is not always a group because other elements may not have a multiplicative inverse.
An element $[a]_n$ has a multiplicative inverse in $\mathbb{Z}_n$ if and only if $\text{gcd}(a, n) = 1$.
The set of all such elements is denoted by $\mathbb{Z}_n^*$.
$(\mathbb{Z}_n^*, \times)$ is an abelian multiplicative group.
- $a\times b=ab\pmod n$ 
- The identity element is $[1]_n$.
- The inverse of $[a]_n$, written as $[a]_n^{-1}$, can be computed using the [[Euclidean-Algorithm|Extended Euclidean Algorithm]].
- Example $Z_{12}^*=\{1,5,7,11\}$.  $5\times7=35\pmod{12}=11$ 
### Euler's Totient Function
Euler's totient function, denoted $\phi(n)$, counts the number of positive integers up to a given integer $n$ that are relatively prime to $n$.
In other words, it is the number of integers $k$ in the range $1 \le k \le n$ for which $\text{gcd}(k, n) = 1$.
The size of the multiplicative group $\mathbb{Z}_n^*$ is $\phi(n)$.
- $\phi(p)=(p-1)$ for prime p
- $\phi(pq)=\phi(p)\phi(q)$ if $gcd(p,q)=1$
- If the prime factorization of $n$ is $n = p_1^{k_1} p_2^{k_2} \cdots p_r^{k_r}$, then the formula for $\phi(n)$ is:
	$\phi(n) = n \prod_{i=1}^{r} (1 - \frac{1}{p_i}) = p_1^{k_1-1}(p_1-1) \cdots p_r^{k_r-1}(p_r-1)$
### Euler's Theorem
If $a$ is an integer such that $\text{gcd}(a, n) = 1$ (i.e., $a \in \mathbb{Z}_n^*$), then:
$a^{\phi(n)} \equiv 1 \pmod n$
**Proof Outline:**
Let $\mathbb{Z}_n^* = \{x_1, x_2, \dots, x_{\phi(n)}\}$.
Consider the set $S = \{ax_1, ax_2, \dots, ax_{\phi(n)}\}$.
1.  Since $\text{gcd}(a, n) = 1$ and $\text{gcd}(x_i, n) = 1$, we have $\text{gcd}(ax_i, n) = 1$. Thus, $S$ is a subset of $\mathbb{Z}_n^*$.
2.  If $ax_i \equiv ax_j \pmod n$, then $x_i \equiv x_j \pmod n$ (since $a$ is invertible). This means all elements in $S$ are distinct.
3.  Since $S$ is a subset of $\mathbb{Z}_n^*$ and has the same number of distinct elements, the two sets must be identical.
Therefore, the product of the elements in each set must be congruent modulo $n$:
$\prod_{i=1}^{\phi(n)} x_i \equiv \prod_{i=1}^{\phi(n)} (ax_i) \pmod n$
$\prod_{i=1}^{\phi(n)} x_i \equiv a^{\phi(n)} \prod_{i=1}^{\phi(n)} x_i \pmod n$
Since every $x_i$ is invertible modulo $n$, their product is also invertible. We can cancel the product from both sides:
$1 \equiv a^{\phi(n)} \pmod n$
### Fermat's Little Theorem
This is a special case of Euler's Theorem where $n$ is a prime number, $p$.
If $p$ is a prime number, then for any integer $a$ not divisible by $p$:
$a^{p-1} \equiv 1 \pmod p$
Since $p$ is prime, $\phi(p) = p-1$.
An alternative form is: for any integer $a$ and prime $p$:
$a^p \equiv a \pmod p$
**Proof Outline (using group theory):**
The set $\mathbb{Z}_p^* = \{1, 2, \dots, p-1\}$ forms a group under multiplication modulo $p$.
The order of this group is $p-1$.
By Lagrange's theorem, the order of any element $a \in \mathbb{Z}_p^*$ must divide the order of the group.
So, $a^k \equiv 1 \pmod p$ where $k$ is the order of $a$, and $k | (p-1)$.
This implies $a^{p-1} = (a^k)^{(p-1)/k} \equiv 1^{(p-1)/k} \equiv 1 \pmod p$.
### How to Compute $a^{-1} \pmod n$
To find the multiplicative inverse of $a$ modulo $n$, you need to find an integer $x$ such that:
$ax \equiv 1 \pmod n$
This is equivalent to solving the Diophantine equation:
$ax + ny = 1$
This equation has a solution if and only if $\text{gcd}(a, n) = 1$. The [[Euclidean-Algorithm|Extended Euclidean Algorithm]] is used to find the integers $x$ and $y$. The value of $x$ is the multiplicative inverse of $a$ modulo $n$.
### Chinese Remainder Theorem
The Chinese Remainder Theorem (CRT) provides a way to solve a system of simultaneous congruences when their moduli are pairwise coprime.
**Theorem:**
Let $n_1, n_2, \dots, n_k$ be integers that are pairwise coprime (i.e., $\text{gcd}(n_i, n_j) = 1$ for any $i \neq j$). Then, for any integers $a_1, a_2, \dots, a_k$, the system of congruences:
$x \equiv a_1 \pmod{n_1}$
$x \equiv a_2 \pmod{n_2}$
$\vdots$
$x \equiv a_k \pmod{n_k}$
has a unique solution for $x$ modulo $N = n_1 \times n_2 \times \cdots \times n_k$.
**Algorithm for finding the solution:**
1.  Calculate $N = n_1 \times n_2 \times \cdots \times n_k$.
2.  For each $i=1, \dots, k$, calculate $N_i = \frac{N}{n_i}$.
3.  For each $i$, find the modular multiplicative inverse of $N_i$ with respect to $n_i$. Let this be $y_i$. So, $N_i y_i \equiv 1 \pmod{n_i}$. This can be found using the Extended Euclidean Algorithm.
4.  The unique solution for $x$ is given by:
    $x \equiv \sum_{i=1}^{k} a_i N_i y_i \pmod N$
#### Example
Solve the following system of congruences:
$x \equiv 2 \pmod 3$
$x \equiv 3 \pmod 5$
$x \equiv 2 \pmod 7$
1.  The moduli are $n_1=3, n_2=5, n_3=7$. They are pairwise coprime.
    $N = 3 \times 5 \times 7 = 105$.
2.  Calculate $N_i$:
    $N_1 = \frac{105}{3} = 35$
    $N_2 = \frac{105}{5} = 21$
    $N_3 = \frac{105}{7} = 15$
3.  Find the inverses $y_i$:
    - For $y_1$: $35y_1 \equiv 1 \pmod 3 \implies 2y_1 \equiv 1 \pmod 3$. By inspection, $y_1=2$ since $2 \times 2 = 4 \equiv 1 \pmod 3$.
    - For $y_2$: $21y_2 \equiv 1 \pmod 5 \implies 1y_2 \equiv 1 \pmod 5$. By inspection, $y_2=1$.
    - For $y_3$: $15y_3 \equiv 1 \pmod 7 \implies 1y_3 \equiv 1 \pmod 7$. By inspection, $y_3=1$.
4.  Calculate the final solution for $x$:
    $x = (a_1 N_1 y_1 + a_2 N_2 y_2 + a_3 N_3 y_3) \pmod{105}$
    $x = (2 \cdot 35 \cdot 2 + 3 \cdot 21 \cdot 1 + 2 \cdot 15 \cdot 1) \pmod{105}$
    $x = (140 + 63 + 30) \pmod{105}$
    $x = 233 \pmod{105}$
    $x = 23$
The unique solution is $x=23$.
**Verification:**
- $23 \div 3 = 7$ remainder $2 \implies 23 \equiv 2 \pmod 3$
- $23 \div 5 = 4$ remainder $3 \implies 23 \equiv 3 \pmod 5$
- $23 \div 7 = 3$ remainder $2 \implies 23 \equiv 2 \pmod 7$
The solution is correct.
### Fields
A **field** is a set $F$ equipped with two binary operations, addition ($+$) and multiplication ($\cdot$), that satisfies the following properties:
1.  $(F, +)$ is an abelian group.
    - The identity element for addition is denoted by $0$.
2.  $(F \setminus \{0\}, \cdot)$ is an abelian group.
    - The identity element for multiplication is denoted by $1$.
3.  The distributive law holds: for all $a, b, c \in F$, $a \cdot (b+c) = (a \cdot b) + (a \cdot c)$.
In essence, a field is a set where you can perform addition, subtraction, multiplication, and division (by non-zero elements) in a way that follows the familiar rules of arithmetic.
**Theorem:** The set of integers modulo $n$, $\mathbb{Z}_n$, is a field if and only if $n$ is a prime number.
**Proof:**
We know that $(\mathbb{Z}_n, +, \cdot)$ is a commutative ring with an identity element for any integer $n \ge 2$. For $\mathbb{Z}_n$ to be a field, every non-zero element must have a multiplicative inverse.
- An element $[a]_n \in \mathbb{Z}_n$ has a multiplicative inverse if and only if $\text{gcd}(a, n) = 1$.
- **If $n$ is a prime number:** For any non-zero element $[a]_n \in \mathbb{Z}_n$, we have $1 \le a < n$. Since $n$ is prime, its only divisors are $1$ and $n$. Therefore, $\text{gcd}(a, n) = 1$. This means every non-zero element in $\mathbb{Z}_n$ has a multiplicative inverse. Thus, $\mathbb{Z}_n$ is a field.
- **If $n$ is a composite number:** Let $n = ab$ for some integers $a, b$ with $1 < a, b < n$. Then $[a]_n$ is a non-zero element in $\mathbb{Z}_n$. However, $\text{gcd}(a, n) = a > 1$. Therefore, $[a]_n$ does not have a multiplicative inverse. Thus, $\mathbb{Z}_n$ is not a field.
#### Finite Fields (Galois Fields)
A field with a finite number of elements is called a **finite field**.
The number of elements in a finite field is called its **order**. The order of any finite field must be a prime power, $p^k$, for some prime $p$ and integer $k \ge 1$.
-   For every prime $p$ and positive integer $k$, there exists a finite field of order $p^k$.
-   Any two finite fields of the same order are isomorphic (structurally identical).
This unique field of order $p^k$ is known as a **Galois Field** and is denoted by $\mathbf{GF}(p^k)$ or $\mathbb{F}_{p^k}$.
-   When $k=1$, the Galois Field $\text{GF}(p)$ is simply the field of integers modulo a prime, $\mathbb{Z}_p$.
-   When $k > 1$, the field $\text{GF}(p^k)$ can be constructed using polynomial arithmetic over $\mathbb{Z}_p$.
