## Web Security Challenges
HTTP, as a simple and stateless client/server application running over TCP/IP, was not designed with inherent security mechanisms. This led to significant vulnerabilities for web communication, necessitating additional security measures.
### Threats and Countermeasures
Common threats to web security and their cryptographic countermeasures:
*   **Integrity:**
    *   **Threat:** Data modification or insertion during transit.
    **Countermeasure:** Cryptographic checksums, primarily through Hash-based Message Authentication Codes (HMACs), ensure that data has not been tampered with.
*   **Confidentiality:**
    *   **Threat:** Eavesdropping on network traffic.
    **Countermeasure:** Encryption prevents unauthorized access to data in transit. While encryption protects data in motion, physical security and encryption at rest are still crucial to prevent theft from server machines.
*   **Authentication:**
    *   **Threat:** Impersonation (e.g., man-in-the-middle attacks) and data forgery.
    **Countermeasure:** Various cryptographic techniques, such as digital certificates and digital signatures, are used to verify the identities of communicating parties.
Outside the Scope of TLS:
*   **Availability:**
    *   **Threat:** Denial of Service (DoS) attacks, hacked web servers.

### Where to Provide Security?
The optimal layer for providing security has been a subject of ongoing discussion. Security can be implemented at various layers of the network stack, each with its own advantages and disadvantages.

![[Pasted image 20251209102052.png]]

## SSL (Secure Socket Layer) and TLS (Transport Layer Security) Evolution
SSL was the predecessor to TLS, and both aim to provide privacy and data integrity between two communicating applications. They are most commonly known for securing HTTP traffic (HTTPS) but also support other TCP/IP applications like POP3, SMTP, and FTP.

*   **SSL 1.0:** An internal Netscape design from early 1994, never publicly released due to significant flaws.
*   **SSL 2.0:** Published by Netscape in November 1994. It had major security vulnerabilities and is now considered badly broken.
*   **SSL 3.0:** Designed by Netscape and Paul Kocher, released in November 1996. It significantly improved upon SSL 2.0 and formed the basis for the first version of TLS.
*   **TLS 1.0 (RFC 2246):** An Internet standard based on SSL 3.0, published in January 1999. It aimed to provide privacy and data integrity between two communicating applications.
*   **TLS 1.1 (RFC 4346):** Defined in April 2006. It added protection against Cipher-Block Chaining (CBC) attacks.
*   **TLS 1.2 (RFC 5246):** Defined in August 2008. Key improvements include:
    *   Replaced the MD5-SHA-1 hash combination with SHA-256 for integrity.
    *   Added support for TLS Extensions.
    *   Incorporated AES cipher suites.
*   **TLS 1.3 (RFC 8446):** Defined in August 2018. A major overhaul with significant security and performance enhancements:
    *   Removed support for older, weaker cryptographic hash functions (MD5 and SHA-224).
    *   Encrypts all handshake messages after the ServerHello, greatly enhancing privacy.
    *   Streamlined the handshake process to reduce latency.

## Key TLS Concepts

### TLS Session
A TLS session is an association between a client and a server that defines a set of cryptographic parameters. These parameters are created by the Handshake Protocol and can be shared by multiple TLS connections. Sessions are designed to avoid expensive renegotiation of cryptographic parameters for each new connection.

### TLS Connection
A TLS connection is a transient, peer-to-peer, secure communication link or channel. It is associated with (and derived from) a TLS session. Connections are typically short-lived, and servers often configure timeouts for idle connections. A single session can be used to establish several connections, amortizing the cost of the initial handshake.

## TLS Protocol Stack
TLS is not a single protocol but rather a two-layer protocol stack that operates on top of TCP. It adds security features to TCP's reliable end-to-end data transfer, resulting in a reliable and secure channel.

### TLS Record Protocol
The TLS Record Protocol serves to build TLS connections and provides two fundamental security services: confidentiality and integrity.

*   **Confidentiality:** Achieved through conventional (symmetric-key) encryption of TLS payloads using a shared secret key negotiated during the handshake. Supported algorithms include AES, IDEA, DES, 3DES, RC4, etc.
*   **Message Integrity:** Achieved using a Hash-based Message Authentication Code (HMAC) with a shared secret key. The HMAC ensures that the data has not been altered in transit.
    The HMAC calculation is defined as:
    $$
    \text{HMAC}(K, M) = H((K^+ \oplus \text{opad}) \mathbin\Vert H((K^+ \oplus \text{ipad}) \mathbin\Vert M))
    $$
    Where:
    *   $H$: The hash function (e.g., SHA-1, SHA-256).
    *   $M$: The message input to HMAC.
    *   $K^+$: The secret key $K$ padded with zeros to be equal to the block length of the hash function $H$.
    *   ipad: Inner pad, a repeating block of `0x36` (binary `00110110`) for the block length of $H$.
    *   opad: Outer pad, a repeating block of `0x5C` (binary `01011100`) for the block length of $H$.
    *   $\mathbin\Vert$: Concatenation.
    *   $\oplus$: Exclusive OR.

![[Pasted image 20251209102344.png]]

**TLS Record Protocol Fields:**
*   **Content Type (8 bits):** Indicates the higher-layer protocol (e.g., Handshake, Alert, ChangeCipherSpec, Application Data) used to process the enclosed fragment.
*   **Major Version (8 bits):** Indicates the major version of TLS in use (e.g., 3 for TLS 1.x). Note that SSL 2.0 used major version 2.
*   **Minor Version (8 bits):** Indicates the minor version of TLS in use (e.g., 1 for TLS 1.0, 2 for TLS 1.1, 3 for TLS 1.2). Note that SSL 2.0 used major version 2.
*   **Compressed Length (16 bits):** The length in bytes of the plaintext fragment (or compressed fragment if compression is used).

### TLS Handshake Protocol
The Handshake Protocol is the most complex part of TLS. Its primary purpose is to allow the server and client to:
*   Authenticate each other.
*   Negotiate the encryption and MAC algorithms (cipher suite).
*   Create cryptographic keys to be used for the secure connection.
*   Establish a TLS session and subsequently a connection.
The handshake must complete successfully before any application data can be transmitted securely. It involves a series of messages exchanged between the client and server. Each handshake message has a common structure:
*   **Type (1 byte):** Indicates one of the 10 defined handshake message types.
*   **Length (3 bytes):** The length of the message's `Content` field in bytes.
*   **Content (variable length):** The parameters associated with this specific message.

![[Pasted image 20251209103301.png]]
The handshake process is divided into four logical phases:
1.  **Phase 1: Establish Security Capabilities**
    *   **Client Hello:** The client initiates the handshake by sending a `Client Hello` message, proposing security capabilities.
        *   **Protocol Version:** The highest TLS version supported by the client (e.g., SSL 3.0: major=3, minor=0; TLS 1.0: major=3, minor=1).
        *   **Random Number (32 bytes):** A randomly generated value, typically with the first 4 bytes being the current time in seconds, and the remaining 28 bytes being cryptographically random. This helps prevent replay attacks.
        *   **Session ID (optional):** If the client wants to resume an earlier session.
        *   **Cipher Suites:** A list of cryptographic algorithms combinations supported by the client, in order of preference.
        *   **Compression Algorithm:** A list of compression algorithms supported.
    *   **Server Hello:** The server responds with a `Server Hello` message, choosing the common security capabilities.
        *   **Protocol Version:** The highest version supported by both client and server.
        *   **Random Number:** Another random number from the server, also used to prevent replay attacks and contribute to key generation.
        *   **Session ID:** If resuming a session, the existing ID; otherwise, a new one.
        *   **Cipher Suite:** The single cipher suite chosen by the server from the client's list.
        *   **Compression Method:** The chosen compression method.

    *Example of a Cipher Suite:* `TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA_384`
    *   `TLS`: Protocol (Transport Layer Security)
    *   `ECDHE`: Key Exchange Algorithm (Elliptic Curve Diffie-Hellman Ephemeral)
    *   `ECDSA`: Authentication Algorithm (Elliptic Curve Digital Signature Algorithm)
    *   `AES_256_GCM`: Symmetric Cipher (Advanced Encryption Standard, 256-bit key, Galois/Counter Mode)
    *   `SHA_384`: Hash/MAC Algorithm (Secure Hash Algorithm, 384-bit output)

2.  **Phase 2: Server Authentication and Key Exchange**
    *   **Certificate (optional):** The server sends its digital certificate (or a certificate chain) to the client. This typically contains the server's public key and is verified by the client using trusted Certificate Authorities (CAs).
    *   **Server Key Exchange (optional):** Sent if the public key in the Certificate is not sufficient for key exchange (e.g., if a Diffie-Hellman parameter exchange is needed).
    *   **Certificate Request (optional):** If the server requires client authentication, it sends a certificate request.
    *   **Server Hello Done:** The server signals that it has finished its part of the initial handshake messages.

3.  **Phase 3: Client Authentication and Key Exchange**
    *   **Certificate (optional):** The client sends its certificate chain if requested by the server.
    *   **Client Key Exchange:** The client generates a `Pre-Master Secret` (or other key exchange parameters depending on the cipher suite) and encrypts it with the server's public key (obtained from the server's certificate). This `Pre-Master Secret` is then used by both parties to derive the `Master Secret`, which in turn generates the MAC key, encryption key, and IVs.
    *   **Certificate Verify (optional):** If the client sent a certificate for authentication, it uses its private key to sign a hash of the handshake messages. The server verifies this signature using the client's public key to authenticate the client.

4.  **Phase 4: Finish Handshake Protocol**
    *   **Change Cipher Spec:** Both client and server send `Change Cipher Spec` messages. This is a separate protocol (not part of the Handshake Protocol itself, but closely linked) that signals a transition from pending cryptographic parameters to the newly negotiated and established "current" parameters. After this message, all subsequent communication will use the new cipher suite and keys.
    *   **Finished:** Both client and server send `Finished` messages. These are encrypted and MACed using the newly established keys. This message serves as a final verification that the handshake was successful and that both parties have correctly derived the same cryptographic keys.

After the `Finished` messages, the client and server can begin to communicate encrypted application data using the symmetric encryption algorithm and cryptographic hash function negotiated, along with the secret key established during the handshake.

### Change Cipher Spec Protocol
The `Change Cipher Spec Protocol` is a very simple protocol. The state established by the handshake protocol is initially a "pending state." This protocol, essentially a single command exchanged between client and server, makes this pending state the "current state." This means that after this message, all subsequent Record Protocol traffic will be encrypted and integrity-protected using the newly negotiated cipher suite and keys.

### Alert Protocol
The `Alert Protocol` is used to convey TLS-related alerts (warnings or fatal errors) to the peer entity. These messages are themselves secured using the Record Protocol.
*   Each alert message is two bytes long:
    *   **Level (1 byte):** Indicates the severity.
        *   `warning`: The connection may resume after the alert.
        *   `fatal`: The connection is terminated immediately.
    *   **Alert Code (1 byte):** Specifies the nature of the alert (e.g., `unexpected_message`, `bad_record_mac`, `decompression_failure`, `handshake_failure`, `illegal_parameter`, `no_certificate`, `bad_certificate`, `unsupported_certificate`, `certificate_revoked`, `certificate_expired`, `certificate_unknown`).

### Heartbeat Protocol
The `Heartbeat Protocol` was a relatively new extension to TLS, defined in 2012. A heartbeat is a periodic signal or message exchanged to probe the availability of the other party.

*   **Operation:** The Heartbeat protocol runs on top of the TLS Record Protocol (part of the upper layer of TLS). It includes `heartbeat_request` and `heartbeat_response` messages. A `heartbeat_request` includes a payload length, payload data, and padding. The `heartbeat_response` is supposed to return an exact copy of the received payload.
*   **Purposes:**
    *   **Liveliness Check:** The sender confirms that the receiver is still active and reachable.
    *   **Connection Keep-Alive:** Generates traffic to prevent idle connections from being closed by network devices (e.g., firewalls, NATs).
*   **Vulnerability:** A critical vulnerability (Heartbleed) was discovered in the implementation of this protocol, where a malicious client could request a heartbeat with a false payload length, tricking the server into revealing portions of its memory.

## From TLS 1.2 to TLS 1.3
TLS 1.3 represents a significant step forward in security and performance compared to TLS 1.2.

![[Pasted image 20251209103531.png]]

Key changes and improvements in TLS 1.3:
*   **Reduced Handshake Latency:** Handshake messages are significantly streamlined, reducing the number of round trips required to establish a secure connection (often to just one round trip, 0-RTT for resumed connections).
*   **Enhanced Security:**
    *   Removed support for many legacy and insecure features and algorithms (e.g., SHA-1, MD5, RSA key exchange, static Diffie-Hellman, DES, 3DES, RC4, arbitrary DH groups).
    *   Required forward secrecy by mandating ephemeral key exchange for all connections.
    *   Encrypts more of the handshake, protecting client identities and other sensitive parameters.
*   **Simpler Configuration:** Reduced complexity due to the removal of many options, making it easier to configure securely.
*   **Modern Cryptography:** Focuses on modern authenticated encryption with associated data (AEAD) ciphers (e.g., AES-GCM, ChaCha20-Poly1305).

The overall goal of TLS 1.3 was to create a faster, more secure, and less error-prone protocol.
