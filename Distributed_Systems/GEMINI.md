# Project Context: Distributed Systems Notes

## Directory Overview
This directory contains study notes and summaries for a course on **Distributed Systems**, focusing on theoretical foundations, architectural patterns, and practical C++ implementations.

### Core Topics
*   **`Introduction.md`**: Foundations, system vs. decentralized, goals (transparency, scalability), and dependability.
*   **`Architectures.md`**: Design styles (Layered, REST, Pub-Sub), middleware, and horizontal vs. vertical distribution.
*   **`Naming.md`**: Resource identification, entities/addresses, structured naming (DNS), and directory services (LDAP).
*   **`Threads-&-RPC.md`**: Concurrency (C++ threads) and Remote Procedure Call semantics and failure modes.
*   **`Cpp-Overview.md`**: C++ memory management (smart pointers), templates, and STL containers.

### Communication/
*   **`Models.md`**: Persistent vs. transient messaging, sync vs. async, ZeroMQ patterns, and MPI.
*   **`Network-Programming.md`**: UNIX Socket API (TCP/UDP), byte ordering, and I/O multiplexing.
*   **`Marshaling-&-Serialization.md`**: Data representation, Protobuf syntax, and manual encoding.

### Consistency/
*   **`Models.md`**: Data-centric (Sequential, Causal, Eventual) and Client-centric (Monotonic Reads/Writes, Read Your Writes).
*   **`Replication.md`**: Reliability/Performance trade-offs, server placement, and content distribution strategies.
*   **`Content-Distribution.md`**: Update propagation (Push vs. Pull), adaptive leases, and primary-based protocols.
*   **`Sequential-Consistency.md`**: Quorum-based protocols (Voting), active replication, and Google File System (GFS).

### Coordination/
*   **`Synchronization.md`**: Physical clocks (NTP), logical clocks (Lamport, Vector), and event ordering.
*   **`Mutual-Exclusion.md`**: Token-based vs. Permission-based (Ricart-Agrawala), decentralized voting, and ZooKeeper.
*   **`Election-Algorithms.md`**: Bully, Ring, and Consensus-based elections (Raft, Paxos).
*   **`Distributed-Event-Matching.md`**: Pub-Sub matching, overlay networks, and selective routing.

---

## Key Concepts Summary

### Naming & Resolution
*   **Flat Names**: Resolved via broadcasting, forwarding pointers, or home-based approaches.
*   **Structured Names**: Hierarchical graphs (DNS) resolved via iterative or recursive queries.
*   **Directory Services**: Search by attributes (LDAP) rather than just names.

### Communication Models
*   **Transient (Sockets, ZeroMQ)**: Messages exist only while apps are running. ZeroMQ provides high-level patterns: Request-Reply, Pub-Sub, Pipeline.
*   **Persistent (MOM)**: Messages stored in queues (AMQP). Decouples sender and receiver.
*   **Multicasting**: Application-level overlays and flooding vs. IP-level multicast.

### Consistency & Replication
*   **Strong Consistency**: Sequential order seen by all; high performance cost.
*   **Weak/Eventual Consistency**: Replicas converge over time; optimized for availability (CAP theorem).
*   **Quorums**: $N_R + N_W > N$ to prevent conflicts.
*   **GFS Case Study**: Optimized for large streaming reads and atomic appends on commodity hardware.

### Coordination & Synchronization
*   **Physical Time**: NTP for external synchronization; drift handled by strata.
*   **Logical Time**: Happened-before relation ($a \to b$). Vector clocks for detecting concurrency.
*   **Mutual Exclusion**: Centralized (bottleneck), Distributed (consensus), or Decentralized (voting).
*   **Elections**: Bully (highest ID), Ring (logical overlay), or Raft (majority quorum).

### Usage
1.  **Review**: Quick reference for distributed systems definitions.
2.  **Implementation**: Reference for C++ threading, socket programming, and Protobuf.
3.  **Strategy**: Design guidance for scalability, transparency, and fault tolerance.
