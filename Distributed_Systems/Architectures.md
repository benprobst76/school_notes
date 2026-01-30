
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
## RESTful Architectures
Resource-based architecture. Collection of resources, managed by components.
- Resources may be added, removed, retrieved, or modified by remote applications.
- Identified using a single naming scheme.
- All services use the same interface.
- Messages are self-described.
- **Stateless**: Once a service executes the operation on behalf of a client component, the service forgets everything about the client component.
### Operations
Derived from HTTP protocol:
- `POST`: Create a new resource.
- `GET`: Retrieve the state of a resource.
- `DELETE`: Delete a resource.
- `PUT`/`PATCH`: Modify a resource.
- Typically run over HTTP.
- **Catch**: Have to do a lot with parameters.
### Blog Service Example
Assume one blog per username (if you want two blogs you need two usernames).
**Resources:**
- **Author Profile**: Only one, cannot be created, only modified.
- **Article**: Main resource, multiple articles per blog.
- **Topics**: Identifiers attached to an article to aid in searching for related articles.
- **Comments**: Other users can attach comments to articles.
**API Examples:**
- `GET https://myblog.server.ca/user/articles`
    - Responds with a list of ids.
    - Parameters: `topic` (a topic name), `sort` (date created, date updated, topic), `dir` (asc, desc).
- `GET https://myblog.server.ca/user/articles?topic=RTPS&sort=created&dir=asc`
- `GET https://myblog.server.ca/user/topics`
    - Responds with a list of topics used to tag articles in this blog.
- `POST https://myblog.server.ca/user/articles` (Create new article)
    - Contents of the put request contains article title, topics, content, description, etc.
    - Returns resource id (e.g., say 45873, or self assigned in contents of PUT, e.g., NewDogsName).
- `PUT https://myblog.server.ca/user/articles/NewDogsName`
    - Update content such as add another topic tag.

So far the architectures require that the client/sender know (or find out) the identity of the server or resource.
- Invoke a procedure or method, access a resource.
- *What about a looser organization of components that cooperate to solve some problem?*
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

## Publish and Subscribe
- Components can publish events, and subscribe to events.
- An event published by one component can be received by multiple subscribers.
- A subscriber can receive events from multiple publishers.
### How are events matched and Data sent?
- Some set of attributes for each event.
    - **Topic based subscription** ($attribute = value$)
    - **Content based subscription** ($attribute \in set$)
    - Possibly both.
- If an event is matched:
    - Notification and subscriber must request the data.
    - Data is sent directly to the subscriber.
- Choice between **persistent** (message buffered to allow late subscribers to get historical data) and **transient** (no subscriber means that the event is lost).

### RTPS (Real-Time Publish-Subscribe)
- Topics are a triple of `(name, data-type, quality of service)`.
- Data type is an arbitrary record, expressed in IDL (see [[Marshaling-&-Serialization|Marshalling]]).
- IDL compiler generates reader and write for the type (uses CDR).
- Publishers publish topics by name.
- Subscribers subscribe to topics by name.
- Can also filter events by values in the data type (SQL like notation).

Events represent the status of an entity in the system (note not a component).
- Examples: an aircraft position, a flight plan, the current reading of a sensor.
- Events can be singletons that represent just a data item (e.g., current reading of a sensor).
- Entities can have identity, represented by a key.
- Events represent updates to the value of an entity (e.g., aircraft position).
- Typically last update is cached so new subscribers get the last value for a given key.

## Middleware
The Operating System of Distributed Systems.
- Commonly used components that need not be implemented by applications.

![[Pasted image 20260119201910.png]]

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

## Resources
- MIT 6.824: Distributed Systems (Spring 2020) - Robert Morris
- van Steen & Tanenbaum. “Distributed Systems”, 4th edition (2023)
