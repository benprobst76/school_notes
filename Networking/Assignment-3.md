## Ben Probst - 20284512 - ELEC 473
### Q1
#### A.
$$
\begin{aligned}
C_1 &= g^k \pmod{q} \\
&= 7^2 \pmod{71} \\
&= 49 \pmod{71} \\
&= 49 \\
\\
C_2 &= M \cdot Y_B^k \pmod{q} \\ 
 &= 30 \cdot 3^2 \pmod{71} \\
 &= 30 \cdot 9 \pmod{71} \\
 &= 270 \pmod{71} \equiv 57 \pmod{71}
\end{aligned}
$$
Therefore, the ciphertext is $(49, 57)$.
#### B.
$$
\begin{aligned}
C_1 &= g^k \pmod{q} \\
59 &= 7^k \pmod{71} \\
\\
7^1 &\equiv 7 \pmod{71} \\
7^2 &\equiv 49 \pmod{71} \\
7^3 &\equiv343 \pmod{71} \\
343 &\equiv 59 \pmod{71} \\
k &= 3 \\
\\
C_2 &= M \cdot Y _B^k \pmod{q} \\
C_2 &= 30 \cdot 3^3 \pmod{71} \\
C_2 &= 30 \cdot 27 \pmod{71} \\
C_2 &= 810 \pmod{71} \\
810 &\equiv 29 \pmod{71} \\
\\
C_2 &= 29 \\
\end{aligned}
$$
### Q2.
$$
\begin{aligned}
\lambda &= \frac{8-9}{-2-(-3)} = -1 \\
x_3 &= (-1)^2 - (-3) - (-2) = 6 \\
y_3 &= (-1)(-3-6) - 9 = 0 \\
P+ Q &= (6,0) \\
\\
\lambda &= \frac{3(-3)^2+(-36)}{2(9)}=-\frac{1}{2}\\
x_3 &= (-\frac{1}{2})^2 - 2(-3) =\frac{25}{4} \\
y_3 &= (\left(-\frac{1}{2}\right)\left(-3 - \frac{25}{4}\right) - 9 = -\frac{35}{8}\\
2P &=\left(\frac{25}{4}, -\frac{35}{8}\right) \\
\end{aligned}
$$
### Q3.
#### A.
$$
\begin{aligned}
P &= (3, 10) & 15P &= (13, 7) \\
2P &= (7, 12) & 16P &= (6, 17) \\
3P &= (19, 5) & 17P &= (15, 20) \\
4P &= (17, 3) & 18P &= (14, 8) \\
5P &= (9, 16) & 19P &= (18, 12) \\
6P &= (12, 4) & 20P &= (1, 15) \\
7P &= (11, 20) & 21P &= (0, 1) \\
8P &= (0, 22) & 22P &= (11, 3) \\
9P &= (1, 8) & 23P &= (12, 19) \\
10P &= (18, 11) & 24P &= (9, 7) \\
11P &= (14, 15) & 25P &= (17, 20) \\
12P &= (15, 3) & 26P &= (19, 18) \\
13P &= (6, 6) & 27P &= (7, 11) \\
14P &= (13, 16) & 28P &= (3, 13) \\
29P &= O \text{ (point at infinity)}
\end{aligned}
$$ 
#### B.
$$
\begin{aligned}
100P &= (3 \times 29 + 13)P \\
&= 3 \times (29P) + 13P \\
&= 3 \times O + 13P \\
&= O + 13P \\
&= 13P
\end{aligned}
$$
Therefore, $100P = (6, 6)$.

### Q4.
#### A.
$$
\begin{aligned}
x &\equiv y^d \pmod{p} \\
x &\equiv y^d \pmod{q}
\end{aligned}
$$
By the uniqueness property of CRT, if $x$ satisfies these two congruences, it must be the unique solution $y^d \pmod{n}$.

First, show that $x_p \equiv y^d \pmod{p}$. The algorithm defines $d_p = d \pmod{p-1}$, which means we can write $d = k(p-1) + d_p$ for some integer $k$. Then we can express $y^d$ as:
$$ y^d = y^{k(p-1) + d_p} = (y^{p-1})^k \cdot y^{d_p} $$
By Fermat's Little Theorem, $y^{p-1} \equiv 1 \pmod{p}$. Therefore:
$$ y^d \equiv 1^k \cdot y^{d_p} \equiv y^{d_p} \pmod{p} $$
The algorithm calculates $x_p = y^{d_p} \pmod{p}$, so we have shown that $x_p \equiv y^d \pmod{p}$.

The same applies to $x_q \equiv y^d \pmod{q}$. With $d_q = d \pmod{q-1}$, we have $d = j(q-1) + d_q$ for some integer $j$.
$$ y^d = (y^{q-1})^j \cdot y^{d_q} \equiv 1^j \cdot y^{d_q} \equiv y^{d_q} \pmod{q} $$
Since $x_q = y^{d_q} \pmod{q}$, we have shown $x_q \equiv y^d \pmod{q}$.

The algorithm calculates $x = (M_p q x_p + M_q p x_q) \pmod{n}$ and $M_p = q^{-1} \pmod{p}$

Evaluate $x \pmod{p}$:
$$
\begin{aligned}
x &\equiv (M_p q x_p + M_q p x_q) \pmod{p} \\
\end{aligned}
$$
The term $M_q p x_q$ is congruent to $0 \pmod p$.
$$
\begin{aligned}
x &\equiv M_p q x_p \pmod{p} \\
\end{aligned}
$$
Substituting $M_p = q^{-1} \pmod p$:
$$
\begin{aligned}
x &\equiv (q^{-1} q) x_p \pmod{p} \\
x &\equiv 1 \cdot x_p \pmod{p} \\
x &\equiv x_p \pmod{p}
\end{aligned}
$$
We know $x_p \equiv y^d \pmod{p}$, so we have $x \equiv y^d \pmod{p}$.

Evaluate $x \pmod{q}$:
$$
\begin{aligned}
x &\equiv (M_p q x_p + M_q p x_q) \pmod{q} \\
\end{aligned}
$$
The term $M_p q x_p$ is congruent to $0 \pmod q$.
$$
\begin{aligned}
x &\equiv M_q p x_q \pmod{q} \\
\end{aligned}
$$
Substituting $M_q = p^{-1} \pmod q$:
$$
\begin{aligned}
x &\equiv (p^{-1} p) x_q \pmod{q} \\
x &\equiv 1 \cdot x_q \pmod{q} \\
x &\equiv x_q \pmod{q}
\end{aligned}
$$
We know $x_q \equiv y^d \pmod{q}$, so we have $x \equiv y^d \pmod{q}$.

 As $y^d \pmod n$ is a solution to this system, and the algorithm's result $x$ is also a solution, they must be equivalent.
#### B.
$$
\begin{aligned}
d_p &= d \pmod{p-1} \\
&= 1234577 \pmod{1511-1} \\
&= 907 \\
\\
d_q &= d \pmod{q-1} \\
&= 1234577 \pmod{2003-1} \\
&= 1345
\end{aligned}
$$
$2003 \equiv 492 \pmod{1511}$. 
Find $492^{-1} \pmod{1511}$.
Using the Extended Euclidean Algorithm:
$$
\begin{aligned}
1511 &= 3 \cdot 492 + 35 \\
492 &= 14 \cdot 35 + 2 \\
35 &= 17 \cdot 2 + 1 \\
\\
1 &= 35 - 17 \cdot 2 \\
1 &= 35 - 17 \cdot (492 - 14 \cdot 35) \\
1 &= 35 - 17 \cdot 492 + 238 \cdot 35 \\
1 &= 239 \cdot 35 - 17 \cdot 492 \\
1 &= 239 \cdot (1511 - 3 \cdot 492) - 17 \cdot 492 \\
1 &= 239 \cdot 1511 - 717 \cdot 492 - 17 \cdot 492 \\
1 &= 239 \cdot 1511 - 734 \cdot 492
\end{aligned}
$$
So, $-734 \cdot 492 \equiv 1 \pmod{1511}$.
$-734 \equiv -734 + 1511 \equiv 777 \pmod{1511}$.
Thus, $M_p = 777$.

Find $1511^{-1} \pmod{2003}$.
$$
\begin{aligned}
2003 &= 1511 + 492 \\
1511 &= 3 \cdot 492 + 35 \\
492 &= 14 \cdot 35 + 2 \\
35 &= 17 \cdot 2 + 1 \\
\\
1 &= 35 - 17 \cdot 2 \\
1 &= 35 - 17 \cdot (492 - 14 \cdot 35) \\
1 &= 35 - 17 \cdot 492 + 238 \cdot 35 \\
1 &= 239 \cdot 35 - 17 \cdot 492 \\
1 &= 239 \cdot (1511 - 3 \cdot 492) - 17 \cdot 492 \\
1 &= 239 \cdot 1511 - 717 \cdot 492 - 17 \cdot 492 \\
1 &= 239 \cdot 1511 - 734 \cdot 492 \\
1 &= 239 \cdot 1511 - 734(2003-1511)\\
1 &= 973 \cdot 1511 - 734 \cdot 2003 
 \end{aligned}
 $$
$973 \cdot 1511 \equiv 1 \pmod{2003}$.
Thus, $M_q = 973$.
#### C.
$$
\begin{aligned}
x_p &\equiv y^{d_p} \pmod{p} \\
&\equiv 152702^{907} \pmod{1511} \\
&\equiv 91^{907} \pmod{1511}
\end{aligned}
$$
$907 = (1110001011)_2$.

| Bit xᵢ |              y              |                  z                   |
| :----: | :-------------------------: | :----------------------------------: |
|   -    |            $91$             |                 $1$                  |
|  x0=1  |  $91^2 \pmod{1511} = 726$   |    $1 \times 91 \pmod{1511} = 91$    |
|  x1=1  | $726^2 \pmod{1511} = 1248$  |  $91 \times 726 \pmod{1511} = 1093$  |
|  x2=0  | $1248^2 \pmod{1511} = 1174$ |                $1093$                |
|  x3=1  | $1174^2 \pmod{1511} = 244$  | $1093 \times 1174 \pmod{1511} = 343$ |
|  x4=0  |  $244^2 \pmod{1511} = 607$  |                $343$                 |
|  x5=0  | $607^2 \pmod{1511} = 1276$  |                $343$                 |
|  x6=0  | $1276^2 \pmod{1511} = 829$  |                $343$                 |
|  x7=1  | $829^2 \pmod{1511} = 1247$  |  $343 \times 829 \pmod{1511} = 279$  |
|  x8=1  | $1247^2 \pmod{1511} = 190$  | $279 \times 1247 \pmod{1511} = 383$  |
|  x9=1  | $190^2 \pmod{1511} = 1347$  |  $383 \times 190 \pmod{1511} = 242$  |

Thus, $x_p = 242$.
Next, for $x_q$:
$$
\begin{aligned}
x_q &\equiv y^{d_q} \pmod{q} \\
&\equiv 152702^{1345} \pmod{2003} \\
&\equiv 474 \pmod{2003} \\
\end{aligned}
$$
1345 = $(10101000001)_2$.

| Bit xᵢ |             y              |                  z                   |
| :----: | :------------------------: | :----------------------------------: |
|   -    |           $474$            |                  1                   |
|  x0=1  | $474^2 \pmod{2003} = 340$  |   $1\times 474 \pmod{2003} = 474$    |
|  x1=0  | $340^2 \pmod{2003} = 1429$ |                $474$                 |
|  x2=0  | $429^2 \pmod{2003} = 984$  |                $474$                 |
|  x3=0  | $984^2 \pmod{2003} = 807$  |                $474$                 |
|  x4=0  | $807^2 \pmod{2003} = 274$  |                $474$                 |
|  x5=0  | $274^2 \pmod{2003} = 965$  |                $474$                 |
|  x6=1  | $965^2 \pmod{2003} = 1833$ |  $474 \times 965 \pmod{2003} = 726$  |
|  x7=0  | $833^2 \pmod{2003} = 858$  |                $726$                 |
|  x8=1  | $858^2 \pmod{2003} = 1063$ | $726 \times 858 \pmod{2003} = 1978$  |
|  x9=0  | $1063^2 \pmod{2003} = 277$ |                $1978$                |
| x10=1  | $277^2 \pmod{2003} = 615$  | $1978 \times 277 \pmod{2003} = 1087$ |
Thus, $x_q = 1087$.
$$
\begin{aligned}
x &\equiv (M_p q x_p + M_q p x_q) \pmod{n} \\
&\equiv (777 \cdot 2003 \cdot 242 + 973 \cdot 1511 \cdot 1087) \pmod{3026533} \\
&\equiv (1974742763) \pmod{3026533} \\
&\equiv 1443247 \pmod{3026533} \\
\end{aligned}
$$
The decrypted plaintext is $x=1443247$. 
### Q5.
$$
    (x_1, x_2, x_3, x_4, x_5, x_6, x_7)
    \begin{pmatrix}
    1 & 0 & 0 & 0 \\
    1 & 1 & 0 & 0 \\
    1 & 1 & 1 & 0 \\
    1 & 1 & 1 & 1 \\
    0 & 1 & 1 & 1 \\
    0 & 0 & 1 & 1 \\
    0 & 0 & 0 & 1
    \end{pmatrix}
    = (0, 1, 0, 1) \pmod 2
    $$

**System of Linear Equations**
$$
\begin{aligned}
x_1 + x_2 + x_3 + x_4 &= 0 \\
x_2 + x_3 + x_4 + x_5 &= 1 \\
x_3 + x_4 + x_5 + x_6 &= 0 \\
x_4 + x_5 + x_6 + x_7 &= 1 \\
\\
x_4 &= 1 + x_5 + x_6 + x_7 \pmod 2 \\
\\
x_3 &= x_4 + x_5 + x_6 \pmod 2 \\
x_3 &= (1 + x_5 + x_6 + x_7) + x_5 + x_6 \pmod 2 \\
x_3 &= 1 + x_7 \pmod 2 \\
\\
x_2 &= 1 + x_3 + x_4 + x_5 \pmod 2 \\
x_2 &= 1 + (1 + x_7) + (1 + x_5 + x_6 + x_7) + x_5 \pmod 2 \\
x_2 &= 1 + x_6 \pmod 2 \\
\\
x_1 &= x_2 + x_3 + x_4 \pmod 2 \\
x_1 &= (1 + x_6) + (1 + x_7) + (1 + x_5 + x_6 + x_7) \pmod 2 \\
x_1 &= 1 + x_5 \pmod 2
\end{aligned}
$$

The variables $x_5, x_6, x_7$ can be chosen freely; 
Since each free variable can be either 0 or 1, there are $2^3 = 8$ possible solutions. 

| $x_5$ | $x_6$ | $x_7$ | $x_1$ | $x_2$ | $x_3$ | $x4$ | Solution $(x_1, x_2, x_3, x_4, x_5, x_6, x_7)$ |
| ----- | ----- | ----- | ----- | ----- | ----- | ---- | ---------------------------------------------- |
| 0     | 0     | 0     | 1     | 1     | 1     | 1    | $(1, 1, 1, 1, 0, 0, 0)$                        |
| 0     | 0     | 1     | 1     | 1     | 0     | 0    | $(1, 1, 0, 0, 0, 0, 1)$                        |
| 0     | 1     | 0     | 1     | 0     | 1     | 0    | $(1, 0, 1, 0, 0, 1, 0)$                        |
| 0     | 1     | 1     | 1     | 0     | 0     | 1    | $(1, 0, 0, 1, 0, 1, 1)$                        |
| 1     | 0     | 0     | 0     | 1     | 1     | 0    | $(0, 1, 1, 0, 1, 0, 0)$                        |
| 1     | 0     | 1     | 0     | 1     | 0     | 1    | $(0, 1, 0, 1, 1, 0, 1)$                        |
| 1     | 1     | 0     | 0     | 0     | 1     | 1    | $(0, 0, 1, 1, 1, 1, 0)$                        |
| 1     | 1     | 1     | 0     | 0     | 0     | 0    | $(0, 0, 0, 0, 1, 1, 1)$                        |
### Q6.
1.  **Assumption**: Assume h is not collision resistant. This means there exist two distinct messages, $x$ and $x'$, such that $h(x) = h(x')$.

2.  Start with the assumption the collision happens when $g_k = g'_{k'}$.

3.  Starting with messages of the same length ($k = k'$).
    Since $x \neq x'$,  $(x_1, ..., x_k)$ and $(x'_1, ..., x'_k)$ must differ.
    The collision $g_k = g'_k$ means that $compress(g_{k-1} || x_k) = compress(g'_{k-1} || x'_k)$.
    - If the inputs to `compress` are different ($g_{k-1} || x_k \neq g'_{k-1} || x'_k$), then we have  found a collision for the `compress` function. The proof is complete.
    - If the inputs are the same ($g_{k-1} || x_k = g'_{k-1} || x'_k$), then $g_{k-1} = g'_{k-1}$ and $x_k = x'_k$. So continue.

    Since `x` and `x'` are different, there must be some block where they first differ. Let `j` be the largest index such that $x_j \neq x'_j$. This means that for all $i > j$, $x_i = x'_i$.

    $g_i = g'_i \implies g_{i-1} = g'_{i-1}$ holds for all $i$ from $k$ down to $j+1$. This means $g_j = g'_j$.

    The inputs for `compress` at step `j`:
    -   Input 1: $z_j = g_{j-1} || x_j$
    -   Input 2: $z'_j = g'_{j-1} || x'_j$

    We know that $g_{j-1} = g'_{j-1}$. However, by our definition of `j`, we have $x_j \neq x'_j$. Therefore, the two inputs $z_j$ and $z'_j$ must be different.
    Yet, their outputs are the same, because $compress(z_j) = g_j$ and $compress(z'_j) = g'_j$, and we know $g_j = g'_j$.

    Therefore two different inputs, $z_j$ and $z'_j$, that produce the same output is a collision for `compress`.

4. The messages have different lengths ($k' > k$)
	A collision for different-length messages could be created if one could find a message `x` such that $h(x)$ is equal to the initial value ($0^m$). If such an `x` exists, then $h(x || x_{k+1}) = compress(h(x) || x_{k+1}) = compress(0^m || x_{k+1})$. This is the same hash value as for the single-block message $h(x_{k+1}) = compress(0^m || x_{k+1})$. This creates a collision between $x_{k+1}$ and $x||x_{k+1}$.
    
    However, finding an `x` such that $h(x) = 0^m$ means being able to find a preimage of $0^m$ for the `compress` function. The problem assumes that `compress` is **zero-preimage resistant** which blocks this.

Therefore either compress is not collision resistant, or compress is not zero-preimage resistant for h to not to be collision resistant. 
### Q7.
This protocol is vulnerable to a Man-in-the-Middle attack. Eve, can position herself between Alice and Bob and trick them into thinking they are authenticating with each other, when in fact they are both authenticating with Eve.
1.  **Bob Initiates with Eve:** Bob wants to talk to Alice and sends his random challenge, but unknowingly initiates the protocol with Eve.
    -   `Bob -> Eve: r1`
2.  **Eve Initiates with Alice:** Eve takes Bob's challenge `r1` and uses it to initiate a separate session with Alice, impersonating Bob.
    -   `Eve -> Alice: r1`
3.  **Alice Responds to Eve:** Alice, thinking she is talking to Bob, responds with her own challenge `r2` and signs the challenge she received, sending both back.
    -   `Alice -> Eve: r2, y1 = sig_Alice(r1)`
4.  **Eve Forwards to Bob:** Eve now has the signature she needs to convince Bob that she is Alice. She forwards Alice's response to Bob.
    -   `Eve -> Bob: r2, y1`
5.  **Bob Authenticates Eve (as Alice):** Bob receives `r2` and `y1`. He checks if `ver_Alice(r1, y1)` is true. Since `y1` is a valid signature from Alice on his original challenge `r1`, the verification succeeds. Bob now incorrectly believes he has authenticated Alice.
6.  **Bob Responds to Eve:** Following the protocol, Bob signs the challenge `r2` he received.
    -   `Bob -> Eve: y2 = sig_Bob(r2)`
7.  **Eve Forwards to Alice:** Eve takes Bob's signature `y2` and forwards it to Alice to complete the second session.
    -   `Eve -> Alice: y2`
8.  **Alice Authenticates Eve (as Bob):** Alice receives `y2` and checks if `ver_Bob(r2, y2)` is true. Since `y2` is a valid signature from Bob on her original challenge `r2`, the verification succeeds. Alice now incorrectly believes she has authenticated Bob.
 When Alice signs `r1`, she is simply signing a random number. She has no way to enforce that this signature is intended for a session with Bob. A secure protocol would require the signed message to include identifiers to prevent this attack.
