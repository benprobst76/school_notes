> If you can build your system on a single computer without building a distributed system, do it that way - Robert Morris (MIT)

*   Distributed systems have a lot of added complexity.
*   Distributed systems use multiple computers to solve a specific problem.
*   Note there is a difference between the application that is running on top of a distributed system vs the infrastructure that makes a distributed system possible.
*   This class is about the infrastructure (similar to other DS classes).

## Decentralized vs. Distributed
Textbook distinguishes between decentralized and distributed:
*   **Decentralized**: Spread over multiple locations due to the nature of the problem.
    *   Examples: Air traffic control, industrial control systems, electronic mail, distributed data (federated systems).
*   **Distributed**: Use of multiple computers for systems that could otherwise be a single system. Adds redundancy, reliability, throughput, or increased resources.
    *   Examples: Search engines, Content Distribution Networks, Databases.
*   Differs in how they respond to partial failures in the systems.

Not as distinct as the textbook suggests:
*   Some components of decentralized systems are distributed systems. Example: Air Traffic Control.
*   Older ATC (1970s) were single computer systems.
*   Flight plan management system.
*   Collision prediction system.

## Perspectives
*   **Process perspective**: Processes have particular tasks to accomplish.
*   **Communication perspective**: Processes have to communicate to accomplish one or more shared tasks.
*   **Coordination**: Processes have to coordinate actions.
*   **Naming**: Resources are distributed through the system. Processes and resources have some sort of name.
*   **Consistency perspective**
*   **Fault tolerance perspective**

## Goals
*   **Resource Sharing**: Share storage, services.
*   **Distribution Transparency**:
    *   **Access transparency**: Access a process or data item without knowing the details of the machine (intel/ARM), storage representation.
    *   **Location transparency**: Doesn't matter where it is.
    *   **Replication transparency**: Multiple copies.
    *   **Failure transparency**

## Dependability
*   **Availability**: System is operating correctly and available to respond to users.
*   **Reliability**: System can run continuously without failure.
*   **Safety**: Minimize impact if the system fails.
*   **Recoverability**
*   **Maintainability**
*   **Security ([[CIA-Triad|CIA]])**

## Fault Tolerance
*   A single computer is relatively fault tolerant.
*   When you multiply the components: many machines, many disks, network switches, network cables:
    *   Low probability all of them fail.
    *   High probability some of them fail.
    *   10s of 1000s of components means multiple failures per day.

## Failures & Faults
*   A system fails when it cannot provide one or more services.
*   The part of the system state that failed is an **error**.
*   The cause of an error that led to the failure is a **fault**.
*   **Transient fault**: Occurs once and disappears.
*   **Intermittent fault**: Occurs semi-regularly, such as a bad contact.
*   **Permanent**: Lasts until fixed.

### Fault Tolerance Tools
*   NV Storage (checkpoints, saved state)
*   Replication
*   Consistency
    *   `put(k,v)`, `get(k) -> v`
    *   Strong consistency (banks)
    *   Weak consistency

## Scalability
*   **Size scalability**: Add machines, disk, network.
    *   Some problems may scale easily.
    *   Many do not scale easily.
    *   Costs of coordination, communication.
*   **Geographical scalability**: Access to remote resources.
    *   Partitioning resources appropriately.
*   **Administrative scalability**: Multiple organizations.