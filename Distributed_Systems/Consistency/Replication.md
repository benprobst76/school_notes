Replication is a fundamental technique used in distributed systems to improve availability and performance.
### Why Replicate?
- **Improve Reliability**: By maintaining multiple copies of data, the system can continue to operate even if one server crashes (e.g., DNS primary and secondary servers). This relates to [[Distributed_Systems/Introduction#Reliability|Dependability and Fault Tolerance]].
- **Performance**: Placing copies of data closer to clients reduces latency. Additionally, multiple replicas help prevent a single server from being overwhelmed by too many client requests, improving [[Distributed_Systems/Introduction#Scalability|Scalability]].
- **Problem: Consistency**: The primary challenge with replication is keeping the replicas synchronized.
- **Local Caches**: A client's local cache might become out-of-date compared to the server version.
- **Update Propagation**: When data is updated, changes must be propagated between servers.
- **Trade-off**: There is a spectrum between **Strong Consistency** and **Weak Consistency**. Implementing consistency often requires complex protocols and impacts performance.
## Distributed Storage
Implementing distributed storage is inherently difficult due to conflicting goals.
### Why is it Hard?
- **Performance Optimization**: Splitting data across multiple servers (sharding) improves performance but complicates data management. See [[Architectures]] for more on system organization.
- **Fault Tolerance**: To handle the loss of servers, data must be replicated.
- **The Consistency Cycle**: Replication leads to potential inconsistency. Ensuring consistency requires extra work and bandwidth, which results in a performance penalty.
### Data Replication for Scalability
According to Robert Morris, distributed data is a key abstraction. A simple storage interface that handles distribution and replication is incredibly useful, as many other distributed system components assume such a system already exists.
