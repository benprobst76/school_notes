---
title: Fault Tolerance and Dependability
tags:
  - distributed-systems
  - fault-tolerance
  - consensus
Assessments:
  - Quiz-3
Week: 8
---
# Fault Tolerance and Dependability
In distributed systems, where components are numerous and failures are inevitable, fault tolerance is the ability of a system to continue providing services even when one or more of its components fail.

A single computer is relatively fault tolerant. When you multiply components like machines, disks, network switches and cables, it is a low probability all of them fail but a high probability some of them fail.  

## Core Concepts of Dependability
Dependability is a broad term encompassing several key attributes:
- **Availability**: The system is operating correctly and is available to respond to users at any given moment.
- **Reliability**: The system can run continuously without failure over a period of time.
- **Safety**: If the system fails, the impact is minimized (e.g., failing into a safe state).
- **Recoverability**: The ability to restore the system to a functional state after a failure.
- **Maintainability**: How easily the system can be repaired or updated.
- **Security**: Maintaining Confidentiality, Integrity, and Availability ([[CIA-Triad|CIA]]).

## Faults, Errors, and Failures
It is important to distinguish between the cause, the state, and the result of a problem:
1. **Fault**: The root cause of an issue (e.g., a software bug or a hardware defect).
2. **Error**: The part of the system state that is incorrect due to a fault (e.g., a corrupted variable).
3. **Failure**: When the system can no longer provide one or more of its intended services.

### Types of Faults
- **Transient**: Occurs once and then disappears (e.g., a bit flip from cosmic radiation).
- **Intermittent**: Occurs semi-regularly (e.g., a loose cable or heat-related issue).
- **Permanent**: Lasts until it is fixed

## Handling Faults
- **Fault Prevention**: Techniques to stop faults from occurring (e.g., Test-Driven Development, formal verification).
- **Fault Tolerance**: Designing the system to continue operating despite faults (e.g., using error-correcting codes).
- **Fault Removal**: Methods to reduce the number of faults present (e.g., acceptance testing, debugging).
- **Fault Forecasting**: Estimating the presence and impact of faults (e.g., analyzing commit history).

## Failure Models
Systems can fail in different ways, ranging from simple stops to malicious behavior.

| Model | Description |
| :--- | :--- |
| **Crash Failure** | The component halts but worked correctly until the moment it stopped. |
| **Omission Failure** | A component fails to respond to requests (includes Receive and Send omission). |
| **Timing Failure** | The response is correct but arrives outside the required deadline. |
| **Response Failure** | The response is incorrect (Value Failure or State Transition Failure). |
| **Arbitrary (Byzantine)** | The component produces arbitrary results at arbitrary times; potentially malicious. |

### Omission vs. Commission
- **Omission Failure**: A component fails to take an action it should have taken.
- **Commission Failure**: A component takes an action it should **not** have taken. 
- *Note*: Deliberate failures are often security issues, and distinguishing them from unintentional faults is difficult.

## Detection and Assumptions
Detecting a crash is challenging in **Asynchronous Systems** because there are no bounds on execution speed or message delivery. You cannot reliably distinguish a crashed process from a very slow one. **Synchronous Systems** allow for reliable detection using timeouts.

### Failure Assumptions
- **Fail-stop**: A crash that can be reliably detected.
- **Fail-noisy**: Eventually detected; timeouts might be temporarily unreliable.
- **Fail-silent**: Cannot distinguish between a crash and an omission.
- **Fail-safe**: An arbitrary failure occurs, but it is guaranteed to do no harm.
- **Fail-arbitrary**: The worst case; failures are unobservable and harmful.

## Masking Failure with Redundancy
To achieve fault tolerance, we must hide failures using redundancy:
- **Information Redundancy**: Adding extra bits (e.g., checksums, ECC) to data.
- **Time Redundancy**: Retrying operations after a failure (best for transient faults).
- **Physical Redundancy**: Using extra hardware (e.g., replicated servers or disks).

## Process Resilience
Process resilience is achieved by organizing multiple identical processes into **Process Groups**.

### Group Structures
- **Flat Groups**: All members are peers. No single point of failure, but decision-making (voting) is complex.
- **Hierarchical Groups**: A coordinator manages workers. Easier to manage, but the loss of the coordinator requires an [[Election-Algorithms|election]]. (e.g. [[Raft]])

### $k$-Fault Tolerance
A group is $k$-fault tolerant if it can survive $k$ concurrent failures. The required group size depends on the failure model:
- **Halting Failures**: Requires **$k+1$** members. (If one survives, it is guaranteed to be correct).
- **Arbitrary Failures**: Requires **$2k+1$** members. (Needed to reach a majority vote on the correct result).

## Consensus and [[Replication]]
In a fault-tolerant group, all non-faulty members must execute the same updates in the same order. This requires reaching **Consensus**.
- **State-Based Replicas**: Replicas maintain consistent state (e.g., a Key-Value store, [[Google-File-System|GFS]]) by applying the same operations.
- **Algorithms**:
	- **Paxos**: A powerful but complex state based replication system.
	- [[Raft]]: A more modern, understandable consensus algorithm used in tools like `etcd`, `Neo4j`, and `MongoDB`.