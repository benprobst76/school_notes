Election algorithms are a critical component of [[Synchronization]] and [[Coordination/Synchronization|Coordination]] in distributed systems. They are used to elect a single process to act as a coordinator or leader for a specific task or resource management.
## Coordinators
Some [[System-Architectures|distributed architectures]] require a single process to act as a coordinator to manage resources, synchronize activities, or handle specific requests.
- **Selection Methods**:
	- **Manual**: Selecting a coordinator manually results in a centralized system, which introduces a single point of failure.
	- **Dynamic**: Choosing a coordinator dynamically allows the system to recover if the current coordinator fails.
- **Assumptions**:
	- Each process has a unique, comparable identifier (e.g., an integer ID).
	- Every process knows the identities of all other processes in the group, though they may not know which ones are currently active.
- **Election Goals**:
	- The election must conclude with all active processes agreeing on the same new coordinator.
	- Once a coordinator is elected, external messages to the group are forwarded to this leader.
## Bully Algorithm
The Bully Algorithm selects the surviving process with the highest identifier as the new coordinator.
- **Election Process**:
	- When a process $P_k$ notices the coordinator has failed, it initiates an election.
	- $P_k$ sends an `ELECTION` message to all processes with higher identifiers ($P_{k+1}, P_{k+2}, \dots, P_n$).
	- If no process responds, $P_k$ is the highest surviving process and becomes the coordinator, notifying all other processes with a `COORDINATOR` message.
	- If a process with a higher ID responds, it takes over the election process, and $P_k$'s role in initiating that specific election ends.
	- If multiple higher-ID processes receive the message, they hold their own election among themselves.
## Zookeeper Internal Elections
[[Mutual-Exclusion#Case Study Election-Algorithms Zookeeper Internal Elections Zookeeper|Zookeeper]] uses a group of servers called an **ensemble** to provide high availability and fault tolerance.
- **Roles**:
	- **Leader**: Coordinates the ensemble and handles all write requests.
	- **Followers**: Act as up-to-date standbys, processing read requests and participating in the leader election.
- **Identifiers**:
	- Each server $s$ has a unique identifier $id(s)$.
	- Each server $s$ maintains a monotonically increasing counter $tx(s)$, representing the last transaction it handled.
- **Transaction Flow**: The leader performs transactions (e.g., adding a node to the namespace) and propagates them to followers to ensure consistency across the local copies of the namespace.
## Ring Algorithm
The Ring Algorithm assumes processes are organized in a logical ring overlay network, where each process knows its successor.
- **Election Process**:
	- A process starts an election by sending an `ELECTION` message containing its own ID to its successor.
	- Each subsequent node adds its own ID to the list within the message and passes it along.
	- If a successor is unresponsive, the sender skips it and attempts to send the message to the next node in the ring.
	- When the message returns to the initiator (detected when it receives a message already containing its ID), it identifies the process with the highest ID in the list.
	- The initiator then sends a `RESULT` message around the ring to inform everyone of the new leader.
- **Concurrency**: Multiple processes may start elections simultaneously, resulting in multiple message chains; however, they will all converge on the same highest ID.
![[Pasted image 20260202105153.png]]
## Raft Elections
[[Raft]] is a consensus algorithm designed for fault-tolerant services, prioritizing understandability over the complexity of Paxos.
- **Configuration**: Requires an odd number of servers (typically 3 or 5) to achieve a majority (quorum).
- **Server States**:
	- **Follower**: Initial state; responds to requests from leaders and candidates.
	- **Candidate**: State used during an election to solicit votes.
	- **Leader**: Handles all client requests and sends heartbeats.
- **Terms**: Time is divided into terms, starting at $0$. Each term begins with an election.
- **Heartbeats**: The leader sends regular heartbeat messages to followers to maintain authority and prevent new elections.
### Selecting a New Leader
- **Election Trigger**: If a follower $s_1$ does not receive a heartbeat or transaction within a specific **timeout** period, it transitions to the **candidate** state.
- **Voting**:
	- The candidate $s_1$ increments the term $t$ to $t +  1$ and votes for itself.
	- It sends `REQUEST_VOTE` messages to other servers.
	- A follower $s_2$ votes for $s_1$ if it hasn't already voted in term $t+1$ and $s_1$'s log is at least as up-to-date as its own.
- **Outcome**: The candidate that receives a majority of votes becomes the leader for the remainder of the term.
- **Deadlocks**: To prevent "split votes" where no candidate gets a majority, Raft uses **randomized election timeouts**. If a term ends without a leader, a candidate will timeout, increment the term to $t + 2$ and start a new election.
![[Pasted image 20260202105421.png]]
![[Pasted image 20260202105436.png]]
## Paxos
Paxos is the foundational consensus algorithm that Raft was designed to simplify.
- **Usage**: Both Paxos and Raft are widely used in production.
- **Implementations**:
	- **etcd**: Uses Raft for distributed name resolution in Kubernetes.
	- **Other Raft Users**: Hazelcast, MongoDB, Neo4j, RabbitMQ, ScyllaDB, Splunk.
- **Further Reading**: Paxos and its variants will be discussed in more detail later in the term regarding [[Fault-Tolerance]].