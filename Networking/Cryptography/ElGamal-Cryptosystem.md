The ElGamal cryptosystem is a public-key cryptosystem developed by Taher Elgamal in 1985. Its security is based on the difficulty of the **Discrete Logarithm (DLog) problem** in a finite cyclic group. It builds upon the principles of the [[#Diffie-Hellman Key Exchange]].
## Diffie-Hellman Key Exchange
The Diffie-Hellman protocol, introduced by Whitfield Diffie and Martin Hellman in 1976, allows two parties (Alice and Bob) to agree on a shared secret key over an insecure channel.
### Protocol Steps
1.  **Public Parameters:** Alice and Bob agree on a large prime `p` and a generator `g` of the multiplicative group $\mathbb{Z}_p^*$. The group $\mathbb{Z}_p^*$ is a finite cyclic group of order $p-1$.
2.  **Alice's Secret:** Alice chooses a random secret integer $a$ where $1 \le a < p-1$.
3.  **Bob's Secret:** Bob chooses a random secret integer $b$ where $1 \le b < p-1$.
4.  **Public Key Exchange:**
    *   Alice computes her public key $A$ and sends it to Bob:
        $$A = g^a \pmod p$$
    *   Bob computes his public key $B$ and sends it to Alice:
        $$B = g^b \pmod p$$
5.  **Shared Secret Calculation:**
    *   Alice computes the shared secret key $k_{AB}$:
        $$k_{AB} = B^a \pmod p = (g^b)^a \pmod p = g^{ab} \pmod p$$
    *   Bob computes the shared secret key $k_{BA}$:
        $$k_{BA} = A^b \pmod p = (g^a)^b \pmod p = g^{ab} \pmod p$$
Both Alice and Bob now share the same secret key $k = g^{ab} \pmod p$.

### Security
The security of the Diffie-Hellman protocol relies on the **Computational Diffie-Hellman (CDH) problem**, which is the problem of computing $g^{ab} \pmod p$ given only the public values $g, p, g^a \pmod p$, and $g^b \pmod p$.
This problem is strongly related to the **Discrete Logarithm (DLog) problem**. If an attacker could efficiently solve the DLog problem, they could find Alice's secret $a$ from her public key $A = g^a \pmod p$ and then compute the shared secret $k = B^a \pmod p$.
It is an open problem whether the CDH problem is equivalent to the DLog problem.
## ElGamal Encryption Algorithm
The ElGamal encryption algorithm adapts the Diffie-Hellman protocol for encryption. Alice's public key $A = g^a$ is used by others to encrypt messages for her.
### Key Generation
*   **Public Parameters:** A large prime $p$ and a generator $g$ of $\mathbb{Z}_p^*$.
*   **Private Key:** A randomly chosen integer $a$ such that $1 \le a < p-1$.
*   **Public Key:** The triple $(p, g, y)$, where $y = g^a \pmod p$.
### Encryption
To encrypt a message $m$ for Alice, Bob performs the following steps:
1.  Obtain Alice's public key $(p, g, y)$.
2.  Choose a random, ephemeral integer $k$ such that $1 \le k < p-1$. This $k$ must be used for only one message.
3.  Compute the first part of the ciphertext, $c_1$:
    $$c_1 = g^k \pmod p$$
4.  Compute the second part of the ciphertext, $c_2$:
    $$c_2 = (m \cdot y^k) \pmod p$$
5.  The ciphertext is the pair $(c_1, c_2)$.
### Decryption
To decrypt the ciphertext $(c_1, c_2)$, Alice uses her private key $a$:
1.  Compute the modular inverse of $(c_1^a) \pmod p$. Let this be $(c_1^a)^{-1}$.
2.  Compute the plaintext message $m$:
    $$m = (c_2 \cdot (c_1^a)^{-1}) \pmod p$$

**Why this works:**
$$\begin{aligned}
c_2 \cdot (c_1^a)^{-1} &\equiv (m \cdot y^k) \cdot ((g^k)^a)^{-1} \pmod p \\
&\equiv (m \cdot (g^a)^k) \cdot (g^{ka})^{-1} \pmod p \\
&\equiv m \cdot g^{ak} \cdot (g^{ak})^{-1} \pmod p \\
&\equiv m \cdot 1 \pmod p \\
&\equiv m \pmod p
\end{aligned}$$

## Example Question
Let $p = 23$ and select a generator $g = 11$.
Choose a private key $x = 6$.
**a. Compute the public key**
The private key is $a=6$. The public key $y$ is computed as:
$$\begin{aligned}
y = g^a \pmod p &= 11^6 \pmod{23} \\
11^2 &\equiv 121 \equiv 6 \pmod{23} \\
11^4 &\equiv 6^2 \equiv 36 \equiv 13 \pmod{23} \\
11^6 &= 11^4 \cdot 11^2 \equiv 13 \cdot 6 = 78 \equiv 9 \pmod{23}
\end{aligned}$$
**The public key is $y=9$.** The full public key is $(p, g, y) = (23, 11, 9)$.
**b. Use the public key to encrypt $m = 10$**
1.  Choose a random ephemeral key $k$. Let's choose $k=5$.
2.  Compute the first part of the ciphertext, $c_1$:
    $$\begin{aligned}
    c_1 = g^k \pmod p &= 11^5 \pmod{23} \\
    11^2 &\equiv 6 \pmod{23} \\
    11^4 &\equiv 13 \pmod{23} \\
    11^5 &= 11^4 \cdot 11^1 \equiv 13 \cdot 11 = 143 \equiv 5 \pmod{23}
    \end{aligned}$$    So, $c_1 = 5$.
3.  Compute the second part of the ciphertext, $c_2$:
    $$c_2 = (m \cdot y^k) \pmod p = (10 \cdot 9^5) \pmod{23}$$
    First, compute $9^5 \pmod{23}$:
    $$\begin{aligned}
    9^2 &\equiv 81 \equiv 12 \pmod{23} \\
    9^4 &\equiv 12^2 = 144 \equiv 6 \pmod{23} \\
    9^5 &= 9^4 \cdot 9^1 \equiv 6 \cdot 9 = 54 \equiv 8 \pmod{23}
    \end{aligned}$$    Now, compute $c_2$:
    $$c_2 = (10 \cdot 8) \pmod{23} = 80 \pmod{23} = 11$$
    So, $c_2 = 11$.
**The ciphertext is $(c_1, c_2) = (5, 11)$.**
**c. Use the secret key to decrypt the obtained ciphertext**
4.  The ciphertext is $(c_1, c_2) = (5, 11)$ and the private key is $a=6$.
5.  Compute the shared secret part:
    $$\begin{aligned}
    s = c_1^a \pmod p &= 5^6 \pmod{23} \\
    5^2 &\equiv 25 \equiv 2 \pmod{23} \\
    5^4 &\equiv 2^2 = 4 \pmod{23} \\
    5^6 &= 5^4 \cdot 5^2 \equiv 4 \cdot 2 = 8 \pmod{23}
    \end{aligned}$$    So, $s=8$.
6.  Compute the modular inverse of $s=8$ modulo $23$. We need to find $s^{-1}$ such that $8 \cdot s^{-1} \equiv 1 \pmod{23}$. Using the Extended Euclidean Algorithm, we find that $s^{-1} = 3$.
    (Check: $8 \cdot 3 = 24 \equiv 1 \pmod{23}$)
7.  Compute the plaintext message $m$:
    $$\begin{aligned}
    m = (c_2 \cdot s^{-1}) \pmod p &= (11 \cdot 3) \pmod{23} \\
    m &= 33 \pmod{23} = 10
    \end{aligned}$$
**The decrypted message is $m=10$, which matches the original plaintext.**
## Security
The security of the ElGamal cryptosystem is based on the difficulty of the DLog problem.
*   If the DLog problem can be solved efficiently, the ElGamal cryptosystem is insecure because an attacker could derive the private key $a$ from the public key $y = g^a \pmod p$.
*   If the DLog problem is hard, the ElGamal cryptosystem is considered secure.

We say that DLog is hard in a group $G$ of order $q$ if for all efficient algorithms $\mathcal{A}$:
$$ 	Pr_{g \leftarrow G, x \leftarrow \mathbb{Z}_q} [\mathcal{A}(G, q, g, g^x ) = x] < \text{negligible} $$
