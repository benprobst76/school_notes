# Coordination in Distributed Systems
While previous topics focused on processes, threads, and communication (see [[Threads-&-RPC]]), processes in a distributed system must also cooperate and synchronize their actions. Coordination is essential for managing shared resources and ensuring the correct ordering of events, but it is significantly more difficult in distributed environments compared to single-system environments (see [[Distributed_Systems/Introduction]]). Coordination often involves mutual exclusion, event ordering, or electing a specific process to act as a coordinator through distributed election algorithms.
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
Note that if two events $a$ and $c$ have no causal relationship, their order is undefined           concurrency).
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
