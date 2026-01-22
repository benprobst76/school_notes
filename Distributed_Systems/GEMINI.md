# Project Context: Distributed Systems Notes

## Directory Overview
This directory contains study notes and summaries related to a course on **Distributed Systems**. It focuses on the theoretical foundations of distributed computing as well as specific implementation details, likely relevant to C++ programming.

## File Summaries

*   **`Introduction.md`**: Foundations of Distributed Systems.
    *   **Core Concepts**: Distinction between Distributed and Decentralized systems.
    *   **Perspectives**: Process, Communication, Coordination, Naming, Consistency, Fault Tolerance.
    *   **Goals**: Resource sharing, Transparency (Access, Location, Replication, Failure), and Scalability.
    *   **Reliability**: Dependability concepts (Availability, Safety, CIA) and Fault Tolerance (types of faults).

*   **`Architectures.md`**: System design patterns and styles.
    *   **Styles**: Layered, Object-based, RESTful (Resources, Operations), Shared Data Space (Tuples, Linda), Publish-Subscribe.
    *   **Middleware**: Network File Systems (NFS, Upload/Download), Web Servers.
    *   **Organization**: Vertical vs Horizontal distribution, P2P, Microservices.

*   **`Communication.md`**: Mechanisms for inter-process communication.
    *   **Models**: Persistent vs Transient, Synchronous vs Asynchronous.
    *   **Messaging**: Sockets (ZeroMQ), MPI (High Performance), Message Oriented Middleware (MOM, Message Queues).
    *   **Patterns**: Request-Reply, Pub-Sub, Pipeline.
    *   **Multicasting**: Application-level multicasting, Overlay Networks, Flooding.

*   **`Network-Programming.md`**: Practical implementation using the UNIX Socket API.
    *   **Basics**: IP addresses, Ports, Byte Ordering (Big/Little Endian), DNS Resolution (`getaddrinfo`).
    *   **Protocols**: TCP (Reliable, Connection-oriented) vs UDP (Unreliable, Datagrams).
    *   **Operations**: `socket`, `bind`, `listen`, `accept`, `connect`, `sendto`, `recvfrom`.
    *   **Advanced**: I/O Multiplexing (`poll`), Multicast configuration.

*   **`Marshalling-&-Serialization.md`**: Data representation for network transmission.
    *   **Concepts**: Serialization vs Marshalling, Text vs Binary formats.
    *   **Technologies**: Manual encoding, ASN.1, Google Protocol Buffers (Protobuf) syntax and C++ usage, CORBA IDL/CDR.
    *   **Details**: Handling endianness, field types, versioning.

*   **`Threads-&-RPC.md`**: Concurrency and Remote Procedure Calls.
    *   **Threads**: C++ `std::thread` usage.
    *   **RPC**: Concept of Client/Server Stubs, Interface Definition.
    *   **Semantics**: At least once, At most once, Exactly once execution guarantees.
    *   **Challenges**: Parameter passing (by value/ref), Binding/Discovery, Failure modes (lost messages, crashes), Orphaned computations.

*   **`Cpp-Overview.md`**: C++ language features relevant to the course.
    *   **Memory Management**: Smart Pointers (`unique_ptr`, `shared_ptr`, `weak_ptr`), Deep vs Shallow copies.
    *   **Language Features**: Classes, Namespaces, Templates, Lambdas, STL Containers (`vector`).
    *   **Concurrency**: Threading basics.

## Usage
These files are intended for:
1.  **Review**: Quick reference for distributed systems concepts and definitions.
2.  **Study**: Preparing for exams or understanding the theoretical underpinnings of distributed infrastructure.
3.  **Reference**: Looking up specific C++ threading syntax or distributed system design goals (like transparency and scalability).
When editing files be sure not to delete any content unless it is already covered or not relevant to the file,
### Formatting
Any math should be returned as latex that can be easily copy and pasted into a $$ $$
block. When math spans multiple lines use the \begin{aligned} and \end{aligned} latex functions. Any code should be returned as a code block 
```
```
Without any number lines. Notes created should be clear and explanatory.  When asked to "reformat" notes, rewrite them so that they are in proper markdown format and are optimized to be used in obsidian. Do not remove any details but if needed, include extra details or examples for concepts if it helps makes the notes clearer and easier to understand. Do not include a line break after paragraphs, headers or sections. Create obsidian links to other files for references to other topics.