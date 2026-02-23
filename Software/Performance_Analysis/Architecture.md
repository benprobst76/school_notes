# Software Architecture
As the size and complexity of software systems increase, the design problem goes beyond algorithms and data structures. Designing and specifying the overall system structure (Software Architecture) emerges as a new kind of problem.
## Software Architecture Issues
- Organization and global control structure.
- Protocols of communication, synchronization, and data access.
- Assignment of functionality to design elements.
- Physical distribution.
- Scaling and performance (See [[Software-Performance-Engineering]]). 
- Selection among design alternatives.
## State of Practice
There is not currently a well-defined terminology or notation to characterize architectural structures. However, good software engineers make common use of architectural principles when designing complex software. These principles represent rules of thumb or idiomatic patterns that have emerged informally over time, while others are carefully documented as industry standards.
## Descriptions of Architectures
- **Camelot:** Based on the client-server model and uses remote procedure calls both locally and remotely to provide communication among applications and servers.
- **Helix:** Abstraction layering and system decomposition provide system uniformity to clients while allowing Helix to accommodate a diversity of autonomous devices.
- **Distributed OO:** A distributed, object-oriented approach to managing information.
- **Concurrent Compiler:** The easiest way to make a canonical sequential compiler into a concurrent compiler is to pipeline the execution of the compiler phases. A more effective way is to split source code into segments processed concurrently before merging.
## Standard Architectures
- **ISO/OSI Reference Model:** A layered network architecture.
- **X Window System:** A distributed windowed user interface architecture based on event triggering and callbacks.
- **NIST/ECMA Reference Model:** A generic software engineering environment architecture based on layered communication substrates.
### The Toaster Model
![[Pasted image 20260210081730.png]]
## Intuition About Architecture
Few named software architectures exist not because there are so few, but because there are so many. Intuition is developed by looking at:
- Hardware Architecture
- Network Architecture
- Building Architecture
## Describing a Software Architecture
The architecture of a specific system is a collection of:
- **Computational Components:** Nodes in a graph (procedures, modules, processes, tools, databases).
- **Connectors:** Edges representing interactions (procedure calls, event broadcasts, database queries, pipes).
## Architectural Styles
An Architectural Style defines a family of systems in terms of a pattern of structural organization. It determines:
- The vocabulary of components and connectors.
- A set of constraints on how they can be combined (e.g., topology constraints like "no cycles", or execution semantics like "parallel execution").
### Architecture vs. Architectural Styles
- **Architecture:** A formal arrangement for a specific problem; more complete and complex.
- **Architectural Style:** Abstracts elements and formal aspects from various specific architectures.
- **Relationship:** An architecture can consist of several architectural styles. Styles encapsulate important decisions and emphasize constraints on elements.
## Determining an Architectural Style
To understand a style, answer:
1. What is the structural pattern? (Components, connectors, constraints)
2. What is the underlying computational model?
3. What are the essential invariants?
4. What are common examples of its use?
5. What are the advantages and disadvantages?
6. What are common specializations?
---
# Catalog of Architectural Styles
## Pipe and Filter Style
Suitable for applications requiring a defined series of independent computations on ordered data. A component reads streams on inputs and produces streams on outputs.
![[Pasted image 20260210081834.png]]
- **Components (Filters):** Apply local transformations and often compute incrementally.
- **Connectors (Pipes):** Conduits for streams.
> [!info] Invariants
> - Filters do not share state.
> - Filters do not know the identity of upstream/downstream filters.
> - Correctness does not depend on the order of incremental processing.

> [!abstract] Specializations
> - **Pipelines:** Linear sequences.
> - **Batch Sequential:** Each filter processes all input before producing any output.

> [!example] Examples
> - **Unix Shell Scripts:** `cat file | grep Erroll | wc -l`
> - **Traditional Compilers:** Lexical analysis $\to$ parsing $\to$ semantic analysis $\to$ code generation.

> [!success] Advantages
> - Easy to understand overall behavior as a composition.
> - Supports reuse (filters agree on data format).
> - Easy maintenance and enhancement.
> - Supports throughput and deadlock analysis.
> - Naturally supports concurrent execution.

> [!failure] Disadvantages
> - Not good for interactive systems.
> - Excessive parsing/unparsing leads to performance loss.
## Object-Oriented Style
Suitable for protecting related bodies of information (data). Data representations and operations are encapsulated.
![[Pasted image 20260210081953.png]]
- **Components:** Objects.
- **Connectors:** Function and procedure invocations (methods).
> [!info] Invariants
> - Objects preserve data integrity (invariants).
> - Data representation is hidden from other objects.

> [!abstract] Specializations
> - Distributed Objects.
> - Objects with Multiple Interfaces.

> [!success] Advantages
> - Implementation changes don't affect clients (encapsulation).
> - Systems as collections of autonomous interacting agents.

> [!failure] Disadvantages
> - Objects must know the identity of others to interact.
> - Changing an object's identity requires modifying all callers.
> - Side effect problems (A and B both use C; B's changes to C affect A).
## Implicit Invocation Style
Suitable for loosely-coupled collections of components. Useful for applications reconfigured on the fly (e.g., changing service providers).
- **Mechanism:** Instead of direct invocation, a component announces (broadcasts) events. Other components register interest and associate procedures with events.
> [!info] Invariants
> - Announcers do not know which components are affected.
> - No assumptions about processing order or whether any processing occurs.

> [!example] Examples
> - **Programming Environments:** Debugger announces breakpoint; Editor scrolls to source line.
> - **DBMS Triggers:** Enforce integrity constraints.
> - **User Interfaces:** Separate presentation from data management.

> [!success] Advantages
> - Strong support for reuse (register new components for existing events).
> - Eases system evolution.

> [!failure] Disadvantages
> - Components have no idea who responds or when they finish.
> - No control over response order.
## Layered Style
Suitable for applications with distinct classes of services organized hierarchically.
- **Mechanism:** Each layer provides service to the layer above and acts as a client to the layer below.
- **Components:** Typically collections of procedures.
- **Connectors:** Procedure calls under restricted visibility.
![[Pasted image 20260210082049.png]]
> [!abstract] Specializations
> - Exceptions made for non-adjacent layers to communicate (for efficiency).

> [!example] Examples
> - **Layered Communication Protocols:** (e.g., ISO/OSI).
> - **Unix Layered Architecture.**

> [!success] Advantages
> - Based on increasing levels of abstraction.
> - Enhancements affect at most two other layers.
> - Reuse: Interchangeable implementations with identical interfaces.

> [!failure] Disadvantages
> - Not all systems structure easily into layers.
> - Performance requirements may force coupling of high-level functions to low-level implementations.
## Repository Style
Suitable for establishing and maintaining a complex central body of information manipulated in various ways.
- **Components:** A central data structure and independent components operating on it.
- **Connectors:** Procedure calls or direct memory access.
> [!abstract] Specializations
> - Data changes trigger computations.
> - Persistent (disk) vs. In-memory data structures.

> [!example] Examples
> - Programming Environments.
> - Graphical Editors.

> [!success] Advantages
> - Efficient storage for large data amounts.
> - Published sharing model (schema).
> - Centralized management (backup, security, concurrency).

> [!failure] Disadvantages
> - Must agree on a data model a priori.
> - Difficult to distribute data.
> - Data evolution is expensive.
## Table Driven Interpreter Style
Suitable when the most appropriate language/machine for a solution is not directly available.
![[Pasted image 20260210082135.png]]
- **Components:** Execution engine (state machine) and three memories (engine state, pseudo-program, program state).
- **Connectors:** Procedure calls and direct memory access.
> [!example] Examples
> - **Compilers/VMs:** Java, Smalltalk.
> - **Rule Based Systems:** Prolog, Coral.
> - **Scripting:** Awk, Perl.

> [!success] Advantages
> - Simulation of non-implemented hardware.
> - Portability across platforms.

> [!failure] Disadvantages
> - Indirection slows execution (mitigated by JIT compilers in Java).
### Java Architecture
![[Pasted image 20260210082230.png]]
## Client-Server Style
Suitable for distributed data and processing.
![[Pasted image 20260210082306.png]]
- **Components:** Servers (stand-alone service providers) and Clients (service requesters).
- **Connector:** The Network.
> [!example] Examples
> - **File Servers:** Primitive sharing.
> - **Database Servers:** Client passes SQL; server processes query.
> - **Object Servers:** ORBs allow objects to communicate across network/machine boundaries.

> [!success] Advantages
> - Straightforward data distribution.
> - Location transparency.
> - Heterogeneous platform support.
> - Easy to add/upgrade servers.

> [!failure] Disadvantages
> - No central register of services makes discovery hard.
### RPCs vs ORBs
![[Pasted image 20260210082339.png]]
### Database Connection Example (JDBC)
```java
// Load Oracle driver
Class.forName("oracle.jdbc.driver.OracleDriver");
// Establish connection
Connection con = DriverManager.getConnection("jdbc:oracle:thin:@dbaprod1:1544:SHR1_PRD", username, passwd);
// Create statement
Statement stmt = con.createStatement();
stmt.executeUpdate("CREATE TABLE Sells (bar VARCHAR2(40), beer VARCHAR2(40), price REAL)");
// Transaction Management
con.setAutoCommit(false);
try {
    stmt.executeUpdate("INSERT INTO Sells VALUES('Bar Of Foo', 'BudLite', 1.00)");
    con.commit();
} catch (Exception e) {
    con.rollback();
}
```
## Process-Control Style
Suitable for maintaining output properties at reference values (Set Points).
- **Components:** Process Definition (manipulation mechanisms) and Control Algorithm.
- **Connectors (Data Flows):**
    - **Controlled Variable:** Value to be controlled.
    - **Input Variable:** Measures process input.
    - **Manipulated Variable:** Changed by the controller.
    - **Set Point:** Desired value.
    - **Sensors:** Obtain values.
### Control Systems
- **Feed-Back:** Controlled variable is measured and used to adjust the process.
- **Open-Loop:** Information about process variables is not used for adjustments.
