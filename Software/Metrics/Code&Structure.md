## Predicting Size Independently of Code

Predictions of effort, cost and time depending on code size have two inherent difficulties:
*   Prediction based on KDSI or KLOC just involves replacing one difficult prediction problem (effort, cost or time) with another one (code size).
*   KDSI and KLOC are actually measures of length, not size (which must take into account functionality).

Code complexity size measures, which would be better, can’t be predicted any more easily than code length. If our size measures are based on the specification of functionality, perhaps we can more accurately estimate size once the specification is known.

## Function Point Analysis

The number of **function points** (Albrecht 1979) is a popular and widely used size metric.
*   Designed to reflect the size of the functionality of a piece of software from the end user’s point of view, independently of the code that implements it.

Computed from detailed system specification (available early in the development cycle) using the equation:
**FP = UFC · TCF**
*   **UFC** is the unadjusted function count, a count of the number of different user visible functions required by the spec.
*   **TCF** is the technical complexity factor, a constant between 0.65 and 1.35, determined by 14 questions about the system.

## Calculating the Unadjusted Function Count (UFC)

The UFC is obtained by summing weighted counts of the number of inputs, outputs, logical master files, interface files and queries visible to the system user, where:
*   An **input** is a user or control data element entering an application.
*   An **output** is a user or control data element leaving an application.
*   A **logical master file** is a data store acted on by the application user (an internal file or database).
*   An **interface file** is a file or input/output data that is used by another application (an external file or database).
*   A **query** is an input-output combination (i.e. an input that results in an immediate output).

## Advantages and Disadvantages of Function Points

FP’s are used extensively as a size metric in preference to KLOC, for example in equations for productivity, defect density and cost / effort prediction.

### Advantages:
*   Language-independent.
*   Can be computed early in a project.F
*   Derived directly from the spec.

### Disadvantages:
*   Unnecessarily complex: evidence is that TCF adds little; effort prediction after adding the TCF is often no better than UFC alone.
*   Difficult to compute, uses a large degree of subjectivity.
*   Some doubt they actually measure functionality.

## Example 1: Spell Checker

### Specification
*   Accepts as 1) input a document file, 2) a dictionary file and 3) an optional user dictionary file.
*   The checker lists/reports all words in the document file not contained in either of the dictionary files.
*   User can query the 1) number of words processed, and 2) number of spelling errors found at any stage in the process.

### Calculation
*   A = #inputs = 3 (document file, dictionary file, user/personal dictionary file)
*   B = #outputs = 3 (# of words processed, #spelling errors, report on misspelled words)
*   C = #internal files (“logical master files”) = 2 (dictionary or internal data structure used)
*   D = #external files (“interface files”) = 1 (external reference used by the spellchecker)
*   E = #queries = 2

Assign complexity weight to each user function -> Calculate UFC:
UFC = 3A + 5B + 6C + 10D + 5E = 6 + 15 + 12 + 10 + 10 = 53

## Example 2: Simple Spellchecker

### 1. Identify components:
*   A = #external input = 1 (user enters text for spellcheck)
*   B = #external outputs = 1 (correction given by spellchecker)
*   C = external enquiry = 1 (user inquire about word definitions)
*   D = #internal files = 1 (internal data structure)
*   E = #external interface files = 1 (external reference)

### 2. Assign complexity weight (let’s say 5 for each)
UFC = 5A + 5B + 5C + 5D + 5E = 25

### 3. Adjust technical complexity factor:
FP = UFC * TCF = 25 x (0.65 + 0.01 x ∑ i=1..14 (Fi))
Assume (0.65 + 0.01 x ∑ i=1..14 (Fi)) = 1 = no adjustment
FP = 25 x 1 = 25 [TCF between .65 to 1.35]

## Source LOC per Function Point

Source LOC per function point is not straightforward, but an estimate is 1 FP = 100-150 SLOC (depends on programming language, code style, code reuse and library, etc.)

| Language | Median | High |
|---|---|---|
| Assembly | 98 | 320 |
| C | 99 | 333 |
| C++ | 53 | 80 |
| C# | 59 | 70 |
| Excel | 191 | 315 |
| HTML | 40 | 48 |
| Java | 53 | 134 |
| JavaScript | 53 | 63 |

## Story Points (used in Agile development)

### Example:
**User story 1:** As a user I want to be able to login using my username and password.
*   **Acceptance Criteria:**
    *   The login screen shall give option to enter username/pwd.
    *   If user input is valid, take the user to home page.
    *   If user not valid, show error.

**User story 2:** ...

### Discuss Story Points:
Team discusses the complexity and effort to implement and compares it to other known user stories, and assigns a relative measure, e.g. 10 story points for the two user stories.