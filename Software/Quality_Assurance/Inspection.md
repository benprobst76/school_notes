# Software Inspections and Reviews

## First Law of Software Development

*   **Earlier is Cheaper**: The later in the development cycle a fault is detected, the more expensive it is to fix. This principle highlights the importance of early defect detection. Methods that find faults earlier in the development lifecycle deliver greater value and cost savings.

## Reviews, Walkthroughs, and Inspections

### Terminology

While there isn't a universal agreement on precise definitions, these terms generally refer to different levels of formality and involvement in examining software work products.

### Reviews

A process of examining software work products (e.g., requirements, design, code, test plans, documentation, etc.). Reviews can range from informal peer checks to highly formal, structured meetings.

*   **Purpose**: To find defects, discuss potential improvements, share knowledge among team members, and provide confidence in the quality of the work product.
*   **Conducted by**: Typically done by the author of the work product or a peer.
*   **Attendance**: Can be attended by management and customers, depending on the formality and scope of the review.

### Walkthroughs

A semi-formal review technique, normally carried out by developers.

*   **Process**: Involves a step-by-step explanation of the logic, design, or code by the author. The goal is to gather feedback, suggestions, or defect reports by involving the whole team in quality assurance at each stage of development.
*   **Focus**: Primarily on a critical analysis of the artifacts being presented, aiming for a deeper understanding and identifying potential issues.

### Inspections

Refers to a completely formal and structured process of review, also known as Formal Technical Reviews (FTRs).

*   **Purpose**: Used to identify defects systematically, improve overall software quality, prevent future defects, reduce the cost of rework by catching issues early, and verify compliance with standards and specifications.
*   **Characteristics**: Involves formal written reports, systematic defect data collection and analysis, adherence to required standards, and predefined measures. There is a strong emphasis on documenting process progress and defects found.
*   **Origin**: First introduced by Michael Fagan at IBM around 1976. This method is now required by some customers, such as the U.S. military, due to its proven effectiveness.

### Inspections in the Software Process
![[Pasted image 20251130110647.png]]

### IEEE Definition of Inspection

*   "... a formal evaluation technique in which software requirements, design, or code are examined in detail by a person or group other than the author to detect faults, violations of development standards, and other problems..."

### IEEE Objective of Inspection

*   "... to detect and identify software element defects. This is a rigorous, formal peer examination..."

### Key Aspects of Inspection

Inspections serve several critical functions:

*   Verifies that the software elements satisfy their specified requirements and functionalities.
*   Verifies that the software elements conform to all applicable standards (e.g., coding standards, design guidelines).
*   Identifies deviations from established standards and specifications.
*   Collects valuable software engineering data, such as defect types, their severity, and the effort required for detection and resolution. This data can be used for process improvement.
*   It's important to note that inspections typically **do not** examine alternatives in design choices or stylistic issues unless they directly violate standards or specifications.

### The Formal Nature of Inspection

Despite the widespread recognition of inspections, studies have shown that many organizations claim to perform them but do not adhere strictly to the formal process. One study found that 84% of surveyed organizations performed reviews or inspections, but **0% performed inspections entirely correctly**.

*   **Effectiveness**: Even a walkthrough or a less rigorously executed inspection can be effective at improving software quality. The act of having others examine the work product often reveals issues.
*   **Beyond Correction**: Inspection is not solely about defect correction; it is crucially about **defect prevention**. By identifying common errors and patterns, teams can learn to avoid introducing similar defects in future work.

## Fagan Inspections (e.g., for Code)
![[Pasted image 20251130110806.png]]

### Inspection Roles (Fagan, Code Inspection)

A Fagan inspection typically involves specific roles to ensure a structured and effective process:

*   **Moderator**:
    *   Chairs the meeting and is responsible for recording all faults found.
    *   Helps other inspectors adhere to the proper pace and focus on paraphrasing code, not rewriting it.
    *   Ensures the proceeding remains objective, professional, and friendly, fostering a constructive environment.
*   **Inspectors (2 or 3)**:
    *   Knowledgeable peers who critically examine the code, often line by line, paraphrasing its intent.
    *   Must have attended an overview meeting and reviewed relevant requirements and design documents to understand the context of the code being inspected.
*   **Author**:
    *   The creator of the document or code being inspected.
    *   Acts as a silent observer during the inspection meeting, assisting or clarifying only when specifically asked by the moderator or inspectors.

### Good Choices for Inspectors

Selecting the right people for inspection roles is crucial for success:

*   **Review specialists (e.g., QA analysts)**: Professionals with expertise in quality assurance and defect detection.
*   **Technical people from the same team as the author**: Possess domain knowledge and understand the project context.
*   **Technical people with special expertise**: Individuals knowledgeable in the specific subject matter or technologies used in the code.
*   **People with a special interest in the product**: Stakeholders who have a vested interest in the quality and success of the software.
*   **People from other parts of the organization or outside it**: Can offer fresh perspectives and identify issues that internal team members might overlook.

### Bad Choices (Exclude!)

Certain individuals should be excluded from inspection roles to maintain objectivity and a productive atmosphere:

*   **Managers, supervisors, or appraisers of the author**: Their presence can create an intimidating environment, making the author or other inspectors hesitant to point out flaws.
*   **Anyone with a personality clash with the author or other reviewers**: Personal conflicts can derail the constructive nature of the inspection.
*   **All management**: While management support is essential, their direct involvement in the inspection meeting can inhibit open discussion.
*   **Anyone with a conflict of interest**: Individuals whose personal or professional interests might bias their judgment during the inspection.

### Side Benefits of Inspection

Beyond defect detection, inspections offer several valuable side benefits:

*   **Cultural**:
    *   Team members gain a broader perspective on the entire software system as they review each other’s work, fostering a holistic understanding.
    *   Promotes a shared "quality culture" within the team, encouraging joint responsibility for the quality of the software.
*   **Organizational**:
    *   Coding standards and best practices are learned, reinforced, and enforced across the team.
    *   Consistency in code style, design patterns, and documentation improves significantly.
*   **Educational**:
    *   Overall software quality improves over time as authors become more aware of the kinds of faults they are prone to make, leading to personal growth and fewer defects in future work.

## Inspection At Any Stage

Inspections are a versatile technique that can be applied effectively at various stages of the software development lifecycle to catch problems as early as they appear:

*   **Requirements**: Inspecting requirements specifications to ensure clarity, completeness, and consistency.
*   **Design**: Reviewing architectural and detailed design documents to identify flaws before implementation.
*   **Coding**: The most common application, inspecting source code for defects, adherence to standards, and logical errors.
*   **Testing**: Inspecting test plans, test cases, and test scripts to ensure adequate coverage and correctness.
*   **Acceptance**: Reviewing user acceptance criteria and processes.

Regardless of the stage at which inspection is applied, the underlying process remains largely consistent.

## A Generic Inspection Process

The basic process of formal inspection follows a structured methodology, adaptable to any artifact being inspected:

1.  **Planning**:
    *   **Objectives**: Gather all necessary review materials (the artifact, reference documents, inspection checklists, data sheets), form the inspection team, and schedule the inspection meetings.
    *   **Procedure**: The Moderator assembles the team and review package, customizes the checklist to the specific artifact, plans the schedule, verifies the artifact is ready for review, and helps the Author prepare an overview.

2.  **Orientation**:
    *   **Objectives**: The Author provides an overview of the artifact to the inspection team. Inspectors receive the review package, preparation goals are set, and inspectors commit to actively participating.
    *   **Procedure**: The Moderator distributes the review package, the Author presents an overview of the artifact, and the Moderator outlines the preparation procedure.

3.  **Preparation**:
    *   **Objectives**: For each inspector, the primary goal is to find the maximum number of non-minor defects in the artifact independently.
    *   **Procedure (for Inspectors only)**: Inspectors allocate scheduled time for individual review, perform a detailed inspection of the artifact using checklists as a guide, and refer to reference materials for context. They note critical, severe, and moderate defects on a reviewer report form and minor defects/questions for clarification on the artifact document itself.

    #### Example Defect Classification

    Defects are typically classified by their severity to prioritize resolution:

    *   **Critical**: Defects that will cause the system to hang, crash, produce incorrect results or behavior, and have no known workarounds. These are top priority.
    *   **Severe**: Defects that will cause incorrect results or behavior but have known workarounds. While serious, they are less immediately catastrophic than critical defects.
    *   **Moderate**: Defects that affect limited areas of functionality and can either be worked around or potentially ignored without significant impact.
    *   **Minor**: Defects that can be overlooked without loss of functionality, often related to style, comments, or minor inconsistencies.

    #### Example Checklists and References

    *   **Checklists**: These often include questions concerning the completeness, style, and adherence to company standards. Code inspection checklists frequently include detailed questions about language-specific features (e.g., prohibition of `goto` statements), naming conventions for variables, methods, and classes, and complexity metrics like depth of nesting.
    *   **References**: May include company-specific standards documents, high-quality examples of similar artifacts, relevant chapters from textbooks on quality practices, and online resources.

4.  **Review Meeting**:
    *   **Objectives**: To create a consolidated and comprehensive list of all non-minor defects identified, leverage group synergy for deeper insights, and ensure shared knowledge of the artifacts among the team.
    *   **Procedure**: The Moderator requests defects sequentially, often in order of importance or by walking through the artifact. Inspectors point out defects they found, comparing notes. The Moderator (or a designated note-taker) records a consolidated list of found defects and summarizes the meeting's results in a review summary defect report.

5.  **Rework**:
    *   **Objectives**: The Author assesses each defect listed in the review defect report, determines if it is truly a defect, and then repairs it as necessary. This stage also involves producing a written report on how each non-minor defect was handled and resolving minor issues appropriately.
    *   **Procedure (for Author)**: The Author receives the review defect summary report and marked-up copies of the inspected artifact. They assess each defect, categorize its root cause, and document the actions taken in an author action report. Once finished, the Author provides this report and the reworked artifact to the Moderator for verification.

6.  **Verify**:
    *   **Objectives**: To assess the quality of the reworked artifact and evaluate the effectiveness of the inspection process itself. The artifact is either passed or failed at this stage.
    *   **Procedure (for Moderator)**: The Moderator obtains the reworked artifact and the author action report. They review both for any remaining problems or new issues. Based on this, the Moderator provides a recommendation (pass/fail) for the artifact. With the inspectors, they sign off on the artifact. Finally, the Moderator computes summary statistics for the inspection, archives all review documents in a quality database, and generates process improvement proposals if any issues in the inspection process were identified.

## Code Inspection Practices

When the artifact being inspected is actual code, specific practices can enhance the effectiveness of the inspection:

### Checklists

Code checklists provide a concrete, structured list of properties to check for within the code.

*   **Scope**: Checklists can cover general programming properties applicable to any program or specific properties tailored to a particular program, language, or project.
*   **Content**: They include both desired properties (characteristics the code *should* have, like clear variable names) and undesired properties (characteristics the code *should not* have, like excessive nesting).
*   **Application**: Inspectors methodically go through the code, checking for the presence or absence of each property and marking it off the list.
*   **Limitations**: Checklists are only one component of inspection; the fundamental correctness of the code's logic must also be verified.

#### An Example: Generic Java Code Inspection Checklist

1.  **Variable and Constant Declaration Defects**:
    *   1.1 Are descriptive variable and constant names used in accordance with naming conventions?
    *   1.2 Are there variables with confusingly similar names (e.g., `user` and `usr`)?
    *   1.3 Is every variable properly initialized before use?
    *   1.4 Can any non-local variables be made local to reduce scope and potential side effects?
    *   1.5 Are there literal constants (magic numbers/strings) that should be defined as named constants for clarity and maintainability?
    *   1.6 Are there variables whose values should not change after initialization, meaning they should be constants?
2.  **Method Definition Defects**:
    *   2.1 Are descriptive method names used in accordance with naming conventions?
    *   2.2 Is every parameter value checked for validity (e.g., null checks, range checks) before being used within the method?
    *   2.3 Does every method return a correct value at every possible return point, considering all execution paths?
3.  **Computation Defects**:
    *   4.1 Is underflow or overflow possible in any computation, especially with integer or floating-point arithmetic?
    *   4.2 Does any expression depend on the order of evaluation of operators? Are parentheses used to explicitly avoid ambiguity and ensure intended evaluation order?
4.  **Control Flow Defects**:
    *   6.1 Will all loops terminate in all cases, preventing infinite loops?

#### Google Python Style Rules (partial example)

Specific style guides also serve as a form of checklist, ensuring consistency and readability:

*   **Semicolons**: Do not terminate your lines with semicolons, and do not use semicolons to put two commands on the same line.
*   **Line length**: Maximum line length is 80 characters to enhance readability, especially on smaller screens or when diffing code.
*   **Parentheses**: Use parentheses sparingly, relying on operator precedence where clear, but use them for clarity when ambiguity might arise.
*   **Indentation**: Indent your code blocks consistently with 4 spaces.
*   **Blank Lines**: Use two blank lines between top-level definitions (functions, classes) and one blank line between method definitions within a class for visual separation.
*   **Strings**: Use the `%` operator for formatting strings (e.g., `"%s %d" % (name, age)`), even when all parameters are strings. Use your best judgment to decide between `+` and `%` for concatenation versus formatting.

### Reading the Code in English (Paraphrasing)

Code paraphrasing is a core method described by Fagan for use in code inspections.

*   **Process**: Consists of a designated "reader" (an inspector) articulating the meaning of the lines of code in terms of the *problem domain* or *business logic*, rather than simply reciting the programming language syntax. The reader restates the logic of the code in their own words, focusing on *what* the code achieves rather than *how* it's implemented.
*   **Focus**: Paraphrasing should intentionally avoid mentioning specific variable names or control flow constructs. Instead, it should be phrased in terms of the abstract meaning of the concepts and processes being implemented.
*   **Discussion**: The paraphrasing process often seeds discussion, especially when scenarios or potential real-world situations are introduced, prompting inspectors to consider edge cases or alternative interpretations.
*   **Combination with Checklists**: Paraphrasing is frequently coupled with checklists. Checklists address the low-level properties and adherence to standards of the code itself, while paraphrasing ensures that the high-level meaning and intent of the code are correct and clearly understood.

#### Example Code Paraphrasing:

Consider the following code snippet:

```java
if (balance < 0) {
    applyPenalty();
} else if (balance == 0) {
    sendReminder();
} else {
    allowTransaction();
}
```

A paraphrased explanation would be:

"If the customer's account balance is negative, a penalty is applied. If the balance is exactly zero, a reminder is sent to the customer. Otherwise, if the balance is positive, transactions are allowed to proceed normally."

This explanation focuses on the business logic and user-perceived outcome, abstracting away the specific `if-else` structure and method calls.
