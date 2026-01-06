User authentication is the process of verifying the identity of an individual. In essence, it's how a system confirms that "you are who you say you are." This is fundamentally important for security, ensuring that only authorized users can access resources.
There are three primary categories for proving identity:
*   **What you are (Behavioral and Physical Attributes):** This category relies on unique biological or behavioral characteristics.
    *   **Biometrics:** Fingerprints, iris recognition, voice patterns, facial recognition, and handwriting analysis are common examples. These provide a high degree of assurance but can be complex to implement and manage.
*   **What you have (Documents or Credentials):** This involves possessing a specific item that acts as a token of identity.
    *   **Credentials:** Identity cards, passports, driving licenses, magnetic cards, smart cards, hardware tokens (e.g., YubiKey), and cryptographic public keys (for digital certificates) fall into this category. These can be lost, stolen, or duplicated, making their security dependent on physical protection or strong cryptographic methods.
*   **What you know (Passwords or Personal Information):** This is the most common form of authentication, relying on secret information known only to the user.
    *   **Secrets:** Passphrases, personal identification numbers (PINs), and answers to security questions (e.g., "your mother’s maiden name") are typical examples. These are vulnerable to guessing, brute-force attacks, and social engineering.
## Attacks on Authentication Systems
Authentication systems are prime targets for attackers. Understanding common attack vectors is crucial for designing secure systems.
*   **Passive Attacker (Eavesdropping):** Eve, a passive attacker, aims to intercept and observe identity credentials as they are transmitted or stored. This can involve packet sniffing on a network or reading leaked data.
*   **Active Attacker:** Active attackers engage directly with the system, attempting to bypass or manipulate authentication mechanisms.
    *   **Impersonation:** Eve tries to pretend to be a legitimate user (e.g., Alice) to communicate with another party (e.g., Bob).
        *   _Example:_ `Bob(K) <--- "I am Alice" <--- Eve` (where `(K)` implies communication through a shared secret or channel Alice and Bob would use). This shows Eve intercepting Alice's attempted communication to Bob and posing as Alice.
    *   **Modification:** Eve alters the data exchanged between Alice and Bob after initial authentication or during an authenticated session.
        *   _Example:_ `Alice --- (K) "I am Alice" ---> Eve --- "I am Alice" (modified) ---> Bob`. Eve intercepts and changes the message, aiming to trick Bob.
    *   **Blocking/Denial of Service:** Eve actively prevents communication between Alice and Bob.
        *   _Example:_ `Alice --- (K) "I am Alice" ---X Eve`. Eve prevents Alice's message from reaching Bob.
    *   **Replay Attack:** Eve captures valid authentication credentials or session tokens and re-transmits them later to gain unauthorized access. This tricks the system into thinking the replayed data is a fresh, legitimate request.
    *   **Other Attacks:** Many other sophisticated attacks exist, such as phishing, man-in-the-middle attacks, and privilege escalation, all targeting various parts of the authentication process.
## Password Authentication
Password-based authentication is ubiquitous due to its simplicity, but it comes with significant challenges related to security.
*   **Basic Idea:** A user possesses a secret password, and the system verifies this password to grant access.
*   **Key Issues:**
    *   **Password Storage:** How is the password stored securely? Storing plaintext passwords is a severe security vulnerability.
    *   **Password Verification:** How does the system check the password without revealing the actual password?
    *   **Password Guessing:** How difficult is it for an attacker to guess a password, especially if they gain access to the password storage mechanism? Even if the password file is difficult to keep secret, individual passwords should be hard to guess.
### Basic Password-based Authentication Using Hashing
To mitigate the risks of storing plain text passwords, [[Hash-Function|hashing]] is commonly employed.
*   **Hash Function:** A cryptographic hash function `h: strings → strings` is used. This function takes an input (the password) and produces a fixed-size string of bytes (the hash value or digest).
    *   **Properties:** A good cryptographic hash function is one-way (difficult to reverse), collision-resistant (difficult to find two different inputs that produce the same output), and deterministic (always produces the same output for the same input).
*   **Security Principle:** Given `h(password)`, it should be computationally infeasible to find the original `password`. There should be no known algorithm better than brute-force guessing.
*   **Process:**
    1.  When a user sets a password, the system computes `h(password)` and stores this hash value in a password file. The original password is *not* stored.
    2.  When a user attempts to log in, they enter their password.
    3.  The system computes `h(entered_password)`.
    4.  The system compares `h(entered_password)` with the stored hash value from the password file. If they match, the user is authenticated.
*   **Properties of this Approach:**
    *   **Unidirectional Identification:** Only verifies the user's knowledge of the password; the system does not receive the actual password.
    *   **No Password Stored:** Enhances security as attackers cannot retrieve actual passwords even if they compromise the password file (they only get hashes).
    *   **Low Complexity:** Computationally and communication-wise efficient.
    *   **Key Management:** The "key" (password) is typically kept in the user's memory and stored as a hash in the system's password file.
### Weaknesses of Password Authentication
Despite hashing, password-based systems have inherent vulnerabilities:
*   **Replay Attacks/Credential Theft:**
    *   **Observation:** Observing typing (shoulder surfing).
    *   **Physical Theft:** Finding written passwords or credentials elsewhere.
    *   **Key Loggers:** Malicious software that records keystrokes.
    *   **Eavesdropping:** Intercepting credentials over a communication channel, even if hashed (a hashed password is still a credential that can be replayed if not protected by a challenge-response mechanism).
*   **Exhaustive Search / Brute-Force Attacks:**
    *   **Online Attacks:** Randomly or systematically trying passwords against an online verifier. These are usually rate-limited to prevent rapid guessing.
    *   **Offline Attacks:** If an attacker obtains the password file (containing hashes), they can perform offline brute-force attacks without rate limits. This highlights the importance of strong hashing algorithms (e.g., bcrypt, scrypt, Argon2) and salting to make each hash unique, even for identical passwords. A single weak password can compromise part of the system if the hash file is leaked.
*   **Password Guessing / Dictionary Attacks:** Attackers leverage common patterns:
    *   **Dictionaries:** Using lists of common words, names, or previously breached passwords.
    *   **Rainbow Tables:** Precomputed tables of hashes for common passwords.
    *   **Assumptions:** These attacks exploit the fact that many users choose easily guessable passwords, meaning not all passwords are equally likely.
## Challenge-Response Identification
Challenge-response protocols aim to prove knowledge of a secret without ever revealing the secret itself, addressing some weaknesses of simple password authentication.
*   **Objective:** Alice (the prover) convinces Bob (the verifier) that she knows a secret (`K`) without leaking `K` to Bob or any eavesdroppers.
*   **General Process:**
    1.  **Challenge:** The verifier (Bob) generates a unique, random challenge message (`r`) and sends it to the prover (Alice).
    2.  **Response:** The prover (Alice) receives `r`, uses her secret `K` to compute a response (`y`) based on both `r` and `K`, and sends `y` back to Bob.
    3.  **Verification:** The verifier (Bob) independently computes what the response `y'` *should* be, using `r` and his own knowledge of `K` (or a related public key). If `y = y'`, Bob accepts Alice's identity.
### Example: Shared Secret Key (MAC-based)
Let's assume Alice and Bob share a secret key `K`. They use a Message Authentication Code (MAC) function, `MAC_K(x)`, where `x` is the message and `K` is the secret key.
1.  **Alice's Claim:** Alice sends "I am Alice" to Bob.
2.  **Bob's Challenge:** Bob generates a random number `r` (the challenge, from a space of `2^L` possible values) and sends `r` to Alice.
    *   $r \leftarrow \{0,1\}^L$
3.  **Alice's Response:** Alice computes `y = MAC_K(r)` and sends `y` to Bob.
4.  **Bob's Verification:** Bob computes `MAC_K(r)` using his own secret key `K`. If his computed value matches the `y` received from Alice, he accepts Alice's identity. Otherwise, he rejects.
### Parallel Session Attack (Insecure Protocol)
Consider a scenario where Eve tries to impersonate Alice to Bob. If the protocol is `y = MAC_K(r)`, Eve might attempt to reuse a MAC.
*   **Problem:** If Eve can somehow obtain a valid `(r, y)` pair from a previous session where Alice responded `y = MAC_K(r)`, Eve could replay `y` for `r` to spoof Alice. Or, if Eve can initiate a session with Alice and observe `(r_A, y_A)`, she might try to use `(r_A, y_A)` to fool Bob.
### Secure Challenge-Response Identification
To counter the parallel session attack, the identity of the prover should be bound to the challenge-response.
1.  **Alice's Claim:** Alice sends "I am Alice" to Bob.
2.  **Bob's Challenge:** Bob generates a random `r` and sends `r` to Alice.
    *   $r \leftarrow \{0,1\}^L$
3.  **Alice's Response:** Alice computes `y = MAC_K(ID(Alice) || r)` where `ID(Alice)` is Alice's identifier and `||` denotes concatenation. Alice sends `y` to Bob.
4.  **Bob's Verification:** Bob computes `MAC_K(ID(Alice) || r)` using his secret key `K`. If his computed value matches the `y` received, he accepts Alice.
#### Security Analysis
*   **Target:** The goal is to confirm that the prover is indeed Alice, not an adversary Eve.
*   **Against Impersonation (Eve as Bob):**
    Imagine Eve tries to impersonate Bob to Alice.
    1.  Eve sends "I am Bob" to Alice.
    2.  Alice challenges Eve with a random `r'`.
    3.  Eve needs to respond with `y' = MAC_K(ID(Eve) || r')`. Without `K`, Eve cannot compute this.
*   **Parallel Session Attack Resilience:** If `MAC` is a secure message authentication code and challenges `r` are sufficiently long (e.g., `L` bits):
    1.  **Proof by Contradiction:** Assume Bob accepts an adversary (Eve) instead of Alice. Bob sends `r` and receives `y`.
    2.  **Case 1: `y = MAC_K(ID(Alice) || r)` was previously created by Bob.** This is impossible because Bob only computes MACs of the form `MAC_K(ID(Bob) || r)`, not `MAC_K(ID(Alice) || r)`.
    3.  **Case 2: `y` was previously created by Alice.** `r` is a *new, random* challenge from Bob. The probability that Bob coincidentally picks an `r` that Alice used in a specific previous session is `1/2^L`, which is negligible for a large `L`. Hence, replaying an old `(ID(Alice) || r, y)` pair is highly unlikely to succeed for a new `r`.
    4.  **Case 3: `y` is a new MAC created by Eve.** If Eve does not know `K`, she cannot compute a valid MAC due to the security properties of `MAC` functions (existential unforgeability against chosen-message attack). Therefore, Eve cannot successfully generate a new `y`.

## Mutual Authentication
Mutual authentication means both parties (e.g., Alice and Bob) prove their identities to each other simultaneously or sequentially.
*   **Goal:** Alice and Bob both want to be sure of each other's identity.
*   **Simple Challenge-Response Mutual Authentication (Insecure):**

    Alice(K)                                       Bob(K)
        "I am Alice" -------------->
        <-------------------------- `r_1` ($r_1 \leftarrow \{0,1\}^L$)
        `y_1` ($y_1 = MAC_K(ID(Alice) || r_1)$) ------>
           (If $y_1 = MAC_K(ID(Alice) || r_1)$ then accept Alice)
        <-------------------------- `y_2` ($y_2 = MAC_K(ID(Bob) || r_2)$), `r_2` ($r_2 \leftarrow \{0,1\}^L$)
           (If $y_2 = MAC_K(ID(Bob) || r_2)$ then accept Bob)

    **Insecurity:** This protocol is vulnerable to replay attacks. An adversary (Eve) can intercept a valid `(y_1, r_2)` pair from Alice to Bob and reuse `y_1` to impersonate Alice in another session, or `y_2` to impersonate Bob. This is because `r_1` is only for Alice's challenge, and `r_2` is only for Bob's challenge, making them easily separable.

*   **Improved Challenge-Response Mutual Authentication (Secure):**
    To prevent replay attacks in mutual authentication, challenges and responses must be bound together and include identifiers.

    Alice(K)                        Bob(K)
        "I am Alice" -------------->
        <-------------------------- `r_1` ($r_1 \leftarrow \{0,1\}^L$)
        `y_1` ($y_1 = MAC_K(ID(Alice) || r_1 || r_2)$) ------>
           `r_2` ($r_2 \leftarrow \{0,1\}^L$)
           (If $y_1 = MAC_K(ID(Alice) || r_1 || r_2)$ then accept Alice)
        <-------------------------- `y_2` ($y_2 = MAC_K(ID(Bob) || r_2)$)
           (If $y_2 = MAC_K(ID(Bob) || r_2)$ then accept Bob)

    **Security Analysis:**
    *   If `MAC` is secure and random challenges (`r_1, r_2`) are long enough (`L` bits), this protocol is a secure mutual identification protocol.
    *   **Proof:** `y_1` and `y_2` are computed differently (`y_1` incorporates `r_1` and `r_2`, while `y_2` only uses `r_2`). This makes it impossible for a `y_1` from one session to be reused as a `y_2` in another session, and vice-versa.
    *   **Eve's Role:** Eve cannot easily determine `y_1` or `y_2` without `K`. Even if Eve captures previous `(r_1, r_2, y_1)` or `(r_2, y_2)` values, they cannot be successfully replayed in a new session where `r_1'` or `r_2'` are different, due to the inclusion of fresh random challenges in the MAC calculation. Eve cannot compute a new MAC without knowing the shared secret `K`.

## Public-Key Identification

When Alice and Bob do not share a prior secret key, public-key cryptography can be used for identification.

*   **Scenario:** Alice proves to Bob that she possesses her private key, and Bob proves to Alice that he possesses his private key. The proof itself does not reveal the private keys.
*   **Methods:**
    *   **Biometrics, Bank Account, Credit Card:** These are typically handled by a trusted third party verification and are not directly public-key methods.
    *   **Cryptographic Proof:**
        *   **Public-key Setting:** Digital signatures are used. Only the holder of the private key can generate a valid signature for a given message. The verifier uses the public key to check the signature.
            *   _Process:_ Alice digitally signs a random challenge `r` sent by Bob using her private key. Bob verifies the signature using Alice's public key. This proves Alice owns the private key without revealing it.
        *   **Secret-key Setting:** Message Authentication Codes (MACs) are used (as seen above). This relies on a shared `K`; however, in the context of this section, it establishes a contrast. The existence of a shared `K` means either party could create MACs, thus the need for challenges and identifiers. In public-key, only the private key owner can sign.
*   **Analogy:** The text uses an image `![[Pasted image 20251113105347.png]]` which likely illustrates a specific public-key identification protocol, perhaps involving challenges and signed messages.

### Security Analysis of Public-Key Identification

*   If the digital signature scheme is secure (meaning it's existentially unforgeable), and random challenges (`L` bits in length) are used, the protocol is a secure mutual identification protocol.
*   **Proof:**
    *   Signatures generated by Alice and Bob are unique for each session because they typically incorporate fresh random values (challenges `r_1, r_2`) from each session. This prevents replay attacks, as an old signature for `r` will not be valid for a new `r'`.
    *   An adversary (Eve) cannot compute new valid signatures `y_1` or `y_2` without possessing the legitimate private keys of Alice or Bob, due to the unforgeability property of secure digital signature algorithms. Eve also cannot reuse old signatures because new challenges are used.

## Kerberos Authentication

Kerberos is a widely adopted network authentication protocol designed to provide strong authentication for client/server applications by using secret-key cryptography.

*   **Purpose:** Allows two users (or a client and server) to authenticate each other over an insecure network.
*   **Origins:** Originally developed at MIT for Project Athena.
*   **Standards:** Kerberos V5 is an Internet Standard (RFC 4120).
*   **Widespread Use:** Default authentication in Windows (2000/XP/Server 2003/Vista), Apple's macOS, and many UNIX/UNIX-like operating systems (FreeBSD, OpenBSD, Red Hat Enterprise Linux, Oracle Solaris, IBM AIX, HP-UX, OpenVMS).
*   **Centralized Server:** Uses a trusted third party, a centralized Authentication Server (AS) and a Ticket Granting Server (TGS), to authenticate users.
*   **Authentication Flow:**
    1.  User authenticates to the AS.
    2.  Once authenticated, the user receives "tickets" to access services on other servers distributed throughout the network.
    3.  Servers then authenticate users based on these tickets and authorize access.
*   **Key Principles:**
    *   Relies exclusively on **symmetric-key encryption** (no public-key encryption in its core design, though hybrid systems exist).
    *   Based on **session key distribution** and **password authentication**.
*   **Versions:**
    *   **Version 4:** Older, primarily used DES (Data Encryption Standard).
    *   **Version 5:** Modern, corrects security deficiencies of V4 and offers more flexibility.

### Threats Kerberos Mitigates

Kerberos is designed to prevent various network security threats:

*   **Impersonation:** Prevents an attacker from gaining access to a server and pretending to be another legitimate user.
*   **Spoofing:** Protects against altering network addresses to make requests appear from an impersonated computer.
*   **Eavesdropping:** Uses encryption to render intercepted communications unintelligible.
*   **Replay Attacks:** Incorporates mechanisms (like timestamps and authenticators) to prevent replay of captured authentication data.

### Kerberos Design Goals

Kerberos was designed with specific attributes in mind:

| Goal        | Description                                                                                                                                                                                            |
| :---------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Secure**  | Prevent impersonation, eavesdropping, spoofing, and replay attacks. Achieved through cryptographic principles and strict protocol design.                                                               |
| **Reliable**| Should be highly reliable and (in V5) employ a distributed server architecture to ensure availability and fault tolerance.                                                                                |
| **Scalable**| Must support a large number of clients and servers within an enterprise environment without performance degradation.                                                                                     |
| **Transparent** | The authentication process should be largely invisible to the user beyond an initial password entry. Users should not need to interact with the underlying cryptographic mechanisms.              |

### Kerberos Components and Tickets

The process involves several key components, often visualized in a diagram like `![[Pasted image 20251113120145.png]]`.

*   **Authentication Server (AS):** Authenticates the initial user request and issues a Ticket-Granting Ticket.
*   **Ticket-Granting Server (TGS):** Issues Service-Granting Tickets for specific application servers.
*   **Ticket-Granting Ticket (TGT - `ticket_{tgs}`):**
    *   **Creation:** Issued by the AS after the user's initial authentication.
    *   **Content:** Contains the user's ID, network address, and the TGS's ID.
    *   **Encryption:** Encrypted using a key `K_{tgs}` shared between the AS and the TGS. This ensures only the TGS can decrypt and verify it. The TGT itself is also encrypted using a key `K_c` derived from the user's password, meant for the client to hold securely.
    *   **Usage:** The client presents this TGT to the TGS when requesting access to a new service.
*   **Service-Granting Ticket (SGT - `ticket_v`):**
    *   **Creation:** Issued by the TGS after successfully verifying the TGT.
    *   **Content:** Contains the user's ID, network address, and the specific application server's ID (`V`).
    *   **Encryption:** Encrypted using a key `K_v` shared between the TGS and the application server (`V`).
    *   **Usage:** The client uses this SGT to authenticate directly to the application server for each service request.

### Kerberos V4 Weaknesses

Kerberos V4 had several security and operational limitations:

*   **Ticket Capture Vulnerability:** An attacker could capture tickets (e.g., in steps 3 and 5 of a typical Kerberos exchange) and reuse them before they expire. This highlights the need for stronger protection against replay.
*   **Proof of Ownership:** V4 lacked robust mechanisms for the TGS and AS to verify that the person using a ticket was indeed the original recipient.
*   **Ambiguous Lifetime:** Determining the appropriate lifetime for TGTs and SGTs was complex and prone to errors.
*   **Server Authentication:** V4 did not inherently provide strong mechanisms for servers to authenticate themselves to users, leading to potential man-in-the-middle attacks where a malicious server could impersonate a legitimate one.

### Kerberos V5 Improvements
(Diagram: ![[Pasted image 20251113120529.png]])

Kerberos V5 significantly improved upon V4, addressing both environmental and technical shortcomings. The accompanying diagram `Pasted image 20251113120529.png` illustrates the more complex message exchange involving `Kc,tgs` (client-TGS session key) and `Kc,v` (client-server session key) distribution, and the role of authenticators.

#### Environmental Shortcomings Addressed by V5:

*   **Encryption System Dependence:**
    *   **V4:** Tied to DES encryption.
    *   **V5:** Designed to be extensible, allowing the use of any encryption technique, enhancing adaptability to newer, stronger algorithms.
*   **Internet Protocol Dependence:**
    *   **V4:** Primarily relied on IP addresses for client identification.
    *   **V5:** Supports any network address type, making it more flexible in diverse networking environments.
*   **Ticket Lifetime:**
    *   **V4:** Had a fixed maximum lifetime (e.g., 1280 minutes).
    *   **V5:** Tickets include explicit start and end times, allowing for arbitrary and more granular lifetime management.
*   **Authentication Forwarding (Delegation):**
    *   **V4:** A ticket was generally for one client accessing one server.
    *   **V5:** Introduced mechanisms for ticket forwarding, enabling a client to delegate credentials to a service, or for a service to act on behalf of a client to access other services. This allows for more complex, multi-tiered application architectures.

#### Technical Deficiencies Addressed by V5:

*   **Double Encryption:** V4 sometimes involved tickets being encrypted twice.
    *   **V5:** Streamlined encryption processes to avoid unnecessary or redundant encryption.
*   **PCBC Encryption:** V4 used PCBC (Propagating Cipher Block Chaining), a non-standard mode of DES, which was found to be vulnerable to specific attacks.
    *   **V5:** Moved to standard, cryptographically secure modes of operation.
*   **Session Keys:** In V4, the same `ticket_v` (containing `K_c,v`) could be reused repeatedly, increasing the window of opportunity for replay if the ticket was compromised.
    *   **V5:** Introduced authenticators and stricter session key management to ensure freshness and prevent reuse. The diagram shows `Authenticators` added to assure the sender of the ticket is its real owner.
*   **Password Attacks:** While Kerberos inherently requires password-based initial authentication, V4 suffered from vulnerabilities related to dictionary and brute-force attacks against the initial password hash.
    *   **V5:** Implemented stronger password hashing algorithms and provided mechanisms for pre-authentication against password attacks.
    *   **Mutual Authentication:** V5 explicitly added mutual authentication of client and server, where the server returns an encrypted value (e.g., incremented timestamp from the client's authenticator) to prove its identity to the client. This is crucial for preventing malicious servers from impersonating legitimate ones.

    *   **Key Exchange:** AS provides client `C` and TGS with a shared secret `K_{c,tgs}`. TGS provides client `C` and server `V` with a shared secret `K_{c,v}`.
    *   **Transparency:** `ID_{tgs}`, timestamps, and ticket lifetimes are accessible to the client, allowing the client to verify ticket validity.
    *   **Authenticators:** Added to ensure the sender of the ticket is its legitimate owner, preventing simple replay.
    *   **Mutual Verification:** The server returns an encrypted timestamp (from the authenticator), incremented by 1, to confirm its identity to the client.
