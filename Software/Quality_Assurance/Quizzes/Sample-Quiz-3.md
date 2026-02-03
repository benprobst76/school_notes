1.  What is the difference between a test plan and a test strategy?
	A test strategy defines the overall approach to testing whereas a test plan determines how the test strategy will be carried out.

2.  What is a test oracle and why is it important?
	 The test oracle decides wether an output matches the expected outcome of a test which determines whether the test passes or fails.

3.  Explain the concept of a Requirements Traceability Matrix and what "holes" and "orphans" are in this context.
	A requirements traceability matrix list specific requirements and there corresponding tests. It includes the test status, notes and other info. Holes are requirements with on tests. Orphans are tests with on requirements

4.  What are the three main types of black-box testing methods?
	 Functionality coverage tests, input coverage tests, and output coverage tests

5.  Describe the difference between equivalence partitioning and boundary value analysis (BVA).
	 Equivalence partitioning breaks the inputs into partitions that behave equivalently and test on every partition. BVA tests on the boundary or edge cases of the expected range of values for inputs.   

6.  What is the primary goal of input robustness testing?
	 The goal of input robustness testing is to test whether a program will crash or fail by using unexpected or extreme values as input. 

7.  What is the difference between statement coverage and path coverage in white-box testing?
	 Statement coverage ensures every line in the code runs at least once. Path coverage ensures that every possible path is followed at least once by test cases. 

8.  How is cyclomatic complexity calculated, and what does it represent?
	 V(G) = D + 1 where D is the number of decision statements in the code. It represents the number of independent paths in a code. 

9.  What is mutation testing, and what does it mean for a mutant to be "killed" or to "survive"?
	 Mutation testing is injecting mutants into the code that modify it some way to test if the test cases can catch the change. A killed mutant is caught by a test case while a mutant that survives is not. 

10. What are the four main levels of testing described in the notes?
	 Unit testing, integration testing, system testing and acceptance testing. 

11. What is the key difference between unit testing and integration testing?
	 Unit testing is for testing small individual components while integration testing is for testing how the components interact together. 

12. What are the three types of software maintenance?
	 Corrective maintenance, adaptive maintenance and perfective maintenance. 

13. What is regression testing, and what are the three major components of a regression test suite?
	 Regression testing are tests to ensure the main functionality of the program still works as updates and maintenance is performed. The three major components are functionality tests, failure tests and operational tests. 

14. What is the difference between functional specifications and design specifications?
	 Functional specifications are descriptions of how the system should behave. Design specifications describe the architecture to implement the functional specifications.

15.  In the context of continuous testing, what is a "failure test" and why is it important?
	 A failure test is a test of a component that has failed before and it is important to enure the failure does not happen again.

16. What is an "equivalent mutant" in mutation testing, and why are they significant?
	 Equivalent mutants are mutants that do not change the behaviour of the code and therefore do not need to be detected by tests.

17. What are the three kinds of systematic mutation discussed in the notes?
	 Value mutation, statement mutation and decision mutation.

18. Explain the difference between shotgun robustness testing and BVA (Boundary Value Analysis) robustness testing?
	 Shotgun robustness testing, tests the system with a large number of random, invalid and unexpected inputs. BVA robustness testing, tests the system on the boundary values of each constraint like min, min - 1, max and max + 1.

19.  What are "side effects" in the context of software maintenance, and why are they a concern?
	 Side effects are when other parts of the software break when maintenance or updates are performed. 

20. What is the difference between data value coverage and data flow coverage in white-box testing?
	 Data value coverage ensures that all critical data values are covered whereas data flow coverage ensures that all variable definitions are used and all variable usages are defined. 