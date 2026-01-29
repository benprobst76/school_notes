## Threads
Distributed systems are inherently concurrent and parallel.
*   In the absence of a lab environment with multiple physical machines, threads within a single process are used to approximate distributed nodes.
*   **Concept**: Single process with a single flow of control vs. multiple threads of execution.

### C++ Thread Example
```cpp
#include <thread>  
#include <string>  

void thread_func(int i) {  
    // ... thread logic ...
}  

int main() {  
    std::thread t1, t2;  
    t1 = std::thread(thread_func, 0);  
    t2 = std::thread(thread_func, 1);  
    t1.join();  
    t2.join();
}
```

## Remote Procedure Call (RPC)
### Motivation
Programming directly with sockets (as seen in [[Network-Programming]]) involves many low-level details:
*   Requires detailed boilerplate code.
*   Prone to bugs and security issues.
*   Portability and maintenance challenges.
**Goal**: A higher-level abstraction that makes an interaction with a remote server look like a local procedure call.

### General Concept
The fundamental technique underlying many distributed systems. The goal is to allow code to be split across computers without changing the semantic logic significantly.
#### Local Function Call (Monolithic)
```c
// client.c  
struct d value1, value2;  
value1 = ...;  
result = put(12, value1);  
value2 = get(25);
```

```c
// kvstore.c  
#include <map>  
map<int, struct d> kv_store;  

bool put(int k, struct d v){  
    kv_store[k] = v;  
}  

struct d get(int k){  
    return (kv_store[k]);  
}
```

#### Remote Function Call (Distributed)
To split this across machines, we use a **Client Stub** and a **Server Stub** (often implementing a common interface).

**Client Side (`client.cpp`):**
```cpp
kvstore kv;  
struct d value1, value2;  
value1 = ...;  
// Looks like a local call, but sends network request
result = kv.put(12, value1);  
value2 = kv.get(25);
```

**Header Interface (`kvstore.hpp`):**
```cpp
#include <map> 
// class kvImpl; 

class kvstore {  
public:  
    bool put(int k, struct d v);  
    struct d get(int k);  
private:  
    // Implementation details hidden (pImpl pattern often used)
    // map<int,struct d> kv_store; 
    // std::unique_ptr<kvImpl> pImpl; 
};
```
*   **pImpl Pattern**: The `kvImpl` class can have two implementations: one for the client (stub that sends messages) and one for the server (actual logic).

## Design & Implementation Issues
### Parameters & Marshaling
*   **Heterogeneity**: Client and server may use different languages (C++, Java, Rust) or data representations.
*   **Marshaling**: The process of converting parameters and memory structures into a sequence of bytes for transmission.
    *   Complex structures (trees, graphs) must be serialized.
    *   **Endianness**: Must agree on byte order (Big Endian vs Little Endian).
*   **Stubs**: Responsible for transforming data between machine-dependent representations and the wire format.

### Parameter Passing Semantics
Since client and server do not share an address space:
*   **Pass by Value**: Easy to implement.
*   **Pass by Reference**: Impossible in the traditional sense.
    *   *Copy-in/Copy-out*: Value is sent, modified, and sent back.
    *   No shared state means other threads on the client cannot see changes until the RPC returns.
*   **Takeaway**: Full **access transparency** is impossible; latency and failure modes differ from local calls.

### Binding (Discovery)
How does the client find the server (IP and Port)?
1.  **Static Configuration**:
    *   Hardcoded or config files.
    *   *Example*: **NFS** uses `/etc/fstab` to list server addresses and mount points.
2.  **Dynamic Configuration (Directory Services)**:
    *   Client broadcasts a discovery message or queries a registry.
    *   Server listens and responds with its address.
3.  **Combination (Port Mapper)**:
    *   Server runs a "Port Mapper" daemon on a known port (e.g., 111).
    *   Services register their random/dynamic ports with the mapper.
    *   Client queries the mapper to find the specific port for a service (e.g., NFS).

### Failure Modes
Things go wrong in distributed systems that don't happen locally:
1.  Client cannot locate server.
2.  Request message lost.
3.  Server crashes during execution.
4.  Reply message lost.
5.  Client crashes after sending request.

## RPC Semantics
Defines how many times a procedure is executed in the face of failures.
### 1. At Least Once
*   **Behavior**: Operation is executed 1 or more times.
*   **Implementation**: Client resends message until it gets a confirmation.
*   **Use Case**: Idempotent operations (e.g., reading data, "set x = 5").
*   **Risk**: Non-idempotent operations (e.g., "transfer $5") may happen multiple times.
### 2. At Most Once
*   **Behavior**: Operation is executed 0 or 1 time.
*   **Implementation**:
    *   Messages have unique IDs.
    *   Server tracks IDs to prevent re-execution of duplicates.
*   **Risk**: If the server crashes or fails over, the duplicate history might be lost.
### 3. Exactly Once
*   **Behavior**: The ideal. Guaranteed single execution.
*   **Implementation**: Extremely difficult; requires atomic tracking of requests and responses and durable state.

## Reliability Issues
### Lost Reply Messages
If the client gets no answer, it doesn't know if:
1.  Request was lost (Server did nothing).
2.  Server is slow.
3.  Reply was lost (Server did the work).

**Handling**:
*   **Idempotent transactions**: Safe to retry.
*   **Non-idempotent**: Requires "At most once" filtering on server.

### Client Crash (Orphans)
If a client crashes after invoking an RPC, the server might still be processing (wasting resources). This computation is an **Orphan**.
*   **Solutions**:
    *   **Extermination**: Client kills orphans upon recovery (complex).
    *   **Epochs**: Client includes a generation number; server ignores/kills tasks from old generations.
    *   **Timeouts**: Operations are killed if they run too long.

## Synchronization & Transport
### Async vs. Sync
*   **Synchronous**: Client blocks until result returns (looks like local call).
*   **Asynchronous**: Client continues, notified via **callback** or **promise/await** when result is ready.
### Transport Protocol
*   **UDP**:
    *   Used by Sun RPC (NFS).
    *   Low overhead, supports multicast.
    *   Reliability must be implemented in the application layer.
*   **TCP**:
    *   Used by gRPC.
    *   Reliable, handles stream control.
    *   Higher overhead for setup/teardown.
### Authentication
*   **IP Check**: Trust based on source IP (weak, e.g., NFS).
*   **API Key**: Simple token.
*   **Session Key**: Cryptographic handshake.

## Examples
*   **Sun RPC**: Used for NFS (Network File System).
*   **CORBA**: Complex object-oriented standard (90s).
*   **Java RMI**: Java-specific Remote Method Invocation.
*   **SOAP/XML-RPC**: Text-based, heavy.
*   **gRPC**: Modern, uses Protocol Buffers and HTTP/2.
*   **REST/AJAX**: Web standard.
