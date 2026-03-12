---
title: RAFT Consensus Algorithm
tags:
  - distributed-systems
  - consensus
  - fault-tolerance
---
# RAFT Consensus Algorithm
Consensus involves reaching agreement on a single data value among a group of distributed processes or systems, even in the presence of failures. In a fault-tolerant process group, each non-faulty component must execute the same updates in the same order as every other non-faulty component.

## Overview
Raft is a consensus algorithm designed as an alternative to Paxos. It was developed by Diego Ongaro and John Ousterhout at Stanford University in 2014 with a primary focus on **understandability**.

### Real-World Applications
Raft is widely used in modern distributed systems:
- **etcd**: The primary configuration and naming service for Kubernetes.
- **Neo4j**: A graph database.
- **MongoDB**: A popular NoSQL database.
- **RabbitMQ**: Message queue middleware.

### State-Based Replication
The system is modeled as a **Replicated State Machine**. Commands are applied to a replica state (e.g., a Key-Value store) in a specific order to ensure all replicas remain consistent.
- **Problem: Split Brain**: In a two-server system, if a network partition occurs, both might proceed independently, leading to inconsistency.
- **Solution: Majority Vote**: Operations require a majority of *all* servers (Quorum) to proceed. With an odd number of servers (e.g., 3), a minority cannot form a majority, preventing divergent states.

## Server Architecture
A Raft server consists of:
1. **Replicated State**: The user-provided data (e.g., KV values).
2. **Log**: A persistent record of commands.
3. **Raft Library**: Manages the consensus logic, state transitions, and communication.

### Server States
At any given time, a server is in one of three states:
- **Leader**: Handles all client requests and manages log replication.
- **Follower**: Passive; responds to RPCs from leaders and candidates.
- **Candidate**: Used during elections to elect a new leader.

![[Pasted image 20260305111002.png]]

## Core Concepts
### Raft Terms
Terms act as a logical clock in Raft.
- Terms are periods of arbitrary length, numbered with consecutive integers.
- Each term begins with an **Election**.
- There is at most one leader per term.
- If a server's current term is smaller than another's, it updates its term and reverts to Follower state.

### Election Process
- **Election Timer**: Each follower has a randomized timer (to prevent split votes).
- **Trigger**: If a follower receives no communication (heartbeats) before the timer expires, it becomes a Candidate and starts a new election.
- **Candidate Actions**:
	1. Increment `currentTerm`.
	2. Vote for self.
	3. Send `RequestVote` RPCs to all other servers.
- **Outcome**: A candidate becomes leader if it receives votes from a majority of the cluster.

### Raft Messages (RPCs)
1. **Client Messages**: Instructions for the state machine (e.g., set key `x` to `5`).
2. **RequestVote RPC**: Candidates gather votes during elections.
3. **AppendEntries RPC**:
	- Used by the leader to replicate log entries.
	- Serves as a **heartbeat** (when empty) to reset follower election timers.

## The Raft Log
Logs are the mechanism by which the leader sequences operations.
- **Entries**: Contain the command and the term number when it was received by the leader.
- **Commit Index**: The highest log entry known to be committed (replicated on a majority).
- **Last Applied**: The highest entry applied to the state machine.

> [!info] Persistence
> Log entries are stored on disk. If a server crashes and recovers, the log is preserved. However, `commitIndex` and `lastApplied` are volatile.

![[Pasted image 20260305110505.png]]

## Raft Guarantees
Raft ensures safety through several key properties:
- **Election Safety**: At most one leader can be elected in a given term.
- **Leader Append-Only**: A leader never overwrites or deletes entries in its log; it only appends.
- **Log Matching**: If two logs contain an entry with the same index and term, the logs are identical up to that index.
- **Leader Completeness**: If a log entry is committed in a given term, it will be present in the logs of all future leaders.
- **State Machine Safety**: If a server has applied an entry at a given index, no other server will ever apply a different operation for that same index.

## Log Replication and Safety
### RPC Details
#### RequestVote RPC
- **Arguments**: `term`, `candidateId`, `lastLogIndex`, `lastLogTerm`.
- **Receiver Rule**: Reply `false` if `term < currentTerm`. Grant vote only if `votedFor` is null/candidateId AND the candidate's log is at least as up-to-date as the receiver's.

#### AppendEntries RPC
- **Arguments**: `term`, `leaderId`, `prevLogIndex`, `prevLogTerm`, `entries[]`, `leaderCommit`.
- **Consistency Check**: If the follower's log doesn't match the `prevLogIndex`/`prevLogTerm`, it rejects the request, forcing the leader to decrement the `nextIndex` and retry until a match is found.

### Election Restrictions
To ensure **Leader Completeness**, a server only votes for a candidate if:
1. The candidate has a higher term in its last log entry.
2. OR the candidate has the same last term AND its log is at least as long as the receiver's.

## Persistence and Optimization
### Snapshotting
As logs grow, they consume space and increase replay time after a crash.
- **Snapshots**: Capture the current application state and discard the log prior to that point.
- **InstallSnapshot RPC**: Used by the leader to bring a very slow or new follower up to speed if the necessary log entries have already been discarded.

### State Summary
| State | Type | Description |
| :--- | :--- | :--- |
| `currentTerm` | Persistent | Latest term seen |
| `votedFor` | Persistent | Candidate ID that received vote in current term |
| `log[]` | Persistent | Log entries |
| `commitIndex` | Volatile | Index of highest committed entry |
| `lastApplied` | Volatile | Index of highest entry applied to state machine |

## Operations
### Write Requests
1. Client sends command to Leader.
2. Leader appends to its log.
3. Leader sends `AppendEntries` to followers.
4. Once a majority acknowledge, the Leader commits the entry and applies it to its state machine.
5. Leader notifies followers of the commit in subsequent `AppendEntries`.

### Read Requests
- Reads are handled by the Leader.
- To prevent stale reads (in case the leader has been deposed but doesn't know it), the leader must exchange heartbeats with a majority of the cluster before responding to verify it is still the leader.

## References
- Ongaro, D., & Ousterhout, J. (2014). *In Search of an Understandable Consensus Algorithm*. Stanford University.
- [[Distributed-Event-Matching]]
- [[Mutual-Exclusion]]
