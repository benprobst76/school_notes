# System Execution Models

## Introduction
The system execution model is a core component of Software Performance Engineering (SPE). It builds upon the [[Software-Execution-Model]] to provide a more realistic view of performance in a shared environment.
- **[[Software-Execution-Model]]**: Provides a static analysis of mean, best-, and worst-case response times. It characterizes the resource requirements of the proposed software in isolation (no other workloads or multiple users).
- **Heuristic**: If the predicted performance in the absence of additional performance-determining factors (like contention) is unsatisfactory, there is no need to construct more sophisticated system models until the software itself is optimized.

## Sources of Contention for Resources
Contention occurs when multiple processes compete for the same physical or logical resources:
- **Multiple users**: Several users executing the same application or transaction simultaneously (e.g., ATM customers).
- **Multiple applications**: Different systems executing on the same hardware resources at the same time.
- **Concurrent processes**: The application itself may have separate processes running in parallel.
- **Multi-threading**: Handling concurrent requests for different external processes within a single application.

## System Execution Models
The system execution model characterizes software performance in the presence of dynamic factors such as workloads or multiple users. Its primary goal is to solve for **contention for resources**.
- If the [[Software-Execution-Model]] indicates no problems, the next step is to construct and solve the system execution model to account for contention effects.
![[Pasted image 20260202194736.png]]

### Benefits of System Execution Model
- Provides more precise metrics by accounting for resource contention.
- Analyzes the sensitivity of performance metrics to variations in workload composition.
- Evaluates the **Scalability** of hardware and software to meet future demands.
- Assesses the effect of new software on the service level objectives (SLOs) of existing systems.
- Identifies **bottleneck resources**.
- Provides comparative data on different performance improvement options.

## System Model Basics
System execution models represent key computer system resources as **queues** and **servers**.
- **Server**: A component of the environment providing service (e.g., CPU, Disk, Network element).
- **Queue**: A place where jobs wait for service when the server is busy.
![[Pasted image 20260202195421.png]]

### Performance Metrics
The primary metrics of interest for each server are:
1. **Residence Time ($RT$):** The average time jobs spend in the server (service time + waiting time).
2. **Utilization ($U$):** The average percentage of time the server is busy.
3. **Throughput ($X$):** The average rate at which jobs complete service.
4. **Queue Length ($N$):** The average number of jobs at the server (both being served and waiting).

The values of these metrics depend on:
- The number of jobs.
- The amount of service required.
- The server's processing time for individual jobs.
- The scheduling policy (e.g., First-Come-First-Served (FCFS) or Priority Scheduling).

## Execution Profile and Calculations
An execution profile tracks the number of jobs in the system over a specific measurement period.
![[Pasted image 20260202195826.png]]

### Example 6-1: Data Collection
From an execution profile, we can obtain the following raw data:
- **Measurement period ($T$):** 20 sec
- **Number of arrivals ($A$):** 8 jobs
- **Number of completions ($C$):** 8 jobs
- **Busy time ($B$):** 16 sec
- **Area Under Graph ($W$):** 41 job-seconds (representing the sum of time all jobs spent in the system).

### Calculation of Performance Metrics
The following formulas are used to calculate the system metrics:
$$
\begin{aligned}
\text{Utilization } (U) &= \frac{B}{T} \\
\text{Throughput } (X) &= \frac{C}{T} \\
\text{Mean Service Time } (S) &= \frac{B}{C} \\
\text{Residence Time } (RT) &= \frac{W}{C} \\
\text{Queue Length } (N) &= \frac{W}{T}
\end{aligned}
$$

**Applying Example 6-1 data:**
$$
\begin{aligned}
U &= \frac{16}{20} = 0.8 \\
X &= \frac{8}{20} = 0.4 \text{ jobs/sec} \\
S &= \frac{16}{8} = 2 \text{ sec/job} \\
RT &= \frac{41}{8} = 5.125 \text{ sec} \\
N &= \frac{41}{20} = 2.05 \text{ jobs}
\end{aligned}
$$ 

## Solving the Queueing Model
To predict future performance, we use similar calculations based on:
- **Workload Intensity**: A measure of the number of requests made by a workload in a given time interval.
- **Service Requirements**: The amount of time the workload requires from each of the devices in the processing facility.

### Job-Flow Balance
A key assumption in many models is that the system is fast enough to handle arrivals, meaning the completion rate (throughput) equals the arrival rate. This property is known as **job-flow balance**.

## Example 6-5: AuthorizeTransaction Software Model
This example maps software execution steps to physical device visits.
**Device Requirements:**
| Device | Visits ($V$) | Service Time ($S$) |
| :--- | :--- | :--- |
| CPU | all | 0.0311 |
| Disk | 14 | 0.02 |
| Network | 1 | 0.01 |

## Modeling Hints and Concepts
- **Average vs. Peak**: Basic Queueing Network Models (QNMs) calculate average values. Peak loads may require more advanced analysis.
- **Sensitivity**: If a small change in one parameter causes a large change in the computed metrics, the model is sensitive to that quantity.
- **Scalability**: The ability of the system to maintain or improve response times for anticipated future loads.
- **Bottlenecks**: The bottleneck device is the one with the highest utilization.

## What System Execution Model Can't Do
Standard system execution models might not easily capture:
- Complex details of computer system devices, such as network protocols or complex I/O scheduling.
- **Passive Resources**: Resources required for processing that do no work themselves (e.g., memory, locks).
- Additional metrics like minimum, maximum, variance, or specific arrival distributions.

It is possible to model these aspects using more advanced or alternative techniques (like simulation) if they are critical to performance.

## Distributed System Case Study: Electronic Virtual Storefront
Focuses on the Customer Service component that:
- Collects completed orders.
- Initiates tasks in other components.
- Tracks the status of orders in progress.
This component is often the focus of system modeling to ensure it doesn't become a bottleneck as the system scales.