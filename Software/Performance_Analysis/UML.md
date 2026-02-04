# Unified Modeling Language (UML)
**Unified Modeling Language (UML)** is a standard language for specifying, visualizing, constructing, and documenting the artifacts for software systems, as well as for business modeling and other non-software systems.
*   The UML is a very important part of developing object-oriented software and the software development process.
*   The UML uses mostly graphical notations to express the design of software projects.

## UML Tools
*   **Standalone tools**
    *   Web-based tools (e.g., creately.com)
    *   Packages (e.g., ArgoUML)
    *   Draw.io
*   **Plugin tools**
    *   Integrate with IDEs (e.g., UML2-SDK for Eclipse)
*   **Tutorials**
    *   Many tutorials are available online.

## UML Building Blocks
*   **Things**
    *   Structural
    *   Behavioral
    *   Grouping
    *   Annotational
*   **Relationships**
*   **Diagrams**
![[Pasted image 20260119144533.png]]

## Stereotypes
*   A stereotype allows you to create new model elements.
    *   Derived from existing UML elements.
    *   Specific to a problem domain.
*   The stereotype is represented as:
    *   A string enclosed in guillemets (`<<string>>`).
    *   Graphic elements, such as an icon.

## Tagged Values
*   A tagged value allows you to include new properties for model elements.
*   A tagged value is a pair of strings — a tag and a value.
    *   `{name of a property = value of the property}`

## Constraints
*   A constraint is a condition or restriction that defines additional model semantics.
*   A constraint may be attached to an individual model element or a collection of elements.
*   A constraint is written as a string enclosed in braces (`{}`).

### Usage in SPE
*   **Stereotypes and Tagged Values** are used to capture information about the software execution environment (e.g., processor type, processor speed, network speed).
*   **Constraints** are used to specify [[Software-Performance-Engineering|performance]] objectives (e.g., response time or throughput).

## Class Diagrams
*   Classes are composed of three components: a name, attributes, and operations.
*   Class diagrams also display relationships such as containment, inheritance, and association.
*   Used to model class structure and contents.
![[Pasted image 20260119144723.png]]

## Use Cases
*   Use cases describe the behavior of a system or a subsystem.
*   **Actor:** An entity (e.g., a user or another system) external to the system that interacts directly with the system.
*   **Use Case:** A set of actions that a system performs and yields an observable result of value to an actor.
*   A use case does not reveal internal details of interactions between actors and the system.

### Use Case Diagrams
*   An actor can be represented by stick figures or stereotyped icons.
*   A use case is represented by an ellipse that contains the name of the use case.
![[Pasted image 2026011832.png]]

## Scenarios
*   A scenario is an instance of a use case.
*   A scenario consists of:
    *   Objects that participate.
    *   A sequence of messages (e.g., event or method invocation) that flow between the objects.
*   Messages describe the interactions between the objects involved in a particular execution of the software.

## Sequence Diagrams
*   Sequence diagrams demonstrate the behavior of objects in a use case by describing the objects and the messages they pass.
*   Sequence diagrams emphasize the **time-ordering** of messages.

### Creation and Destruction
*   **Activation:** Indicates a period of time when the object is busy performing some action (focus of control).
*   Object creation and destruction are indicated by stereotyped messages.
![[Pasted image 20260119144918.png]]

## Use Cases and Scenarios for SPE
*   The [[SPE-Process|SPE process]] focuses on the **critical use cases** and the **key performance scenarios** that describe those use cases.
*   **Critical Use Cases** are important to:
    *   The operation of the system.
    *   Responsiveness as seen by the user.
*   **Key Performance Scenarios** are:
    *   Executed frequently.
    *   Critical to the perceived performance of a system.

## Extensions to Sequence Diagram Notation
The notation is extended to represent:
*   Instance decomposition
*   References
*   Looping
*   Alternation (Option)
*   Concurrency

### Instance Decomposition
*   Used to indicate the refinement of sequence diagrams.
*   Makes it possible to attach another sequence diagram to an object lifeline.
*   **Benefits:**
    *   Elaborate the sequence diagram as more is learned about the system without re-drawing the original.
    *   Ensure consistency with the scenario as originally described.
    *   Used to elaborate high-level objects as the design evolves.

### Loop, Alternation, and Option
*   **Loop:** Used when a sequence of steps is repeated (e.g., `while`, `for`).
*   **Alternation (alt):** Used when several possible transitions can be executed (e.g., `if-then-else`, `switch-case`).
    *   A probability of execution can be attached to a given sequence.
*   **Option (opt):** Used to describe an optional step (e.g., `if` without `else`).
![[Pasted image 20260119145103.png]]

### References (ref)
*   References allow for referring to other sequence diagrams.
*   Used to reduce the complexity of sequence diagrams.

### Dispatch Algorithm Example
```
procedure dispatch
  foreach (order.lineitem)
    if (product.value > $10K)
      careful.dispatch
    else
      regular.dispatch
    endif
  endfor
  if (needsConfirmation) 
    messenger.confirm
  endif
end procedure
```
![[Pasted image 20260119145130.png]]

## Extending the UML
*   Extending the sequence diagrams
    *   Instance decomposition
    *   Reference
    *   Loop
    *   Alternation (alt)
    *   Option (opt)
hese mechanisms are
    *   stereotypes
    *   tagged values
    *   Constraints

## Specifying Time
The UML allows you to specify timing requirements through:
1.  **Timing Marks:** Denote the time at which a message or an event occurs.
    *   `message.sendTime()` — The time the message is sent.
    *   `message.receiveTime()` — The time the message is received.
2.  **Time Expressions:** Evaluate to an absolute or relative value of time.
    *   `after(500msec)` — Time elapsed after a particular state is entered.
    *   `when(t=08:00)` — The occurrence of an event at a specific time.
3.  **Time Constraints:** Express a constraint based on the absolute or relative value of time.
    *   Example: `{a.receiveTime() - b.sendTime() < 10 msec}`

### Performance Perspective on Time
Timeout conditions are not particularly useful for performance analysis. Instead, we focus on **Response Time**:
$$ \begin{aligned} \text{responseTime} &= j.\text{receiveTime}() - i.\text{sendTime}() \\ \{\text{responseTime}(j.\text{receiveTime}() - i.\text{sendTime}()) &< 5s\} \end{aligned} $$
Use time expressions like `responseTime()` to specify performance objectives.
![[Pasted image 20260119145440.png]]

## Concurrency
Modeling concurrency is important in the later stages of [[SPE-Process|SPE]] for evaluating contention effects. Concurrency issues are expressed by:
*   **Threads and Processes:**
    *   **Process:** Represents a flow of control executing in parallel with other processes. It has its own address space. Stereotype: `<<process>>`.
    *   **Thread:** Executes concurrently with other threads inside a process. All threads in a process share the same address space. Stereotype: `<<thread>>`.
*   **Coregions:** Sequence diagrams are usually strictly ordered in time. Coregions allow an exception to total ordering whereby messages within the coregion are unordered. They show the interleaving of messages in parallel processing.
*   **Parallel Composition:** Indicates sections of the sequence diagram executed in parallel. Allows flexible representation of parallel processing.
![[Pasted image 20260119145552.png]]

### Contention Effects
Early stages focus on software models without contention. Concurrency and synchronization properties are considered later when knowledge of the system increases.

## Component Diagram
Describes the organization and wiring of the physical components in a system.
*   **Component:** A logical unit block of the system; a higher abstraction than classes.
*   **Interface:** Describes a group of operations used (required) or created (provided) by components.
    *   Full circle: Provided/Created interface.
    *   Semi-circle: Required interface.
*   **Dependencies:** Drawn among components using dashed arrows.
*   **Port:** Represented using a square along the edge of a component. Used to expose interfaces.
![[Pasted image 20260119145642.png]]

## Deployment Diagram
Visualizes the hardware processors, nodes, devices, and the links of communication between them, as well as the placement of software files.
*   **Node:** Represents a physical computational resource (e.g., application server).
*   **Artifact:** Elements caused by a development process (e.g., libraries, archives, configuration files).
*   **Device:** A physical entity that executes one or more components, subsystems, or executables. Can be hardware or software.
*   **Communication Association:** Represented by a solid line between two nodes; shows the path of communication.
*   **Deployment Specifications:** A configuration file (text/XML) describing how an artifact is deployed on a node.
![[Pasted image 20260119145852.png]]
