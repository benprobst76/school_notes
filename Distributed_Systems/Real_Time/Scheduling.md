---
Assessments:
  - Quiz-3
Week: 9
---
### Feasibility
A **feasible schedule** is an assignment of time slots such that no task experiences a time overflow.
### Static vs. Dynamic Scheduling
- **Static Scheduling (Offline)**:
	- Pre-allocated time slots generated before the system starts.
	- Common in safety-critical systems (e.g., automotive).
	- Ensures no resource contention but is less flexible.
- **Dynamic Scheduling**:
	- Calculated at runtime.
	- More flexible and adaptable to changing conditions.
	- Common in higher-level command and control systems.
### Priority-Based Scheduling
Most [[Real-Time-Operating-System|RTOS]] implementations use priorities:
- **Fixed (Static) Priorities**: Set at design time.
- **Dynamic Priorities**: Adjusted by the scheduler during execution.
- **Preemptive Scheduling**: Allows a high-priority task (e.g., sporadic event) to interrupt a low-priority running task.
