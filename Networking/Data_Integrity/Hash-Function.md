A hash function is a mathematical function that maps an input of arbitrary size to a fixed-size output. This can be represented as:
$$
H: \{0,1\}^* \to \{0,1\}^n
$$
where $\{0,1\}^*$ represents a binary string of any length, and $\{0,1\}^n$ represents a binary string of a fixed length $n$.
*   **Input**: Data of any size, often called the "message".
*   **Output**: A fixed-size value known as the **hash value**, **message digest**, or simply **hash**.
Hash functions are a fundamental tool for ensuring data integrity.
**Example**: A very simple (and insecure) hash function could be one that takes a binary string $b_1b_2...b_k$ and computes the XOR sum of all its bits: $b_1 \oplus b_2 \oplus \dots \oplus b_k$. This produces a single-bit hash.
## Security Properties of Hash Functions
For a hash function to be cryptographically secure, it must possess three key properties: preimage resistance, second preimage resistance, and collision resistance.
### Preimage Resistance (One-Way Property)
A hash function $H: M \to T$ is **preimage resistant** if, given a hash value $y \in T$, it is computationally infeasible to find any message $m \in M$ such that $H(m) = y$.
*   **Problem**: Given $y$, find $m$ such that $H(m) = y$.
*   **Security Goal**: This should be hard to do. This property is why hash functions are often called "one-way functions".
### Second Preimage Resistance (Weak Collision Resistance)
A hash function $H: M \to T$ is **second preimage resistant** if, given a message $m \in M$, it is computationally infeasible to find a *different* message $m' \in M$ such that $m' \neq m$ and $H(m') = H(m)$.
*   **Problem**: Given $m$, find $m' \neq m$ such that $H(m') = H(m)$.
*   **Security Goal**: This should be hard to do. This prevents an attacker from substituting a message with a new one that has the same hash.
### Collision Resistance (Strong Collision Resistance)
A hash function $H: M \to T$ is **collision resistant** if it is computationally infeasible to find *any* two distinct messages $m_0, m_1 \in M$ such that $H(m_0) = H(m_1)$ and $m_0 \neq m_1$.
*   **Problem**: Find any pair $(m_0, m_1)$ such that $m_0 \neq m_1$ and $H(m_0) = H(m_1)$.
*   **Security Goal**: This should be hard to do.
Since the input space $M$ is much larger than the output space $T$ (i.e., $|M| \gg |T|$), collisions are guaranteed to exist by the pigeonhole principle. The goal is to make them computationally infeasible to find.
**Relationship between properties**:
*   **Collision Resistance implies Second Preimage Resistance**: If a hash function is collision resistant, it must also be second preimage resistant. If an attacker could find a second preimage for a given $m$, they would have found a collision.
*   **Second Preimage Resistance does not imply Collision Resistance**: It is generally easier to find any two messages that collide than to find a message that collides with a *specific* message. The birthday attack demonstrates this.
**Quiz**:
Which of the following statements about hash functions is incorrect?
A. If a hash function is strong collision resistant, it must be second pre-image resistant. (Correct)
B. If an adversary can solve the preimage problem of the hash function, he must be able to find a collision. (Correct - finding a preimage for a random hash means you found a collision)
C. If a hash function is weak collision resistant, it must be second pre-image resistant. (Correct, these are the same property)
D. If an adversary can find a collision of the hash function, it must be able to solve the second pre-image problem. (Incorrect - finding a collision doesn't mean you can find a second preimage for any *given* message)
## Birthday Attack
The birthday attack is a generic attack that targets the **strong collision resistance** of a hash function. It is based on the "birthday paradox".
**Birthday Paradox**: In a group of people, what is the probability that at least two of them share the same birthday?
With just 23 people, this probability is over 50%.
Let's analyze the probability. Suppose there are $n$ possible birthdays (e.g., $n=365$) and $k$ people in a room. The probability that no two people share a birthday, $q$, can be calculated as:
$$
q = \frac{n \times (n-1) \times \dots \times (n-k+1)}{n^k} = \prod_{i=0}^{k-1} \frac{n-i}{n} = \prod_{i=0}^{k-1} \left(1 - \frac{i}{n}\right)
$$
Using the approximation $1+x \le e^x$, we get:
$$
q \le \prod_{i=0}^{k-1} e^{-i/n} = e^{-\sum_{i=0}^{k-1} i/n} = e^{-k(k-1)/2n}
$$
To find the number of people $k$ needed for the probability of a collision to be at least 0.5 (i.e., $q \le 0.5$), we can solve for $k$:
$$
\begin{aligned}
0.5 &\le e^{-k(k-1)/2n} \\
\ln(0.5) &\le -\frac{k(k-1)}{2n} \\
-\ln(2) &\le -\frac{k^2 - k}{2n} \\
k^2 - k &\ge 2n \ln(2)
\end{aligned}
$$
For large $k$, this is approximately $k^2 \approx 2n \ln(2)$, which gives $k \approx \sqrt{2n \ln(2)} \approx 1.177\sqrt{n}$. For $n=365$, $k \approx 22.49$, which is why the threshold is 23 people.
**Applying to Hash Functions**:
An attacker can generate $k$ different messages and compute their hash values. If the hash function has an $n$-bit output, there are $2^n$ possible hash values. The attacker is looking for a collision. The number of messages $k$ the attacker needs to compute to have a >50% chance of finding a collision is approximately $k \approx \sqrt{2^n} = 2^{n/2}$.
This means that an $n$-bit hash function provides only $n/2$ bits of security against collision attacks. To prevent birthday attacks, hash functions need a sufficiently large output size. Today, $n \ge 256$ is recommended.

| n (bit length) | Security against Birthday Attack (k ≈ 2^(n/2)) |
| :------------: | :--------------------------------------------: |
|      128       |                    $2^{64}$                    |
|      160       |                    $2^{80}$                    |
|      256       |                   $2^{128}$                    |
## Hash Function Construction
A common strategy to design collision-resistant hash functions for long messages is:
1.  **Step 1**: Design a collision-resistant **compression function** `h` that works on fixed-size inputs.
    $$
h: T \times X \to T$$
    A popular method for this is the **Davies-Meyer compression function**, which uses a block cipher `E`:
    $$h(H, m) = E(m, H) \oplus H$$
    If `E` is an ideal cipher, finding a collision for this compression function takes $O(2^{n/2})$ evaluations, where $n$ is the block size.
2.  **Step 2**: Use an iterative construction to extend `h` to a hash function `H` that can handle arbitrary-length messages.
### Merkle-Damgård Iterated Construction
This is a widely used method for building a full hash function from a compression function.
![[Pasted image 20251112102328.png]]
The process is as follows:
1.  The input message is padded to be a multiple of the block size. The original length of the message is appended to the padded message.
2.  The padded message is divided into blocks $m_1, m_2, \dots, m_t$.
3.  An initial value (IV), denoted $H_0$, is set.
4.  The compression function `h` is applied iteratively:
    *   $H_1 = h(H_0, m_1)$
    *   $H_2 = h(H_1, m_2)$
    *   ...
    *   $H_t = h(H_{t-1}, m_t)$
5.  The final hash value is $H(M) = H_t$.
**Theorem**: If the compression function `h` is collision resistant, then the iterated hash function `H` constructed using the Merkle-Damgård method is also collision resistant.
**Proof Sketch**: A collision in `H` implies a collision in `h`.
Suppose we have a collision in `H` for two different messages, $M \neq M'$, such that $H(M) = H(M')$.
Let the intermediate hash values for $M$ be $H_0, H_1, \dots, H_t$ and for $M'$ be $H'_0, H'_1, \dots, H'_r$.
Since $H(M) = H(M')$, we have $h(H_{t-1}, m_t) = h(H'_{r-1}, m'_r)$.
If $(H_{t-1}, m_t) \neq (H'_{r-1}, m'_r)$, we have found a collision in `h`.
If $(H_{t-1}, m_t) = (H'_{r-1}, m'_r)$, we can work backwards. Since $M \neq M'$, at some point there must be a step `i` where $(H_{i-1}, m_i) \neq (H'_{i-1}, m'_i)$ but $H_i = H'_i$. This means $h(H_{i-1}, m_i) = h(H'_{i-1}, m'_i)$, which is a collision in `h`.
![[Pasted image 20251112102530.png]]
## Common Hash Functions
### MD5
*   Designed by Ron Rivest in 1991.
*   Based on the Merkle–Damgård construction with a Davies-Meyer compression function.
*   **Output size**: 128 bits.
*   **Status**: Broken. Practical collision attacks were demonstrated in 2005. It should no longer be used for security purposes. Preimage resistance is also weakened.
### SHA-1
*   Designed by the NSA, published in 1995.
*   Based on MD4/MD5 designs.
*   **Output size**: 160 bits.
*   **Structure**: 80 rounds of compression.
    ![[Pasted image 20251112103438.png]]
*   **Padding**: A message is padded so its length is 64 bytes short of a multiple of 512 bits. The original length is then appended as a 64-bit integer.
*   **Status**: Broken. In 2017, Google and CWI announced the first public collision attack (SHAttered), creating two different PDF files with the same SHA-1 hash. It is deprecated for most uses.
### SHA-2
*   Designed by the NSA, published in 2001.
*   A family of hash functions: SHA-224, SHA-256, SHA-384, SHA-512, etc.
*   Based on the same Merkle–Damgård construction and Davies-Meyer compression function as SHA-1, but with larger internal state, more complex rounds, and larger output sizes.
*   **SHA-256**: 256-bit output, 32-bit words, 64 rounds.
*   **SHA-512**: 512-bit output, 64-bit words, 80 rounds.
*   **Status**: Currently considered secure.
### SHA-3
*   Result of a public competition held by NIST (2007-2012).
*   Designed by Bertoni, Daemen, Peeters, and Van Assche.
*   **Structure**: Based on a completely different design called the **Sponge Construction**. It is not vulnerable to the same attacks as Merkle–Damgård-based hashes (like length extension attacks).
*   **Status**: Secure. Standardized in 2015.
