---
Assessments:
  - Quiz-3
Week: 7
tags:
  - consistency
  - distributed-systems
  - GFS
aliases:
  - GFS
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
