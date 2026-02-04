---
tags:
  - performance
  - modeling
  - software-engineering
  - SPE
  - school-notes
---
# Software Execution Model

*   Construct early in the development process to ensure that the chosen software architecture can achieve the required performance objectives.
*   Capture essential [[Software-Performance-Engineering#Core Definitions|performance]] characteristics of the software.
*   Provide a static analysis of the mean, best, and worst-case response time.
*   Characterize the resource requirements of the proposed software alone, in the absence of other workloads, multiple users, or delays due to contention for resources.

> **Note:** Software execution models are generally sufficient for identifying serious performance problems at the architectural and early design phases.
> *   We can refine software execution model in the critical areas.
> *   The absence of problems in the software model does not mean that there are none.

## Execution Graphs
Execution graphs are visual representations for software execution models and help communicate execution behaviors.
*   An execution graph consists of nodes and arcs.
    *   **Nodes** represent processing steps, i.e., a collection of operation invocations and program statements that perform a function in the software system.
    *   **Arcs** represent the order of execution.

An execution graph is constructed for each performance scenario.
![[Pasted image 20260120193405.png]]

### Basic Nodes
*   Basic nodes represent processing steps at the lowest level of detail that is appropriate for the current development stage.
*   Software execution models elaborate details of interest to performance.
*   The **simple-model principle** recommends that details that are not pertinent to performance should be excluded.

### Expanded Nodes
*   Expanded nodes represent processing steps elaborated in another subgraph.
*   Expanded nodes show additional processing details that are identified as the design evolves.
![[Pasted image 20260120193505.png]]

### Repetition Nodes
*   Repetition nodes represent one or more nodes that are repeated.
*   **Repetition factor** associated with the node that specifies the number of times the processing steps repeat.
*   An arc connects the last node repeated with the repetition node.

### Case Nodes
*   Case nodes represent conditional execution of processing steps.
*   Attached nodes represent the steps that may be executed.
*   A case node has more than one attached nodes.
*   Each attached node has an execution probability.

### Pardo Node
*   A **Pardo** (as *Parallel do*) node represents parallel execution within a scenario.
![[Pasted image 20260120193549.png]]

### Graph Restrictions
*   **Initial node restriction:** Graphs and subgraphs can have only one initial node.
*   **Loop restriction:** All loops in the graph must be repetition loops.

---

## Example: Checking Emails Scenario
*   A user checks the inbox of the email client application.
*   The email client application:
    *   Authenticate the users with the server.
    *   Send the user a response to show the results of the response.
    *   Retrieve the emails.
    *   Sort the emails.
    *   Display the emails the user.
*   The server:
    *   Authenticate users.
    *   Send emails to the email client.
![[Pasted image 20260120193733.png]]

---

## Software Execution Model Analysis
*   Primary purposes of software execution model analysis are:
    *   Make a quick check of the best-case response time in order to ensure the architecture and design lead to satisfactory performance.
    *   Assess the performance impact of alternatives.
    *   Identify critical parts of the system for performance management.
    *   Derive parameters for the system execution model.
*   The algorithms are formulated for evaluating graphs.

### Basic Solution Algorithms
*   The algorithms are 'easy' to understand.
    *   Examine graphs and identify a basic structure.
    *   Compute the time of a basic structure and reduce the basic structure to a 'computed node'.
    *   Continue until only one node left.
*   **Basic structures are:**
    *   Sequences
    *   Loops
    *   Cases
    *   Parallel processing

### Graph Reduction for Case Nodes
*   The computation for case nodes differs for the shortest path, the longest path, and the average analyses.
    *   **Shortest path:** The time for the case node is the minimum of the times for the conditionally executed nodes.
    *   **Longest path:** The time for the case node is the maximum of the times for the conditionally executed nodes.
    *   **Average analysis:** The time is multiplying each node’s time by its execution probability.

---

## Example: ATM Scenario

### Example 4-1: Best, Worst and Average Times
To illustrate the basic path reductions, consider the ATM scenario in Figure 4-3 and the subgraph for `processTransaction` in Figure 4-4. Assume the node “times” in the following table.

| Node | Time |
| :--- | :--- |
| getCardInfo | 50 |
| getPIN | 20 |
| getTransaction | 30 |
| processDeposit | 500 |
| processWithdrawal | 200 |
| processBalanceInquiry | 50 |
| terminateSession | 100 |

![[Pasted image 20260122170619.png]]

### Analysis Procedures
*   Use both the best- and the worst-case estimates of resource requirements for each basic node.
*   Begin with a simplistic analysis of the best case and introduce more sophisticated analyses of realistic cases as more detailed information becomes available.

---

## Software Resource Requirements
*   Each basic node has specified software resource requirements $A_j$ for each service unit $j$.
### Processing Overhead Matrix
*   A chart of the computer resource requirements for each of the software resource requests.
![[Pasted image 20260122170701.png]]

### Computing the Total Execution Time
**STEP 1:** Uses the processing overhead matrix to calculate the total computer resources required per software resource for each node in the graph.
![[Pasted image 20260122170731.png]]

**STEP 2:** Computes the total computer resource requirements for the graph.

**Table 4-2: Total Computer Resource Requirements for `authorizeTransaction`**

| Processing Step | CPU Kinstr | Physical I/O | Network Messages |
| :--- | :--- | :--- | :--- |
| validateUser | 1,020 | 4 | 0 |
| validateTransaction | 1,540 | 6 | 0 |
| sendResult | 550 | 4 | 1 |
| **Total: authorizeTransaction** | **3,110** | **14** | **1** |

**STEP 3:** Compute the best-case elapsed time.

$$ 
\begin{aligned}
\text{Total Service Time} &= (\text{CPU Total} \times \text{CPU Service Time}) + (\text{I/O Total} \times \text{I/O Service Time}) + (\text{Network Total} \times \text{Network Service Time}) \\
\end{aligned}
$$ 

*   **Service Time Assumptions (Example):**
    *   CPU: 0.00001
    *   Physical I/O: 0.02
    *   Network Messages: 0.01

### Types of Software Resource
![[Pasted image 20260122170826.png]]
![[Pasted image 20260122170834.png]]

### Software Resource Estimation
*   One of the most difficult resources to estimate is CPU usage.
    *   We use **work units** that focus on the relative amount of work performed in a processing step.
*   Early in development, models typically use two to five types of software resource specifications.
*   Later, you may include more software resource types, such as synchronization and lock requests.

---

## Case Study: ICAD (Interactive Computer-Aided Design)
*   Engineers use the application to construct and view drawings that model structures, such as aircraft wings.
*   The system also allows users to store a model in a database, and interactively assess the design’s correctness, feasibility, and suitability.
*   The model is stored in a relational database, and several versions of the model may exist within the database.
*   An ICAD drawing consists of nodes and elements (e.g., beams, triangles, or plates).

### Use Cases
*   **Use Case:** Draw (draw a model), Solve (solve a model).
*   **Scenario:** DrawMod (Draw models).
*   **Data:** A typical model contains only nodes and beams and consists of 2,000 beams.
*   **Performance goal:** To draw (show on screen) a typical model in 10 seconds or less.

![[Pasted image 20260122170948.png]]
![[Pasted image 20260122171005.png]]

### Software Resource Requirements
*   **DBMS:** The number of calls to the ICAD Database process.
*   **CPU:** An estimate of the number of instructions executed.
*   **I/O:** The number of disk accesses to obtain data from the database.
*   **Allocate/Free:** The number of calls to the memory management.
*   **Screen:** The number of times graphics operations “draw” to the screen.
![[Pasted image 20260122171038.png]]

### Winning Design 3
*   Retrieve blocks containing 20K of data at a time instead of retrieving individual nodes and beams.
*   A single retrieval of a block can fetch 64 beams or 170 nodes a time.

---

## Modeling Hints
*   It is not necessary to include all of the details of the software’s processing flow in the performance model.
*   Use hierarchy to help make your models easier to understand and modify.
*   Use best- and worst-case estimates of resource requirements to help compensate for uncertainty early in the process.
*   Study the sensitivity of the performance results to the input parameters.