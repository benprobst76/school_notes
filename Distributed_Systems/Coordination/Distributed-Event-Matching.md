This note covers the mechanisms for matching events to subscriptions in a distributed system, focusing on scalability and routing strategies.

## Publish and Subscribe Review
In a publish-subscribe system:
*   **Publishers**: Publish notifications of events ($N$) that contain specific attributes.
*   **Subscribers**: Subscribe to events based on the value of attributes ($S$).
*   **Matching**: When a subscription matches an event, the notification is sent to the subscriber. This may include the event data itself, or the subscriber may request the data after receiving the notification.

The system must perform two core functions:
1.  **Match**: A function $match(S, N)$ that returns true if the subscription matches the notification.
2.  **Notify**: Deliver the notification to the subscriber when a match occurs.

**The Challenge**: How to implement the matching function in a scalable manner.

## Centralized Matching
*   **Topic-Based**: Both $S$ and $N$ are associated with a specific topic (a single set of attributes with single values). Each topic can be handled by a specific server; if a match is found, the notification is forwarded.
*   **Content-Based**: A subscription is defined as a set of attributes with constraints on their values.
    *   Example: $-80.25 < \text{longitude} < -78.722$
    *   Example: $x \in \{\text{green, yellow}\}$
*   **Problem**: Content-based matching is significantly harder to scale than topic-based matching.

## Scaling Up
To scale, work is divided across multiple servers dynamically.
*   $sub2node(S)$: Maps a given subscription $S$ to a set of rendezvous servers.
*   $not2node(N)$: Maps a given notification $N$ to a subset of servers.
*   **Requirement**: There must be at least one server in the intersection of both sets to ensure a match is found.
*   For topic-based matching, hashes of topic names are typically used to select rendezvous servers.

## Distributed Matching Strategies
Matching can be distributed across multiple servers called **brokers**, which are organized into an overlay network.
### Flooding
1.  **Flood Subscriptions**: Subscriptions are broadcast to all brokers. Every broker stores every subscription. When a broker receives a notification, it forwards it to all matching local subscribers.
![[Pasted image 20260213190025.png]]
2.  **Flood Notifications**: Subscriptions are stored only at the nearest broker, and notifications are broadcast to all brokers.
![[Pasted image 20260213190128.png]]

**Trade-offs**:
*   Flooding consumes significant network and broker resources.
*   Scalability is an issue for content-based subscriptions.
*   Best suited for local networks.
*   Used by **TIBCO Rendezvous** (with optimizations like local network broadcasting and point-to-point messaging).

### Selective Routing
Brokers are organized into an overlay network that forms an acyclic undirected graph (a tree).
*   **Leaves**: Brokers.
*   **Internal Nodes**: Routers (though a physical machine may act as both).
*   **Filter Tables**: Each broker maintains a table of subscription filters.
*   **Routing Tables**: Routers use these to route notifications only toward brokers with matching subscriptions.
![[Pasted image 20260213190211.png]]

**Overlapping Conditions**:
If multiple subscribers have overlapping conditions:
*   Sub 3: $-76.64 < \text{longitude} < -76.54$
*   Sub 5: $-78.1 < \text{longitude} < -76.60$
An event matching both would be routed from $Broker 1 \to Router 1 \to Router 3$, then duplicated and sent to both $Broker 5$ and $Broker 3$.

## Location in Distributed Systems
### Physical Location
*   **GPS**: Uses 72 satellites with atomic clocks.
*   A minimum of 4 visible satellites is required to determine a 3D position and precise time.

### Logical Location
Physical proximity does not always reflect network costs or topology.
*   Example: Two computers in adjacent houses might be on different ISPs (e.g., Cogeco vs. Bell). Traffic between them might route through a distant city (Kingston $\to$ Toronto $\to$ Kingston) rather than directly.
*   Logical location is critical for optimizing [[Architectures#Overlay-Networks|Overlay Networks]].

### Content Delivery Networks (CDN)
CDNs like Netflix use location to optimize delivery:
*   **Control Plane**: AWS is used for account management and UI.
*   **Data Plane**: Video delivery is bandwidth-intensive. CDN servers are placed directly within major provider networks (TMobile, AT&T, Bell, Cogeco).
*   **Benefits**: Limits total backbone traffic, improves latency, and reduces bandwidth costs.

## Geometric Overlay Networks
Nodes are assigned positions in an $m$-dimensional geometric space where distance represents a performance metric (e.g., latency).
*   **Network Coordinates System**: The simplest version uses latency (RTT) between nodes as the distance.
*   **Centralized Positioning**: A node calculates its position relative to predefined "landmark" nodes with known coordinates. This helps determine which server is the "closest" or best choice for a client.
