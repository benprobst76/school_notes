Software measurement, often through [[Software-Metrics]], is crucial for understanding and improving the software development process and the quality of the resulting product.

*   **Process Improvement**: Measuring the development process allows teams to identify areas needing improvement, such as bottlenecks, inefficiencies, or quality issues. This data-driven approach helps optimize workflows and resource allocation.
*   **Product Quality Enhancement**: Product metrics, such as reliability, usability, maintainability, and performance, provide insights into whether the software meets quality standards and user expectations. By tracking these, teams can ensure a high-quality end product.

However, measuring software projects can be controversial. There is ongoing debate about which metrics are most appropriate and whether people, processes, or products can be reliably compared using these metrics.

## Measurement Basics

### Know What You Are Measuring

As George Miller wisely stated:
> “In truth, a good case could be made that if your knowledge is meager and unsatisfactory, the last thing in the world you should do is make measurements. The chance is negligible that you will measure the right things accidentally.”

This emphasizes the importance of a clear understanding of what you intend to measure before collecting any data.

### Definition of Measurement

**Measurement** is the process of empirical, objective assignment of numbers to entities to characterize an attribute.

Let's break down this definition:

*   **Entity**: An object or event being observed or measured.
    *   *Example*: A source program, a software module, a testing process, a programmer.
*   **Attribute**: A specific feature or property of an entity that we are interested in.
    *   *Example*: The size of a program, the duration of a test phase, the efficiency of a tester.
*   **Objective**: The measurement process must be based on a well-defined rule whose results are repeatable and verifiable by others.
    *   *Example*: Counting the exact number of source lines in a program is an objective measurement.

In essence, for each entity, a number is assigned that provides information about one of its attributes. For instance, assigning a source line count to each source program tells us about its size.

### Example Measurements

| Entity           | Attribute             | Measure                        |
| :--------------- | :-------------------- | :----------------------------- |
| Person           | Age                   | Years since birth              |
| Person           | Age                   | Months since last birthday     |
| Source code      | Length                | # Lines of Code (LOC)          |
| Source code      | Length                | # Executable Statements        |
| Testing process  | Duration              | Time in hours from start to finish |
| Tester           | Efficiency            | Number of faults found per KLOC |
| Testing process  | Fault frequency       | Number of faults found per KLOC |
| Source code      | Quality               | Number of faults found per KLOC |
| Operating system | Reliability           | Mean time to failure / rate of failure occurrence |

## Common Mistakes in Software Measurement

It's easy to make mistakes when choosing what or how to measure characteristics in software. To avoid these, adhere strictly to the definition of measurement:

1.  **Specify both an Entity and an Attribute**: Do not just state one or the other.
    *   *Incorrect*: "Measuring a program."
    *   *Correct*: "Measuring the **size** (attribute) of a **program** (entity)."
    *   *Incorrect*: "Measuring the size of the software."
    *   *Correct*: "Measuring the **size** (attribute) of the **source code** (entity) of the software."
    This is a common bad habit in many fields, not just software engineering.

2.  **Define the Entity Precisely**: Be specific about the entity you are measuring.
    *   *Incorrect*: "Program."
    *   *Correct*: "**Program source code**" or "**Compiled executable**" or "**Design document**." Precision avoids ambiguity.

3.  **Have a Good Intuitive Understanding of the Attribute**: Before proposing a measure, ensure there's a clear, intuitive grasp of the attribute it's characterizing.
    *   *Example*: We have strong evidence that the attribute "size" of a program is intuitively related to its "number of source lines." This intuitive link validates the measure.

It is a mistake to propose a measure if there is no clear consensus on what attribute it is characterizing.
*   *Example*: The "Number of defects per KLOC (1000 lines of code)" can ambiguously characterize either the **quality of the code** (fewer defects = higher quality) or the **quality of the testing** (more defects found = more effective testing). Without clarity, this metric is misleading.

It is also a mistake to redefine an attribute to fit an existing measure.
*   *Example*: If we've only measured "# defects found this month," it's incorrect to then claim this as an indicator of "code quality." It primarily indicates detection effort, not necessarily inherent quality.

## Kinds and Uses of Software Measurement

### Kinds of Measurement

There are two primary kinds of measurement in software engineering:

*   **Direct Measurement**: Quantities that can be derived directly from the entity without requiring information from other sources.
*   **Indirect Measurement**: Quantities derived by combining two or more direct measures to characterize a particular attribute.

### Uses of Measurement

Measurement serves two distinct purposes:

*   **Assessment**: Understanding the current state of affairs ("the way things are now"). This includes evaluating current performance, identifying existing problems, or benchmarking against standards.
*   **Prediction**: Forecasting future outcomes or behaviors ("the way things are likely to be in the future"). This is essential for planning, risk management, and making informed decisions about future projects.

### Direct Measurement

Direct measures are straightforward counts or observations.

*   **Length of source code**: Measured by the number of lines of code (LOC).
*   **Duration of testing process**: Measured by elapsed hours or days.
*   **Number of defects discovered during testing**: Measured by counting each unique defect.
*   **Effort of a programmer on a project**: Measured by person-months worked.

### Indirect Measurement

Indirect measures often involve ratios or calculations combining direct measures to gain more complex insights.

*   **Programmer productivity**:
    `Lines of code produced / Person-months of effort`
    *(This is a common but often debated metric due to its limitations in reflecting true productivity.)*
*   **Program defect density**:
    `Number of defects / Length of source code (e.g., per KLOC)`
    *(Provides an indication of how "buggy" the code is relative to its size.)*
*   **Requirements stability**:
    `Original number of requirements / Total number of requirements`
    *(A measure of how much requirements change over time.)*
*   **Test effectiveness ratio**:
    `Number of items covered / Total number of items (e.g., requirements, features)`
    *(Indicates the thoroughness of the testing process.)*

## Predictive Measurement

Measurement for prediction is a more advanced application that requires a structured **prediction system**. This system typically consists of three key components:

1.  **A Mathematical Model**: A formula or algorithm that relates input variables to the predicted outcome.
    *   *Example*: `E = a * S^b`, where `E` is the effort to be predicted, `S` is the estimated size in lines of code, and `a` and `b` are constants determined empirically. If `b = 2`, the model suggests effort increases quadratically with LOC.

2.  **A Procedure for Determining the Model Parameters**: Methods for calibrating the model using historical data or expert judgment.
    *   *Example*: Analyzing data from past projects to determine the specific values for constants `a` and `b` that best fit the organization's context.

3.  **A Procedure for Interpreting the Results**: Techniques to understand the confidence and accuracy of the prediction.
    *   *Example*: Using Bayesian probability analysis to determine the likelihood that a prediction is accurate within a specified margin (e.g., 10%).

