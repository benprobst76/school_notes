## Public Key Cryptography
Public-key cryptography, also known as asymmetric-key cryptography, was invented by Whitfield Diffie and Martin Hellman in 1976. It addresses two main issues that symmetric-key cryptography faces:
*   **Key Distribution:** In symmetric-key cryptography, a shared secret key `K` must be securely exchanged between Alice and Bob before any encrypted communication can occur. Public-key cryptography eliminates this need for a prior secure channel for key exchange.
*   **Authentication:** It provides mechanisms to verify the identity of the sender.
The advent of asymmetric-key cryptography does not eliminate the need for symmetric-key cryptography; rather, they often complement each other in hybrid cryptosystems.
In public-key cryptography:
*   Each user possesses a pair of keys: a **public key** and a **private key**.
*   The **public key** is used for encryption and can be freely distributed and known to anyone.
*   The **private key** is used for decryption and must be kept secret by its owner.
## Trapdoor One-Way Function
The fundamental concept behind asymmetric-key cryptography is the **trapdoor one-way function**.
A **one-way function** is a function that is easy to compute in one direction but computationally infeasible to invert (find the input given the output).
A **trapdoor one-way function** is a one-way function that has a "trapdoor" – a piece of secret information (the private key) that makes the inversion easy. Without this trapdoor, the function remains computationally infeasible to invert.
Many public-key cryptosystems, including RSA, are based on such trapdoor one-way functions.
## RSA Cryptosystem
The RSA cryptosystem, named after its inventors Rivest, Shamir, and Adleman in 1977, is one of the first and most widely used public-key cryptosystems. It is used for both data encryption and digital signatures.
The security of RSA relies on the computational difficulty of the **integer factorization problem** (factoring large composite numbers) and the **RSA problem**.
RSA is based on the one-way function of modular exponentiation:
*   **Forward computation (easy):** Given a message $x$, public exponent $e$, and modulus $n$, compute the ciphertext $y$: $$y = x^e \pmod n$$**Inverse computation (hard without trapdoor):** Given the ciphertext $y$, public exponent $e$, and modulus $n$, finding the original message $x$:$$x = y^{1/e} \pmod n$$This inversion is computationally hard without knowing the private key, which acts as the trapdoor.
### Existence of Modular Inverse
For $y^{1/e} \pmod n$ to exist and be efficiently computable, we need $\text{gcd}(e, \phi(n)) = 1$, where $\phi(n)$ is Euler's totient function.
If $\text{gcd}(e, \phi(n)) = 1$, then there exists a unique multiplicative inverse $d$ of $e$ modulo $\phi(n)$, such that:
$$d \cdot e \equiv 1 \pmod{\phi(n)}$$
This means $d \cdot e = k \cdot \phi(n) + 1$ for some integer $k$.
Then, for any $y \in \mathbb{Z}_n^*$:
$$y^{d \cdot e} \equiv y^{k \cdot \phi(n) + 1} \equiv (y^{\phi(n)})^k \cdot y^1 \pmod n$$
By Euler's Theorem, if $\text{gcd}(y, n) = 1$, then $y^{\phi(n)} \equiv 1 \pmod n$.

Therefore:
$y^{d \cdot e} \equiv 1^k \cdot y \equiv y \pmod n$

> **Note:** You might wonder what happens if $\text{gcd}(y, n) \neq 1$. This occurs only if $y$ shares a factor with $n$ (meaning $y$ is a multiple of $p$ or $q$). Although Euler's Theorem doesn't directly apply in this specific case, it can be proven using Fermat's Little Theorem and the Chinese Remainder Theorem that $y^{d \cdot e} \equiv y \pmod n$ still holds. Additionally, the probability of randomly encountering such a $y$ is negligible for large primes. Thus, decryption works for **all** messages $0 \le y < n$.

So, computing $x = y^d \pmod n$ effectively computes $y^{1/e} \pmod n$. The private key $d$ is the trapdoor that allows efficient inversion. Knowing $\phi(n)$ is crucial for computing $d$, and computing $\phi(n)$ requires factoring $n$.
## Setup (Key Generation)
A user wishing to set up an RSA cryptosystem generates a pair of public and private keys:
1.  **Choose two large distinct prime numbers, $p$ and $q$.** These primes should be chosen randomly and kept secret.
2.  **Compute the modulus $n$:** $$n = p \cdot q$$
3.  **Compute Euler's totient function $\phi(n)$:**$$\phi(n) = (p-1)(q-1)$$(Note: $p$ and $q$ must be kept secret and can be securely deleted after $\phi(n)$ is computed.)
4.  **Choose an encryption exponent $e$ (public key):**
    *   $1 < e < \phi(n)$
    *   $\text{gcd}(e, \phi(n)) = 1$ (i.e., $e$ and $\phi(n)$ are coprime).
    *   Common choices for $e$ are $3, 17, 65537$.
5.  **Compute the decryption exponent $d$ (private key):**
    *   $d$ is the modular multiplicative inverse of $e$ modulo $\phi(n)$.
    *   $d \cdot e \equiv 1 \pmod{\phi(n)}$
    *   This can be computed using the Extended Euclidean Algorithm.
The **public key** is the pair $(n, e)$.
The **private key** is $d$.
## Encryption & Decryption
Suppose Bob wants to send a secret message $m$ to Alice.
### Encryption (by Bob)
1.  Bob obtains Alice's public key $(n, e)$.
2.  Bob converts the message $m$ into an integer (if it's not already). The integer $m$ must satisfy $0 \le m < n$.
3.  Bob computes the ciphertext $c$: $$c = m^e \pmod n$$4.  Bob sends $c$ to Alice.
### Decryption (by Alice)
1.  Alice receives the ciphertext $c$.
2.  Alice uses her private key $d$ to compute the original message $m$: $$m = c^d \pmod n$$
## Example
Let's walk through an example of RSA encryption and decryption.
1.  **Select two primes:** $p=17$, $q=11$.
2.  **Compute the modulus $n$:** $$n = p \cdot q = 17 \cdot 11 = 187$$3.  **Compute $\phi(n)$:** $$\phi(n) = (p-1)(q-1) = (17-1)(11-1) = 16 \cdot 10 = 160$$3.  **Select encryption exponent $e$:**
    Choose $e=7$. We check that $1 < 7 < 160$ and $\text{gcd}(7, 160) = 1$.
3.  **Compute decryption exponent $d$:**
    We need to find $d$ such that $7d \equiv 1 \pmod{160}$.
    Using the Extended Euclidean Algorithm, we find $d=23$.
    (Check: $7 \cdot 23 = 161 \equiv 1 \pmod{160}$)
*   **Public Key:** $(n, e) = (187, 7)$
*   **Private Key:** $d = 23$
Now, let's encrypt and decrypt a message.
*   **Suppose message $m = 88$.** (Note: $0 \le 88 < 187$)
### Encryption
1.  **Compute ciphertext $c$:** $$
\begin{aligned}
& c = m^e \pmod n = 88^7 \pmod{187} \\ 
&c = 88^7 \pmod{187} = 11
\end{aligned}$$
### Decryption
1.  **Compute original message $m$:** $$m = c^d \pmod n = 11^{23} \pmod{187} = 88$$The original message $88$ is recovered.
## Security of RSA
The security of RSA is based on the presumed difficulty of certain mathematical problems:
1.  **Integer Factorization Problem:** Given a large composite number $n$, it is computationally infeasible to find its prime factors $p$ and $q$. If an adversary could factor $n$, they could then compute $\phi(n) = (p-1)(q-1)$ and subsequently derive the private key $d = e^{-1} \pmod{\phi(n)}$, thus breaking the RSA system.
    *   **Proof Sketch:** If $n=pq$, then $p+q = n - \phi(n) + 1$. Knowing $n$ and $\phi(n)$ allows one to form a quadratic equation $x^2 - (p+q)x + n = 0$, whose roots are $p$ and $q$. Thus, computing $\phi(n)$ is equivalent to factoring $n$.
2.  **RSA Problem:** Given a public key $(n, e)$ and a ciphertext $c$, it is computationally infeasible to find the plaintext $m$ such that $m^e \equiv c \pmod n$. While not strictly proven to be equivalent to integer factorization, it is generally assumed to be at least as hard.
### Factoring Records
The computational effort required to factor large numbers has steadily decreased over time due to algorithmic improvements and increased computing power. This necessitates the use of increasingly larger key sizes for RSA to maintain security.
*   **RSA-129 (428-bit):** Factored in April 1994.
*   **RSA-130:** Factored in April 1996.
*   **RSA-140:** Factored in February 1999.
*   **RSA-155 (512-bit):** Factored in August 1999.
*   **RSA-174 (576-bit):** Factored in December 2003.
*   **RSA-768 (232 decimal digits):** Factored in December 2009, requiring two years on hundreds of machines.
Factoring a 1024-bit integer is estimated to be about 1000 times harder than factoring RSA-768, but it is likely possible with future advancements. Current recommendations for RSA key sizes are typically 2048 bits or higher.
## Choosing $p$ and $q$
To ensure the security of RSA, the selection of the prime numbers $p$ and $q$ is critical:
1.  **Large Difference:** The absolute difference $|p-q|$ should be large. If $p$ and $q$ are too close, $n$ can be factored using methods like Fermat's factorization.
2.  **Similar Lengths:** The bit lengths of $p$ and $q$ should be approximately equal. This makes factorization harder as it prevents trial division by small factors.
3.  **Large Prime Factors for $p-1$ and $q-1$:** The numbers $p-1$ and $q-1$ should have at least one large prime factor. This helps defend against Pollard's $p-1$ factorization method.
4.  **Small $\text{gcd}(p-1, q-1)$:** The greatest common divisor of $p-1$ and $q-1$ should be small. This helps prevent certain attacks related to the order of elements.