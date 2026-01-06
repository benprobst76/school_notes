# Software Product Metrics

Software product metrics are measurements taken directly from the software product itself. These can be broadly categorized into two types:

*   **External Product Metrics**: These are derived from observing the software in its operational environment (e.g., when it's being run).
    *   *Examples*: Defect metrics, reliability, availability.
*   **Internal Product Metrics**: These are derived from the inherent characteristics of the software's code, design, or functionality, independent of its execution environment.
    *   *Examples*: Size metrics, complexity metrics.

---

## External Product Metrics

External metrics are applied by observing the software product as it interacts within its environment. They primarily focus on the behavior and performance of the system from a user or operational perspective.

Key external metrics include:

*   **Failure rate**: The number of failures per unit time, directly indicating the system's reliability.
*   **Availability rate**: The percentage of time the system is operational ("up") and ready to deliver services.
*   **Defect rate**: The number of defects observed in relation to the size of the code or during a specific operational period.

### Software Reliability

Software reliability is a critical quality attribute that quantifies the probability of a system operating without failure for a specified period under defined conditions.

**Implications of Reliability:**

*   **No Single Number**: There isn't one universal reliability number for a given program. Its reliability depends significantly on how the program is used (its operational environment, workload, and usage patterns).
*   **Probabilistic Model**: Reliability is modeled using probability to account for inherent uncertainty in system behavior and failure occurrences.
*   **Time-Dependent**: Reliability is time-dependent; the longer a system operates, the higher the probability of encountering a failure.

### Reliability Metrics

For a more detailed discussion on these, refer to the `Metrics/Measurement.md` file.

#### Probability of Failure On Demand (POFOD)

*   **Definition**: The probability that a demand for service from a system will result in a system failure.
*   **Interpretation**: A POFOD of `0.001` means there is a 1 in 1,000 chance that the system will fail when a service request is made. This metric is especially relevant for systems where failures are sporadic and event-triggered rather than time-continuous (e.g., transaction processing systems, emergency shutdown systems).

#### Rate of Occurrence of Failures (ROCOF)

*   **Definition**: The probable number of failures likely to be observed within a specified time period (e.g., failures per hour or per day).
*   **Interpretation**: If ROCOF is two failures per hour, it means, on average, two failures are expected within any given hour of operation.
*   **Relationship to MTBF**: The reciprocal of ROCOF is the **Mean Time Between Failures (MTBF)**. For example, if ROCOF is two failures/hour, then MTBF = 30 minutes (indicating the average time expected between consecutive failures).

### Reliability: Definition of Failure

Understanding what constitutes a "failure" is fundamental to measuring reliability:

*   **Formal View**: Any deviation from the officially specified behavior or requirements. This is a strict interpretation often used in contracts or compliance.
*   **Engineering View**: A broader perspective that encompasses any deviation from required, specified, or expected behavior.
    *   **Required**: What the system *must* do as dictated by its operational environment or critical functions.
    *   **Expected**: What users anticipate the system to do, even if not explicitly written in formal specifications.

### Errors, Faults, and Failures

These terms are often used interchangeably, but in software engineering, they have distinct meanings:

*   **Error (Human)**: A mistake or oversight made by a designer, programmer, or user that produces an incorrect or unexpected result.
    *   *Example*: A programmer misunderstands a requirement and writes incorrect logic.
*   **Fault (Defect/Bug)**: A mistake or flaw in the software's code or design that can cause it to behave incorrectly. It's the manifestation of a human error within the software artifact.
    *   *Example*: A division-by-zero bug, an incorrect conditional statement.
*   **Failure (System Behavior)**: An event that occurs when the program is run in certain situations, and it does not perform as intended due to an underlying fault. A failure is the observable symptom of a fault.
    *   *Example*: The application crashes, a calculation produces an incorrect result, data is corrupted.

**Relationship**: Errors *cause* faults in the software, which then *lead to* failures during execution.

**Defect**: This term is often used broadly. Sometimes it refers only to **faults**, sometimes only to **failures**, and sometimes to the combination of **faults + failures**. It's crucial to clarify its meaning in context.

### Defect Density Metric

Defect density is a standard reliability metric used as an indicator of software quality.

*   **Formula**: `DD = (Number of defects found) / (System size)`
*   **Units**: Size is commonly measured in KLOC (thousands of lines of code), so defect density units are typically "defects found per 1000 lines" (defects/KLOC).
*   **Application**: Widely used to compare the quality of different software components or projects, assuming a lower defect density indicates higher quality.

### Predictive Power of Defect Density

Despite its widespread use, the predictive power of defect density has limitations:

*   **Faults vs. Failures**: Research suggests that faults are not always a good predictor of failures, and vice versa. For example, some studies indicate that a large percentage of faults might cause only a small percentage of failures, and conversely, a small number of critical faults can be responsible for a significant portion of failures.
*   **Historical Data Limitations**: This finding implies that historical defect density data might not be a strong predictor of actual operational quality or user-perceived reliability. A high defect density might indicate poor quality, or it might indicate very thorough testing that uncovered many faults.

### Availability

**Availability** is the ability of a system to deliver services when requested, or the probability that a system will be operational when a demand is made for service. It's often expressed as a percentage.

*   **Interpretation**: An availability of `0.9999` means that, on average, the system will be available for 99.99% of its operating time.

For a detailed table on Availability and its implications over time, please refer to the `Metrics/Measurement.md` file.

---

## Internal Product Metrics

Internal product metrics measure characteristics of the software's design and code, independent of its runtime environment. The U.S. military, for example, lists hundreds of measures for code alone.

*   **Advantages**: These measures are often easier to make and automate, as they can be derived directly from source code or design documents.
*   **Challenges**: It's not always clear which attributes of the program these metrics truly characterize, or their direct correlation with external quality attributes like reliability or maintainability.

### Code Metrics

#### Software Size

The simplest and most enduring internal product metric is the size of the product.

*   **Lines of Code (LOC)**: Most often quoted in thousands (KLOC).
*   **Uses of LOC**:
    *   **Productivity**: Often used in indirect measures like `Productivity = LOC / Effort`.
    *   **Effort or Cost Estimation**: Models like `Effort = f(LOC)` use LOC as a primary input.
    *   **Quality Assessment**: Used to calculate `Quality = Defects / LOC`.
*   **Similar Measures**:
    *   **KDSI (Thousands of Delivered Source Instructions)**: A refined version of LOC, focusing on executable instructions.
    *   **NLOC (Non-Comment Lines of Code)**: Excludes comments and blank lines for a more focused measure of active code.
    *   **Number of characters of source or bytes of object code**: Alternative physical size measures.

#### Problems with LOC Measures

LOC measures have significant limitations and drawbacks:

*   **What Attribute is Measured?**: LOC primarily measures the *length* of a program (a physical characteristic) rather than its *size* (a logical characteristic, often related to functionality or complexity). It's often mistakenly used as a surrogate for more complex attributes we're truly interested in, such as effort, complexity, or functionality.
*   **Redundancy and Reuse**: Does not account for redundant code or the impact of code reuse, which can inflate or deflate perceived size without reflecting true development effort or functionality.
*   **Language Dependency**: Cannot be reliably compared across different programming languages due to varying syntax, verbosity, and expressiveness. A task requiring 100 LOC in Python might require 1000 LOC in C++, making direct comparison misleading.
    *   As Capers Jones stated in "Applied Software Measurement (2008)":
        > "Lines of code metrics distort the true economic case by so much that their use for economic studies involving more than one programming language might be classified as professional malpractice. The only situation where LOC metrics behave reasonably well is when two projects utilize the same programming language."
*   **Measurement Timing**: Can only be accurately measured at the end of the development cycle, limiting their utility for early project estimation or tracking.
*   **Ambiguity in Counting**: Even within the same language, counting "lines of code" can be ambiguous (e.g., multiple statements on one line vs. one statement split across multiple lines).

    *   *Example*:
*
```c
for (i=0; i<100; ++i) printf("hello %d\n", i); // 1 LOC by some counts
```
vs.
```c
printf("hello 0\n");
printf("hello 1\n");
// ... 98 more lines ...
printf("hello 99\n"); // 100 LOC by statement count
```
#### Better Size Measures

To address the limitations of LOC, other fundamental size attributes are considered:

*   **Length**: The physical extent of the software. LOC can still serve as a measure for this specific attribute.
*   **Functionality**: The capabilities provided to the user by the software. This measures "how big or rich" the set of functions is.
    *   This is tricky unless comparing subsets and supersets, but it's useful for version comparisons:
        *   Version 1.0: features 1 through 50
        *   Version 1.1: features 1 through 56 (Version 1.1 ⊇ Version 1.0)
        *   Version 2.0: features 1 through 100 (Version 2.0 ⊇ Version 1.1)
    *   **Function Points (FP)**: A widely used indirect measure of functionality, calculated based on the number and complexity of inputs, outputs, inquiries, files, and external interfaces.
*   **Complexity**: How intricate or difficult the software is to understand, develop, or maintain.

    *   **Problem Complexity**: Measures the inherent complexity of the underlying problem that the software is designed to solve.
    *   **Algorithmic Complexity**: Measures the complexity or efficiency of the specific algorithms implemented by the software (e.g., Big O notation).
    *   **Structural Complexity**: Measures the structure of the program used to implement the algorithm, including control structure, modular structure, data flow structure, and architectural structure.
    *   **Cognitive Complexity**: Measures the mental effort required for a human to understand the software code.

---

## Code Complexity Metrics

These metrics provide more nuanced insights into the characteristics of source code beyond simple size.

### Early Measures of Source Code Characteristics

Early work in code complexity measured characteristics such as:

*   Number/density of decision (e.g., `if`, `switch`) statements.
*   Number/depth of blocks and loops (indicating nesting levels).
*   Number/average length of methods/classes.

### Best-Known Code Complexity Measures

Two widely accepted and foundational measures for source code complexity are:

*   **Halstead's "Software Science" Metrics (1977)**
*   **McCabe's "Cyclomatic Complexity" and "Data Complexity"**

#### "Software Science" Metrics (Halstead 1977)

Halstead's metrics are based on counting operators and operands in the source code.

*   **Operators**: Reserved language words and language-specific symbols that perform operations.
    *   *Examples*: `if`, `return`, `this`, `+`, `!=`, `>>`, `.`
*   **Operands**: Identifiers, type names, and literal constants (character, numeric, or string).
    *   *Examples*: `int`, `bool`, `void`, `x`, `y`, `1`, `"Hello world"`

**Derived Metrics:**

By treating program source code as a sequence of "tokens" (either an operator or an operand), Halstead defined:

*   **η1 (eta1)**: Number of unique (distinct) operators.
*   **η2 (eta2)**: Number of unique (distinct) operands.
*   **N1**: Total number of operator uses (occurrences).
*   **N2**: Total number of operand uses (occurrences).

From these, further metrics can be derived:

*   **Program Length (N)**: `N = N1 + N2`
*   **Program Vocabulary (η)**: `η = η1 + η2`
*   **Program Volume (V)**: `V = N * log2(η)` (the number of bits required to specify the program).
*   **Program Difficulty (D)**: `D = (η1/2) * (N2/η2)`
*   **Effort (E)**: `E = V * D` (Halstead estimated this corresponds to mental discriminations required to implement the program).

#### McCabe's "Cyclomatic Complexity" Metric

Cyclomatic complexity `v(P)` is a quantitative measure of the number of linearly independent paths through a program's source code. It is derived from the program's control flow graph.

*   **Control Flow Graphs (CFG)**: A representation of all paths that might be traversed through a program during its execution.
*   **Formula**: If the control flow graph `G` of program `P` has `e` edges and `n` nodes, then the cyclomatic complexity `v(P)` is:
    `v(P) = e - n + 2`
*   **Interpretation**: `v(P)` represents the number of linearly independent paths in `G`. A higher `v(P)` indicates a more complex control flow, which generally correlates with higher testing effort and a greater risk of defects.
    *   *Example*: For a CFG with `e = 16` edges and `n = 13` nodes, `v(P) = 16 - 13 + 2 = 5`. This means there are 5 independent paths that need to be tested.
*   **Guideline**: McCabe proposed that for each module of code (e.g., a method or function) `P`, a cyclomatic complexity `v(P) < 10` is desirable, as higher values typically discourage understanding and maintenance.

#### Other Flowgraph Metrics

Cyclomatic complexity is just one of many flowgraph-based complexity metrics. A significant advantage of these metrics is their independence from the specific programming language, as they focus on the control flow structure.

Other metrics derived from flowgraphs measure aspects such as:

*   **Maximum path length**: The longest path through the program.
*   **Number/interaction of cycles**: Indicates the complexity of loops and recursive structures.
*   **Maximum number of alternative paths (a.k.a. width)**: Reflects the branching complexity.

All these metrics can be automatically computed once the control flow graph of the program is known, making them suitable for automated analysis tools.

---

## Summary

*   **Software Product Metrics**: Are divided into external (observed in environment) and internal (derived from code/design) measures.
*   **External Metrics**: Focus on attributes like reliability and availability. Failures and faults form the basis of **defect density metrics**, which are widely used indicators of software quality, though their predictive power has limitations.
*   **Internal Metrics**: Began with simple **size metrics** like Lines of Code (LOC) but have evolved to encompass more sophisticated notions of **code complexity**. LOC has significant limitations, including language dependency and ambiguity.
*   **Complexity Metrics**: Modern complexity measures include Halstead's "Software Science" metrics (based on operators and operands) and McCabe's "Cyclomatic Complexity" (based on control flow graphs). Flow graphs are a powerful tool, forming the basis for many language-independent code complexity metrics.
