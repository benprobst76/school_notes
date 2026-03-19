---
title: Real-Time Operating Systems (RTOS)
tags:
  - distributed-systems
  - real-time
  - operating-systems
aliases:
  - RTOS
Assessments:
  - Quiz-3
Week: 9
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

## General OS vs. RTOS
In a Real-Time Distributed System, each individual node must also be real-time to maintain system-wide predictability.

### Core Responsibilities
Both general-purpose operating systems (GPOS) and RTOS share fundamental tasks:
- **Process Management**: Creating, deleting, and scheduling tasks (a program in execution).
- **I/O Management**: Handling device input and output.
- **Memory Allocation**: Managing system RAM.
- **Key Difference**: While GPOS focuses on throughput and user experience, RTOS prioritizes **predictability** (determinism) and meeting timing constraints.

### Interrupt Handling
- **Mechanism**: External devices generate interrupts; the CPU transfers control to an **Interrupt Service Routine (ISR)**, pausing the current process.
- **Nesting**: RTOS must support nestable interrupts (higher priority interrupts can preempt lower priority ISRs).
- **Classification**:
	- **Critical**: Must be handled immediately (e.g., high-speed data sampling where data loss is imminent).
	- **Non-Critical**: Can wait (e.g., hard drive read completion).
	- **Middle**: Needs timely response, but data isn't immediately lost (e.g., network packet arrival).
- **Rule**: Minimize time spent inside the ISR to return control to the scheduler as soon as possible.

### Synchronization & Communication
- **Low Latency**: Must be fast and tightly integrated with the scheduler.
- **Priority Inversion**: Occurs when a high-priority process is blocked by a low-priority process holding a resource (lock).
	- **Solution**: Temporarily elevate the priority of the low-priority process so it releases the resource sooner (Priority Inheritance).
- **Rollback**: Often impossible in real-time systems when hardware interactions are involved.

### Memory Management
- **Predictability**: Must avoid unpredictable delays caused by dynamic allocation or virtual memory.
- **Strategies**:
	- Minimize dynamic memory for critical processes.
	- **Memory/Buffer Pools**: Pre-allocated blocks for reuse (e.g., for interrupt buffers).
	- **RAM Locking**: Lock critical processes in RAM to prevent page faults.
	- Prefer **statically allocated memory** wherever possible.

## Process Classifications
Processes in an RTOS are classified by their activation patterns:
- **Periodic Processes**: Activated at regular, constant intervals (the "period"). Common in hard real-time systems.
- **Aperiodic Processes**: Activated by unpredictable external events (e.g., user input).
- **Sporadic Processes**: Similar to aperiodic, but with a **known minimum time** between activations.

## Process Attributes
RTOS schedulers use these attributes to manage task execution:

| Attribute | Description |
| :--- | :--- |
| **Priority** | Real-time systems are typically priority-based. |
| **Period** | The regular interval at which periodic tasks must be scheduled. |
| **Arrival Time** | When a process becomes ready for execution (Release Time). |
| **WCET** | **Worst-Case Execution Time**: The longest possible time a task might take. |
| **Response Time** | The actual time from release to completion (Finish - Release). |
| **Absolute Deadline** | The specific time by which a task must finish. |
| **Relative Deadline** | The time window between arrival and completion (deadline relative to dispatch). |
| **Slack Time** | The buffer between the relative deadline and the WCET. |
| **Laxity Time** | The remaining execution time of a task at any given moment. |

> [!warning] Time Overflow
> A time overflow occurs when a process finishes after its deadline. In hard real-time systems, this is a critical failure.

---
**Related Topics**:
- [[Real-Time-Systems]]
- [[Data-Distribution-Service]]
- [[Raft]]
- [[Scheduling]]
