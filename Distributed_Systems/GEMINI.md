# Project Context: Distributed Systems Notes

## Directory Overview
This directory contains study notes and summaries related to a course on **Distributed Systems**. It focuses on the theoretical foundations of distributed computing as well as specific implementation details, likely relevant to C++ programming.

## Key Files

*   **`Introduction.md`**: Provides a high-level introduction to Distributed Systems. Key topics include:
    *   **Definitions**: Distinctions between decentralized and distributed systems.
    *   **Perspectives**: Process, communication, coordination, naming, consistency, and fault tolerance.
    *   **Goals**: Resource sharing and various forms of transparency (access, location, replication, failure).
    *   **Dependability & Fault Tolerance**: Concepts of availability, reliability, safety, and types of faults (transient, intermittent, permanent).
    *   **Scalability**: Size, geographical, and administrative scalability.

*   **`Cpp-Overview.md`**: Focuses on **Threads and Concurrency**, contrasting C and C++ approaches.
    *   Discusses `pthreads` in C versus `std::thread` in C++.
    *   Includes code examples for creating and joining threads in C.
    *   Mentions compilation flags (e.g., `-pthread`).

## Usage
These files are intended for:
1.  **Review**: Quick reference for distributed systems concepts and definitions.
2.  **Study**: Preparing for exams or understanding the theoretical underpinnings of distributed infrastructure.
3.  **Reference**: Looking up specific C++ threading syntax or distributed system design goals (like transparency and scalability).
When editing files be sure not to delete any content unless it is already covered or not relevant to the file,
### Formatting
Any math should be returned as latex that can be easily copy and pasted into a $$ $$
block. When math spans multiple lines use the \begin{aligned} and \end{aligned} latex functions. Any code should be returned as a code block 
```
```
Without any number lines. Notes created should be clear and explanatory.  When asked to "reformat" notes, rewrite them so that they are in proper markdown format and are optimized to be used in obsidian. Do not remove any details but if needed, include extra details or examples for concepts if it helps makes the notes clearer and easier to understand. Do not include a line break after paragraphs, headers or sections. Create obsidian links to other files for references to other topics.