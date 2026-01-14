---
tags:
  - performance
  - software-engineering
  - SPE
  - school-notes
---

# Introduction to Software Performance

## Core Definitions

### What is Performance?
**Performance** refers to **response time** or **throughput** as seen by the users.

*   **Response Time:** The time required to respond to a request.
    *   *Example:* The time required for an ATM withdraw transaction to complete.
*   **Throughput:** The number of requests that can be processed in a specified time interval.
    *   *Example:* An ATM network processing 100,000 transactions per hour.

### Responsiveness
**Responsiveness** is the ability of a system to meet its objectives for response time or throughput. It has two components:
1.  **Objective:** Measurable metrics (e.g., "Transaction takes 200ms").
2.  **Subjective (User Perceived):** How fast the system *feels* to the user.
    *   *Clarification:* A system can improve subjective responsiveness without improving actual speed by providing feedback (e.g., progress bars, immediate UI updates) while processing happens in the background.

### Scalability
**Scalability** is the ability of a system to *continue* to meet its response time or throughput objectives as the demand for its functionality increases (e.g., more users, more data).

---

## The Cost of Performance Failures
Performance is not just a technical metric; it is a business requirement.

*   **Consequences:**
    *   Damaged customer relations
    *   Business failures
    *   Lost income
    *   Additional project resources required
    *   Project failure
*   **Key Insight:** The most serious consequence of performance failure is the possibility of **business failure**.
*   **Common Situations:**
    *   Problems often stem from **fundamental architecture/design** choices, not just inefficient coding.
    *   Issues are often late-detected (during integration testing).
    *   **Cost of Change:** It is significantly more costly to modify design/architecture than to modify code.

---

## Managing Performance: Approaches

### Reactive Approach ("Fix-it-Later")
*   "Let’s build it first and see what it can do."
*   "We’ll tune it later."
*   "We cannot do anything until we have something to measure."
*   "Hardware is fast; don't worry."
*   **Result:** Often leads to major refactoring or project failure if architectural limits are hit.

### Proactive Approach (SPE)
*   The project includes a **Performance Engineer (PE)**.
*   Performance awareness is shared: Everyone knows the PE and has training.
*   Procedures are in place to identify performance issues early.
*   **New Technology:** Careful attention is paid to performance when adopting new tech until its characteristics are understood.

---

## Common Misconceptions
*   "Performance problems are rare."
*   "Hardware is fast and inexpensive" (so software efficiency matters less).
*   "It’s too expensive to build responsive software."
*   "You can tune the software later, if necessary."
*   "Efficiency implies 'tricky code'."

---

## [[SPE-Process|Software Performance Engineering (SPE)]]

### Definition
**Software Performance Engineering (SPE)** is a systematic, quantitative approach to constructing software systems to meet performance objectives.
*   Begins **early** in the software lifecycle (Requirements/Analysis phase).
*   Uses quantitative methods (modeling, estimation).
*   Identifies problems **before** significant implementation effort.
*   Continues through detailed design, coding, and testing.

### History & Context
*   **Early Days:** Difficult; relied on hand-crafted simulation models. Hard to keep up-to-date. Cost-effective only for mission-critical systems.
*   **Non-Critical Systems:** Traditionally adopted the "fix-it-later" method.
*   **Traditional SDLC Problems:** Considering performance only at the end makes fixing issues costly and time-consuming, often requiring major code refactoring.

### Why SPE is Often Skipped
1.  No established discipline for quick/easy assessment.
2.  Insufficient budget/time for analysis.
3.  Pressing deadlines.
4.  Emphasis on functionality first ("Make it work, then make it fast").

### Benefits of Early Integration
*   **Productivity:** Increased during implementation and testing (less time fighting fires).
*   **Cost Control:** Avoids throwing away bad designs or over-provisioning hardware.
*   **Quality:** Selects suitable design choices early.
*   **Hardware Sizing:** Ensures sufficient computing power is identified and available.

---

## Systems with High Performance Requirements
While all systems benefit from performance, some require it critically:
*   **End-user related functions:** Reservation systems, Checkout systems (Responsiveness directly affects revenue).
*   **Real-time / Mission-critical:** Flight-control systems (Performance = Safety).
*   **Employee support:** Inventory control, CAD systems (Performance = Productivity).

---

## Key Questions to Address Early
*   Will users be able to complete tasks in the allotted time?
*   Are hardware and network capabilities sufficient for the load?
*   What is the expected response time for key tasks?
*   Will the system scale to meet future needs?