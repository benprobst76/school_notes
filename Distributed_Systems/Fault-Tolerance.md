Dependability  
• Availability - system is operating correctly and available to respond to users.  
• Reliability - system can run continuously without failure.  
• Safety - minimize impact if the system fails.  
• Recoverability  
• Maintainability  
• Security (CIA)

Fault tolerance  
• Single computer is relatively fault tolerant  
• When you multiply the components: many machines, many disks, network  
switches, network cables  
• low probability all of them fail  
• high probability some of them fail  
• 10 of 1000s of components means multiple failures per day

Failures & Faults  
• A system fails when cannot provide one or more services (crashed program)  
• The part of the system state that failed is an error (software bug)  
• Cause of an error that led to the failure is a fault (misunderstood spec)  
• Transient fault - occurs once and disappears.  
• Intermittent fault - occurs semi-regularly such as a bad contact  
• Permanent - lasts until fixed

Handling Faults  
• Fault Prevention - prevent fault from happening. Example: Model Driven  
Engineering, Test Driven Development  
• Fault Tolerance - system can provide service in the presence of faults.  
Example: error correcting codes for messages that allow errors during  
message transmission  
• Fault removal - reduce presence of faults. Example: acceptance testing,  
Model Driven Testing  
• Fault Forecasting - Estimate presence of bugs - Analysis of commit history

Failure Models  
• Crash Failure - Halts, but is working correctly until it halts  
• Omission Failure - fails to respond to requests  
• Receive omission - fails to receive one or more messages  
• Send omission - fails to send one or more message  
• Timing Failure - response is past a deadline  
• Response Failure - response is incorrect  
• Value Failure - returned value is wrong  
• State transition failure - system is in wrong state (future values will be wrong)  
• Arbitrary Failure - arbitrary response at arbitrary time

Dependability vs Security  
Omission vs Commission  
• Omission failure - a component fails to take an action that should have been  
taken.  
• Commission failure - a component takes an action that it should not have  
taken  
• Deliberate failures (omission or commission) is usually a security problem.  
• Distinguishing between deliberate failures and unintentional ones is difficult.

Halting Failures  
Has it crashed?  
• If one component has not seen any activity from another component for some period of time, is it a crash?  
• Asynchronous system - no assumptions about process execution speed or message delivery times  
• can not reliability detect crash failures  
• Synchronous System - process execution and message delivery time are bounded  
• Can reliability detect crash failures  
• In practice, most systems are partially synchronous. Most of the time they operate within predictable time  
frames  
• Can normally detect errors with timeouts, may sometimes be wrong (the other component may just be  
slow).  
• Must not only handle failures, must also handle misdiagnosing failures.

Halting Failures  
Assumptions  
• Fail-stop - system crashed that can be reliably detected (may assume non-  
faulty communication links and reliable timeouts  
• Fail-noisy - Similar to fail stop, but will only eventually be detected (timeout  
may not be reliable indicator)  
• Fail-silent - cannot distinguish between a crash and an omission  
• Fail-safe - arbitrary failure of a component, but does not do any harm  
• Fail arbitrary - may fail in anyway, and failures may be unobservable and  
harmful

Masking Failure with Redudancy  
• If a system is to be fault tolerant, we have to hide the failures from the other  
components of the system.  
• Key technique is redundancy  
• Information Redundancy: add extra bits to data to allow recovery of garbled  
information. Can be used in storage or in communication  
• Time Redundancy - deadlines allow for action to be performed a second time  
if the first time fails. Important when faults are transient or intermittent  
• Physical Redundancy - extra equipment to allow components to fail (most  
common)

Process Resilience  
• Protect against malfunctioning components through process replication  
• Organize multiple processes into process groups  
• When a message is sent to the group, it goes to all members of the group  
• If one process in the group fails, the others make up for it.  
• Process groups may be dynamic  
• New groups formed, destroyed  
• Add members, lose members  
• Groups appear to be a single entity to outside components

Group Structure  
• Flat groups  
• no leader, all decisions made collectively  
• Peer to peer  
• No single point of failure, but decision making is more complicated (usually voting)  
• Hierarchical  
• One process is coordinator others are workers.  
• Work request are sent to coordinator which then redirect to appropriate workers  
• Loss of coordinator stops the group, group needs to select a new coordinator

Groups and Failure Masking  
k-fault tolerant group  
• the group can handle up to k failures of group members  
• degree of fault tolerance  
• How large does the group have to be?  
• Depends on failure models  
• With halting failures (crash/omission/timing) -> k+1 members  
• no member produces and incorrect result, so one member left is enough  
• with arbitrary failures -> 2k+1  
• since failures produce incorrect results, need to vote on the correct result.  
• Assumptions  
• All members are identical  
• All member process updates in the same order

Consensus in the presence of failures  
• In a fault tolerant process group, each non faulty component executes the  
same updates, in the same order as every other non faulty component  
• Need to reach a consensus on which command to execute next  
• Easiest to do with hierarchical groups -> RAFT - tomorrow

Consensus in the presence of failures  
• In a fault tolerant process group, each non faulty component executes the  
same updates, in the same order as every other non faulty component  
• Need to reach a consensus on the order to execute command  
• Raft  
• Onagaro, D., Ousterhout, J., In Search of an Understandable Consensus  
Algorithm (Extended Version), Stanford University. 2014

State Based Replicas  
• State based replicas is based on an operation that changes the system state  
• KV - commands to update part of the replica state (i.e. the value associated with a particular  
key)  
• examples: Databases, Lock servers, System monitors, telephone switches, routing tables.  
• Important that updates be applied at all replicas in the same order  
• Paxos is a complex state based replication system  
• Real world use of Raft (non exclusive list):  
• etc (naming service used in kerbunetes)  
• Neo4j (graph datase)  
• MongoDB (no sql database)  
• RabbitM (Message Queue Middleware)