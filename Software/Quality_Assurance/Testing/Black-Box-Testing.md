The structure, design and implementation not know to the tester. Focus is on inputs & outputs  
Types of black box testing:  
- Functional testing  
- System testing  
- Acceptance testing  
- Usability testing
## Black Box Methods
Methods are chosen based on the requirements, specification or sometimes design documents. In black box the tester does not have knowledge of the internal code so testing is performed based on the systems externally observable behaviors and inputs. This can be an advantage, to create test cases independently and parallelly to the development of the software. 
### Functional Specifications
There are formal (mathematical) specifications and there are informal (natural language) specifications. Functional specifications need to provide at least three kinds of information:
- the corresponding intended actions
- the intended inputs
- the corresponding intended outputs
### Three kinds of Black Box Methods
[[#Functionality Coverage Tests]], [[#Input Coverage Tests]] and [[#Output Coverage Tests]]
#### Functionality Coverage Tests
Verify that a function, feature or system does what its supposed to do form the users perspective without knowing how its implemented. 
#### Input Coverage Tests
An analysis of the intended inputs
#### Output Coverage Tests
An analysis of the intended outputs
## Systematic Functionality Testing
Systematically derive test cases from requirements using techniques equivalence partitioning, boundary value analysis, decision tables, and state transition testing. 
### Requirements Partitioning
Requirements partitioning conceptually resembles equivalence partitioning. Our first step is to physically partition the functional specification into separate requirements. In this system we model the separate requirements as independent even though they are not. 
**Example**
	"Given as input two integers x and y, output all the numbers smaller than or equal to x that are evenly divisible by y. If either x or y is zero, then output zero."
	1. Accept two integers as input
	2. Output zero or more integers
	3. All numbers output must be less than or equal to the first input number
	4. All numbers output must be evenly divisible by the second number
	5. Output must contain all numbers that meet both 3 and 4
	6. Output must be zero only in the case where either first or second input integer is zero
## Input Coverage
Inputs are all the possibilities allowed by the functional specifications (All, not limited to function argument, e.g. reading from DB)
To ensure the system handles a wide range of input including edge cases and invalid inputs we implement **Input Coverage Testing**. Which is done to cover unexpected behavior of the system like when the system receives inputs outside the expected range. This shows the software correctly handles all allowed inputs. There are four types:
### Exhaustive Testing
Test all inputs, meaning every possible input to the program. This is strong be generally impractical for complex systems due to numerous combinations.
**Example**
	"Given as input two integers x and y, output all the numbers smaller than or equal to x that are evenly divisible by y. If either x or y is zero, then output zero."
	Assuming each integer has 32 bits there will be 16,000,000,000,000,000,000 pairs to test
### Input Partition Testing
Identify input variables and constraints and derive valid and invalid classes. Then pick one representative per class or more. This reduces the number of test cases. Ensure you cover all categories of input (valid vs invalid). Choose the simplest input values and vary them as little as possible. It is a systematic approach giving a structured test design method. 
- Analyzes all the possible inputs in certain ways
- At least handles one example of each different kind of input correctly
- Creates test case based on the analysis
- Defines stopping criteria
**Example**
	"Age must be between 18 and 65 (inclusive) to register.“
	Partitions:
	- EP1 : age < 18 (Invalid)
	- EP2 : 18 ≤ age ≤ 65 (Valid)
	- EP3 : age > 65 (Invalid)
	Pick representative cases:
	- From EP1: age = 15
	- From EP2: age = 40
	- From EP3: age = 75
### Shotgun Testing
Black box shotgun testing consists of choosing random input values and repeat for a large number of times. Then verify outputs and observe crashes  
- Practically, legal set and illegal set as separate sets of shotgun tests
- Not a systematic approach becasue you can test in many ways, there is no stopping criteria and does not have specific criteria
- Requires a very large number of test cases
### Input Partition + Shotgun Testing
A hybrid method where you first do input partitioning and then use the shotgun method to choose random input within each partition. It gives additional confidence by covering simple input values and random values. Can be hard to maintain coverage.
### Input Robustness Testing
Robustness is the property that a program doesn't crash or halt unexpectedly, no matter of what input. To test whether the system is robust against unusual, extreme, or invalid input. There are two types [[#Shotgun Robustness Testing]] and [[#BVA Robustness Testing]].
Input Values Include:  
- Empty input (e.g., blank username).  
- Null, whitespace, or missing values.  
- Inputs of extreme size (e.g., 0-length string, 1,000 character string).  
- Special characters, Unicode, emojis, SQL injection attempts.  
- Out-of-range numbers, negative numbers, NaN, infinity.
### Shotgun Robustness Testing  
Testing the system with a large number of random, invalid, or unexpected inputs.
Which is often important in:  
- Security-sensitive systems  
- User input forms (prevent injection attacks)  
- Not a systematic approach
### BVA
Boundary Values (BVA) is a systematic test method, an easy way to choose test cases and an easy way to know when you are done. The stopping criteria is that all boundaries are tested. Typical failures come at the boundaries of the expected range of values.
Example (exercise): reverse a linked list!  
- An empty linked list?  
- A linked list with a single node?  
- A linked list with a large number of nodes?  
- A circular linked list?  
- Linked lists with special data values?
For each constraint, test min, min−1, max, max+1  
- Clarify inclusivity: \[a..b\] vs (a..b)  
- Boundaries apply to size, count, dates, lexicographic ranges (e.g. "1" → "9")  
- BVA ensures you test the edges of the input categories, where mistakes usually happen.
### Choosing Inputs
- Isolate failure causes by as much as possible
- Use the simplest input values possible
- Keep everything constant between test cases, varying only one input value at a time. (Don't try to introduce random variations)
- Use these principles when choosing inputs for all systematic test methods
## Output Coverage
Need to cover all the possible outputs specified in the functional specification. Focus on verifying the correctness and completeness of the outputs produced by a system. Ensure that every possible program output is exercised at least once. While input coverage makes sure that all input classes are tested it may miss some unseen outputs. Output coverage will detect missing or wrong outputs. 
- same output mat be obtained due to many inputs
- So only testing inputs may lead to unproduced output
- Good for any software where outputs partition the behavior
### Exhaustive Approach
Testing them all.
**Example**
	"Output 1 if two input integers are equal, 0 otherwise"
	- Only two test cases 
- More practical than input exhaustive testing but still impractical in general
### Equivalence Partitioning 
Divide the input domain into classes (partitions) where the system is expected to behave equivalently (produce the same kind of output/result).  Ensure every category of expected system response is tested. 
**Example**
	"Users must be between 18 and 65 years old."
	- EP1: (Invalid): Age <18 (Output: Error message 'Too young’)  
	- EP2: (Valid): Age 18−65 (Output: Success/Proceed)  
	- EP3: (Invalid): Age >65 (Output: Error message 'Too old’)
### BVA
Test cases are designed based on the boundaries of the equivalence partitions. 
**Example**
	Age Verification (18-65)  
	- Boundary: lower(18), upper (65)
### Decision Table
A Decision Table maps every combination of input conditions to its resulting action (output)
**Example**
	"A customer gets a discount if they have a Coupon AND their purchase Total is ≥$100 OR if they are a Loyalty Member."
	Conditions:  
	- C1: Has Coupon? (Y/N)  
	- C2: Total ≥$100? (Y/N)  
	- C3: Loyalty Member? (Y/N)  
	Action (output)  
	- A1: Apply 10% Discount? (Y/N)  
	- A2: Apply 20% Discount? (Y/N)  
	- A3: No Discount (Output: 'Full Price')
### State Transition
To ensure that the system's output (its new State) is correct based on a sequence of events. Models the system as a finite state machine: State → Event → Action/Output → New State. State Coverage and transition coverage 
**Example**
	User Login/Account  
	- S1: Logged Out  
	- S2: Logged In  
	- S3: Account Locked  
	Transition and output:  
	- T1: (S1) -- Valid Credentials→ (S2), Output: Welcome Dashboard  
	- T2: (S1) --Invalid Password (x5)→(S3), Output: Error:  
	Account Locked  
	- T3: (S2) --Logout Clicked → (S1), Output: Logged Out Page  
	- T4: (S3) --Valid Credentials→(S3), Output: Error: Still Locked
## Summary
- Black box methods include input coverage, output coverage, functionality coverage  
- Functionality coverage partitions the functional  specification into separate requirements to test 
- keep test input values simple, and varying one input value at a time
- Input coverage methods analyze the set of possible inputs specified and create tests to cover  them  
- Exhaustive testing is usually impractical, but we can approximate it using input partitioning  
- Shotgun testing can be added to input partitioning to give additional confidence  
- Robustness testing checks for crashes on unexpected or unusual input, such as the boundaries of the input range