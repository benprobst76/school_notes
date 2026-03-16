### Event-Driven Systems (Reactive)
- Responds to asynchronous external events.
- **Examples**: Pacemakers, elevators, aircraft flight controls, spark delivery based on cylinder position.

### Time-Driven Systems
- Operates on a fixed time loop, sampling inputs and generating outputs at synchronous intervals.
- **Examples**: Irrigation systems, automated pet feeders.

### Mixed Systems
- Combines both approaches.
- **Examples**: 
	- **Traffic Lights**: Usually time-based but triggered by sensors.
	- **Video Games**: Internal gameplay loops (time-driven) vs. user input (event-driven).


## Basic Idea
- A style is defined in terms of:
    - The way that components are connected to each other
    - The data exchanged between components
    - How the component and connectors are configured into a system
- **Connector**: A mechanism or technique that mediates communication or coordination between components (e.g., [[Threads-&-RPC|RPC]], Messages, Streaming). 

## Layered Architecture
![[Pasted image 20260119201625.png]]
![[Pasted image 20260119201632.png]]
### Application Layers
Traditionally 3 layers:
- **Application interface layer**: Interface to the user (e.g., browser), or an API for other applications to use (Google Maps API).
- **Processing Layer**: Functions of our application - can be complex and involve multiple processes and functions.
- **Data layer**: Persistent storage of data used by the processing layer. Used in many distributed systems that provide some functionality using traditional databases (e.g., Queen's SOLUS).
![[Pasted image 20260119201646.png]]
### Objects Style
- Components are objects connected through procedure calls.
- Objects may be on different machines, methods involved across a network (CORBA/Java RMI/AJAX).
- Objects encapsulate data and offer methods on the data, hiding the internal representation.

## Shared Data Space
- Components communicate and cooperate through a shared data space.
- **Tuples** are a record of values, not all the same type, can be an arbitrary number of values.
- Components can store any type of tuple into the shared data space.
- Retrieve and/or delete a tuple using pattern matching template (values for some of the members of the tuple).
- Processes that want to exchange information agree on the number and type of arguments for the data they want to exchange, tuple space is automatic.
### Linda Tuple Space
- `out(t)`: Add tuple to the tuple space. Calling twice with the same tuple gives duplicates (called a multiset).
- `in(t)`: Remove a tuple matching template `t` and return to process (destructive read).
- `rd(t)`: Obtain a copy of tuple matching template `t` (non-destructive read).
- Supports multiple tuple spaces, and a tuple in one tuple space can contain a reference to another tuple space.

### Example 1: Network File Systems
**Two models:**
1.  **Remote Manipulation** (NFS, CIFS, AFS, etc.):
    - Files remain on server, incremental access or changes to the file are sent from the client to the server and processed on the server.
    - Allows multiple clients to access the same file at the same time.
2.  **Upload/Download** (iCloud Drive, One Drive, Dropbox, etc.):
    - Files are automatically downloaded to the client and uploaded after changes are made. The entire file is downloaded.
    - Concurrent access to a file requires the applications (Word, Excel, Pages, etc.) to collaborate directly.

### Example 2: Web Server
- **File Access Model**: Retrieval of Hypertext Markup Files.
- **Dynamic Page Model** (CGI, PHP, Perl, Python):
    - Retrieval of Hypertext Markup Files.
    - URI gives a path to an executable, possible parameters added to the resource.
    - Resource identification.

![[Pasted image 20260119201958.png]]

## Organizations
- **Vertical Distribution**: Layered Architectures.
- **Horizontal Distribution**:
    - Client or Server (or both) are split into logically equivalent parts, but each part is operating on its own share of the data set.
- **Peer to Peer**:
    - Processes are all equal, each process a client and server at same time.
- **Microservices**:
    - System is divided into small object/[[Threads-&-RPC|RPC]] components that are distributed through the system, clients compose calls to different components to complete a task.