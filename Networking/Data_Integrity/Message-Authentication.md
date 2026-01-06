**Message Authentication**: Verifying the authenticity and integrity of received messages. This includes confirming that the message originated from the claimed sender, has not been altered in transit, and is received in the correct order and timeliness.
To achieve message authentication, an **authentication tag** is generated. This tag is a value used to authenticate the message. The primary methods for generating these tags are:
*   **Message Authentication Code (MAC)**
*   **Digital Signature**
## Message Authentication Code (MAC)
A Message Authentication Code (MAC) system can be formally defined as a four-tuple $I = (M, T, K, H)$, where:
*   $M$: A set of all possible messages that can be authenticated.
*   $T$: A finite set of all possible authentication tags (MACs).
*   $K$: The key space, a finite set of all possible secret keys.
*   $H$: A family of functions. For each key $k \in K$, there is a specific function $H_k \in H$, such that $H_k: M \to T$. This function takes a message from $M$ and produces an authentication tag from $T$
A MAC is essentially a **keyed hash function**, denoted as $H_k: M \to T$. Unlike unkeyed hash functions ($H: M \to T$), a MAC requires a secret key for its computation. It produces a fixed-length value (the MAC) from a message using a key-controlled public function (the MAC function).
![[Pasted image 20251112091047.png]]
The security of MAC relies on a shared secret key between the sender (Alice) and the receiver (Bob). If only Alice and Bob know the secret key $k$, and Bob verifies that the MAC of the received message is consistent with the MAC he computes, then:
*   **Integrity**: Bob can be confident that the message sent by Alice has not been tampered with during transmission. Any alteration would likely result in a different MAC.
*   **Authenticity**: Bob can be confident that the message indeed originated from Alice, as only she possesses the secret key required to generate the correct MAC.
It's important to note that **MAC provides authentication and integrity without necessarily providing confidentiality**. This means the message content itself might be readable by an eavesdropper, but its origin and integrity are assured.
**Examples of MAC usage**:
*   Protecting public binaries on disk from unauthorized modification.
*   Protecting banner ads on web pages to ensure they haven't been swapped or altered.
![[Pasted image 20251112091217.png]]
### MAC Algorithm (One-key MAC)
One widely used message authentication code algorithm is based on the **[[Data-Encryption-Standard|DES]] algorithm in CBC (Cipher Block Chaining) mode**. This is often referred to as **CBC-MAC**.
*   **Initialization Vector (IV)**: The initial vector for the CBC mode is typically set to a zero vector.
*   **Data Division**: The message data is divided into fixed-size blocks, for example, 64-bit blocks $D_1, D_2, \dots, D_N$.
*   **Padding**: If the last block is shorter than the required block size (e.g., less than 64 bits), it is padded with zeros on the right to reach the full block size.
The process involves encrypting each block in CBC mode, and the final ciphertext block (or a part of it) serves as the MAC.
![[Pasted image 20251112091425.png]]
### Attacks on MAC
Attackers can attempt to compromise MAC systems in several ways:
1.  **Exhaustive Search Attack to Find the Secret Key**:
    An attacker might try to find the secret key $K$ by trying all possible keys. This is a brute-force attack.
    Consider a scenario where an adversary has a message $M$ and its corresponding MAC, $C_K(M)$. The goal is to find the key $K$.
    *   **Round 1**: Given $M_1$ and $MAC_1 = C_K(M_1)$, the attacker calculates $MAC_i = C_{K_i}(M_1)$ for all $2^k$ possible keys $K_i$. This process will yield a subset of candidate keys, approximately $2^{k-n}$ keys, where $k$ is the key length and $n$ is the MAC length.
    *   **Round 2**: Given a second message $M_2$ and its MAC $MAC_2 = C_K(M_2)$, the attacker takes the $2^{k-n}$ candidate keys from Round 1 and calculates $MAC_i = C_{K_i}(M_2)$ for each. This further reduces the number of possible keys to approximately $2^{k-2n}$.
    *   This process continues. If $k = \alpha n$, then on average, $\alpha$ rounds are needed to find the correct key.
    **Example**: If the key length $k$ is 80 bits and the MAC length $n$ is 32 bits:
    *   Round 1: Approximately $2^{80-32} = 2^{48}$ possible keys remain.
    *   Round 2: Approximately $2^{48-32} = 2^{16}$ possible keys remain.
    *   The correct key $K$ can likely be found in Round 3.

2.  **Forgery Attacks (without finding the key)**:
    Some attacks don't require finding the secret key. An attacker might try to forge a valid message-MAC pair.
    Consider a MAC based on ECB-DES, where the key size is 56 bits and the MAC size is 64 bits.
    Let $M = (X_1 \Vert X_2 \Vert \dots \Vert X_m)$, where each $X_i$ is a 64-bit block.
    A common construction for a MAC in this context might involve XORing all blocks and then encrypting the result:$$
    \begin{aligned}
    \triangle(M) &= X_1 \oplus X_2 \oplus \dots \oplus X_m \\
    C_K(M) &= E_K[\triangle(M)]
    \end{aligned}
    $$
    Here, $E_K$ represents the DES encryption function with key $K$.
    If an adversary obtains $M \Vert C_K(M)$, they could attempt an exhaustive search for the key, which would require $2^{56}$ encryptions.
    However, an adversary might also try to forge a new message $M'$ such that $M$ and $M'$ have the same MAC, i.e., $C_K(M') = C_K(M)$.
    **Assumptions for a secure MAC**:
    *   If the adversary knows the MAC algorithm $C$ but not the key $K$, recovering $K$ from $M$ and $C_K(M)$ should be computationally infeasible.
    *   If the adversary knows $M$ and $C_K(M)$, constructing a new message $M'$ such that $C_K(M') = C_K(M)$ should also be computationally infeasible.
    *   The MAC values should be uniformly distributed: For two randomly selected messages $M$ and $M'$, the probability that their MACs are equal, $Pr[C_K(M) = C_K(M')]$, should be approximately $2^{-n}$, where $n$ is the size of the MAC. This indicates that collisions are rare and difficult to engineer.
