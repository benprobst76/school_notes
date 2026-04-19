---
Assessments:
  - Quiz-3
Week: 9
---
# Real-Time Scheduling
Scheduling in a [[Real-Time-Operating-System|RTOS]] involves assigning time slots to tasks to ensure they meet their deadlines.
### Feasibility
> [!abstract] Definition
> A **feasible schedule** is an assignment of time slots such that no task experiences a **time overflow** (finishing after its deadline).
### Static vs. Dynamic Scheduling
- **Static Scheduling (Offline)**
	- Pre-allocated time slots generated before the system starts.
	- Common in safety-critical systems (e.g., automotive).
	- Ensures no resource contention but is less flexible.
- **Dynamic Scheduling**
	- Calculated at runtime.
	- More flexible and adaptable to changing conditions.
	- Common in higher-level command and control systems.
### Priority-Based Scheduling
Most [[Real-Time-Operating-System|RTOS]] implementations use priorities:
- **Fixed (Static) Priorities**: Set at design time.
- **Dynamic Priorities**: Adjusted by the scheduler during execution.
- **Preemptive Scheduling**: Allows a high-priority task (e.g., sporadic event) to interrupt a low-priority running task.
- **Non-Preemptive Scheduling**: A task runs to completion or until it voluntarily yields, even if a higher-priority task arrives.
### Process Attributes
Each process ($\tau_i$) in a real-time system is defined by several attributes:
- **Arrival/Release Time ($a_i$ or $r_i$)**: When a process becomes ready for execution.
- **Worst-Case Execution Time ($C_i$)**: Estimate of the longest possible execution time.
- **Start/Finish Time ($s_i$ / $f_i$)**: When the process actually starts and finishes.
- **Response Time ($R_i$)**: Total time from release to finish ($f_i - r_i$).
- **Process Period ($T_i$)**: Constant interval between activations of a periodic task.
- **Absolute Deadline ($d_i$)**: Specific time by which a task must finish.
- **Relative Deadline ($D_i$)**: Time between arrival and the required finish time ($D_i = d_i - r_i$).
- **Slack Time ($S_i$)**: Difference between the relative deadline and worst-case execution time ($D_i - C_i$).
- **Laxity Time ($L_i(t)$)**: Remaining execution time of a task at a given time $t$.
- **Priority ($P_i$)**: Relative importance of the process.
### Scheduling Algorithms
To simplify periodic tasks, we often assume the **Relative Deadline ($D_i$)** is equal to the **Period ($T_i$)**.
#### Static Scheduling: Cyclic Executives
In this approach, time is divided into major and minor cycles.
- **Minor Cycles (Frames)**: Decision points for the scheduler. The frame size ($f$) must be at least as large as the largest $C_i$.
- **Major Cycle ($H$)**: The Least Common Multiple (LCM) of all task periods ($T_i$).
- **Feasibility Condition**: $2f - \text{GCD}(T_i, f) \le D_i$ (often simplified to $T_i$).
- **Advantages**: Small context switching overhead, predictable, handles precedence constraints well.
- **Disadvantages**: NP-complete for single processors, hard to split tasks, sensitive to timing estimate errors.
![[Pasted image 20260419132832.png]]
#### Dynamic Priority Scheduling
##### Utilization Factor
The utilization $u_i$ of a task is the fraction of its period consumed by execution:
$$u_i = \frac{C_i}{T_i}$$
The total **Processor Utilization ($U$)** is the sum of all individual utilizations:
$$U = \sum_{i=1}^{n} \frac{C_i}{T_i}$$
##### Rate Monotonic Scheduling (RMS)
- **Rule**: Shorter period $\to$ Higher priority.
- **Feasibility**: A sufficient (but not necessary) condition is $U \le n(2^{1/n} - 1)$. As $n \to \infty$, $U \approx 0.69$.
![[Pasted image 20260419132926.png]]
##### Deadline Monotonic Scheduling (DMS)
- Used when $D_i < T_i$.
- **Rule**: Shorter relative deadline $\to$ Higher priority.
##### Earliest Deadline First (EDF)
- **Rule**: The task with the nearest absolute deadline is executed first.
- **Feasibility**: Can produce a feasible schedule if $U \le 1$.
- **Overhead**: Requires frequent deadline recalculations at each timer interrupt.
![[Pasted image 20260419133348.png]]
##### Least Laxity First (LLF)
- **Rule**: Executes the task with the least "laxity" (spare time before it must start to meet its deadline).
### Aperiodic and Sporadic Scheduling
When tasks don't arrive on a fixed schedule, different strategies are used:
- **Spare Space Approaches**: Use open slots or "slack stealing" (delaying periodic tasks if they will still meet deadlines).
- **Periodic Servers**: A dedicated periodic task handles aperiodic requests.
	- **Polling Server**: A high-priority task with a fixed budget used each period.
	- **Deferrable Server**: Can "save" its budget until later in the period to handle late arrivals.
![[Pasted image 20260419133231.png]]
