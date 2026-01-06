A digital signature is the electronic equivalent of a handwritten signature, but it provides stronger security guarantees. It is a cryptographic mechanism used to verify the authenticity, integrity, and non-repudiation of digital messages or documents.
A digital signature scheme provides the following security goals:
*   **Message Integrity**: Ensures that the message has not been altered since it was signed.
*   **Sender Authenticity**: Verifies that the message was sent by the claimed sender.
*   **Non-repudiation**: Prevents the sender from later denying that they signed the message.
### Properties of Digital Signatures
*   **Easy to Generate**: The signer can easily generate a signature for a message.
*   **Easy to Verify**: A verifier can easily check the validity of a signature.
*   **Hard to Forge**: It is computationally infeasible for anyone other than the signer to create a valid signature.
*   **Message Dependent**: The signature is a function of the message being signed.
*   **Represented as a bit string** attached to the message.
## Digital Signature Schemes
A signature scheme is defined by a triple of algorithms: `(KeyGen, Sign, Verif)`.
*   `KeyGen(λ)`: A randomized algorithm that takes a security parameter `λ` and outputs a key pair `(pk, sk)`, where `pk` is the public verification key and `sk` is the private signing key.
*   `Sign(sk, m)`: An algorithm that takes the private key `sk` and a message `m` and outputs a signature `σ`.
*   `Verif(pk, m, σ)`: An algorithm that takes the public key `pk`, the message `m`, and the signature `σ`, and outputs either 'accept' or 'reject'.
**Consistency**: For a correctly generated key pair `(pk, sk)`, the verification algorithm must accept a signature generated with the corresponding private key.
$$
\forall m \in M: \text{Verif}(\text{pk}, m, \text{Sign}(\text{sk}, m)) = \text{'accept'}
$$
### Security Requirements
1.  **Unforgeability**: Without the private signing key `sk`, it should be computationally infeasible to construct a valid message-signature pair `(m, σ)` such that `Verif(pk, m, σ) = 'accept' `.
2.  **Non-reusability**: It should be computationally infeasible to find a different message `m'` for a known signature `σ` such that `Verif(pk, m', σ) = 'accept' `. Note that while it might be possible for two messages to have the same signature (`Sign(sk, m) = Sign(sk, m')`), finding such a pair should be infeasible.
### Adversarial Goals
The goal of an adversary is to forge a signature. The severity of the forgery can be categorized as:
*   **Total Break**: The adversary is able to determine the signer's private key `sk`, allowing them to generate a valid signature on any message.
*   **Selective Forgery**: The adversary is able to create a valid signature on a specific message `m` chosen before the attack.
*   **Existential Forgery**: The adversary can create a valid signature for at least one message `m` that they were not given a signature for. The adversary doesn't get to choose the message `m`; any valid pair `(m, σ)` is sufficient.
### Attack Models
The power of the adversary is defined by what information they have access to:
*   **Key-Only Attack**: The attacker only knows the public verification key `pk`.
*   **Known-Message Attack**: The attacker has a set of messages and their corresponding valid signatures.
*   **Chosen-Message Attack**: The attacker can obtain valid signatures for any messages of their choice. This is the strongest attack model.
## Secure Digital Signature
A digital signature scheme is considered secure if it is **existentially unforgeable under a chosen-message attack (EUF-CMA)**.
*   **Attacker's Power**: The attacker can choose a series of messages $m_1, m_2, …, m_q$ and is given the corresponding signatures $\sigma_i = \text{Sign}(\text{sk}, m_i)$.
*   **Attacker's Goal**: The attacker's goal is to produce a new, valid message-signature pair $(m, \sigma)$ such that $m \notin \{m_1, …, m_q\}$.
A scheme is secure if any efficient attacker has only a negligible probability of success in this game.
## RSA Signature Scheme
The [[RSA-Cryptosystem|RSA]] signature scheme was developed by Rivest, Shamir, and Adleman in 1977. Its security is based on the difficulty of the integer factorization problem.
### Key Generation
1.  Generate two large, distinct primes, `p` and `q`.
2.  Compute the modulus $n = pq$ and Euler's totient function $\phi(n) = (p-1)(q-1)$.
3.  Select a random integer `e` such that $1 < e < \phi(n)$ and $\text{gcd}(e, \phi(n)) = 1$.
4.  Compute the unique integer `d` such that $ed \equiv 1 \pmod{\phi(n)}$.
5.  The **public verification key** is `(n, e)`.
6.  The **private signing key** is `d`.
### Signing and Verification
To improve efficiency and security, RSA signatures are typically applied to the hash of a message, not the message itself. Let `H` be a cryptographic [[Hash-Function]].
**Sign(sk, m)**: To sign a message `m`, Alice does the following:
1.  Compute the hash of the message: $h = H(m)$.
2.  Use her private key `d` to compute the signature:
    $$
    \sigma = h^d \pmod{n}
    $$
3.  The signature `σ` is sent with the message `m`.
**Verif(pk, m, σ)**: To verify the signature, Bob does the following:
4.  Obtain Alice's public key `(n, e)`.
5.  Compute the hash of the received message: $h' = H(m)$.
6.  Use the public key to reverse the signature calculation:
    $$
    h_{computed} = \sigma^e \pmod{n}
    $$
7.  Verify that the computed hash matches the hash of the message: if $h_{computed} = h'$, the signature is valid. Otherwise, it is rejected.
### Correctness of RSA Signatures
The verification works because of Euler's theorem. Since $ed \equiv 1 \pmod{\phi(n)}$, we can write $ed = 1 + k\phi(n)$ for some integer `k`.
$$
\begin{aligned}
 h_{computed} &= \sigma^e \pmod{n} \\ 
 &= (h^d)^e \pmod{n} \\ 
 &= h^{ed} \pmod{n} \\ 
 &= h^{1+k\phi(n)} \pmod{n} \\ 
 &= h^1 \cdot (h^{\phi(n)})^k \pmod{n}
\end{aligned}
$$
By Euler's theorem, if $\text{gcd}(h, n)=1$, then $h^{\phi(n)} \equiv 1 \pmod{n}$. Therefore:
$$
 h_{computed} \equiv h \cdot 1^k \equiv h \pmod{n}
$$
### Example
*   **Alice's Setup**:
    *   Chooses $p=5, q=7$.
    *   Computes $n = 35$ and $\phi(n) = (5-1)(7-1) = 24$.
    *   Chooses $e=5$.
    *   Computes $d=5$ because $5 \times 5 = 25 \equiv 1 \pmod{24}$.
    *   Public key: `(n=35, e=5)`. Private key: `d=5`.
*   **Signing**:
    *   Suppose the hash of the message is $H(m) = 26$.
    *   Alice computes the signature: $\sigma = 26^5 \pmod{35} = 31$.
*   **Verification**:
    *   Bob receives the message and signature `σ=31`.
    *   He computes the hash of the message, getting $H(m)=26$.
    *   He uses Alice's public key to compute: $31^5 \pmod{35} = 26$.
    *   Since the computed value `26` matches the message hash `26`, the signature is valid.
## Digital Signature Standard (DSS) and Algorithm (DSA)
*   The **Digital Signature Standard (DSS)** was published by NIST as FIPS-186 in 1991.
*   The **Digital Signature Algorithm (DSA)** is the algorithm specified in the standard.
*   **Security**: Based on the difficulty of the discrete logarithm problem.
*   **Performance**: Generally creates smaller signatures and has faster computation than RSA.
### DSA Key Generation
**Shared Global Parameters (p, q, g)**:
*   Choose a 160-bit prime `q`.
*   Choose a large prime `p` (e.g., 1024 bits) such that `q` is a prime divisor of `(p-1)`.
*   Choose `g` such that $g = h^{(p-1)/q} \pmod p > 1$ for some $1 < h < p-1$.
**User Keys**:
*   Choose a random private signing key `x` such that $x < q$.
*   Compute the public verification key: $y = g^x \pmod p$.
### DSA Signing
To sign a message `m`, Alice does the following:
1.  Generate a random, single-use value `k` such that $k < q$. **This value must be kept secret and never reused.**
2.  Compute the two parts of the signature, `r` and `s`:
    $$
    \begin{aligned}
    r &= (g^k \pmod p) \pmod q \\ 
    s &= [k^{-1}(H(m) + x \cdot r)] \pmod q
    \end{aligned}
    $$
3.  The signature is the pair `σ = (r, s)`.
### DSA Verification
To verify the signature `(r, s)` on message `m`, Bob does the following:
1.  Compute:
    $$
    \begin{aligned}
    w &= s^{-1} \pmod q \\ 
    u_1 &= (H(m) \cdot w) \pmod q \\ 
    u_2 &= (r \cdot w) \pmod q \\ 
    v &= ((g^{u_1} y^{u_2}) \pmod p) \pmod q
    \end{aligned}
    $$
2.  The signature is valid if and only if $v = r$. c