# Resource Sharing in Real-Time Systems
In real-time systems, resource sharing requires special protocols to avoid issues like **Priority Inversion** and ensure tasks meet their deadlines.
### Priority Inversion
Priority inversion occurs when a lower-priority task holds a resource (e.g., a mutex) that a higher-priority task needs, while a medium-priority task preempts the lower-priority task, effectively blocking both from finishing.
#### Priority Inheritance Protocol (PIP)
- **Concept**: A lower-priority process temporarily "inherits" the priority of any higher-priority process that it is blocking.
- **Rule**: When a high-priority process blocks on a resource held by a low-priority process, the low-priority process's priority is raised to that of the high-priority process.
- **Completion**: Once the low-priority process releases the resource, its priority reverts to its original level.
- **Pros**: Prevents medium-priority tasks from preempting the resource holder and delaying both high-priority and low-priority tasks.
- **Cons**: Can lead to chains of inheritance and potential **deadlock**.
### Case Study: Mars Pathfinder (1997)
> [!info] The Sojourner Problem
> The Mars Pathfinder rover used the **Wind River VxWorks** RTOS. Tasks were threads with priorities reflecting urgency.
- **The Setup**: 
	- **Bus Management (High Priority)**: Communicated with hardware; ran frequently.
	- **Communication (Medium Priority)**: Occasional long-running task.
	- **Weather Sensors (Low Priority)**: Wrote meteorological data to a shared bus.
	- **Shared Bus**: A data space protected by a mutex.
	- **Watchdog Timer**: Would reset the rover if the high-priority Bus Management task didn't run for a certain interval.
- **The Failure**: 
	1. The low-priority **Weather task** locked the bus mutex.
	2. The high-priority **Bus Management task** preempted the Weather task but then blocked, waiting for the bus mutex.
	3. The medium-priority **Communication task** preempted the Weather task. 
	4. This left the high-priority Bus Management task blocked for a long time.
	5. The **Watchdog Timer** expired and reset the rover repeatedly.
- **The Fix**: 
	- Engineers reproduced the issue on an identical copy on Earth.
	- They enabled **Priority Inheritance** on the VxWorks mutexes via a software patch uploaded to Mars.
	- This allowed the Weather task to finish and release the mutex before the Communication task could preempt it.
### Priority Ceiling Protocols
These protocols assign a **Ceiling Value** to each resource (semaphore/mutex), representing the highest priority of any task that could potentially use it.
#### Immediate Priority Ceiling Protocol (IPCP)
- **Concept**: A task's priority is immediately raised to the resource's ceiling as soon as it locks the resource.
- **Rationale**: Releases the resource as quickly as possible to avoid blocking higher-priority tasks.
- **Features**: Simple to implement (uses a stack of priorities), deadlock-free.
- **Example**: If P1 (highest) and P3 (lowest) use S1, P3's priority is raised to P1's whenever it locks S1.
#### Original Priority Ceiling Protocol (OPCP)
- **Concept**: A task $P_i$ can only lock a resource if its priority is strictly higher than the ceilings of all resources currently locked by other tasks.
- **Benefit**: Unlike IPCP, priority is only raised when a higher-priority task actually attempts to lock a resource.
- **Complexity**: More complex as it requires tracking all active locks and dependencies.
### Linux Realtime
Modern Linux kernels support real-time capabilities through the **PREEMPT_RT** patch (mainline since 6.12.0).
#### Scheduling Algorithms
Linux supports three main real-time policies (see [[Scheduling.md]]):
- `SCHED_FIFO`: Fixed-priority, first-in-first-out.
- `SCHED_RR`: Fixed-priority, round-robin.
- `SCHED_DEADLINE`: Uses Earliest Deadline First (EDF) scheduling.
#### System Management
- **CPU Isolation**: Reserve specific cores for real-time processes.
- **chrt utility**: Used to convert existing processes to real-time.
	- Example: `chrt -p -f 98 PID` changes a process to FIFO with priority 98.
#### Example: FIFO Periodic Task (C)
```c
void *rt_fifo_thread_func(void *arg) {
    struct timespec next_release_time;
    clock_gettime(CLOCK_MONOTONIC, &next_release_time);
    mlockall(MCL_CURRENT | MCL_FUTURE); // Prevent swapping
    while (1) {
        next_release_time.tv_nsec += PERIOD_NS;
        // Handle nanosecond overflow
        while (next_release_time.tv_nsec >= NSEC_PER_SEC) {
            next_release_time.tv_sec++;
            next_release_time.tv_nsec -= NSEC_PER_SEC;
        }
        clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &next_release_time, NULL);
        // Task logic goes here
    }
}
```
#### Mutexes & Inheritance
In Linux, `pthread` mutexes support priority inheritance for `SCHED_FIFO` and `SCHED_RR`:
```c
pthread_mutexattr_t attr;
pthread_mutexattr_init(&attr);
pthread_mutexattr_setprotocol(&attr, PTHREAD_PRIO_INHERIT);
pthread_mutex_init(&pri_mutex, &attr);
```
> [!warning] Deadline Scheduling Note
> Since `SCHED_DEADLINE` tasks don't have static priorities, traditional priority inheritance isn't applicable. Linux uses **Proxy Execution** to allow a task to "donate" slack time to a resource holder.
#### C++ Implementation
C++ threads are built on `pthreads`. Since the C++ `std::thread` class doesn't support setting scheduling policies at creation, you must use:
- `native_handle()` to access the underlying `pthread_t`.
- `pthread_setschedparam()` inside the thread function using `pthread_self()`.
