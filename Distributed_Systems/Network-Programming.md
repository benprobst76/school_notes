# Network Programming

## Overview
This section covers network programming using the **Linux/BSD/MacOS/iOS API**, which are all variations of the UNIX operating system.
*   **Windows**: Uses WINSOCK, which is similar but differs in implementation details. WSL (Windows Subsystem for Linux) can be used to access the Linux API on Windows.
*   **Goal**: Understanding these APIs is essential for assignments and general distributed systems development.

## IP Basics
Network communication relies on IP addresses and ports.
*   **IP Address**: Identifies a network interface (e.g., `130.15.115.43` for IPv4).
*   **Port**: Identifies a specific process on a host.
    *   **Ownership**: On UNIX/Linux, a port can only be owned by a single process (or its children).
    *   **Standard Ports**:
        *   80: Unencrypted web traffic (HTTP)
        *   443: Encrypted web traffic (HTTPS)
        *   21: SSH connections
    *   **Ephemeral Ports**: High-numbered ports (typically 32768+) assigned automatically by the OS.

### Socket API
Sockets are the fundamental abstraction for network I/O.
```c
int socket(int domain, int type, int protocol);
```
*   **domain**: Protocol family. `AF_INET` (IPv4) or `AF_INET6` (IPv6).
*   **type**: Communication type. `SOCK_STREAM` (TCP) or `SOCK_DGRAM` (UDP).
*   **protocol**: Specific protocol (usually 0 for IP).
*   **Return**: Returns a file descriptor or -1 on error.

### Address Structures
Addresses are defined using `struct sockaddr`. For IPv4, `struct sockaddr_in` is used:
```c
struct sockaddr_in { 
    short sin_family;        // AF_INET
    unsigned short sin_port; // Port number (0-65535)
    struct in_addr sin_addr; // IPv4 address (32-bit)
    char sin_zero[8];        // Padding to match sockaddr size
}; 
```

### Byte Order
Network protocols typically use **Big Endian** byte order, while many host architectures (like Intel x86) use **Little Endian**.
*   **Conversion Functions**:
    *   `htons()`: Host to Network Short
    *   `htonl()`: Host to Network Long
    *   `ntohs()`: Network to Host Short
    *   `ntohl()`: Network to Host Long
*   *Example*: `servaddr.sin_port = htons(PORT);`

### Address Resolution (DNS)
The Domain Name Service (DNS) translates symbolic names (e.g., `code.engineering.queensu.ca`) into numeric IP addresses.
*   **Modern API**: `getaddrinfo()` (replaces the deprecated `gethostbyname()`).

```c
int getaddrinfo(char * node, char * service, struct addrinfo * hints, struct addrinfo ** res);
```
*   **node**: Hostname / IP string.
*   **service**: Service name (or NULL).
*   **hints**: Filter criteria (e.g., IPv4 only, UDP only).
*   **res**: Pointer to a linked list of results.

**Example Usage**:
```c
struct addrinfo hints; 
hints.ai_family = AF_INET;      // IPv4 
hints.ai_socktype = SOCK_DGRAM; // UDP 
hints.ai_protocol = 0; 
hints.ai_flags = 0; 

e = getaddrinfo("code.engineering.queensu.ca", nullptr, &hints, &addr_res);
// Remember to free memory: freeaddrinfo(addr_result);
```

### Core Socket Operations
*   **`bind()`**: Associates a socket with a local address and port.
    ```c
    int bind(int sockfd, const struct sockaddr *addr, socklen_t addrlen);
    ```
    *   Using `INADDR_ANY` binds to the given port on *all* interfaces.
*   **`close()`**: Frees resources associated with the socket. Same system call used for files.

## TCP (Transmission Control Protocol)
TCP provides a **reliable, bidirectional stream** (e.g., Web, SSH, Video).
*   Requires a connection setup handshake.
*   **Server Lifecycle**:
    1.  `socket()`: Create endpoint.
    2.  `bind()`: Attach to port.
    3.  `listen(sockfd, backlog)`: Mark as passive socket waiting for connections. `backlog` defines the queue size for pending connections.
    4.  `accept(sockfd, addr, addrlen)`: Block until a client connects. Returns a **new** socket file descriptor for this specific connection.
*   **Client Lifecycle**:
    1.  `socket()`: Create endpoint.
    2.  `connect(sockfd, addr, addrlen)`: Initiate connection to server. If not bound, an ephemeral port is assigned.

**Data Transfer**:
Both sides use `read()` and `write()` on the connected socket.
*   *Note*: Servers often create a new thread or process to handle the accepted connection. See [[Cpp-Overview]] for threading details.

## UDP (User Datagram Protocol)
UDP provides **unreliable, message-based** communication (e.g., DNS, NTP, RTPS).
*   No connection setup/teardown overhead.
*   Supports multicasting.

### Sending and Receiving
*   **`sendto()`**: specificies destination address for every message.
    ```c
    size_t sendto(int sockfd, const void *buf, size_t len, int flags, 
                  const struct sockaddr *dest_addr, socklen_t addrlen);
    ```
*   **`recvfrom()`**: Receives message and populates sender's address.
    ```c
    size_t recvfrom(int sockfd, void *buf, size_t len, int flags, 
                    struct sockaddr *src_addr, socklen_t *addrlen);
    ```

### Timeouts
Socket options can control behavior, such as receive timeouts.
```c
struct timeval tv;
tv.tv_sec = 1; 
tv.tv_usec = 0; 
// Set 1 second timeout
if (setsockopt(sockfd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv)) < 0) { ... }
```

## I/O Multiplexing (Polling)
When handling multiple protocols or connections simultaneously (e.g., listening on multiple ports), single-threaded blocking calls are inefficient.
*   **`poll()`**: Waits for one of a set of file descriptors to become ready to perform I/O.
```c
struct pollfd {
    int fd;         // File descriptor
    short events;   // Requested events (e.g., POLLIN)
    short revents;  // Returned events
};

// Returns number of ready descriptors
int poll(struct pollfd *fds, nfds_t nfds, int timeout);
```

## Multicast
UDP supports multicasting, where messages are sent to a group of interested receivers rather than a single specific host.
*   **Address Range**: `224.0.0.0` to `239.255.255.255`.
*   **Programming**:
    *   **Sender**: Sends to a multicast address/port.
    *   **Receiver**: Binds to the port and joins the multicast group using `setsockopt`.

**Joining a Group**:
```c
struct ip_mreqn { 
    struct in_addr imr_multiaddr; // Multicast group to join
    struct in_addr imr_address;   // Local interface to use (INADDR_ANY)
    int imr_ifindex;              // Interface index
}; 

setsockopt(sock, IPPROTO_IP, IP_ADD_MEMBERSHIP, &mc_req, sizeof(mc_req));
```
