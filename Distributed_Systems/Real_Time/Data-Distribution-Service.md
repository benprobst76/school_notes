---
title: Data Distribution Service (DDS)
aliases:
  - DDS
tags:
  - distributed-systems
  - dds
  - middleware
  - publish-subscribe
---
# Data Distribution Service (DDS)
DDS is a data-centric middleware standard for real-time systems, focusing on performance, dependability, and high-volume data exchange.

## Overview
- **Origins**: Started in 2001 by RTI and Thales Group; versions 1.0 (2004) through 1.4 (2015).
- **Architecture**: **Data-Centric Publish-Subscribe (DCPS)** model.
- **Key Features**:
	- Built-in capabilities for network issues.
	- Real-time alerts if deadlines are missed.
	- Dynamic discovery (no central registry).
	- High performance with low latency.

### The Global Data Space
Publishers add data to a "Distributed Global Data Space," and subscribers receive it. There is no single point of failure.

## System Entities
- **Domain Participant**: A process connected to the DDS middleware.
- **Domains**: A 32-bit integer ID that establishes an overlay network. Subscribers only see data from the same domain.
- **Partitions**: Flat namespaces (strings like "WLH-5th-floor") that can be joined using exact matches or regular expressions (e.g., "ECE.*").
- **Topics**: A triple of a **Name**, a **Type**, and a set of **Quality of Service (QoS)** policies.

## Interface Definition Language (IDL)
DDS uses IDL to define data structures independently of the host language.

### Data Types

| Type Category | Examples |
| :--- | :--- |
| **Primitives** | `int8`, `uint16`, `float`, `boolean`, `octet`, `long long`. |
| **Templates** | `string<bound>`, `sequence<type, bound>`. |
| **Aggregates** | `struct`, `union`, inheritance (`struct SubType : BaseType`). |
| **Others** | `enum`, `bitmask`, `typedef`, `const`. |

### Key Annotations
- `@key`: Identifies a member as a **key member** (defines an instance).
- `@final`, `@appendable`, `@mutable`: Structural constraints.
- `@optional`: Makes a field optional.

```idl
module Radar {
    @final
    struct Track {
        @key uint32_t id; // All updates with same ID refer to the same aircraft
        float velocity;
        double lat;
        double lon;
    };
};
```

## Publishers and Subscribers
### Data Serialization
**Common Data Representation (CDR)** is used for serialization. An IDL compiler (e.g., `idlc`) translates IDL files into C++ or other languages.

### Writers and Readers
- **DataWriter**: Used by the publisher to push data immediately (real-time).
- **DataReader**: Used by the subscriber to retrieve data via `read()` (non-destructive) or `take()` (destructive).

## Topics and Instances
- **Keyless Topics**: Every message is a singleton and independent.
- **Keyed Topics**: Each unique key represents an **instance**. New published values are updates to that specific instance.

## Quality of Service (QoS) Policies
QoS policies govern how data is handled and delivered.

| Policy | Description |
| :--- | :--- |
| **Durability** | `Volatile`, `Transient`, or `Persistent`. Determines how long data is kept for new readers. |
| **Reliability** | `Best_Effort` (no retries) or `Reliable` (guaranteed delivery). |
| **Deadline** | Ensures updates occur within a specific time frame. |
| **History** | `Keep_Last(N)` or `Keep_All`. Controls internal buffers. |
| **Presentation** | Controls coherence and order across instances or groups. |
| **Latency Budget** | Max delay from write to read. |

## Advanced Interaction
### WaitSets
WaitSets allow a thread to wait for specific events (e.g., `data_available`, `publication_matched`) rather than polling.
```cpp
dds::core::cond::WaitSet waitset;
dds::core::cond::StatusCondition rsc(reader);
rsc.enabled_statuses(dds::core::status::StatusMask::data_available());
waitset.attach_condition(rsc);
waitset.wait(); // Pauses until data is ready
```

### Listeners
Listeners provide a callback mechanism (`on_data_available`) for asynchronous event handling.

### Filtering and Queries
- **Selecting Keys**: Lookup specific instances via `lookup_instance()`.
- **Content Filtering**: Use SQL-like syntax or boolean filter functions to subscribe to data matching specific criteria (e.g., `distance < 8.0`).

---
**Related Topics**:
- [[Real-Time]]
- [[Real-Time-Operating-System]]
- [[RAFT]]
