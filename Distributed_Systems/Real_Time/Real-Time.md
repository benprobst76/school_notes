---
title: Introduction to Real-Time Systems
tags:
  - distributed-systems
  - real-time
  - systems-design
---
# Introduction to Real-Time Systems
Real-time systems are those whose correctness depends not only on the logical result of the computation but also on the **time at which the result is produced**.

## Defining Real-Time
A common misconception is that real-time systems are simply "fast" or "optimized." While speed is important, the core requirement is **predictability** and **determinism**.

> [!important] Predictability
> Can we predict the amount of time required to complete a specific task? A predictable system with a known latency is more valuable for real-time applications than a fast system with unpredictable latency (jitter).

### Example: Gasoline Engine
- A spark must be delivered shortly before the piston reaches the top of its stroke.
- **Too Early**: Causes knocking/detonation and engine damage.
- **Too Late**: Results in significant power loss.
- This creates a narrow "window" in time for an acceptable result.

## Classification of Real-Time Systems
Real-time systems are categorized by the consequence of missing a deadline.

### Hard Real-Time
- If a deadline is missed, the **system fails**.
- Often leads to catastrophic failure or real-world physical damage.
- Requires strong, deterministic guarantees.

### Soft Real-Time
- If a deadline is missed, the system does not fail, but the **result becomes less useful**.
- **Firm Real-Time**: A subset of soft real-time where a late result is useless and discarded (e.g., video frames), but the system persists.
- **Classic Soft Real-Time**: The value of the result diminishes over time (e.g., stock quotes, sensor readings).

## Distributions and Factors
System performance is influenced by two main distributions:
1. **Variation in Task Length**:
	- How often is a task late?
	- Influenced by network latency, congestion, and input event timing.
2. **Variation in Result Value**:
	- Does the value decrease before or after the deadline?
	- Hard real-time has a value distribution that becomes extremely negative outside the target window.

## System Architectures
### Event-Driven Systems (Reactive)
- Responds to asynchronous external events.
- **Examples**: Pacemakers, elevators, aircraft flight controls, spark delivery based on cylinder position.

### Time-Driven Systems
- Operates on a fixed time loop, sampling inputs and generating outputs at synchronous intervals.
- **Examples**: Irrigation systems, automated pet feeders.

### Mixed Systems
- Combines both approaches.
- **Examples**: 
	- **Traffic Lights**: Usually time-based but triggered by sensors.
	- **Video Games**: Internal gameplay loops (time-driven) vs. user input (event-driven).

## Middleware Responsibilities
Middleware in real-time systems handles:
- **Clock Synchronization**: Ensuring all nodes agree on the current time.
- **Distributed Scheduling**: Managing task execution across multiple systems.
- **Dynamic Load Balancing**: Moving tasks between systems to prevent overflows.
- **Real-Time Communication**: Ensuring deterministic data delivery (e.g., [[Data-Distribution-Service]]).

---
**Related Topics**:
- [[Real-Time-Operating-System]]
- [[Data-Distribution-Service]]
- [[RAFT]]
