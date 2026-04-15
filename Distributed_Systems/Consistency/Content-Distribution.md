---
tags:
  - distributed-systems
  - consistency
  - replication
  - leases
Week: 7
Assessments:
  - Quiz-3
---
# Content Distribution: Replica Update Management
When a replicated resource is updated, the system must decide how to keep other copies consistent. The choice depends on available bandwidth and the read-to-write ratios at each replica.
## Update Propagation Options
There are three primary ways to handle an update:
1. **Propagate Notification:** Inform other copies that their data is out of date (Invalidation).
2. **Transfer Data:** Send the updated data to other copies (Passive Replication).
3. **Propagate Operation:** Send the update operation itself to be executed on other copies (Active Replication).

### Invalidation Protocols (Propagate Notification)
- Copies are marked as "out of date."
- **Advantage:** Low overhead for the notification itself.
- **Usage:** Data is only pulled when a client actually tries to access it.
- **Efficiency:** Effective if there are multiple updates before a read occurs, as it avoids intermediate data transfers.

### Passive Replication (Transfer Data)
- Useful when the **read-to-write ratio is high**.
- Can transfer the **entire resource** or just a **delta** (the specific changes).
- Bandwidth usage is proportional to the amount of data modified.

## Push vs. Pull Protocols

| Feature | Push-Based (Server-Client) | Pull-Based (Client-Server) |
| :--- | :--- | :--- |
| **Initiator** | Server pushes updates to replicas. | Replicas request updates from server. |
| **Consistency** | High (replicas kept up-to-date). | Periodic (depends on pull frequency). |
| **Overhead** | Server must track all replica locations. | Server is stateless regarding replicas. |
| **Efficiency** | Can waste bandwidth if data isn't used. | Can have latency on first read. |

## Hybrid Approaches: Leases
A **Lease** is a promise by a server to push updates to a replica for a specified period. Once the lease expires, the replica must pull updates again.

### Adaptive Lease Types
> [!abstract] Age-Based Leases
> Used for resources that haven't changed in a long time. If it hasn't changed recently, it's unlikely to change soon, so a longer lease is granted.

> [!abstract] Renewal Frequency Leases
> If a replica frequently requests a renewal (high access rate), the server increases the lease duration to reduce overhead.

> [!abstract] State-Based Leases
> If the server is overloaded, it reduces lease times to lower its push-notification burden, shifting the cost back to the clients.

## Transmission Mechanisms
- **Unicast:** Sending separate messages to every replica.
- **Multicast:** Sending one message that reaches all replicas.
	- Efficient on local networks.
	- Difficult and complex over wide geographic areas (WAN).

---

# Consistency Protocols

Consistency protocols implement specific [[Models|Consistency Models]] like [[Sequential-Consistency]].

## Primary-Based Protocols
In these protocols, each data item has a designated "Primary" copy.

### Primary Backup Protocols
- A single fixed server acts as the primary for a specific data item.
- **Writes:** All write/update operations are forwarded to the primary. The primary forwards the write to backups and **blocks** until all acknowledgments are received.
- **Reads:** Can be performed on any server (primary or backup).
- **Tradeoff:** Blocking updates ensure strong consistency but can impact performance. Non-blocking updates improve speed but risk consistency in the event of a crash.

![[Pasted image 20260226123955.png]]

### Primary Backup with Local Write
- The primary copy "migrates" to the server currently requesting the write.
- Only one server can be the primary for a specific item at a time.
- Requires a **distributed lock** mechanism.
- **Use Case:** Disconnected mobile clients. A mobile device becomes the primary before disconnecting, allowing it to perform multiple updates locally without network overhead. Other clients cannot update that item until the mobile device reconnects and relinquishes primary status.
