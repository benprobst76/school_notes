Testing is the process of executing software in a controlled manner:
- Check whether it behaves as specified
- Identify errors, gaps or missing requirements
- Ensure it behaves as expected
Testing is not just a onetime task; it is a continuous process that lasts throughout the software life cycle. Effective testing requires careful engineering, similar and parallel to the process for design and implementation of the software itself. An overall test strategy drives test plans, test case  
design, and test procedures for a project
## Systematic Testing
An approach where testing is planned, technique driven, traceable to requirements, risk prioritized, repeatable and auditable. It should
- Follow defined strategies, techniques and levels: [[Levels-of-Testing#Unit]] 
- Adopt test design methods: [[Black-Box-Testing]]
	- Includes test case and test data preparation
	- Consider equivalence classes, boundaries and coverage 
- Execute the tests and document the results
- Evaluate the results against measurable criteria
	- Coverage, defect rates etc.
	- Includes stopping/exit criteria (e.g. 90% coverage reached)
A system working on one machine is not evidence it will work on all. Defects can hide at edge cases and stakeholders need auditable and traceable coverage. 
#### Testing in the Life Cycle
Testing done through software life cycle  
	![[Pasted image 20251030102623.png]]
- Requirement analysis (create test case to check requirements are clear, complete, achievable, and testable)  
- Design (test plan and strategy aligned with design architecture and test coverage)  
- Implementation/Development of code (unit testing, Static analysis)  
- Testing/validation:  
	- The integration (integration testing)  
	- The system (system testing)  
	-  Acceptance testing  
- Maintenance of software (regression and performance testing)
### Test Design
Applies to all tests and is a difficult engineering problem. Broken into a set of stages; high level test-> detailed test procedures
#### Test Strategy
The overall approach to testing. Levels of testing, type, techniques, tools and standards. The overall static quality plan by the project manager driven by the business
#### Tests Plans
How the test strategy will be carried out. Lead by test lead or test manager. Project-wide or procedure-wise
- the items to be tested  
- the level they will be tested at  
- the order they will be tested in  
- the test environment  
- the test coverage
#### Test Case Design
A set of test cases for each item to be tested at each level. Each test case specifies:
- how the implementation is to be tested
- how we will know if the test is successful
- input -> actions/events -> expected response
- positive testing, negative testing, separately by level: unit, integration, system and acceptance
#### Test Procedures
The process for conducting test cases. For each level:
- the process for running and evaluating the test cases (test harnesses run part of the system)
- test scripts
- testing tools/frameworks (GitHub Actions)
#### Test Reports
Documenting the test results by output of test execution to a results file and then summarized in a readable report. Should be concise, easy to read and clearly points out failures. Of a standardized form 
### Evidence
Evidence over anecdotes: Versioned test results, CI links, logs, screenshots, coverage and mutation reports, defect tickets linked to tests. 
### Traceability 
Every requirement has more than 1 test and recorded result. Find the requirement holes and test orphans. Link risk and evidence artifacts in [[#Requirements Traceability Matrix]]
**Holes**: Requirements with not tests
**Orphans**: Tests not linked to any requirement
#### Requirements Traceability Matrix 
![[Pasted image 20251019101250.png]]
#### Risk-Based Testing
![[Pasted image 20251019101617.png]]
### Entry Criteria
Code builds; env & data ready; [[#Test Oracle]] defined (assert)
### Exit Criteria
- Coverage goals → e.g., 90% branch or functional coverage  
- Defect-related → critical defects fixed, defect rate falls below threshold  
- Requirement-based → all planned test cases executed and passed  
- Time or budget limit → testing stops when resources are exhausted  
- Risk acceptance → remaining defects are low-risk  and acceptable
### Test Oracle
The oracle decides pass or fail for a test. Its the mechanism that defines the expected outcome for the given units. Without the oracle we cant judge the correctness of an outcome. Every automated test in as oracle. 
### Debugging
Debugging is not testing, it supports testing but cannot replace it. Debugging analyzes and locates bugs when something is wrong. Testing methodically searches for and exposes bugs.

## Levels of Specification
There are three levels; [[#Functional Specifications]], [[#Design Specifications]], and [[#Detailed Design Specifications]].
### Functional Specifications
- Precise description of the required behavior of the system
- What the software should do, not how it should do  it  
- Click "Exit" -> "Save" dialog if "has not been saved" -> otherwise "exit"
### Design Specifications
- Describe the architecture of the design to implement the functional specification  
- Describe the components of the software and how they relate to one another
#### Class Diagram
![[Pasted image 20251019103035.png]]
### Detailed Design Specifications
How to code
- Component of the architecture  
- Individual code units  
- Data Structure?  
- Data Storage?  
- Algorithms?  
- Input and expected outputs?  
- Invalid inputs?
### Test Evolution 
Tests don't die. Testing does not end when the software is accepted by the customer. Tests are repeated, modified and extended; continuously monitoring the failed parts when adding new features. Maintaining the test is how you control quality. 