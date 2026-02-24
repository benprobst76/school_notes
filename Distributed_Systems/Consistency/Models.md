A **Consistency Model** acts as a contract between a distributed data store and its clients, defining the expected results of read and write operations.
### Main Issue: Conflicting Operations
The core problem is ensuring that all conflicting operations are executed in the same order across all replicas.
- **Write-Write Conflict**: Two concurrent write operations occur. The system must decide which value ultimately gets stored.
- **Read-Write Conflict**: A read operation occurs concurrently with a write operation. The system must determine whether the old or new value is returned.
- **Performance Impact**: Guaranteeing a global order for all operations is extremely costly. Systems often weaken consistency requirements to minimize this impact.
### Strong Consistency
The system behaves as if it were a single server, even though it is distributed.
![[Pasted image 20260210134620.png]]
#### Naive Replication
In a simple approach, clients write to all replicas, and readers read from any single replica. However, without proper coordination (like [[Synchronization]]), this can easily lead to inconsistencies.
![[Pasted image 20260210134717.png]]
### Sequential Consistency
The result of any execution is the same as if the operations of all processes were executed in some sequential order, and the operations of each individual process appear in this sequence in the order specified by its program.
- **Global Order**: There must be a single global order of operations seen by everyone.
- **Program Order**: The order of operations from a single process must be preserved.
![[Pasted image 20260210134825.png]]
### Causal Consistency
A weaker form of consistency that distinguishes between related and unrelated operations.
- **Causally Related**: Writes that are potentially causally related (e.g., a read followed by a write that depends on that read) must be seen by all processes in the same order.
- **Concurrent Writes**: Writes that are not causally related may be seen in different orders by different processes.
### Eventual Consistency
The system guarantees that if no new updates are made to a data object, eventually all accesses will return the last updated value.
- **Propagation**: All writes to one data store must eventually be propagated to all others.
- **Strong Eventual Consistency**: Conflicting updates are resolved in a specific, deterministic order at all replicas (e.g., using CRDTs or specific timestamps).
- **Weak Eventual Consistency**: Only requires that conflicts are reported, often requiring manual resolution or simple "last writer wins" strategies.

## Continuous Consistency
Continuous consistency provides a measure of the error that can be tolerated between replicas, as not all replicas are updated simultaneously.
*   **Numerical Error**:
    *   **Absolute**: The maximum difference between stored values (e.g., a pressure sensor difference must be less than $0.02 \text{ mPa}$).
    *   **Relative**: The maximum percentage difference (e.g., values must be within $5\%$ of each other).
*   **Weight**: Measured by the number of pending updates (e.g., Server 2 is behind Server 1 by $2$ updates).
*   **Staleness**: Measured by the time since the last update. This is useful for values that change slowly.
*   **Ordering**: Replicas may temporarily hold updates in different orders. Once an agreement is reached, some updates may be rolled back and reapplied.
*   **Conit (Consistency Unit)**: The basic unit used to measure consistency.

## Client Consistency Models
While data-centric models focus on a system-wide view, client-centric models focus on the perspective of a single client. These models assume that simultaneous updates to the same resource by different clients are infrequent.
*   **Examples**: iCloud, OneDrive, or shared documents that are rarely modified at the same time.
### Consistency for Mobile Users
A mobile user may access a data store at one location, then move to a different location served by a different server. Consistency must be guaranteed for that specific client, even if updates haven't propagated to the new server yet.
**Notation**:
*   $W_1(x_2)$: Write operation by Process 1 producing version $x_2$ of $x$.
*   $W_1(x_i; x_j)$: Write produces $x_j$ based on a previous version $x_i$.
*   $W_1(x_i | x_j)$: Process 1 produces two values concurrently (potential conflict).

### Monotonic Reads
If a process reads the value of data item $x$, any successive read by that same process must return the same value or a more recent value.
*   **Example**: Reading your personal calendar or email while traveling. You should always see at least what you saw at your previous location, plus any new updates.
**Consistent Monotonic Read**:

| Location 1 ($L_1$) | Location 2 ($L_2$) |
| --- | --- |
| $W_1(x_1)$ | |
| | $W_2(x_1; x_2)$ |
| $R_1(x_1)$ | |
| | $R_1(x_2)$ |
*Process 1 reads $x_1$, moves to $L_2$, and reads $x_2$ (which is newer).*

**Inconsistent Monotonic Read**:

| Location 1 ($L_1$) | Location 2 ($L_2$) |
| :----------------- | :----------------- |
| $W_1(x_1)$         |                    |
|                    | $W_2(x_1 \| x_2)$  |
| $R_1(x_1)$         |                    |
|                    | $R_1(x_2)$         |
*It is unclear if $x_2$ is newer than $x_1$ because the writes were concurrent ($W_1 \| W_2$).*

### Monotonic Writes
A write operation by a process on a data item $x$ must be completed before any successive write operation on $x$ by the same process.
*   **Guarantee**: A write to a copy of $x$ only happens if all previous writes by that process have already been applied to that copy.

**Consistent Monotonic Write**:

| Location 1 ($L_1$) | Location 2 ($L_2$) |
| :----------------- | :----------------- |
| $W_1(x_1)$         |                    |
|                    | $W_2(x_1; x_2)$    |
|                    | $W_1(x_2; x_3)$    |
*Process 1 writes $x_1$, moves to $L_2$, and writes $x_3$ only after $x_2$ (which followed $x_1$) is applied.*
### Read Your Writes
the effect of a write operation by a process on data item $x$ will always be seen by successive reads of $x$ by the same process.
*   **Example**: Updating a password or editing a web page. Your browser should show the newest version you just saved, not a cached or unpropagated older version.

### Writes Follow Reads
A write operation on data item $x$ by a process following a previous read on $x$ by the same process is guaranteed to take place on the same or a more recent value of $x$ than the one that was read.
*   **Example**: Posting a reaction to an article. The reaction (write) should only be visible if the original article (read) is also present, ensuring the write "pulls in" the corresponding previous write.