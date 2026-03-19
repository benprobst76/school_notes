---
Week: 7
Assessments:
  - Quiz-3
---
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

