## Networking Models
![[Pasted image 20260120191119.png]]

**Alternate Model**
![[Pasted image 20260120191159.png]]

## Types of Communication
### Persistent vs Transient
*   **Persistent**: Middleware saves the message until it is delivered, even after the sender has exited.
    *   *Example*: Email, Message Queues.
*   **Transient**: Message only exists as long as sending and receiving applications are executing.
    *   *Example*: UDP/TCP Sockets, ZeroMQ.
### Asynchronous vs Synchronous
*   **Asynchronous**: Sender continues execution immediately after sending.
*   **Synchronous**: Sender blocks until the message is accepted or processed.
*   *Note*: Middleware often provides temporary storage to facilitate asynchronous communication.

## Messaging
### Message-Oriented Middleware (MOM)
*   **Goal**: Persistent asynchronous communication.
*   **Mechanism**: Processes send messages which are queued.
*   **Benefits**:
    *   Senders don't need to wait for a reply (can do other things).
    *   Often ensures fault tolerance.
### Transient Messaging on Sockets
**Socket Based Programming** ([[Network-Programming]])
*   Some applications are based on low-level sockets (TCP or UDP).
*   **Process**: Open a socket, send and receive messages using a custom protocol for the application.
*   **Database Usage**: Some database clients/servers have their own implementation and protocol built on sockets inside their libraries.
*   **Drawback**: Low level, mistakes are easily made.
### Higher Level Transient Messaging: ZeroMQ
*   Provides a higher level of expression by pairing sockets: one at the sending process, one at the receiving process.
*   **Abstraction**: Hidden inside an API library.
*   **Features**:
    *   First message can be sent *before* sockets are set up (buffered until connection is established).
    *   Sockets have specific types (`REQ`, `REP`, `PUB`, `SUB`, `PUSH`, `PULL`) separate from underlying TCP/UDP types.
    *   All communication is **asynchronous** (sender continues after submitting a message).
    *   Supports **Many-to-One** and **One-to-Many** (multicasting) communication, not just One-to-One.

#### Communication Patterns
Many message applications use simple communication patterns.
1.  **Request-Reply**
    *   Traditional client-server communication.
    *   **Client**: Uses `REQ` socket. Sends request, waits for reply.
    *   **Server**: Uses `REP` socket. Waits for request, sends reply.
2.  **Publish-Subscribe**
    *   **Server**: Uses `PUB` socket.
    *   **Client**: Uses `SUB` socket.
    *   **Filtering**: Messages are typed by prefix bytes. Clients specify a filter for which messages they are interested in.
3.  **Pipeline**
    *   Stream of data (Producer-Consumer pattern).
    *   **Process 1 (Producer)**: Wants to push data as fast as possible. Uses `PUSH` socket.
    *   **Process 2 (Consumer)**: Reads data using `PULL` socket.

### Message Passing Interface (MPI)
Used for **Parallel Applications**.
*   High-performance transient messaging.
*   **Assumption**: Serious failures (process crashes, network failures) are **fatal**. No fault tolerance.
*   **Group Communication**: Assumes communication takes place within a known group of processes.
*   **Addressing**: Each group gets an identifier. `(gid, pid)` uniquely identifies the source or destination.

## Persistent Message Communication
### Message Queuing Systems (MOM)
*   Intermediate-term storage capacity.
*   Designed for supporting message transfers that are allowed to take minutes instead of seconds/milliseconds.
*   **Mechanism**: Applications communicate by adding messages to a specific queue.
*   **Routing**: Messages may have to transfer between multiple communication servers to reach the destination.
    *   *In practice*: Message can be transferred directly to destination server.
*   **Access**: Queue can only be read by associated application(s).
### Characteristics
*   **Guarantees**: Senders usually only guaranteed the message will be *eventually* inserted.
*   **Decoupling**: Receiver may not be running. Sender and receiver execute independently.
*   **Persistence**: Once a message has been inserted, it stays there until removed.
*   **Addressing**: Unique name of destination queue.
### Queue Operations
*   `PUT`: Append message to specific queue.
*   `GET`: Blocking read of first message on queue.
*   `POLL`: Non-blocking read of first message on queue.
*   `NOTIFY`: Add a callback to be notified when a message has been added to a queue.
### Queue Managers
*   Queues are managed by **Queue Managers**.
*   Applications can only put into a **local queue**.
*   Messages contain the identity of the **destination queue**.
*   **Routing**: Queue managers route messages until they reach the final destination queue.
*   **Routers**: Special queue managers operate as routers (different from network routers), forwarding messages to other queue managers.
*   **Consumption**: Destination process removes the message from the queue.
### Representation & Semantics
*   MOM systems often span multiple organizations and have multiple representations of messages.
*   It is not always practical to ensure everyone is using the same message format.
*   **Issue**: Not only encoding, but **semantics** of the messages differ (e.g., two house listing services may have different fields).
*   **Message Brokers**: Special nodes in the queue manager network that convert between message formats.
### Example: AMQP
*   **Advanced Message-Queuing Protocol** (2006).
*   Multiple versions, most recent 1.0.
*   Described in Chapter 4 of *van Steen and Tanenbaum* (2023).

## Multicasting
### Application Level Multicasting
*   **IP Level Multicasting** (Network Layer) is limited in range since most ISPs do not run multicast routers. It usually only works between segments of a given organization's network (e.g., ATC network, radar stations).
*   **Peer-to-Peer (P2P)** middleware techniques often involve sending messages to multiple recipients.
*   **Goal**: Avoid setting up multiple individual explicit communication paths through existing networks.
### Overlay Networks
*   Peer nodes act as **application-level routing nodes**.
*   They organize themselves into a network independent of the underlying physical network.
*   **Challenges**: Building an efficient overlay is difficult.
    *   Neighbors in the overlay may be multiple real hops away.
    *   Nodes that are close in the real network may be far apart in the overlay.
*   **Redundancy**: A multicast message broadcast to every node in the overlay might traverse the same real network link multiple times.
*   **Subsets**: Sending messages to subsets of nodes is difficult (may require building multiple overlay networks).
### Flooding
*   A simple technique where each node forwards the message to each of its neighbors in the overlay graph.

## Out-of-Band Communication
*   **Problem**: How to interrupt a server if it has already accepted a request (e.g., cancel a long-running job)?
*   **Solution 1**: Use a **separate port** for urgent data.
    *   Server has a separate thread to process urgent messages.
*   **Solution 2**: Use **transport layer facilities**.
    *   TCP allows for urgent messages on the same connection (Urgent Pointer).
    *   Messages are caught using OS signaling techniques (e.g., `SIGURG`).
## Server State
### Stateless Servers
*   Never keep accurate information about the status of a client after handling a request.
*   **Characteristics**:
    *   Don’t record if a file has been opened.
    *   Don't promise to invalidate a client’s cache.
    *   Don’t keep track of clients.
*   **Consequences**: Keeps clients and servers independent. State inconsistencies due to crashes are reduced.
### Stateful Servers
*   Keep track of the status of clients.
*   **Characteristics**:
    *   Record that a file has been opened (and by whom).
*   **Trade-off**: Performance is usually better, but reliability is harder to manage during failures.
