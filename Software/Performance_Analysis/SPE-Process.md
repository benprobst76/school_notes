# Software Performance Engineering (SPE) - Quick View
![[Pasted image 20260113131823.png]]
Object-oriented (OO) systems present unique challenges for Software Performance Engineering (SPE) due to their inherent structure:
*   **Decentralized Functionality:** Logic is spread across many classes rather than centralized.
*   **Complex Collaborations:** Functions require interaction between multiple objects.
*   **Tracing Difficulties:** Polymorphism and dynamic binding make it hard to statically trace execution paths.
*   **Mitigation:** The [[UML|Unified Modeling Language (UML)]] helps visualize and manage these complexities, allowing SPE to integrate tightly with OO notation.

## Performance Analysis
SPE involves deriving performance models directly from the software design:
*   **Derivation:** Use [[UML]] models (like Object-Oriented Analysis or Design models) to create the performance model.
*   **Starting Point:** Use cases and scenarios define the workloads.
*   **Feedback Loop:** Solving the performance model provides metrics (response time, throughput) to validate and revise the OO design *before* implementation.
*   **Characteristics:** SPE is language-independent and compatible with various process models (Waterfall, Spiral, Unified Process).

## SPE Process for Object-Oriented Systems
For OO systems, SPE adapts general techniques to the development process and artifacts like [[UML]]. The process is **use-case driven**, focusing on scenarios that describe workloads significant to performance.

### The 9-Step SPE Process
1.  **Assess Performance Risk:** Determine the level of effort needed. High risk (critical mission, high user load) requires significant SPE effort.
2.  **Identify Critical Use Cases:** Select use cases critical to system operation or user-perceived responsiveness. This is risk-driven (e.g., "Where is failure most likely or most damaging?").
3.  **Select Key Performance Scenarios:** Pick frequent or critical scenarios within the critical use cases. These are often represented by Sequence Diagrams.
	![[Pasted image 20260113131605.png]]
4.  **Establish Performance Objectives:** Define quantitative criteria (Response Time, Throughput, Resource Constraints) and Workload Intensities (arrival rates, concurrent users). *Note: Objectives should ideally cover end-to-end business tasks.*
5.  **Construct Performance Models:** Translate sequence diagrams into **Execution Graphs** to represent processing steps.
	![[Pasted image 20260113131533.png]]
6.  **Determine Software Resource Requirements:** Estimate the computational needs for each step (e.g., number of SQL queries, messages sent, screens displayed).
7.  **Add Computer Resource Requirements:** Map software resources to hardware demands (CPU instructions, Disk I/O, Network packets) using an **Overhead Matrix**.
	![[Pasted image 20260113131746.png]]
8.  **Evaluate the Models:** Solve the execution graph (software model) and system model. *Action:* If problems are found, modify the product concept or revise objectives.
9.  **Verify and Validate Models:** Ensure the model accurately reflects the software and that predictions match reality. This is an ongoing parallel activity.

## SPE Modeling Strategies
Strategies allowing developers to manage uncertainty and effort during different project phases.

### 1. Simple-Model Strategy
*   **Goal:** Provide rapid feedback on the proposed software performance.
*   **Approach:** Start with the simplest possible model (e.g., checking only the most critical path) to identify major architectural or design flaws early.

### 2. Best- and Worst-Case Strategy
*   **Context:** Early in the process, precise resource estimates are difficult.
*   **Approach:** establishing bounds on expected performance by using:
    *   **Best-case estimates:** (e.g., data is in cache, no network contention).
    *   **Worst-case estimates:** (e.g., worst-case sorting complexity, maximum network latency).
*   **Benefit:** Manages uncertainty and brackets the probable performance range.

### 3. Adapt-to-Precision Strategy
*   **Evolution:** As the project moves from early lifecycle to later development, the model should evolve.
*   **Approach:** Match the detail level in the performance model to the current level of knowledge about the software. Start simple, then add granularity as the design solidifies.

## Conventional vs. SPE Modeling
### Conventional Modeling Procedure
Traditionally, performance is addressed late:
1.  Study the existing computer system.
2.  Construct a system execution model.
3.  Measure current execution patterns.
4.  Characterize workloads.
5.  Develop input parameters and calculate metrics.
6.  Validate and calibrate the model.
*Drawback:* This often happens too late to fix architectural problems easily ("fix-it-later" approach).

### Conventional vs. SPE Models
SPE shifts the focus to early-stage modeling using design artifacts.
![[Pasted image 20260119144242.png]]

## Case Study: ATM System
The core concepts are illustrated using an ATM system:
*   **Critical Use Case:** `CustomerTransaction` (Withdraw, Deposit, Balance).
*   **Modeling:** A [[UML]] Sequence Diagram (handling loops and alternatives) is translated into an **Execution Graph**.
    *   Steps included: `getPIN`, `processTransaction`, `terminateSession`.
*   **Resource Requirements:**
    *   *Software:* logical units like "Screens", "Host interactions", "Log entries".
    *   *Hardware:* The Overhead Matrix maps "1 Screen" to specific CPU/Display service times.
*   **Evaluation:** Initial analysis (best-case, no contention) might show a result like ~29s response time against a 30s limit, indicating the design is barely acceptable and needs optimization.
## SPE in the Unified Software Process
SPE should be integrated into the software development lifecycle (e.g., Unified Process) to ensure it is systematic rather than ad-hoc.
*   **Risk-Driven:** Address [[Software-Performance-Engineering|Performance]] risks early (Inception/Elaboration phases).
*   **Iterative:** Models start with bounds (Best/Worst) and refine to point estimates.
*   **Feasibility:** Early iterations may focus on prototyping critical components specifically to validate performance assumptions.
## Performance Solutions
SPE is not just measurement; it drives the creation of performant software through:
*   **Performance Principles:** General design heuristics (e.g., "fixing point").
*   **Performance Patterns:** proven best practices for scalability.
*   **Performance Antipatterns:** Common mistakes ("The God Class", "Excessive Round Trips") and their refactorings.
*   **Implementation Solutions:** Tuning code or SQL when architectural changes are no longer an option.