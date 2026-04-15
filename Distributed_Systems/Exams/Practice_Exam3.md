ELEC 477 Distributed Systems
Practice Exam 3
Time: 35 Minutes

Instructions: Total 30 marks. Closed Book.
Answer all questions in the space provided.

---

1. (4 marks) Give a brief (one or two line) description of each of the following terms as they were discussed in class.

    a. Priority Inheritance (RTOS)
	%%     
    A solution to priority inversion where a low-priority process holding a resource needed by a high-priority process temporarily inherits that high priority to finish its task and release the lock quickly. 
    %%
    b. $k$-fault tolerance
	%%
	A property of a process group that can survive $k$ concurrent failures. For halting failures, $k+1$ members are needed; for arbitrary failures, $2k+1$ are needed.
	%%    
    c. Lease (Content Distribution)
    %%
    A promise by a server to push updates to a replica for a specific period. After expiration, the replica reverts to a pull-based model until the lease is renewed.
    %%
    d. Global Data Space (DDS)
    %%
    The logical overlay in DDS where publishers add data and subscribers retrieve it, decoupled in time and space with no single point of failure.
    %%

2. (3 marks) In replica update management, compare **Invalidation Protocols** with **Passive [[Replication]]**. In what scenario is an Invalidation Protocol more efficient?
	%%
	**Invalidation** only sends a notification that data is out of date, while **Passive Replication** transfers the actual updated data. Invalidation is more efficient when the **write-to-read ratio is high** (multiple updates occur before a client actually needs to read the data), as it avoids unnecessary data transfers.
	%%

3. (3 marks) In the [[Google-File-System]] (GFS), how is an **Atomic Record Append** handled if the data does not fit in the current chunk? What is the resulting consistency guarantee?
	%%
	 If the record doesn't fit, the primary **pads the chunk**, tells the secondaries to do the same, and instructs the client to retry on a **new chunk**. GFS guarantees the data is written **at least once** as an atomic unit at the same offset across replicas, but does not guarantee byte-wise identity (replicas may contain duplicate data or padding).
	 %%

4. (3 marks) Consider a [[Quorum]]-Based Protocol with $N$ replicas. 
    
    a. What are the two primary constraints on the Read Quorum ($N_R$) and Write Quorum ($N_W$) to prevent conflicts?
    %%
    $N_W > N/2$ (prevents write-write conflicts); 2) $N_R + N_W > N$ (prevents read-write conflicts).
    %%
    
    b. If $N=9$ and the system is optimized for **ROWA (Read One, Write All)**, what are the values of $N_R$ and $N_W$?
    %%
    $N_W=9, N_R=1$ 
	%%

5. (3 marks) [[Fault-Tolerance]] requires understanding how systems fail. Define and distinguish between a **Fault**, an **Error**, and a **Failure**.
    %%
	- **Fault**: The root cause (e.g., a bug or a hardware defect).
	- **Error**: The incorrect internal state resulting from the fault (e.g., a corrupted bit).
	- **Failure**: The external observable behavior where the system fails to provide its service.
	%%

6. (5 marks) The [[Raft]] Consensus Algorithm is designed for state-based replication.

    a. Name the three states a Raft server can be in.
    %%
    Leader, follower and candidate.
    %%
    
    b. How does Raft use **Terms** to act as a logical clock, and what happens if a server discovers its term is smaller than another's?
    %%
    Terms are consecutive integers used to identify election periods. If a server sees a higher term, it immediately updates its own term and reverts to the **Follower** state.
    %%
    
    c. What mechanism does Raft use to ensure that a candidate wins a majority vote even if multiple followers start an election simultaneously?
    %%
    **Randomized Election Timeouts**: Each follower waits a random duration before becoming a candidate, ensuring one usually starts and gathers a majority before others wake up.
    %%

7. (4 marks) [[Real-Time-Systems]] are categorized by the consequences of missing deadlines.

    a. Compare **Hard Real-Time** and **Firm Real-Time**.
    %%
    **Hard Real-Time**: Missing a deadline is a total system failure (potentially catastrophic). **Firm Real-Time**: A late result is useless and discarded, but the system continues to operate.
    %%
    
    b. In the context of RTOS, why should time spent inside an **Interrupt Service Routine (ISR)** be minimized?
    %%
    To ensure the CPU returns to the **scheduler** as quickly as possible, allowing high-priority real-time tasks to meet their deadlines and maintaining system predictability.
    %%


8. (5 marks) The [[Data-Distribution-Service]](DDS) is a data-centric middleware.

    a. Explain the difference between a **Domain** and a **Partition** in DDS.
    %%
    A **Domain** establishes an isolated overlay network (participants in different domains cannot see each other). A **Partition** is a flat namespace (string-based) within a domain used to further group or filter data.
    %%
    
    b. Briefly describe the following **Quality of Service (QoS)** policies:
        - **Durability**: 
        - **Deadline**: 

    %%
    **Durability**: Determines if the middleware should store data for "late-joining" readers (Volatile vs. Transient vs. Persistent).
    **Deadline**: Sets an expectation for how frequently data should be updated; triggers an alarm if a writer fails to publish within the specified interval.
    %%