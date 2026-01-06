IPsec is a suite of protocols defined by the Internet Engineering Task Force (IETF) to secure Internet Protocol (IP) communications. It provides cryptographic protection for IP packets, addressing key weaknesses in IPv4.
## TCP/IP Protocol Suite and Encapsulation
The TCP/IP architecture encapsulates data from upper layers by attaching a header for the current-layer protocol to the data. This layering allows for modular communication, but also presents security challenges.

### IPv4 Weaknesses
Original IPv4 had several inherent security vulnerabilities:
*   **Source/Destination Address Modification:** Attackers could easily spoof source and destination IP addresses.
*   **Data Tampering:** The contents of data packets could be viewed, modified, or deleted in transit without detection.
*   **Packet Replay Attacks:** Captured packets could be retransmitted by an attacker to disrupt services or impersonate legitimate users.

## Security Protocols (IPsec Overview)
IPsec was standardized in 1995 to provide security extensions to IP.
Its primary goal is to authenticate and encrypt data packets, enabling secure encrypted communication between two computers or networks over an IP network.

![[Pasted image 20251209095324.png]]

Key services provided by IPsec include:
*   **Authentication:** Verifying the identity of the sender and ensuring data integrity.
*   **Confidentiality:** Protecting data from eavesdropping through encryption.
*   **Key Agreement:** Securely establishing shared secret keys for cryptographic operations.

## Core IPsec Components
IPsec is comprised of several protocols and mechanisms:
*   **Authentication Header (AH):** An extension header designed to provide connectionless integrity and data origin authentication for IP datagrams.
*   **Encapsulating Security Payload (ESP):** Consists of an encapsulating header and trailer used to provide encryption and optionally authentication services.
*   **Internet Key Exchange (IKE):** The protocol used for key management, facilitating the secure exchange and negotiation of cryptographic keys and Security Associations (SAs).
*   **Cryptographic Algorithms:** IPsec utilizes various cryptographic algorithms for encryption (e.g., AES, 3DES), message authentication (e.g., HMAC-SHA, HMAC-MD5), pseudorandom functions (PRFs), and cryptographic key exchange (e.g., Diffie-Hellman).

![[Pasted image 20251209095540.png]]

## IPsec Modes of Operation
IPsec operates in two main modes: Transport Mode and Tunnel Mode.
### Transport Mode
*   **Protection for Upper-Layer Protocols:** Provides protection primarily for higher-layer protocols (e.g., TCP, UDP, ICMP).
*   **Scope:** The AH authenticates the IP payload and selected portions of the IP header. ESP encrypts and optionally authenticates the IP payload but **does not** protect the IP header itself.
*   **Application:** Typically used for end-to-end communication between two hosts.
### Tunnel Mode
*   **Protection for Entire IP Packet:** Provides protection for the entire original IP packet.
*   **Encapsulation:** The entire original IP packet (including its header) is treated as the payload of a new, outer IP packet. A new outer IP header is added.
*   **Router Obscurity:** Intermediate routers along the path are unable to examine the inner IP header, as it is encrypted (if ESP is used).
*   **Scope:** AH authenticates the entire inner IP packet and selected portions of the outer IP header. ESP encrypts and optionally authenticates the entire inner IP packet, including the inner IP header.
*   **Application:** Commonly used between security gateways (e.g., routers or firewalls) to create Virtual Private Networks (VPNs).

### Tunnel Mode IPsec Operations (Example with Gateways)
1.  **Host A generates an IP packet** to Host B. The packet has Host A's source IP and Host B's destination IP.
2.  **Host A's Gateway:** The packet is routed from Host A to its network's gateway. The gateway filters outgoing packets to determine if IPsec protection is required.
3.  **IPsec Processing at Gateway:** The gateway performs IPsec processing, encapsulating the original packet within a new outer IP header. The source IP address of this outer packet is the gateway itself, and the destination address is B's gateway.
4.  **Routing to B's Gateway:** The encapsulated packet is routed across the internet to Host B's gateway.
5.  **IPsec Processing at B's Gateway:** B's gateway examines the outer IP header, performs IPsec processing (decryption and authentication), and strips off the outer header.
6.  **Forwarding to Host B:** B's gateway forwards the original (now protected) packet to Host B.

## Security Associations (SA)
A Security Association (SA) is a fundamental concept in IPsec. It represents a one-way logical connection between a sender and a receiver, defining how security services will be applied to communicate securely.

*   **Unidirectional:** A single SA protects data in only one direction. For bidirectional communication, two SAs are required.
*   **Security Properties:** SAs specify the cryptographic algorithms, keys, and other parameters that communicating hosts will use.
*   **Creation:** SAs are typically created and managed by the Internet Key Exchange (IKE) protocol.

### Components of an SA
A security association for key management contains:
*   **Key Material:** Keys used for encryption and authentication.
*   **Algorithms:** Specification of the encryption, authentication, and PRF algorithms to be used.
*   **Endpoint Identities:** Identities of the communicating parties.
*   **Other Parameters:** Lifetimes, mode (transport/tunnel), etc.

### Security Parameters Index (SPI)
*   A 32-bit unsigned integer assigned to an SA.
*   Carried in AH and ESP headers.
*   Enables the receiving system to uniquely identify the SA under which a received packet will be processed.

### SA Identification
An SA is uniquely identified by:
1.  **IP Destination Address:** The address of the SA's destination.
2.  **Security Protocol Identifier:** Indicates whether the SA is for AH or ESP.
3.  **SPI:** The Security Parameters Index.

## IPsec General Architecture
![[Pasted image 20251209095825.png]]
## Security Association Database (SAD)
The SAD stores parameters associated with each active SA. Each entry in the SAD typically includes:
*   **Security Parameter Index (SPI):** A 32-bit value to uniquely identify the SA.
*   **Sequence Number Counter:** A 32-bit counter used in AH/ESP headers to prevent replay attacks.
*   **Sequence Counter Overflow:** A flag indicating how to handle counter overflow (e.g., generate an audit event, prevent further transmission).
*   **Anti-Replay Window:** A window used to detect and discard replayed inbound AH or ESP packets.
*   **AH Information:** Details of the authentication algorithm, keys, key lifetimes, and related parameters if AH is used.
*   **ESP Information:** Details of the encryption and authentication algorithms, keys, initialization values (IVs), key lifetimes, and related parameters if ESP is used.
*   **Lifetime:** A time interval or byte count after which an SA must be replaced or terminated.
*   **IPsec Protocol Mode:** Whether the SA operates in Tunnel, Transport, or Wildcard mode.
*   **Path MTU:** The observed Path Maximum Transmission Unit.

## Security Policy Database (SPD)
The SPD defines the policy for IP traffic and determines which IP traffic is subject to IPsec processing.
*   **Entries:** Each entry in the SPD defines a subset of IP traffic and points to an SA (or set of SAs) for that traffic.
*   **Selectors:** A set of IP and upper-layer protocol field values used to filter outgoing traffic and map it to a particular SA.

### SPD Selectors
Common selectors include:
*   **Remote IP Address:** The destination IP address or range.
*   **Local IP Address:** The source IP address or range.
*   **Next Layer Protocol:** The protocol operating over IP (e.g., TCP, UDP, ICMP).
*   **Name:** A user identifier from the operating system (e.g., for user-specific policies).
*   **Local and Remote Ports:** TCP or UDP port values.

### SPD Example
| Protocol | Local IP    | Port | Remote IP   | Port | Action    | Comment               |
| :------- | :---------- | :--- | :---------- | :--- | :-------- | :-------------------- |
| UDP      | 1.2.3.101   | 500  | `*`         | 500  | BYPASS    | IKE (Key Exchange)    |
| ICMP     | 1.2.3.101   | `*`  | `*`         | `*`  | BYPASS    | Error Messages        |
| `*`      | 1.2.3.101   | `*`  | 1.2.3.0/24  | `*`  | PROTECT: ESP | In transport-mode, encrypt intranet traffic |
| TCP      | 1.2.3.101   | `*`  | 1.2.4.10    | 80   | PROTECT: ESP | In transport-mode, encrypt to server |
| TCP      | 1.2.3.101   | `*`  | 1.2.4.10    | 443  | BYPASS    | TLS: avoid double encryption |
| `*`      | 1.2.3.101   | `*`  | 1.2.4.0/24  | `*`  | DISCARD   | Others in DMZ         |
| `*`      | 1.2.3.101   | `*`  | `*`         | `*`  | BYPASS    | Internet              |
## IPsec Traffic Processing
### Outbound Packets
1.  A block of data from a higher layer (e.g., TCP) is passed down to the IP layer.
2.  An IP packet is formed, consisting of an IP header and an IP body.
3.  The IPsec layer intercepts the packet, consults the SPD to determine if it needs protection, and then applies the appropriate SA(s) if required, performing encapsulation or adding AH/ESP headers.

![[Pasted image 20251209100141.png]]

### Inbound Packets
1.  An incoming IP packet triggers the IPsec processing.
2.  The IPsec layer identifies the SA using the SPI in the AH/ESP header and the destination IP address.
3.  It performs decryption and authentication based on the SA parameters, verifies the anti-replay window, and then passes the processed packet up to the higher layers.

![[Pasted image 20251209100205.png]]

<h2>Authentication Header (AH)</h2>
The Authentication Header provides integrity and authentication for IP packets.
**AH Header Fields:**
*   **Next Header:** Specifies the next header or upper-layer protocol.
*   **Payload Length:** Specifies the length of the AH header itself, in 32-bit words, minus 2.
*   **Reserved:** For future use.
*   **SPI (Security Parameters Index):** Identifies the Security Association.
*   **Sequence Number:** A monotonically increasing 32-bit counter used to prevent replay attacks.
*   **Authentication Data (ICV):** A variable-length field containing the Integrity Check Value (ICV) or Message Authentication Code (MAC).
### AH - Integrity Check Value (ICV)
*   The ICV is a MAC calculated over the immutable and predictably mutable fields of the IP header, the AH header (excluding the authentication data itself), and the entire IP payload.
*   **HMAC Usage:** HMAC (e.g., HMAC-MD5-96, HMAC-SHA-1-96) is commonly used. The output is often truncated to 96 bits for efficiency.
*   **MAC Calculation:**
    *   **IP Payload:** Included entirely.
    *   **IP Headers:** Only fields that are "immutable" (do not change in transit) or "mutable but predictable" (change in a predictable way, like destination address which changes only if tunneling is used and the outer header changes) are included. Mutable fields (e.g., Time To Live) are zeroed out for MAC calculation.
    *   **AH Header:** Included, except for the Authentication Data field itself.
### AH – Transport Mode
*   AH is inserted after the original IP header and before the IP payload (transport-layer segment).
*   Authentication covers the entire packet, excluding mutable fields in the IPv4 header (which are set to zero for MAC calculation).
![[Pasted image 20251209100445.png]]
### AH – Tunnel Mode
*   AH is inserted between the original (inner) IP header and a new outer IP header.
*   The outer IP header typically contains the addresses of security gateways (e.g., firewalls or VPN concentrators).
*   Authentication covers the entire original IP packet (inner header and payload) and selected portions of the outer IP header, excluding mutable fields.

![[Pasted image 20251209100529.png]]
<h2>Encapsulating Security Payload (ESP)</h2>
ESP provides confidentiality (encryption) and optionally authentication services.
![[Pasted image 20251209100559.png]]
**ESP Header and Trailer Fields:**
*   **Security Parameters Index (SPI) (32 bits):** Identifies the security association.
*   **Sequence Number (32 bits):** Provides anti-replay protection.
*   **Payload Data (variable):** The encrypted data, which can be a transport-level segment or an entire IP packet.
*   **Padding (0–255 bytes):** Added to ensure the plaintext length is a multiple of the encryption algorithm's block size, and for traffic flow confidentiality.
*   **Pad Length (8 bits):** Indicates the number of pad bytes.
*   **Next Header (8 bits):** Identifies the type of data contained in the Payload Data field (e.g., TCP, UDP, or IP for tunnel mode).
*   **Integrity Check Value (ICV) (variable):** The MAC computed over the ESP packet (excluding the ICV field itself) if authentication is enabled.
*   **Initialization Value (IV):** Required by block ciphers in certain modes (e.g., CBC).
*   **Traffic Flow Confidentiality (TFC):** Achieved by arbitrary padding after the Payload Data and before the Padding field, helping to obscure the actual data length.
### Encryption and Authentication with ESP
*   **Encryption:** Applies to the Payload Data, Padding, Pad Length, and Next Header fields. An IV is used if required by the encryption algorithm.
*   **Authentication (Optional):** If enabled, the ICV is computed over the ESP packet (excluding the Authentication Data field). This is typically done *after* encryption.
    *   Provides rapid detection of replayed or bogus packets, mitigating Denial-of-Service (DoS) attacks.
    *   Allows for parallel processing of packets.
    *   Utilizes a keyed integrity algorithm.
### Padding in ESP
Padding serves several purposes:
*   **Block Cipher Alignment:** Many encryption algorithms (block ciphers) require plaintext input to be a multiple of their block size.
*   **32-bit Word Alignment:** The ESP format often requires alignment to 32-bit words.
*   **Traffic Flow Confidentiality:** Additional padding can be used to obscure the actual length of the original data, making traffic analysis harder.
### Transport Mode ESP
*   **Direct Host-to-Host Encryption:** Encryption (and optional authentication) is provided directly between two hosts.
*   **IP Header in Clear:** The IP payload (e.g., TCP segment) is protected, but the original IP header remains unencrypted. This means source and destination addresses are visible.
*   **Application:** Primarily for host-to-host (end-to-end) traffic.

![[Pasted image 20251209100717.png]]
### Tunnel Mode ESP
*   **Entire IP Packet Encryption:** Encrypts and optionally authenticates the entire original IP packet (inner header and payload).
*   **New Outer IP Header:** A new outer IP header is added, which may have different source/destination addresses than the inner header. This helps prevent traffic analysis based on the ultimate destination.
*   **Application:** Ideal for Virtual Private Networks (VPNs) and gateway-to-gateway (router-to-router) security.
*   **Benefits:**
    *   Internal network hosts are offloaded from security processing.
    *   Reduces the number of keys needed (only between gateways).
    *   Thwarts traffic analysis based on ultimate destination (due to new outer IP header).

![[Pasted image 20251209100815.png]]
![[Pasted image 20251209100829.png]]

### AH vs. ESP Comparison (Summary)
| Feature          | Transport Mode AH                           | Tunnel Mode AH                                       | Transport Mode ESP                                      | Tunnel Mode ESP                                                 |
| :--------------- | :------------------------------------------ | :-------------------------------------------------- | :------------------------------------------------------ | :-------------------------------------------------------------- |
| **Authentication** | IP payload and selected IP header portions. | Entire inner IP packet + selected outer IP header portions. | IP payload (if authentication enabled).                 | Entire inner IP packet (if authentication enabled).             |
| **Encryption**   | None                                        | None                                                | IP payload.                                             | Entire inner IP packet.                                         |
| **Header Protection** | IP header is exposed (except mutable fields for MAC). | Outer IP header exposed; inner IP header protected by authentication. | IP header exposed.                                      | Outer IP header exposed; inner IP header encrypted.             |

## Internet Key Exchange (IKE)
IKE is a critical component of IPsec, responsible for generating and managing Security Associations (SAs) for AH and ESP.

*   **Manual vs. Automated Key Management:**
    *   **Manual:** System administrators manually configure keys and SAs on every system. Feasible for small, static environments.
    *   **Automated:** IKE provides on-demand creation of keys and SAs, essential for large or dynamic systems.
*   **Evolution:** IKE evolved from earlier protocols like Oakley and ISAKMP. IKEv2 is the current standard.

### IKE Key Determination (Oakley/Diffie-Hellman)
*   IKE utilizes a key exchange protocol based on the Diffie-Hellman algorithm, often with added security features.

![[Pasted image 20251209101008.png]]

*   **Vulnerabilities:** Standard Diffie-Hellman is vulnerable to man-in-the-middle attacks if identities are not authenticated.
*   **Clogging Attacks:** Computationally intensive nature of DH can make it vulnerable to clogging (DoS) attacks where an attacker floods with requests, tying up computational resources.
*   **Mitigation Measures:**
    *   **Cookies:** Used to prevent clogging (Denial-of-Service) attacks by requiring the initiator to prove reachability before significant cryptographic computation. In IKE, cookies sometimes refer to the SPI.
    *   **Predefined Groups:** Use fixed Diffie-Hellman global parameters.
    *   **Nonces:** Random numbers used once to prevent replay attacks.
    *   **Authentication:** Using symmetric or asymmetric cryptography (e.g., digital signatures with certificates) to thwart Man-in-the-Middle attacks by authenticating the identities of the parties involved.

### Internet Security Association and Key Management Protocol (ISAKMP)
*   ISAKMP defines procedures and message formats to establish, negotiate, modify, and delete SAs.
*   It is a framework for internet key management, providing protocol support (including formats) for negotiating security attributes.
*   **Decoupled:** ISAKMP was designed to be independent of the specific key exchange protocol, encryption algorithm, and authentication method.
*   **IKE Combination:** IKE (especially IKEv2) combines ISAKMP's SA management with actual key exchange mechanisms.

### Typical SA Establishment in ISAKMP (General Flow)
1.  **Negotiate Capabilities:** Parties agree on encryption algorithms, authentication methods, key exchange methods, etc.
2.  **Exchange Keys:** Keys are exchanged using the agreed-upon method (e.g., Diffie-Hellman).
3.  **Authenticate Exchange:** The key exchange is authenticated using digital signatures (with certificates), public-key authentication, or symmetric-key authentication (using pre-shared secret keys).

<h2>IKEv2 Exchanges</h2>
IKEv2 streamlines the key exchange process into fewer messages and phases.

<h3>Initial Exchanges (IKE_SA_INIT and IKE_AUTH)</h3>
These two rounds establish an IKE Security Association and the first IPsec SA.
*   **1st Round (IKE_SA_INIT):** Sets up the IKE SA and builds a secure channel.
    *   `HDR`: IKE header
    *   `SAx1`: Offered and chosen algorithms, DH group
    *   `KEx`: Diffie-Hellman public key
    *   `Nx`: Nonces
    *   `CERTREQ`: Certificate request (optional)
*   **2nd Round (IKE_AUTH):** Authenticates each other and sets up the first IPsec SA.
    *   `IDx`: Identity payload
    *   `CERT`: Certificate payload (optional)
    *   `SK {...}`: MAC and encrypt various fields.
    *   `AUTH`: Authentication payload
    *   `SAx2`: Algorithms and parameters for the IPsec SA
    *   `TSx`: Traffic selectors for the IPsec SA

<h3>CREATE_CHILD_SA Exchange</h3>
Used to establish further IPsec SAs for protecting traffic without needing to re-establish the IKE SA.
*   `HDR`: IKE header
*   `SAx1`: Offered and chosen algorithms, DH group
*   `KEx`: Diffie-Hellman public key (for rekeying or new child SAs)
*   `Nx`: Nonces
*   `IDx`: Identity (optional)
*   `CERT`: Certificate (optional)
*   `SK {...}`: MAC and encrypt
*   `AUTH`: Authentication (optional)
*   `SAx2`: Algorithms, parameters for the new IPsec SA
*   `TSx`: Traffic selectors for the new IPsec SA

<h3>Informational Exchange</h3>
Used for exchanging management information, IKEv2 error messages, and other notifications.
*   `HDR`: IKE header
*   `N`: Notify payload (for error messages or other notifications)
*   `D`: Delete payload (to delete SAs)
*   `CP`: Configuration payload (for configuration requests/responses)
*   Other payloads like `SAx1, KEx, Nx, CERTREQ, IDx, CERT, SK {...}, AUTH, SAx2, TSx` can also be present depending on the specific informational message (e.g., rekeying IKE SA).

<h2>IKE Header and Payload Format</h2>
An IKE message consists of an IKE header followed by one or more payloads. These define procedures and packet formats for SA management.

<h3>IKE Header Fields</h3>
*   **Initiator SPI (64 bits):** Identifies a unique IKE SA from the initiator's perspective.
*   **Responder SPI (64 bits):** Identifies a unique IKE SA from the responder's perspective.
*   **Next Payload (8 bits):** Indicates the type of the first payload in the message.
*   **Major Version (4 bits):** Indicates the major version of IKE (e.g., 2 for IKEv2).
*   **Minor Version (4 bits):** Indicates the minor version.
*   **Exchange Type (8 bits):** Indicates the type of IKE exchange (e.g., IKE_SA_INIT, IKE_AUTH, CREATE_CHILD_SA, INFORMATIONAL).
*   **Flags (8 bits):** Indicates specific options set for this IKE exchange.
*   **Message ID (32 bits):** Used to control retransmission of lost packets and match requests with responses.
*   **Length (32 bits):** Total length of the IKE message (header plus all payloads) in octets.

<h3>IKE Payload Header</h3>
Each IKE payload has a generic header with common fields:
*   **Next Payload:** Type of the next payload. A value of 0 indicates this is the last payload.
*   **Payload Length:** Length of this payload in octets, including the generic payload header.
*   **Critical Bit:**
    *   **0:** The recipient can skip this payload if it doesn't understand its type.
    *   **1:** The recipient *must* reject the entire message if it doesn't understand this payload type, ensuring critical information is processed.

<h3>IKE Payload Types (Examples)</h3>

| Type                          | Parameters                                       |
| :---------------------------- | :----------------------------------------------- |
| **Security Association**      | Proposals (algorithms, DH group, PRF)            |
| **Key Exchange**              | DH Group Number, Key Exchange Data               |
| **Identification**            | ID Type, ID Data                                 |
| **Certificate**               | Certificate Encoding, Certificate Data           |
| **Certificate Request**       | Certificate Encoding, Certification Authority    |
| **Authentication**            | Authentication Method, Authentication Data       |
| **Nonce**                     | Nonce Data                                       |
| **Notify**                    | Protocol-ID, SPI Size, Notify Message Type, SPI, Notification Data |
| **Delete**                    | Protocol-ID, SPI Size, Number of SPIs, SPI (one or more) |
| **Vendor ID**                 | Vendor ID Data                                   |
| **Traffic Selector**          | Number of Traffic Selectors, Traffic Selectors   |
| **Encrypted**                 | IV, Encrypted IKE payloads, Padding, Pad Length, ICV |
| **Configuration**             | Configuration Type, Configuration Attributes     |
| **Extensible Authentication Protocol (EAP)** | EAP Message                       |

<h2>Cryptographic Suites for IPsec</h2>
RFC 4308 defines standard cryptographic suites for establishing Virtual Private Networks (VPNs). These suites specify the recommended algorithms for different IPsec functions.
<h3>VPN-A and VPN-B Suites (Example from RFC 4308)</h3>

| Feature          | VPN-A                 | VPN-B                 |
| :--------------- | :-------------------- | :-------------------- |
| ESP encryption   | 3DES-CBC              | AES-CBC (128-bit key) |
| ESP integrity    | HMAC-SHA1-96          | AES-XCBC-MAC-96       |
| IKE encryption   | 3DES-CBC              | AES-CBC (128-bit key) |
| IKE PRF          | HMAC-SHA1             | AES-XCBC-PRF-128      |
| IKE Integrity    | HMAC-SHA1-96          | AES-XCBC-MAC-96       |
| IKE DH group     | 1024-bit MODP Group   | 2048-bit MODP Group   |

<h3>GCM Suites (Example)</h3>

| Feature        | GCM-128                  | GCM-256                  | GMAC-128                 | GMAC-256                 |
| :------------- | :----------------------- | :----------------------- | :----------------------- | :----------------------- |
| ESP encryption | AES-GCM (128-bit key)    | AES-GCM (256-bit key)    | Null                     | Null                     |
| ESP integrity  | Null                     | Null                     | AES-GMAC (128-bit key)   | AES-GMAC (256-bit key)   |
| IKE encryption | AES-CBC (128-bit key)    | AES-CBC (256-bit key)    | AES-CBC (128-bit key)    | AES-CBC (256-bit key)    |
| IKE PRF        | HMAC-SHA-256             | HMAC-SHA-384             | HMAC-SHA-256             | HMAC-SHA-384             |
| IKE Integrity  | HMAC-SHA-256-128         | HMAC-SHA-384-192         | HMAC-SHA-256-128         | HMAC-SHA-384-192         |
| IKE DH group   | 256-bit random ECP group | 384-bit random ECP group | 256-bit random ECP group | 384-bit random ECP group |
