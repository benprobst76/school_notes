---
tags:
  - distributed-systems
  - replication
  - scalability
  - content-delivery
Week: 7
Assessments:
  - Quiz-3
  - Quiz-2
---
# Replication
Replication is a fundamental technique used in distributed systems to improve availability and performance.

### Why Replicate?
- **Improve Reliability**: By maintaining multiple copies of data, the system can continue to operate even if one server crashes (e.g., DNS primary and secondary servers). This relates to [[Fault-Tolerance|Dependability and Fault Tolerance]].
- **Performance**: Placing copies of data closer to clients reduces latency. Additionally, multiple replicas help prevent a single server from being overwhelmed by too many client requests, improving [[Scalability]].
- **Problem: Consistency**: The primary challenge with replication is keeping the replicas [[Synchronization|synchronized]].
- **Local Caches**: A client's local cache might become out-of-date compared to the server version.
- **Update Propagation**: When data is updated, changes must be propagated between servers.
- **Trade-off**: There is a spectrum between **Strong Consistency** and **Weak Consistency**. Implementing consistency often requires complex protocols and impacts performance.

## Distributed Storage
Implementing distributed storage is inherently difficult due to conflicting goals.
### Why is it Hard?
- **Performance Optimization**: Splitting data across multiple servers (sharding) improves performance but complicates data management. See [[System-Architectures]] for more on system organization.
- [[Fault-Tolerance]]: To handle the loss of servers, data must be replicated.
- **The Consistency Cycle**: Replication leads to potential inconsistency. Ensuring consistency requires extra work and bandwidth, which results in a performance penalty.

### Data Replication for Scalability
According to Robert Morris, distributed data is a key abstraction. A simple storage interface that handles distribution and replication is incredibly useful, as many other distributed system components assume such a system already exists.

When scaling via replication, two primary questions must be answered:
1. **Where to put replica servers?** (Infrastructure/Placement)
2. **Where to put replica content?** ([[Content-Distribution]])

---

## Server Location
Deciding where to place physical or virtual server instances is a long-term strategic decision involving contracts, space, and energy.

- **Objective:** Find the "best $K$ out of $N$" locations.
- **Complexity:** Most optimization approaches are computationally expensive.
- **Decision Criteria:**
	- **QoS:** Minimizing latency and maximizing bandwidth for users.
	- **Consistency:** The cost (latency/bandwidth) of propagating updates between these servers.
	- **Energy:** The financial and environmental cost of running replicas that may not be heavily utilized.

## Content Location
Replicas can be categorized based on how they are initiated and maintained.

### 1. Permanent Replicas
These are "always-on" copies typically maintained by the system owner.
- **Cluster-based Replicas:** Multiple web servers within a single data center.
- **Mirrored Servers:** Geographically distributed copies where clients are routed to the nearest instance.
- **Share-Nothing Architecture:** Servers do not share memory or disk storage, enhancing fault isolation.

### 2. Server-Initiated Replicas
Replicas dynamically created by a server to enhance performance based on demand.
- **Temporary copies:** Usually created for a specific period to handle a spike in regional traffic.
- **Counting Accesses:** The "origin" server tracks the geographic source of requests. If a specific region exceeds a threshold, a replica is pushed to a server closer to that region.

> [!tip] Placement Thresholds
> Servers use several thresholds to manage dynamic replicas:
> - **Replication Threshold ($R$):** If requests exceed $R$, create a new replica.
> - **Deletion Threshold ($D$):** If requests fall below $D$, remove the replica to save resources.
> - **Migration Threshold ($M$):** If a different server is significantly closer to the majority of traffic, move the replica there.

### 3. Client-Initiated Replicas (Client Caches)
Local storage managed by the client to temporarily store copies of data (e.g., browser cache, DNS resolver cache).
- **Staleness Management:** The client must decide when cached data is no longer valid.
- **Time-Based (TTL):** Data is marked with a "Time To Live" (e.g., DNS TTL or Web Cookie expiration).
- **Validation:** The client asks the server if the resource has changed (e.g., an `HTTP HEAD` request or `If-Modified-Since`).
