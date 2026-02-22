Mutual exclusion guarantees that only one process can access a shared resource at a time. This is a fundamental problem in operating systems, but it becomes significantly more complex in distributed systems where there is no shared memory or global clock.
## Algorithms
There are generally two main categories of algorithms to handle mutual exclusion: **Token-based** and **Permission-based**.
### Token-Based Approach
In this approach, a unique "token" is passed between processes. Only the process currently holding the token is allowed to enter the critical section.
*   **Mechanism**: A logical ring or other structure is often used to pass the token.
*   **Access**: When a process receives the token:
    *   If it needs to access the resource, it enters the critical section.
    *   When it leaves, it passes the token to the next process.
    *   If it does not need the resource, it immediately passes the token along.
*   **Guarantees**: This method guarantees that starvation cannot occur (every process gets a turn).
*   **Issues**:
    *   **Token Loss**: If the token is lost (e.g., the holder crashes), a new token must be generated. This often requires an [[Election-Algorithms|election]] process to decide who generates it.
    *   **Process Failure**: If a process crashes while holding the token, the ring is broken and needs to be repaired.

### Permission-Based Approach
In this approach, a process wanting to access a resource must request and receive permission from other processes in the system.

#### Centralized (Coordinator)
A single process is elected as the Coordinator for the shared resource.
*   **Request**: Clients send a request to the coordinator.
*   **Grant**:
    *   If the resource is free, the coordinator grants permission.
    *   If the resource is busy, the coordinator queues the request.
*   **Release**: When finished, the client sends a release message, and the coordinator grants the next request in the queue.
*   **Pros**: Simple to implement; guarantees mutual exclusion; fair (FCFS).
*   **Cons**:
    *   **Bottleneck**: The coordinator handles all traffic.
    *   **Single Point of Failure**: If the coordinator fails, a new one must be elected (see [[Election-Algorithms]]).

#### Distributed (Lamport Clocks / Ricart-Agrawala)
This method relies on consensus among peers rather than a central authority. It uses [[Synchronization|logical clocks]] to order requests.
*   **Ordering**: Each process maintains a logical clock and a request queue. The queue is ordered by timestamp.
*   **Request**:
    1.  A process $P$ wanting to enter sends an `ENTER` message with its timestamp and ID to *all* other processes.
    2.  $P$ also adds this request to its own local queue.
*   **Response**: When process $Q$ receives an `ENTER` message from $P$:
    *   $Q$ adds the request to its local queue.
    *   $Q$ sends a timestamped `ACK` back to $P$ (after incrementing its own clock).
*   **Entry Condition**: $P$ can enter the critical section when:
    1.  It has received an `ACK` from *all* other processes.
    2.  Its own `ENTER` request is at the head of its priority queue.
*   **Release**:
    1.  When $P$ leaves the critical section, it removes its `ENTER` request from its queue.
    2.  It sends a `RELEASE` message to all other processes.
    3.  Receiving processes remove $P$'s request from their queues, potentially bringing a new request to the head.

![[Pasted image 20260127134002.png]]

## Decentralized Mutual Exclusion
To mitigate the single point of failure in centralized systems and the high message overhead in fully distributed systems, a decentralized voting approach can be used.
*   **Replication**: The resource is assumed to be replicated $N$ times. Each replica has its own coordinator.
*   **Voting**: Accessing the resource requires a majority vote ($m > N/2$) from the coordinators.
*   **Coordinator Logic**:
    *   If a coordinator believes the resource is free, it votes "Yes".
    *   If it has already voted "Yes" for another pending request, it votes "No".
    *   Coordinators recover quickly from crashes but lose memory of past votes.
*   **Client Logic**:
    *   If a client gets $< m$ votes, it is denied access.
    *   It backs off for a random time before retrying (to prevent deadlocks).
*   **Performance**: Utilization can drop under high load because concurrent requests may split the votes such that no one gets a majority.

### Robustness Analysis
We can analyze the probability of the system violating mutual exclusion due to coordinator resets.
Let:
*   $T$: The lifetime of a coordinator.
*   $\Delta t$: The vulnerability window (time to reset).
*   $p = \frac{\Delta t}{T}$: The probability a coordinator resets during the interval.

The probability that exactly $k$ out of $m$ coordinators reset during the interval follows a binomial distribution:
$$ P[k] = \binom{m}{k}p^k(1 - p)^{m-k} $$
Correctness is violated if enough coordinators reset such that they grant permission to a second process while the first is still in the critical section. This occurs if the number of surviving coordinators plus the number of reset coordinators is sufficient to form a majority for a new request.  
The condition for safety against $f$ failures is: $f < 2m - N$
**Probability of Violation (Table)**

| N   | m   | p (reset rate) | Violation Probability |
| :-- | :-- | :------------- | :-------------------- |
| 8   | 5   | 3 sec/hour     | $< 10^{-5}$           |
| 8   | 6   | 3 sec/hour     | $< 10^{-11}$          |
| 16  | 9   | 3 sec/hour     | $< 10^{-4}$           |
| 16  | 12  | 3 sec/hour     | $< 10^{-21}$          |
| 32  | 17  | 3 sec/hour     | $< 10^{-4}$           |
| 32  | 24  | 3 sec/hour     | $< 10^{-43}$          |

### Algorithm Comparison

| Algorithm         | Messages per Entry/Exit          | Delay before Entry (in message times) |
| :---------------- | :------------------------------- | :------------------------------------ |
| **Centralized**   | 3 (Request, Grant, Release)      | 2                                     |
| **Distributed**   | $2(N - 1)$                       | $2(N - 1)$                            |
| **Decentralized** | $2mk + m$, varies by retries $k$ | $2mk + m$                             |

## Case Study: [[Election-Algorithms#Zookeeper Internal Elections|Zookeeper]]
ZooKeeper is a distributed coordination service that provides primitives for distributed applications, including locking, leader election, and configuration management.
*   **Architecture**: Centralized server cluster (ensemble).
*   **Performance**: Clients connect to any server; reads are fast (local), writes require consensus.
*   **Namespace**: Maintains a hierarchical tree of data nodes (z-nodes), similar to a file system.
*   **Features**:
    *   **Non-blocking**: Clients get immediate responses.
    *   **Watches**: Clients can subscribe to notifications for changes on nodes.
    *   **Ephemeral Nodes**: Nodes that disappear when the client session ends (useful for failure detection).

### Locking Protocol
ZooKeeper does not provide a "lock" primitive directly but allows building one using ephemeral sequential nodes.
1.  **Create Lock**: Client tries to create a node for the resource (e.g., `/lock-node`).
2.  **Wait**:
    *   If creation succeeds, the client holds the lock.
    *   If the node already exists, the client sets a **watch** on the node and waits for it to be deleted.
3.  **Release Lock**: Client deletes the node.
4.  **Notification**: Watching clients are notified of the deletion and try to create the node again.

#### Handling Race Conditions
A naive implementation might suffer from race conditions:
1.  $P_1$ creates the lock.
2.  $P_2$ tries to create the lock and fails (it exists).
3.  $P_1$ deletes the lock (releases it).
4.  $P_2$ tries to set a watch, but the node is already gone. $P_2$ might wait forever.

**Solution**: ZooKeeper handles this by checking existence and setting the watch as an atomic operation or by checking again if the watch setting fails. A more robust recipe uses **sequential nodes**:
1.  Client creates an ephemeral sequential node under the lock directory (e.g., `/lock/request-1`).
2.  Client gets all children of `/lock`.
3.  If its node has the lowest sequence number, it holds the lock.
4.  Otherwise, it watches the node *immediately preceding* it in the sequence. This prevents the "herd effect" where all clients wake up at once.