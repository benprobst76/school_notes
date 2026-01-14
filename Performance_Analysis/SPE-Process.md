# Software Performance Engineering (SPE) - Quick View
![[Pasted image 20260113131823.png]]
Object oriented systems present special problems for SPE  
– Functionality is decentralized  
– Collaborations are required to perform a given function  
– The interactions are difficult to trace caused by  
polymorphism  
– Unified Modeling Language (UML) helps reduce the impact  
of these problems.  
• SPE is tightly integrated with object-oriented notation, such as  
the UML

3  
Performance Analysis  
• Use object-oriented analysis or design model to derive a  
performance model  
• Use cases and scenarios provide a starting point for  
constructing performance models  
• Solving the performance model gives you feedback on  
performance to revise the object-oriented design  
• SPE is also language independent  
• SPE can be easily integrated into the software development  
processes, such as waterfall model, and spiral model

## 1. SPE Process for Object-Oriented Systems
For OO systems, SPE adapts general techniques to the development process and artifacts like Unified Modeling Language (UML). The process is **use-case driven**, focusing on scenarios that describe workloads significant to performance.

### The 9-Step SPE Process:
1.  **Assess Performance Risk:** Determine the level of effort needed. High risk (critical mission, high user load) requires significant SPE effort.
2.  **Identify Critical Use Cases:** Select use cases critical to system operation or user-perceived responsiveness. This is risk-driven (where will failure occur?).
3.  **Select Key Performance Scenarios:** Pick frequent or critical scenarios within the critical use cases. These are often represented by Sequence Diagrams.
	![[Pasted image 20260113131605.png]]
4.  **Establish Performance Objectives:** Define quantitative criteria (Response Time, Throughput, Resource Constraints) and Workload Intensities (arrival rates, concurrent users).
    *   *Note:* Objectives should ideally cover end-to-end business tasks, not just "time in the box".
5.  **Construct Performance Models:** Translate sequence diagrams into **Execution Graphs** to represent processing steps.
	![[Pasted image 20260113131533.png]]
6.  **Determine Software Resource Requirements:** Estimate the computational needs for each step (e.g., number of SQL queries, messages sent, screens displayed).
7.  **Add Computer Resource Requirements:** Map software resources to hardware demands (CPU instructions, Disk I/O, Network packets) using an **Overhead Matrix**.
	![[Pasted image 20260113131746.png]]
8.  **Evaluate the Models:** Solve the execution graph (software model) and system model.
    *   *If problems found:* Modify product concept (find alternatives) or Revise objectives (if no feasible alternative exists).
9.  **Verify and Validate Models:** Ensure the model accurately reflects the software and that predictions match reality. (Ongoing parallel activity).

## 2. Case Study: ATM System
The chapter uses an ATM system to illustrate the process:
*   **Critical Use Case:** `CustomerTransaction` (Withdraw, Deposit, Balance).
*   **Modeling:**
    *   A UML Sequence Diagram (with loops and alternatives) is translated into an **Execution Graph**.
    *   Processing steps: `getPIN`, `processTransaction`, `terminateSession`, etc.
*   **Resource Requirements:**
    *   *Software:* "Screens", "Host interactions", "Log entries".
    *   *Hardware:* Maps "1 Screen" to specific CPU/Display service times.
*   **Evaluation:** Initial "no contention" (best-case) analysis showed ~29s response time against a 30s objective, indicating a need for optimization or careful monitoring.

## 3. SPE in the Unified Software Process
SPE should be integrated into the software development lifecycle (e.g., Unified Process) to avoid over-reliance on individuals and ensuring it isn't skipped.

*   **Risk-Driven:** Address performance risks early (Inception/Elaboration phases).
*   **Iterative:** Models start with best/worst-case estimates and are refined as the design details solidify in later iterations.
*   **Feasibility:** Early iterations may focus specifically on prototyping critical components to validate performance assumptions.

## 4. Performance Solutions
SPE is not just about measuring; it's about creating software with good performance.

*   **Performance Principles:** General design strategies (heuristics) that consistently produce good results.
*   **Performance Patterns:** Best practices/solutions for common performance and scalability problems.
*   **Performance Antipatterns:** Common mistakes ("what not to do") and their refactorings (how to fix them).
*   **Implementation Solutions:** Late life-cycle techniques for tuning and fixing code when architectural changes are no longer feasible.
