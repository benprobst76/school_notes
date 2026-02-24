ELEC 477 Distributed Systems
Practice Exam 2
Time: 30 Minutes

Instructions: Total 25 marks. Closed Book.
Answer all questions in the space provided.

---

1. (4 marks) Give a brief (one or two line) description of each of the following terms as they were discussed in class.

    a. Conit

    < Consistency unit used to measure the consitency >

    b. Zone Transfer (DNS)

    < >

    c. Lamport's Happened-Before Relation ($a \to b$)

    < >

    d. Location Independence (Naming)

    < >


2. (3 marks) Briefly describe **two** mechanisms used to resolve names in a **flat namespace**. For each, describe one drawback.

    < >


3. (3 marks) Explain the difference between **Iterative** and **Recursive** DNS name resolution. State one advantage of each.

    < >


4. (4 marks) Three processes $P_1$, $P_2$, $P_3$ each start with a Lamport clock value of $0$. The following events occur (in order):

    - $P_1$ sends message $m_1$ to $P_2$ (after 1 local event at $P_1$).
    - $P_2$ receives $m_1$, then immediately sends message $m_2$ to $P_3$.
    - $P_3$ receives $m_2$ (after 2 local events at $P_3$ have already occurred).

    a. What is the Lamport timestamp assigned to the **send** event of $m_1$?

    < >

    b. What is the Lamport timestamp assigned to the **send** event of $m_2$?

    < >

    c. What is the Lamport timestamp assigned to the **receive** event of $m_2$ at $P_3$?

    < >

    d. If we later observe that $C(a) < C(b)$ for two events $a$ and $b$ at different processes, can we conclude that $a$ causally preceded $b$? Briefly justify your answer.

    < >


5. (3 marks) Consider two vector clocks $V = (3, 1, 0)$ and $W = (2, 3, 0)$ from a system with 3 processes.

    a. Are these events causally related or concurrent? Justify your answer using the definition of vector clock comparison.

    < >

    b. Name one **disadvantage** of vector clocks compared to Lamport clocks.

    < >


6. (4 marks) Describe each of the following consistency models and give a short real-world scenario where it would be appropriate.

    a. **Sequential Consistency**

    < >

    b. **Causal Consistency**

    < >

    c. **Eventual Consistency**

    < >

    d. **Monotonic Reads** (client-centric)

    < >


7. (4 marks) In the context of distributed **mutual exclusion**, three algorithms were discussed: Centralized Coordinator, Distributed (Ricart-Agrawala), and Decentralized (voting).

    a. How many messages are required per entry/exit in the **Centralized** algorithm?

    < >

    b. How many messages are required per entry/exit in the **Distributed (Ricart-Agrawala)** algorithm for $N$ processes?

    < >

    c. What is the main drawback of the **Centralized** approach?

    < >

    d. In the **Decentralized** algorithm, a client requires a majority vote $m > N/2$ from $N$ coordinators. Why is a majority required rather than a unanimous vote?

    < >


8. (4 marks) Three election algorithms were discussed: Bully, Ring, and Raft.

    a. In the **Bully Algorithm**, which process is elected as the new coordinator?

    < >

    b. In the **Ring Algorithm**, how does the initiating process know the election is complete and determine the winner?

    < >

    c. In **Raft**, what triggers a follower to start a new election, and what mechanism prevents repeated split-vote deadlocks?

    < >

    d. **Raft** requires an odd number of servers (e.g., 3 or 5). Why?

    < >

---

## Answers

1.
a. **Conit (Consistency Unit)**: The basic unit used to measure consistency between replicas in a continuous consistency model (e.g., a single data item or row).

b. **Zone Transfer**: The process by which a secondary DNS name server synchronizes its records with the primary name server for a given zone, keeping the two in sync.

c. **Lamport's Happened-Before ($a \to b$)**: A strict partial order relation meaning event $a$ causally precedes event $b$. This holds if both are in the same process and $a$ occurs first, or if $a$ is the sending of a message and $b$ is the receipt of that same message (or transitively).

d. **Location Independence**: A name is location-independent if it remains valid even after the entity changes its address (e.g., moves to a different machine). The name resolution system must be updated to reflect the new address.

2. Two flat namespace mechanisms:
    - **Broadcast/Multicast**: Broadcast the entity's name on the network; the owner replies with its address. *Drawback*: Does not scale — suitable only for local networks, as broadcasting across the internet is infeasible.
    - **Forwarding Pointers**: When an entity moves, it leaves a pointer at the old address pointing to the new one. *Drawback*: Highly mobile entities create long chains of redirections, leading to latency or "too many redirects" errors.
    - *(Also acceptable)*: **Home-Based Approach**: A fixed "home address" tracks the entity's current mobile address. *Drawback*: The home must persist for the entity's lifetime; geographic distance between the client and the mobile entity can cause unnecessary latency even when both are nearby.

3. **Iterative**: The local resolver contacts a root server, which returns the address of the next name server (not the final answer). The resolver repeats this with each successive server until the name is fully resolved.
    *Advantage*: Reduces load on high-level name servers.

    **Recursive**: The root server takes full responsibility and queries child servers itself, passing the result back up the chain.
    *Advantage*: Allows effective caching at every level of the hierarchy.

4.
a. $P_1$ performs 1 local event: $C_1 = 1$. The send of $m_1$ is assigned timestamp $\mathbf{1}$.

b. $P_2$ starts at $0$. It receives $m_1$ with timestamp $1$: $C_2 = \max(0, 1) + 1 = 2$. The send of $m_2$ is assigned timestamp $\mathbf{2}$.

c. $P_3$ performs 2 local events: $C_3 = 2$. It receives $m_2$ with timestamp $2$: $C_3 = \max(2, 2) + 1 = \mathbf{3}$.

d. **No.** Lamport clocks only guarantee the converse: if $a \to b$ then $C(a) < C(b)$. However, $C(a) < C(b)$ does **not** imply $a$ caused $b$ — the events may be concurrent with no causal relationship. Vector clocks are needed to determine true causality.

5.
a. $V = (3,1,0)$ and $W = (2,3,0)$: For $V < W$ we need every element of $V \le W$ with at least one strictly less. Here $V[0]=3 > W[0]=2$, so $V \not< W$. Similarly $W \not< V$ since $W[1]=3 > V[1]=1$. The vectors are **incomparable**, so the events are **concurrent** (no causal relationship).

b. **Disadvantage**: Vector clocks grow in size with the number of processes ($O(N)$ per message), adding overhead to every message. They also track "potential causality" — links that may not represent true causal relationships — which can waste resources.

6.
a. **Sequential Consistency**: All operations appear as if executed in a single global sequential order, and each process's operations appear in program order within that sequence. The system behaves as if it were a single server. *Scenario*: A distributed replicated database where all nodes must agree on the exact order of all writes (e.g., a bank ledger).

b. **Causal Consistency**: Causally related writes must be seen by all processes in the same order; concurrent (causally unrelated) writes may be seen in different orders. *Scenario*: A social network where a reply to a post must always appear after the original post, but two unrelated posts can appear in any order.

c. **Eventual Consistency**: If no new updates are made, all replicas will eventually return the same (last written) value. *Scenario*: A shopping cart or DNS cache — stale values are acceptable for a short period, as long as the system converges.

d. **Monotonic Reads**: Any successive read by the same process must return the same or a more recent value than a previous read. *Scenario*: Reading your email while travelling — you should always see at least what you saw before, never an older message list.

7.
a. **3 messages**: Request, Grant, Release.

b. $2(N-1)$ messages: $N-1$ `ENTER` requests + $N-1$ `ACK` replies (plus $N-1$ `RELEASE` messages on exit, giving $2(N-1)$ total per entry cycle as stated in the comparison table).

c. **Single Point of Failure**: If the coordinator crashes, no process can access the resource until a new coordinator is elected. It is also a potential bottleneck since all traffic passes through it.

d. A majority ($m > N/2$) guarantees that **no two processes can hold the resource simultaneously** — two disjoint majorities cannot both be granted at the same time. A unanimous vote would be overly strict and would fail if even one coordinator is unavailable.

8.
a. The process with the **highest identifier** among all surviving processes.

b. The election message travels the entire ring. When the initiating process **receives a message that already contains its own ID**, the ring has completed one full circuit. The initiator scans the list of IDs in the message and selects the **highest ID** as the winner, then sends a `RESULT` message around the ring.

c. A follower starts an election when it does **not receive a heartbeat from the leader within its timeout period** (the leader is assumed to have failed). To prevent repeated split votes, Raft uses **randomized election timeouts** — each follower waits a different random duration, so one candidate typically starts before others and wins the majority before they wake up.

d. An odd number of servers ensures a **clear majority ($\lceil N/2 \rceil + 1$) can always be formed** without ties. With an even number, votes could split evenly (e.g., 2 vs 2 in a 4-server cluster), preventing any candidate from reaching a majority and causing repeated failed elections.
