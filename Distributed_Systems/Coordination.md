# Coordination in Distributed Systems
While previous topics focused on processes, threads, and communication (see [[Threads-&-RPC]]), processes in a distributed system must also cooperate and synchronize their actions. Coordination is essential for managing shared resources and ensuring the correct ordering of events, but it is significantly more difficult in distributed environments compared to single-system environments (see [[Introduction]]). Coordination often involves mutual exclusion, event ordering, or electing a specific process to act as a coordinator through distributed election algorithms.
## The Problem of Time
In a single-machine system, there is a single system clock. If two processes request the time, the second process is guaranteed to receive a value greater than or equal to the first. In a distributed system, however, each machine has its own physical clock, and no two clocks are ever perfectly identical.
Time is critical for sequencing writes to shared resources and debugging. For example, when analyzing logs to trace an SQL injection attack, an administrator needs to know the exact sequence of events as data "bounces" between multiple machines. Because network delays and computer loads vary, distributed systems are modeled as asynchronous, making a unified view of time a complex challenge.
## Physical Clocks
Physical time is typically tracked using **Universal Coordinated Time (UTC)**, which is based on the transitions of the Cesium 133 atom. The official UTC time is the average of approximately 50 cesium clocks worldwide. **Leap seconds** are occasionally added to compensate for the gradual slowing of the Earth's rotation. UTC is broadcast via satellites (GPS) and short-wave radio with an accuracy of roughly $\pm 0.5$ ms.
### Synchronization Metrics
* **Precision:** The goal of keeping the deviation between two clocks within a specific bound $\pi$.
* **Accuracy:** The goal of keeping the difference between a system clock and UTC bounded by a value $\alpha$.
* **Internal Synchronization:** Keeping clocks within the system precise relative to each other.
* **External Synchronization:** Keeping clocks accurate relative to an external time source (like UTC).
### Clock Drift
Clocks are driven by quartz oscillators that "drift" due to factors like temperature and hardware quality. Even with high-quality receivers at data centers, local system clocks (driven by motherboard hardware interrupts) will deviate.
### Synchronization Algorithms
A common approach is requesting the time from a central server. Assuming the request delay $\delta T_{req}$ is approximately equal to the response delay $\delta T_{resp}$, the offset $\theta$ and delay $\delta$ can be estimated:
$$ \begin{aligned} \theta &= T_3 + \frac{\delta T_{req} + \delta T_{resp}}{2} - T_4 \\ \delta &= \frac{(T_4 - T_1) - (T_3 - T_2)}{2} \end{aligned} $$
#### Network Time Protocol (NTP)
Defined in **RFC 5905**, NTP is designed to synchronize many machines across a network. It achieves worldwide accuracy in the range of 1–50 ms by collecting multiple $(\theta, \delta)$ pairs and choosing the offset $\theta$ corresponding to the minimal delay $\delta$. NTP organizes computers into **strata**:
* **Stratum 1:** Servers directly connected to a UTC receiver or atomic clock.
* **Stratum 2:** Servers that synchronize with Stratum 1 servers.
* **Stratum $n$:** Servers synchronize with Stratum $n-1$. Higher stratum numbers (further from the source) adjust their time to match lower stratum servers.
## Logical Clocks
Leslie Lamport observed that many distributed coordination tasks do not require absolute "real time," but rather a consistent **global order of discrete events**. This is often easier to achieve than physical clock synchronization.
### Lamport's Happened-Before Relation
The relation $a \to b$ signifies that event $a$ happened before event $b$. For example, if $a$ is the sending of a message and $b$ is the receipt of that same message, then $a \to b$. This is a **Strict Partial Order**:
* **Irreflexive:** $a \not\to a$.
* **Asymmetric:** If $a \to b$, then $b \not\to a$.
* **Transitive:** If $a \to b$ and $b \to c$, then $a \to c$.
Note that if two events $a$ and $c$ have no causal relationship, their order is undefined (concurrency).
### Lamport Clock Protocol
To capture causality, we attach a timestamp $C(e)$ to each event $e$ such that:
1. If $a \to b$ within a single process, then $C(a) < C(b)$.
2. If $a$ is a send event and $b$ is a receive event, then $C(a) < C(b)$.
**Protocol Rules:**
1. Each process $P_i$ maintains a local counter $C_i$.
2. Every local event in $P_i$ increments $C_i$ by 1.
3. When $P_i$ sends a message $m$, it attaches its current timestamp $T_m = C_i$.
4. Upon receiving $m$ with timestamp $T_m$, process $P_j$ updates its clock: $C_j = \max(C_j, T_m)$.
5. The receive event is then assigned a timestamp $C_j + 1$.
![[Pasted image 20260122164439.png]]
### Totally Ordered Multicast
An application of logical clocks is **Totally Ordered Multicast**, where concurrent updates to a replicated database must be processed in the same order at every node.
1. A process sends a timestamped message to all others.
2. Messages are placed in a local queue, ordered by timestamp.
3. Because clocks are synchronized via the message exchange, all processes eventually see the same sequence of events. This assumes reliable communication and that messages are acknowledged.
## Vector Clocks
Lamport clocks guarantee that if $a \to b$, then $C(a) < C(b)$. However, the converse is not true: $C(a) < C(b)$ does **not** necessarily mean $a$ caused $b$. Vector clocks address this by maintaining a vector of clocks, one for each process.
Let $VC_i$ be the vector for process $P_i$. If $VC_i[j] = k$, then $P_i$ knows that $k$ events have occurred at process $P_j$.
**Protocol Rules:**
1. Before executing an event, $P_i$ increments its own entry: $VC_i[i] = VC_i[i] + 1$.
2. When $P_i$ sends a message, it includes its entire vector $VC_i$.
3. Upon receiving a message with vector $TS$, $P_j$ updates its vector: $VC_j[k] = \max(VC_j[k], TS[k])$ for all $k$.
![[Pasted image 20260122164755.png]]
### Comparison of Vector Clocks
Vector clocks allow us to determine if two events are causally related or concurrent:
* $V < W$ if every element $V[i] \le W[i]$ and at least one $V[j] < W[j]$. This indicates $V$ causally precedes $W$.
* If $V$ is neither less than, greater than, nor equal to $W$ (e.g., $(4, 1, 0)$ and $(2, 3, 0)$), the events are **concurrent** and may represent a causal conflict.
### Pros and Cons
* **Pros:** They respect causality, which is vital for distributed debugging and consistency.
* **Cons:** They do not capture causality from events outside the system (e.g., a user seeing an output on one machine and typing an input on another).
* **Cons:** They can lead to "potential influence" overhead, where the system tracks causal links that don't actually exist, potentially impacting performance and scalability.
## Mutual Exclusion  
• Similar to the same problem on a single system  
• Ensure that only one process accesses a shared resource, but now distributed  
• Token Based  
• Messages are used to transfer a token between the processes that access the shared resource  
• Different tokens for different resources  
• Process that has the token gets to enter the critical section, passes the token to next process when leaving the critical section  
• Guarantees each process gets a turn  
• What happens if the token is lost?
#### Permission based approach  
• Process wanting to access the shared resource needs permission from the other  
processes.  
#### Coordinator  
• One process is elected as a coordinator for the shared resource.  
• Other processes ask it before accessing the shared resource.  
• Coordinator maintains a queue of requests and lets each process access the shared  
resource in turn. (Can be a bottleneck) 
• If coordinator fails, then a new coordinator must be elected
### Distributed Algorithms - Lamport Clocks  
• Each process needs to agree on the order of accessing the shared resource  
• Each process maintains a request queue as well as a logical clock. The local queue is sorted by timestamp.  
• Process adds an ENTER message with the timestamp and its process id into the local queue and sends that same message to the other processes., who add to their local queues 
• When a process P receives an ENTER message from Q, it sends an timestamped ACK message (after incrementing its clock).  
• P can enter when it has received a time stamp ACK from all other units, and its ENTER is at the front of the queue.  
• When a process leaves a critical section, it removes ENTER from the queue and sends a RELEASE message to all processes  
• All processes remove entry from their queue.
![[Pasted image 20260127134002.png]]
## Decentralized Mutual Exclusion  
• Assume each resource is replicated N times, each replica has its own coordinator  
• access requires a majority vote (m > N/2)  
• Assume coordinators respond immediately to a request  
• If they think the resource is free, then they say yes,  
• If they have already said yes to another process they say no.  
• If a coordinator crashes, it recovers quickly (but will have forgotten any votes).  
• If a process is denied (gets less than m votes), it backs off for some random time and makes another attempt.  
• utilization can drop for high demand resources (no process gets a majority vote)
#### Robustness
• p = ∆t/T is the probably a coordinator resets during interval ∆t, with a lifetime  
of T 
• The probability that k out of m coordinators reset at the same time  
•  $P[k] = \pmatrix{m \\ k}p^k(1 − p)^{m−k}$
• Correctness is violated when enough coordinators reset that the other  
coordinators think it is ok to grant access to the resource.  
• N - (m-f) >= m or f >= 2m -N  
Table: 
N m p Violation N m p Violation  
8 5 3 sec/hour < 10 −5 8 5 30 sec/hour < 10 −3  
8 6 3 sec/hour < 10 −11 8 6 30 sec/hour < 10 −7  
16 9 3 sec/hour < 10 −4 16 9 30 sec/hour < 10 −2  
16 12 3 sec/hour < 10 − 21 16 12 30 sec/hour < 10 −13  
32 17 3 sec/hour < 10 −4 32 17 30 sec/hour < 10 −2  
32 24 3 sec/hour < 10 −43 32 24 30 sec/hour < 10 −27

  

| Algorithm     | Messages per entry/exit           | Delay before entry  (in message times) |
| ------------- | --------------------------------- | -------------------------------------- |
| Centralized   | 3                                 | 2                                      |
| Distributed   | 2(N − 1)                          | 2(N − 1)                               |
| Decentralized | 2kN +(k − 1)N/2 + N, k = 1, 2,... | 2kN +(k − 1)N/2                        |

### Example - Zookeeper  
• Zookeeper is a set of building block routines for distributed systems. It has  
facilities for locking, leader election and monitoring.  
• Centralized server setup  
• All client-server communication is nonblocking: a client immediately gets a  
response  
• ZooKeeper maintains a tree-based namespace, similar to a filesystem  
• Clients can create, delete, or update nodes, as well as check existence.  
• Notification mechanism for actions in the node space
#### zookeeper locking protocol  
• Create a lock  
• create a node for that resource in the zookeeper namespace  
• if the lock node already exists, subscribes to a notification to changes of  
the node  
• release a lock  
• delete the node for the resource  
• if a process is waiting, it will receive notification of the deletion.
#### Race condition  
• P1 creates a lock  
• P2 attempts to create the lock, but it already exists  
• Before P2 subscribes to a notification, but P1 deletes the lock  
• P2 subscribes to changes.  
• Zookeeper has a mechanism to deal with this particular condition.
### Election Algorithms
#### Coordinators  
• Some algorithms require that a single process acts as a coordinator.  
• How to select a coordinator  
• Manual -> centralized system, but a single point of failure  
• How to choose a coordinator dynamically  
• If the coordinator fails, need to pick a replacement.
- Each process has a unique identifier which is comparable (ordered)  
• processes know the processes in the group for which a coordinator must  
be elected  
• Once an election starts, it concludes with all processes agreeing on who the  
new coordinator is  
• Once coordinator is known, messages to other members of the group from  
outside the group will be forwarded to the coordinator
#### Bully Algorithm  
Choose the surviving process with the highest id  
• When a process (Pk) notices that the coordinator is no longer alive, it starts an  
election  
• Pk sends election message to all processes with higher identifiers (e.g.  
Pk+1...Pn  
• If no one responds, then Pk is the highest id process still alive.  
• If a higher id process answer, it takes over.  
• If more than one higher id process gets the message, then they hold an  
election.
#### Zookeeper internal elections  
Server group called an ensemble  
• Ensemble looks like a single server, coordinated by a leader  
• Other servers in the group are followers and act as up-to-date standby  
• Each server has an identifier (id(s))  
• Each server s has a monotonically increasing counter tx(s) of the last  
transaction it handled  
• Leader performs a transaction (e.g. add node to namespace) and sends a  
copy of the transaction to followers to act on local copy of namespace.
