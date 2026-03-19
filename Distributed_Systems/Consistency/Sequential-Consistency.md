---
tags:
  - distributed-systems
  - consistency
  - replication
  - GFS
Assessments:
  - Quiz-3
Week: 7
---
# Sequential Consistency: Replicated-Write Protocols

## Active Replication
In active replication, each replica maintains its own update operation.
- When a write or update occurs on one copy, the operation is forwarded to all other replicas.
- **Sequencer:** A designated primary server responsible for ordering updates to ensure consistency across all replicas.
- **Primary-Based Replication:** Requires all replicas to agree on the update before completion.
- **Read Access:** Can be performed on any single replica, as they are all kept consistent.

A [[Quorum]] is required for a majority vote to manage consistency of reads and writes across servers. 
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

An example using map reduce is the [[Google-File-System]].