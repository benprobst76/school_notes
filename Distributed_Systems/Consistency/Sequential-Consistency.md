---
tags:
  - distributed-systems
  - consistency
  - replication
  - GFS
---
# Sequential Consistency: Replicated-Write Protocols

## Active Replication
In active replication, each replica maintains its own update operation.
- When a write or update occurs on one copy, the operation is forwarded to all other replicas.
- **Sequencer:** A designated primary server responsible for ordering updates to ensure consistency across all replicas.
- **Primary-Based Replication:** Requires all replicas to agree on the update before completion.
- **Read Access:** Can be performed on any single replica, as they are all kept consistent.

## Quorum-Based Protocols
Quorum-based protocols use a voting mechanism to manage reads and writes across multiple servers.

### Voting Mechanism
- Reads and writes require the agreement of multiple servers.
- **Write Quorum ($N_W$):** To update an item, a client must get agreement from at least $50\% + 1$ replicas.
	- The version code is updated on all servers in the quorum.
	- This results in a mixed set of versions across the system.
- **Read Quorum ($N_R$):** A read operation must contact a specific number of replicas.
	- If all contacted replicas have the same version, it is the most recent.
	- If versions are mixed, the latest version is considered correct.

> [!info] Quorum Constraints
> - $N_W > N/2$: Prevents write-write conflicts by ensuring two write quorums must overlap.
> - $N_R + N_W > N$: Prevents read-write conflicts, guaranteeing at least one server in the read quorum has the most recent update.
> - A larger write quorum allows for a smaller read quorum.

### Common Quorum Strategies
- **ROWA (Read One, Write All):** $N_R = 1, N_W = N$. Optimized for high read performance but vulnerable to any single server failure during writes.
- **Write to All (New Version):** Reading from any single replica (if updated) provides the latest data.
- **Partial Quorums:** e.g., Writing to a subset (A-C) ensures that reading from another subset (C-L) will hit at least one updated item.

![[Pasted image 20260226124657.png]]

> [!warning] Conflict Example
> If two clients write to overlapping but distinct quorums (e.g., Client 1 writes to $ABCEFG$, Client 2 writes to $DHIJKL$), a subsequent read of $ABCEFGH$ might retrieve two different values both claiming to be the latest version (e.g., version 10).

## Client-Centric Consistency
Focuses on ensuring consistency for a single client as they move between different locations or replicas, even if the system is inconsistent between different clients.

### Operation Tracking
- Each write is assigned a **globally unique identifier** by the origin server.
- The identifier includes information about the original replica.
- Clients maintain two sets:
	- **Read Set:** Write IDs relevant to previous read operations.
	- **Write Set:** Identifiers assigned to the client's own writes.

### Consistency Models
- **Monotonic Read Consistency:** If a client reads from a replica, subsequent reads will return that value or a more recent one. If a replica is behind, it pulls updates to catch up.
- **Monotonic Write Consistency:** Ensures that a client's writes are processed in the order they were issued. Replicas pull missing writes from the client's write set before applying new ones.
- **Read Your Writes:** A client will always see the effects of its own previous writes. The client passes its write set to the replica, which catches up before performing the read.
- **Write Follows Read:** A write operation by a client following a read is guaranteed to take place on the same or a more recent version of the data.

---

# Case Study: Google File System (GFS)

## Motivation
Google needed a way to index the web (Large Corpus of documents) and perform computations like word frequency and PageRank.
- **Challenges:** Exchanging dictionaries between servers is expensive.
- **Solution:** [[Map-Reduce]] and a specialized distributed file system.

## Map-Reduce Overview
- **Input:** (Key, Value) pairs.
- **Map Operation:** $(k1, v1) \to \text{list}(k2, v2)$. Produces intermediate pairs.
- **Shuffle:** Consolidation of all values with the same key.
- **Reduce Operation:** $(k2, \text{list}(v2)) \to \text{list}(k3, v3)$. Applied in parallel to process consolidated values.

> [!example] Word Count Example
> - **Map:** `(Doc, Content) -> (word, 1)` for every word.
> - **Reduce:** `(word, [1, 1, 1]) -> (word, 3)`.

## GFS Architecture
GFS is designed for inexpensive commodity hardware that fails frequently. It handles a modest number of very large files (Multi-GB).

### Key Design Points
- **Workload:** Large streaming reads, sequential appends, and high bandwidth requirements over low latency.
- **Master-Slave Design:**
	- **Single Master:** Stores all metadata.
	- **Chunk Servers:** Store file data in fixed-size **64 MB chunks**.
- **Replication:** Default is 3 replicas per chunk.
- **Consistency:** Relaxed model; no client-side caching.

![[Pasted image 20260226124335.png]]

### Write Operations
1. **Small Writes:**
	- Client asks Master for the chunk's primary and secondary replicas.
	- Client pushes data to all replicas (stored in a buffer).
	- Once acknowledged, Client sends a commit request to the **Primary**.
	- Primary determines the order and tells secondaries to commit.
2. **Atomic Record Appends:**
	- Client asks Master for the location of the last chunk.
	- Client pushes data to replicas.
	- **Primary** checks if the data fits in the current chunk.
		- If not, it pads the chunk and tells the client to retry on a new chunk.
		- If it fits, the primary appends the data and tells secondaries the offset.
	- If it fails at any replica, the client retries.

> [!important] GFS Consistency Guarantee
> GFS does **not** guarantee that replicas are byte-wise identical. It guarantees that data is written **at least once** as an atomic unit and at the same offset across replicas. This may result in duplicate data or padding ("lulls") which must be handled by the application.
