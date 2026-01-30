ELEC 477 Distributed Systems
Practice Exam - ANSWER KEY

1. (4 marks) Give a brief (one or two line) description of each of the following terms as they were discussed in class.

    a. Location Transparency
    The ability for users or applications to access a resource without knowing its physical location on the network.

    b. Idempotent Operation
    An operation that can be performed multiple times without changing the result beyond the initial application (e.g., reading a value).

    c. Middleware
    A software layer that sits between the operating system and distributed applications, providing common services (like naming, communication, or authentication) to simplify development.

    d. Stratum 1 Server (NTP)
    A time server that is directly connected to a high-precision reference clock (like a GPS receiver or atomic clock).


2. (2 marks) In the context of Publish-Subscribe architectures, subscribers need to indicate which events they want to receive. What are the two main models for subscription discussed in class?
    1. Topic-based subscription (matching a named channel/subject).
    2. Content-based subscription (matching attributes or values within the event data).


3. (3 marks) Failures in distributed systems are often categorized by their duration and recurrence. Name and briefly describe the three types of faults discussed.
    1. Transient: Occurs once and then disappears.
    2. Intermittent: Occurs semi-regularly or sporadically (e.g., a loose connection).
    3. Permanent: Persists until the faulty component is repaired or replaced.


4. (4 marks) Compare **Stateless Servers** and **Stateful Servers**. Give two distinct advantages of using a Stateless Server design.
    1. Fault Tolerance / Recovery: If a server crashes, it can restart immediately without needing to restore client state; no session data is lost because none was held.
    2. Independence: Clients and servers are independent; a client can switch to a different server instance seamlessly (easier load balancing).


5. (2 marks) What is the primary purpose of using an **Interface Definition Language (IDL)** (such as in gRPC or CORBA) when developing a distributed application?
    To define the service interface and data structures in a language-neutral way, allowing client and server stubs to be generated for different programming languages (enabling interoperability).


6. (6 marks) The following sequence describes events and messages between three processes (P1, P2, P3). All vector clocks start at (0,0,0).

    a. (4 marks) Determine the Vector Clock timestamp for **Event C**, **Event D**, **Event E**, and **Event F**.
    
    - Event A (P1 internal): (1, 0, 0)
    - Event B (P2 internal): (0, 1, 0)
    
    - **Event C** (P1 Send M1): **(2, 0, 0)**
    
    - **Event D** (P2 Recv M1):
      Local P2 becomes (0, 2, 0).
      Msg timestamp is (2, 0, 0).
      Max((0, 2, 0), (2, 0, 0)) = **(2, 2, 0)**
    
    - **Event E** (P2 Send M2): **(2, 3, 0)**
    
    - **Event F** (P3 Recv M2):
      Local P3 becomes (0, 0, 1).
      Msg timestamp is (2, 3, 0).
      Max((0, 0, 1), (2, 3, 0)) = **(2, 3, 1)**

    b. (2 marks) List the events that are in the causal history of Event F (excluding Event F itself).
    
    Events: A, B, C, D, E.
    (Note: A -> C -> D -> E -> F and B -> D -> E -> F)

6. (3 marks) RPC systems define specific semantics for how many times a remote procedure is executed. Briefly explain the difference between **"At Least Once"** and **"At Most Once"** semantics. Which one is required for non-idempotent operations?
    - **At Least Once**: The client keeps retrying until it gets a confirmation. The operation may run multiple times if the response is lost.
    - **At Most Once**: The system ensures the operation runs 0 or 1 time, typically by using transaction IDs to filter duplicates on the server.
    - **Required for Non-idempotent**: "At Most Once" is required (to prevent things like double-charging a credit card).


7. (3 marks) Scalability is a primary goal of distributed systems. Name and briefly describe the three dimensions of scalability discussed in the course introduction.
    1. **Size Scalability**: The ability to add more users and resources (machines) to the system easily.
    2. **Geographical Scalability**: The ability for the system to perform well even when users and resources are far apart.
    3. **Administrative Scalability**: The ability for the system to span multiple independent administrative organizations easily.


8. (4 marks) In the context of Mutual Exclusion, compare the **Token-Based** approach with the **Centralized Coordinator** approach. Provide one advantage and one disadvantage for each.
    - **Token-Based**:
        - Advantage: Guaranteed fairness (everyone gets the token eventually) and no single bottleneck (though the ring itself can be slow).
        - Disadvantage: If the token is lost, it is difficult to detect and regenerate.
    - **Centralized Coordinator**:
        - Advantage: Simple to implement and understand.
        - Disadvantage: The coordinator is a single point of failure and a potential performance bottleneck.
