ELEC 477 Distributed Systems
Practice Exam
Time: 25 Minutes

Instructions: Total 21 marks. Closed Book.
Answer all questions in the space provided.

1. (4 marks) Give a brief (one or two line) description of each of the following terms as they were discussed in class.

    a. Location Transparency
    
    <When the location of the servers is hidden and not relevant to the client for communication.>
    
    b. Idempotent Operation
    
    <An operation that can be executed multiple times without changing the result beyond the initial execution.>
    
    c. Middleware
    
    <A layer in the network that completes intermediary procedures for communication>
    
    d. Stratum 1 Server (NTP)
    
    <A time server that is directly connected to a reference clock for Network Time Protocol>


2. (2 marks) In the context of Publish-Subscribe architectures, subscribers need to indicate which events they want to receive. What are the two main models for subscription discussed in class?

    <Topic based - subscribe to all in the channel 
    Content based - subscribe to specific events with matching attributes >


3. (3 marks) Failures in distributed systems are often categorized by their duration and recurrence. Name and briefly describe the three types of faults discussed.

    <Transient failure - when a failure occurs once and not again
    Permanent failure - failure remains until it is fixed
    Intermittent  failure - A failure that occurs sporadically throughout operation >		


4. (4 marks) Compare Stateless Servers and Stateful Servers, Give two distinct advantages of using a Stateless Server design.

    <Stateless does not retain information about the client between requests while stateful does. Stateless is advantages can recover without having to restore client state. A client can switch to a different server without having to share state>


5. (2 marks) What is the primary purpose of using an **Interface Definition Language (IDL)** (such as in gRPC or CORBA) when developing a distributed application?

    <To provide a standard interface for communication between distributed processes allowing stubs to be generated for different programming languages.>


6. (3 marks) RPC systems define specific semantics for how many times a remote procedure is executed. Briefly explain the difference between **"At Least Once"** and **"At Most Once"** semantics. Which one is required for non-idempotent operations?

    <At least once the RPC executes the request 1 or moire times
    At most once the RPC executes the request 0 or one times
    At most once is required for non-idempotent operations>


7. (3 marks) Scalability is a primary goal of distributed systems. Name and briefly describe the three dimensions of scalability discussed in the course introduction.

    < **Size Scalability**: The ability to add more users and resources (machines) to the system easily.
    **Geographical Scalability**: The ability for the system to perform well even when users and resources are far apart.
    Administrative Scalability**: The ability for the system to span multiple independent administrative organizations easily.
 >


8. (4 marks) In the context of Mutual Exclusion, compare the **Token-Based** approach with the **Centralized Coordinator** approach. Provide one advantage and one disadvantage for each.

    <The token  based apporaoch is a process a token which allows only it to interact with the chared reasource. In the >
