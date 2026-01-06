 A software testing technique that focuses on the internal structure, logic, and coding of an application. Testers have full knowledge of code and can see/control execution path. It is used to verify that logic, paths, and flow of data are working as expected. Compared to [[Black-Box-Testing]] there is a difference in the knowledge required, who performs the test, testing basis and focus. 

| Benefits                                 | Limitations                                |
| ---------------------------------------- | ------------------------------------------ |
| Completeness for black box testing  <br> | Time consuming                             |
| Early defect detection                   | Good programming knowledge is required     |
| Code optimization                        | Cannot easily detect missing functionality |
| Thorough testing                         |                                            |
| Security vulnerability detection         |                                            |
The types of White Box testing includes [[Levels-of-Testing#Unit]], [[Levels-of-Testing#Integration]], [[#Mutation Testing]], [[#Security Testing]], and [[#Static Analysis]]
Testing the APIs between components in a white-box approach means knowing the internal data formats, error codes, and business logic to craft precise test data. 
White box testing techniques:  
statement → branch → condition → loop → path → data  
Data coverage testing : 
- To ensures all program’s data elements (variables, parameters, and data structures) are properly defined, used, and maintained throughout the code  
- Focus on internal handling of data
### Statement Coverage
Ensures that every executable line of source code is executed at least once  
- System: Make a test case for each statement in the program, independent of the others  
- Completion criterion: A test case for every  statement
**Metrics:** Statement coverage (%) = (Executed statements ÷ Total statements) × 100
#### Example
![[Pasted image 20251020085651.png]]
**Limitations:** Statement coverage would not test all logical paths e.g. what if the condition at line 10 is false? Branch coverage would catch all the logical paths.
### Basic Block Coverage
Cause every basic block (every sequence of consecutive statements) to be executed at least once which usually generates fewer tests. 
- System: Identify basic blocks by code analysis, design tests cases for each block
- Completion Criterion: A test case for every basic block
We make one test for each block, analyzing which inputs are needed to cause the block to be entered. Create test case for each unique set of inputs. ![[Pasted image 20251031084637.png]]
### Path Coverage  
Control flow testing to ensure all possible execution paths in source code is tested at least once. Focuses on internal structure of the code.
#### Control Flow Graphs 
A visual model of program logic where nodes are statements (a sequential block of code with no internal branches) and edges are branches (transfer control from one statement to another). The flow graph shows program control flow between basic blocks (nodes).
![[Pasted image 20251020094113.png]]
**Execution Path:** a sequence of executed statements starting at the entry to a unit and ending at the exit from the unit.
**Independent Path:** Two paths are independent if one of them introduces at least one new edge (control flow connection) that is not included in any other path
**Cyclomatic Complexity (CC):**  a measure to obtain the number of independent paths through a program’s source code
#### Path Analysis
![[Pasted image 20251020094429.png]]
![[Pasted image 20251020094442.png]]
The easiest way to find this set is to work from top to bottom, left to right to create paths. This program has only five independent paths (CC = 5)
- P1: 1, 2, 12  
- P2: 1, 2, 3, 5, 6, 7, 11, 2, 3, 4, 12  
- P3: 1, 2, 3, 5, 6, 8, 9, 11, 2, 3, 4, 12  
- P4: 1, 2, 3, 5, 6, 8, 10, 11, 2, 3, 4, 12  
- P5: 1, 2, 3, 4, 12
#### Path Coverage Testing 
**System:** Make one test case for each independent path analyzing which inputs are needed to exercise the path.
**Completion Criterion:** A test for each path

| Advantages                                      | Disadvanatages                                         |
| ----------------------------------------------- | ------------------------------------------------------ |
| Good for finding logical and structural defects | Exponential number of paths                            |
| Validates all control paths                     | Impractical for complex programs due to path explosion |
### Cyclomatic Complexity
McCabe’s definition based on graph:$$ V(G)=E−N+2P $$
- E: number of edges (transition between nodes)  
- N: number of nodes  
- P: number of connected components, default is 1 per function
![[Pasted image 20251020095804.png]]
Decision count approach: $$ V(G) = D + 1 $$
if, while, for, case, catch, &&, ||, etc.
In the above code there is one if therefore:
$$ V(G) = 1 + 1 = 2$$
![[Pasted image 20251020100429.png]]
### Data Coverage 
Data coverage methods explicitly try to cover the data aspects of the program code, rather than the control aspects
- Data value coverage
- Data flow coverage
- Data interface coverage
**System:** Identify critical variables, analyze code to find the different values or sets of values each can take on, partition and design tests to cover.
**Completion criterion:** Test for each value partition
#### Data Value Coverage
To make sure all significant or critical data values:
if (age >= 18 && age <= 65)  
	eligible = true;  
Test age = 17, 18, 65, 66 (valid and invalid data range)
#### Data Flow Coverage 
Focuses on how data moves inside the program and tracks:
- All definitions; every variable definition is covered by at least one use  
- All uses: every definition and use pair is covered  
E.g.  
```
x = 5; // variable defined  
y = x + 1; // variable is used
```
#### Data Interface Coverage
verifies how data is transferred between program  units, such as functions, classes, or APIs. It checks:  
- Parameter passing  
- Return values  
- Shared variable  
- API input/output  
E.g.  
```
int add(int a, int b) { return a + b; }  
int main() {  
  int sum = add(2, 3);  
}
```
### Mutation Testing
 Mutation testing is to deliberately inject minor artificial flaws (mutations) into the source code to check whether the existing test suite have the capability to detect and flag these mutations.
 Mutation testing is a white box method for checking:  
- The adequacy of a test suite  
- The quality/effectiveness of test suite  
An effective test suite should kill the mutant (fail on minor code changes)  
#### Terminology
**Mutant:** A minor variation (syntactic change) of the original program
**Mutator:** The rule or operator used to create a mutant, e.g. Change a + operator to -
**Killed Mutant:** A mutant that is detected by at least one failed test case (good thing)
**Survived Mutant:** Tests didn't detect any difference (bad thing)
**Equivalent Mutant:** When the behavior of the code does not change by the mutant, e.g. changing `a==b` to `b==a`. Therefore they don't need to be killed.
**Mutation Score:** A metric used in mutation testing to measure how effective a test suite is at detecting mutants in the program
$$Mutation Score = \frac{Killed\space Mutants}{Total\space Mutants-Equivalent\space Mutants} \times 100\%$$
#### Process of Mutation Testing
1. Execute the existing test suite against the original software and save the results to compare  
2. Use a mutation testing tool to automatically create many single-change versions of the code (mutants)  
3. Run the entire test suite against each mutant and compare the results to the saved results from the original.  
	- If the test suite fails for a mutant, the mutant is killed
	- If the test suite passes for a mutant, the mutant has survived and a new test must be added to the suite to kill that mutant  
#### Systematic Mutation
For mutation testing to be systematic there must be a **system** for creating mutants and a **completion criterion** for knowing when you have enough mutants.
##### Kinds of Systematic Mutation
- Value mutations (changing constants, subscripts, or parameters by adding or subtracting one, etc.)
	- **System**: Mutate the value of each constant (or more generally, each integer expression) in the program by adding or subtracting a value or modifying some other way.
	- **Completion Criterion:** One mutant for each constant in the program
	![[Pasted image 20251030083131.png]]
- Decision mutations (inverting or otherwise modifying the sense of each decision condition in the program) 
	- **System:** Invert the sense of each decision condition in the program (e.g., change > to < (or <=), == to !=, and so on)
	- **Completion criterion:** One mutant for each decision condition in the program
	![[Pasted image 20251030083359.png]]
- Statement mutation (deleting or exchanging individual statements in the program)  
	- **System:** Delete, interchange, reorder or double each statement in the program
	- **Completion criterion:** One mutant for each statement
	![[Pasted image 20251030083827.png]]
**Others:**
- Changing if (a > b) to if (a < b): relational operator mutations  
- Changing if (a && b) to if (a || b): logical operator mutation  
- Changing if (a <= 10) to if (a < 10): boundary condition mutation  
- Changing (int result = a + b) to (int result = a + c): variable replacement mutation  
- Changing calculate(a, b) to calculate(b, a) – method call  mutation  
- So on  
#### Summary
- Mutation testing is a white box method for automatically checking test suites for completeness
- Mutations are simple, syntactic variants of programs that can be generated automatically  
- Typical mutations are value mutations, decision mutations, statement mutations  
- Mutation can find missing test cases in a test suite  
- Statement coverage is a strong testing system, usually “kills” most kinds of mutants  
**Advantages:**
- Provides a good check for quality of a test suite, not just coverage
- Forces stronger test design
**Disadvantages:** 
- Computationally expensive with many mutants
- Detecting mutant equivalence is a big problem