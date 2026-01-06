1. What is the formal definition of "measurement" in software engineering, and what are its three key components?
   Measurement is the process of empirical, objective assignment of numbers to entities to characterize an attribute. The key components are:
   - **Entity**: The object or event being measured (e.g., source code, a programmer).
   - **Attribute**: The specific property of the entity being measured (e.g., size, efficiency).
   - **Objective**: The measurement is based on a well-defined, repeatable, and verifiable rule.

2.  What is the difference between process, product, and project metrics? Provide a brief definition for each.
    - **Product Metrics**: Describe characteristics of the software product itself (e.g., size, complexity, reliability).
    - **Process Metrics**: Measure the effectiveness and efficiency of the software development process (e.g., development time, defect removal efficiency).
    - **Project Metrics**: Describe project characteristics and progress (e.g., number of developers, cost, schedule).

3.  What is Function Point Analysis (FPA) designed to measure, and what is one of its main advantages over Lines of Code (LOC)?
    Function Point Analysis is designed to measure the size of a software's functionality from a user's perspective. Its main advantage over LOC is that it is language-independent and can be computed early in the development cycle from the system specifications.

4.  What is the simple COCOMO effort prediction model? What is considered its biggest drawback?
    The simple COCOMO model for effort is **Effort = a(Size)^b**, where 'Size' is in thousands of delivered source instructions (KDSI), and 'a' and 'b' are constants based on the project type. Its biggest drawback is that its accuracy depends on a size estimate (KDSI), which is often as difficult to predict as the effort itself.

5.  Explain the difference between an Error, a Fault, and a Failure in the context of software quality.
    - **Error**: A mistake made by a a programmer or designer.
    - **Fault (or Defect/Bug)**: The result of an error, representing a flaw in the software code or design.
    - **Failure**: An observable event where the software does not perform as required or expected, which is caused by a fault being executed.

6.  What does McCabe's "Cyclomatic Complexity" `v(P)` represent, and what is the general guideline for its value in a single module?
    Cyclomatic complexity `v(P)` represents the number of linearly independent paths through a program's source code. It is a measure of the code's control flow complexity. The general guideline proposed by McCabe is that `v(P)` should be less than 10 for any given module to maintain understandability and testability.

7.  Explain the core difference between Verification and Validation in SQA.
    - **Verification**: Focuses on process and conformance. It asks, "Are we building the product right?" by checking if the software meets its specified requirements and adheres to development standards.
    - **Validation**: Focuses on user needs and fitness for purpose. It asks, "Are we building the right product?" by checking if the software meets the user's actual needs and expectations.

8.  What is the role of a CI/CD pipeline in SQA? Name one popular CI tool.
    A CI/CD pipeline automates the build, integration, testing, and deployment processes. In SQA, it ensures that every code change is automatically tested for defects and regressions, providing rapid feedback and enforcing quality gates before release. Popular CI tools include GitHub Actions, Jenkins, and CircleCI.

9.  What is the "First Law of Software Development"?
    The later in the development cycle a fault is detected, the more expensive it is to fix. This emphasizes the importance of early defect detection.

10. Describe the roles of the Moderator and the Author in a Fagan-style formal inspection.
    - **Moderator**: Chairs the inspection meeting, ensures the process is followed, records all defects found, and keeps the discussion professional and focused.
    - **Author**: The creator of the work product being inspected. During the meeting, they are typically a silent observer, answering questions only when asked by the moderator, to ensure an unbiased review.

11. What is code "paraphrasing" and why is it used during an inspection?
    Code paraphrasing is an inspection technique where a reader articulates the meaning of the code in terms of the problem domain or business logic, rather than just reading the syntax. It is used to verify that the high-level intent and logic of the code are correct and clearly understood by the team.

12. What is the difference between Static Application Security Testing (SAST) and Dynamic Application Security Testing (DAST)?
    - **SAST (Static)**: A "white-box" method that analyzes source code, bytecode, or binary for security vulnerabilities *without* executing the application.
    - **DAST (Dynamic)**: A "black-box" method that tests a running application from the outside, simulating attacks to find vulnerabilities that appear at runtime.

13. What does the STRIDE acronym stand for in threat modeling?
    STRIDE stands for:
    - **S**poofing
    - **T**ampering
    - **R**epudiation
    - **I**nformation Disclosure
    - **D**enial of Service
    - **E**levation of Privilege

14. What is considered the root cause of the vast majority of software security vulnerabilities?
    Bad input handling, which includes issues with both input size (leading to overflows) and input interpretation (failing to sanitize malicious content).

15. What is the most effective method to prevent SQL Injection attacks?
    Using parameterized queries (also known as prepared statements). This approach separates the SQL code from the user-provided data, ensuring the input is treated as data and not as executable code.

16. How can an attacker use the input `' OR 1=1 --` to bypass an authentication mechanism?
    When an application improperly concatenates this input into a SQL query, it changes the query's logic. The `OR 1=1` clause makes the `WHERE` condition always true, and the `--` comments out the rest of the original query. This causes the database to return all rows (e.g., all users), often allowing the attacker to log in as the first user in the table without a valid password.

17. What is the difference between internal and external product metrics? Give an example of each.
    - **Internal Metrics**: Derived from the inherent characteristics of the software's code or design, independent of its execution (e.g., Lines of Code, Cyclomatic Complexity).
    - **External Metrics**: Derived from observing the software in its operational environment (e.g., Failure Rate, Availability, Defect Rate).

18. What is the difference between direct and indirect measurement? Give an example of each.
    - **Direct Measurement**: A quantity derived directly from the entity being measured (e.g., counting the Lines of Code in a program, measuring the duration of a testing phase).
    - **Indirect Measurement**: A quantity derived by combining two or more direct measures (e.g., calculating programmer productivity as `Lines of code / Person-months`, or defect density as `Number of defects / KLOC`).

19. Define Software Reliability and name one metric used to measure it.
    Software reliability is the probability of a system operating without failure for a specified period under defined conditions. Metrics to measure it include Probability of Failure On Demand (POFOD) and Rate of Occurrence of Failures (ROCOF).

20. What does the CIA Triad stand for in information security?
    The CIA Triad stands for:
    - **C**onfidentiality
    - **I**ntegrity
    - **A**vailability

21. What are the five component types counted for the Unadjusted Function Count (UFC) in Function Point Analysis?
    The five components are:
    - Inputs
    - Outputs
    - Logical master files (internal files)
    - Interface files (external files)
    - Queries

22. Why is the metric "Number of defects per KLOC" considered potentially ambiguous?
    It can be interpreted in two ways: a high value could indicate low-quality code with many faults, or it could indicate a high-quality, effective testing process that is good at finding faults. Without context, the metric is unclear.

23. What is "Lead Time" in the context of Kanban process metrics?
    Lead Time is the total time elapsed from when a new work item is requested (added to the backlog) until it is completed and delivered to the customer.

24. What is "Velocity" in the context of Scrum process metrics?
    Velocity is the sum of the estimation units (usually story points) for all the features or user stories that a team successfully completes in a single Sprint. It is used to forecast how much work the team can complete in future sprints.

25. What is the Defect Removal Efficiency (DRE) metric used for?
    DRE is used to measure the effectiveness of the development and testing process at finding defects *before* the software is released. It is typically calculated as `(Defects found before release) / (Total defects found before and after release)`.

26. What are Halstead's "Software Science" metrics based on?
    They are based on counting the number of "operators" (language keywords and symbols) and "operands" (variables, literals, and constants) in the source code.

27. What are two significant problems with using Lines of Code (LOC) as a software metric?
    Any two of the following:
    - **Language Dependency**: It cannot be used to compare projects written in different programming languages.
    - **Ambiguity**: There is no standard definition for what constitutes a "line of code."
    - **Measures Length, Not Functionality**: It is a poor indicator of the actual functionality or complexity of the software.
    - **Discourages Good Practice**: It can penalize concise, efficient code and reward verbose, redundant code.

28. What is the purpose of a linter in software development? Give an example of a popular linter.
    A linter is a static analysis tool that analyzes source code to flag programming errors, bugs, stylistic errors, and suspicious constructs. Its purpose is to improve code quality and enforce coding standards. ESLint (for JavaScript) and Pylint (for Python) are popular examples.

29. What is the goal of End-to-End (E2E) testing? Name one popular E2E testing framework.
    The goal of End-to-End testing is to simulate real user scenarios and test the entire application workflow from start to finish, including the user interface, backend services, and databases. Popular frameworks include Cypress and Selenium.

30. In what industries are specific, rigorous coding standards like MISRA C or DO-178C primarily used, and why?
    They are used in safety-critical industries like automotive (MISRA C), aviation (DO-178C), and medical devices (IEC 62304). These standards are mandated to ensure the highest levels of software safety, reliability, and predictability where failure could result in loss of life or severe damage.

31. Name two types of individuals who should be excluded from a formal code inspection and explain why.
    - **Managers or Supervisors of the author**: Their presence can be intimidating and may prevent an open and honest discussion about defects.
    - **Anyone with a personality clash with the author**: Personal conflicts can derail the objective and constructive nature of the inspection.

32. What are the four classifications of defect severity mentioned in the formal inspection process?
    The four classifications are:
    - **Critical**: Will cause the system to crash or produce incorrect results with no workaround.
    - **Severe**: Will cause incorrect behavior, but a workaround exists.
    - **Moderate**: Affects limited functionality and can be worked around or ignored.
    - **Minor**: Can be overlooked without loss of functionality (e.g., stylistic issues).

33. Besides finding defects, what is one "side benefit" of performing formal inspections?
    Any one of the following:
    - **Cultural**: Fosters a shared "quality culture" and gives team members a broader system perspective.
    - **Organizational**: Reinforces and enforces coding standards and best practices.
    - **Educational**: Helps authors learn from their common mistakes, improving future work.

34. Besides using parameterized queries, name and briefly describe another technique for preventing SQL injection.
    Any one of the following:
    - **Input Escaping**: Sanitize user input by "escaping" special characters (like quotes), so the database treats them as literal parts of a string rather than as special SQL characters.
    - **Strong Typing**: Validate that the user input is of the expected data type (e.g., ensure a user ID is an integer) on the server side, rejecting any input that doesn't conform.
    - **Whitelisting Input**: Define a strict pattern (e.g., using a regular expression) for what is considered valid input and reject anything that does not match.

35. What is an Attack Tree in the context of threat modeling?
    An Attack Tree is a hierarchical diagram that decomposes a high-level security threat (the root) into more specific and concrete sub-goals or attack vectors (the branches and leaves). It helps visualize the different paths an attacker could take to compromise a system.

36. What are the three project types that COCOMO uses to adjust its parameters 'a' and 'b'?
    The three project types are:
    - **Organic**: Small, in-house projects with experienced teams.
    - **Embedded**: Projects with tight constraints, often linked to hardware (e.g., real-time systems).
    - **Semi-detached**: An intermediate project type that falls between organic and embedded in terms of size and complexity.

37. What are the three components of a predictive measurement system?
    A predictive measurement system consists of:
    1.  A **Mathematical Model** that relates input variables to the predicted outcome.
    2.  A **Procedure for Determining the Model Parameters** (i.e., calibration).
    3.  A **Procedure for Interpreting the Results** to understand the confidence in the prediction.

38. What is the purpose of the Technical Complexity Factor (TCF) in Function Point Analysis?
    The Technical Complexity Factor (TCF) is used to adjust the initial function count (UFC) based on 14 technical characteristics of the system, such as performance requirements, reusability, and transaction rates. It acts as a weighting factor to account for the overall technical complexity of the project.

39. What is a "Story Point" in Agile development?
    A Story Point is a relative unit of measure used in Agile to estimate the overall effort required to fully implement a user story. The estimate includes factors like complexity, amount of work, and uncertainty. It is not tied to a specific unit of time (like hours).

40. What is the key difference between a "review," a "walkthrough," and an "inspection" in SQA?
    The key difference is the level of formality.
    - **Review**: Can be very informal.
    - **Walkthrough**: Is semi-formal, typically led by the author to explain the work product.
    - **Inspection**: Is a highly formal, structured, and rigorous peer examination with defined roles, checklists, and data collection, aimed at systematically finding defects.
