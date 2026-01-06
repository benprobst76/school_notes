Let a and b be real numbers. An elliptic curve E over the field of real numbers R is the set of points (x,y) with x and y in R that satisfy the equation:
$$E=\{(x,y)\in \mathbb{R}\times \mathbb{R}|y^2=x^3+ax+b\}\cup \{O\}$$ 
Where $a,b \in \mathbb{R}, 4a^3 + 27b^2 \neq 0$ and O is called the point at infinity.
![[Pasted image 20251103085957.png]]
### Group Operation + Over E
(E, +) is an abelian group.
- **Closure**: Given P, Q ∈ E, P+Q ∈ E
- **Associative Law**: Given P, Q, R ∈ E, (P+Q)+R=P+(Q+R)
- **Identity**: O is the identity element, P+O=P for any P ∈ E.
- **Inverse**: For each point P, there is an inverse -P such that P+(-P)=O. If P=(x,y), then -P=(x,-y).
- **Commutative Law**: Given P, Q ∈ E, P+Q=Q+P

Given $P=(x_1, y_1)$ and $Q=(x_2, y_2)$ in E.
- If $x_1 \neq x_2$, then $P+Q=(x_3, y_3)$ where:
$$\begin{aligned}
\lambda &= \frac{y_2-y_1}{x_2-x_1} \\
x_3 &= \lambda^2 - x_1 - x_2 \\
y_3 &= \lambda(x_1-x_3) - y_1
\end{aligned}$$
- If $P=Q$ (doubling the point), then $2P=(x_3, y_3)$ where:
$$\begin{aligned}
\lambda &= \frac{3x_1^2+a}{2y_1} \\
x_3 &= \lambda^2 - 2x_1 \\
y_3 &= \lambda(x_1-x_3) - y_1
\end{aligned}$$
#### Example: Addition
Consider the curve $y^2=x^3-25x$ with $a=-25, b=0$. Let $P_1=(0, 0)$ and $P_2=(-5,0)$.
$$\begin{aligned}
\lambda &= \frac{0-0}{-5-0} = 0 \\
x_3 &= (0)^2 - 0 - (-5) = 5 \\
y_3 &= 0(0-5) - 0 = 0
\end{aligned}$$So, $P_1+P_2 = (5, 0)$.
#### Example: Doubling
Consider the curve $y^2=x^3-25x$ and the point $P_1=(-4, 6)$.
$$\begin{aligned}
\lambda &= \frac{3(-4)^2 - 25}{2(6)} = \frac{48-25}{12} = \frac{23}{12} \\
x_3 &= (\frac{23}{12})^2 - 2(-4) = \frac{529}{144} + 8 = \frac{529+1152}{144} = \frac{1681}{144} \\
y_3 &= \frac{23}{12}(-4-\frac{1681}{144}) - 6 = \frac{23}{12}(-\frac{576+1681}{144}) - 6 = \frac{23}{12}(-\frac{2257}{144}) - 6 = -\frac{51911}{1728} - \frac{10368}{1728} = -\frac{62279}{1728}
\end{aligned}$$So, $2P_1 = (\frac{1681}{144}, -\frac{62279}{1728})$.
### Elliptic Curves Modulo a Prime
Let p > 3 be a prime. An elliptic curve E over $Z_p$ is the set of points $(x, y) \in Z_p \times Z_p$ satisfying the congruence:
$$y^2 \equiv x^3 + ax + b \pmod{p}$$ 
where $a, b \in Z_p$ are constants such that $4a^3 + 27b^2 \not\equiv 0 \pmod{p}$, together with a special point O called the point at infinity.
#### Example
Consider the elliptic curve $y^2 = x^3 + x + 6$ over $Z_{11}$.
We find the points by substituting values for x from 0 to 10.
- x=2: $y^2 = 8+2+6=16 \equiv 5 \pmod{11}$. $y=4, 7$. Points: (2,4), (2,7).
- x=3: $y^2 = 27+3+6=36 \equiv 3 \pmod{11}$. $y=5, 6$. Points: (3,5), (3,6).
- x=5: $y^2 = 125+5+6=136 \equiv 4 \pmod{11}$. $y=2, 9$. Points: (5,2), (5,9).
- x=7: $y^2 = 343+7+6=356 \equiv 4 \pmod{11}$. $y=2, 9$. Points: (7,2), (7,9).
- x=8: $y^2 = 512+8+6=526 \equiv 9 \pmod{11}$. $y=3, 8$. Points: (8,3), (8,8).
- x=10: $y^2 = 1000+10+6=1016 \equiv 4 \pmod{11}$. $y=2, 9$. Points: (10,2), (10,9).
There are 12 points plus the point at infinity O, so the order of the group #E is 13.
### Quadratic Residue
Def: c in $Z_p$ is a quadratic residue (Q.R.) modulo p if it has a square root in $Z_p$ (p is odd prime).
Euler’s theorem: c in $(Z_p)^*$ is a Q.R. $\iff c^{(p-1)/2} \equiv 1 \pmod{p}$ (p odd prime).
Lemma: When $p \equiv 3 \pmod 4$, if $c \in Z_p^*$ is Q.R. then its square roots are $\pm c^{(p+1)/4} \pmod{p}$.
When $p \equiv 1 \pmod 4$, can also be done efficiently (e.g. Tonelli-Shanks algorithm).
### (E,+) over $Z_p$ is a cyclic abelian group.
The group properties (Closure, Associativity, Identity, Inverse, Commutativity) hold with all calculations performed modulo p.
Since the order of $E(Z_{11})$ is 13 (a prime number), any point other than the identity O is a generator.
Let's choose the generator $\alpha = (2,7)$.
#### Example: Compute $3\alpha$
First, compute $2\alpha = \alpha+\alpha$. Using the doubling formula with $a=1$:
$$\begin{aligned}
\lambda &= (3(2^2)+1)(2(7))^{-1} \equiv 13 \cdot 14^{-1} \equiv 2 \cdot 3^{-1} \equiv 2 \cdot 4 \equiv 8 \pmod{11} \\
x_3 &= 8^2 - 2(2) = 64-4=60 \equiv 5 \pmod{11} \\
y_3 &= 8(2-5)-7 = -24-7 = -31 \equiv 2 \pmod{11}
\end{aligned}$$
Next, compute $3\alpha = 2\alpha + \alpha = (5,2) + (2,7)$. Using the addition formula:
$$\begin{aligned}
\lambda &= (7-2)(2-5)^{-1} \equiv 5 \cdot (-3)^{-1} \equiv 5 \cdot 8^{-1} \equiv 5 \cdot 7 \equiv 35 \equiv 2 \pmod{11} \\
x_3 &= 2^2 - 5 - 2 = -3 \equiv 8 \pmod{11} \\
y_3 &= 2(5-8)-2 = -6-2 = -8 \equiv 3 \pmod{11}
\end{aligned}$$
### Elliptic Curve ElGamal
Suppose we have an Elliptic Curve $E(Z_p)$ of order q. $\alpha$ is a generator of $E(Z_p)$.
**KeyGen**: Bob’s private key is an integer $d_B \in \{1, ..., q-1\}$. Bob’s public key is $P_B = d_B \alpha$.
**Encryption**: To encrypt a message point $P_m$ on $E(Z_p)$, Alice randomly selects an integer $k \in \{1, ..., q-1\}$, and computes the ciphertext $C = (C_1, C_2)$:
$C_1 = k\alpha$
$C_2 = P_m + k P_B$
**Decryption**: To decrypt C, Bob uses his private key $d_B$ to compute:
$$\begin{aligned}
P_m &= C_2 - d_B C_1 \\
&= (P_m + k P_B) - d_B(k\alpha) \\
&= P_m + k(d_B\alpha) - d_B(k\alpha) \\
&= P_m
\end{aligned}$$
#### Example
Let's use the curve $E(Z_{11})$ with order q=13 and generator $\alpha=(2,7)$.
Bob's private key is $d_B=7$. His public key is $P_B = 7\alpha = (7,2)$.
Alice wishes to encrypt the plaintext message $P_m = (10,9)$. She chooses a random integer $k=3$.
She computes:
$C_1 = k\alpha = 3\alpha = (8,3)$
$kP_B = 3(7,2) = (4,6)$
$C_2 = P_m + kP_B = (10,9) + (4,6) = (0,7)$
The ciphertext is $C=((8,3), (0,7))$.
Bob receives the ciphertext and decrypts it using his private key $d_B=7$:
$d_B C_1 = 7(8,3) = (4,6)$
$$\begin{aligned}
P_m &= C_2 - d_B C_1 \\
&= (0,7) - (4,6) \\
&= (0,7) + (4,-6) \\
&= (0,7) + (4,5) \\
&= (10,9)
\end{aligned}$$
### Elliptic Curve DLP
The security of ECC is based on the difficulty of the Elliptic Curve Discrete Logarithm Problem (ECDLP).
Given a point P on an elliptic curve and another point $Q=kP$ (the result of adding P to itself k times), it is computationally infeasible to find the integer k.
$$Q = kP = \underbrace{P+P+...+P}_{k \text{ times}}$$
**ECDLP**: Given an elliptic curve E over $Z_p$, a point P of order q, and a point Q in the group generated by P, find the integer $k \in \{0, ..., q-1\}$ such that $Q=kP$.
We say that ECDLP is hard in E over $Z_p$ if for all efficient algorithms A:
$$Pr_{P\leftarrow E, k\leftarrow Z_q}[A(E, p, P, kP) = k] < \text{negligible}$$
### Security of ECC vs. RSA/ElGamal
Elliptic curve cryptosystems offer equivalent security to RSA/ElGamal but with much smaller key sizes.
- The ECDLP is considered to be significantly harder than the Integer Factorization Problem (for RSA) and the Discrete Logarithm Problem (for ElGamal over $Z_p^*$).
- This means that the strength of ECC grows more rapidly with key size increases compared to RSA.

| Security Level (bits) | RSA/DSA Key Size (bits) | ECC Key Size (bits) |
|---|---|---|
| 80                    | 1024                      | 160|
| 112                   | 2048                      | 224|
| 128                   | 3072                      | 256                  |
| 192                   | 7680                      | 384                   |
| 256                   | 15360                     | 512                   |
Explanation:
  When $p \equiv 3 \pmod 4$, we can explicitly calculate the square roots of a quadratic residue $a$ using the formula $x \equiv \pm a^{(p+1)/4} \pmod p$.

  Proof:
   1. Let $x = a^{(p+1)/4}$.
   2. Square both sides:
      $$x^2 \equiv (a^{(p+1)/4})^2 \equiv a^{(p+1)/2} \pmod p$$
   3. Rewrite the exponent:
      $$x^2 \equiv a^{(p-1)/2 + 1} \equiv a^{(p-1)/2} \cdot a \pmod p$$
   4. By Euler's Criterion, if $a$ is a quadratic residue (which implies a square root exists), then $a^{(p-1)/2} \equiv 1 \pmod p$.
   5. Substitute this back into the equation:
      $$x^2 \equiv 1 \cdot a \equiv a \pmod p$$

  Thus, $a^{(p+1)/4}$ is a square root of $a$. This formula relies on $p \equiv 3 \pmod 4$ because it ensures that $p+1$ is divisible by 4, making the exponent an integer.