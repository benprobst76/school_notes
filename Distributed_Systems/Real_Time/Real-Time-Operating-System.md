---
title: Real-Time Operating Systems (RTOS)
tags:
  - distributed-systems
  - real-time
  - operating-systems
aliases:
  - RTOS
---
# Real-Time Operating Systems (RTOS)
A RTOS is a specialized operating system designed to handle real-time applications by providing deterministic response times and efficient scheduling of tasks.

## Common RTOS Examples
- **FreeRTOS**:
	- A popular, lightweight RTOS for embedded systems.
	- Written in C and assembly, supporting Intel and ARM architectures.
	- Small footprint (6-12 KB).
	- Focuses on priority scheduling and periodic tasks.
- **VxWorks (Wind River Systems)**:
	- Industrial-grade RTOS used in high-stakes environments like the Mars Rover and Pathfinder.
	- Supports multi-threaded processes and both priority-based and round-robin scheduling.
- **Real-Time Linux Variants**:
	- **RTLinux**: An older approach that ran Linux as a task under a low-level scheduler (now defunct).
	- **PREEMPT-RT**: A modern kernel patch for mainline Linux (used in RedHat/Ubuntu) that introduces preemptions into the kernel to improve determinism.

## Process Classifications
Processes in an RTOS are classified by their activation patterns:
- **Periodic Processes**: Activated at regular, constant intervals (the "period"). Common in hard real-time systems.
- **Aperiodic Processes**: Activated by unpredictable external events (e.g., user input).
- **Sporadic Processes**: Similar to aperiodic, but with a **known minimum time** between activations.

## Process Attributes
RTOS schedulers use these attributes to manage task execution:

| Attribute | Description |
| :--- | :--- |
| **Arrival Time** | When a process becomes ready for execution (Release Time). |
| **WCET** | **Worst-Case Execution Time**: The longest possible time a task might take. |
| **Response Time** | The actual time from release to completion (Finish - Release). |
| **Absolute Deadline** | The specific time by which a task must finish. |
| **Relative Deadline** | The time window between arrival and completion. |
| **Slack Time** | The buffer between the relative deadline and the WCET. |
| **Laxity Time** | The remaining execution time of a task at any given moment. |

> [!warning] Time Overflow
> A time overflow occurs when a process finishes after its deadline. In hard real-time systems, this is a critical failure.

---
**Related Topics**:
- [[Real-Time]]
- [[Data-Distribution-Service]]
- [[RAFT]]
- [[Scheduling]]
