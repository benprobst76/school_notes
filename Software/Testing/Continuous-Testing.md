Maintenance is the phase of development in which the software is in production day to day by real users. For successful software, this is almost all of its lifetime, and the software evolves in response  
to observed failures and new requirements. Usual estimate is that up to 85% of the total software effort is in maintenance. There are three kinds of maintenance; **corrective**, **adaptive**, and **perfective**
#### Corrective Maintenance 
Concerned with fixing reported failures (errors) observed in the software. The process of receiving reports of such errors, diagnosing the problem, and fixing it is called "corrective maintenance". 
Three varieties:  
- Coding errors: typically, easy and inexpensive to correct since they are confined within one unit 
- Design errors: more expensive since they may involve changes to several units  
- Requirements errors: most expensive since they often involve extensive system redesign (re-architecting) to correct
#### Adaptive Maintenance
Adaptive maintenance involves changing the software to work in some new environment such as a new platform, operating system or web browser. It is characterized by no change in functionality, just a move to a new environment. 
#### Perfective Maintenance 
Implementing new or changed functionality due to changes in requirements. Normally generated either by users (e.g., need to handle a new transaction or a new kind of bank card or service) or changes in the business environment the software operates in (e.g., changes to tax laws, new information interchange formats, competition from other businesses, etc.)
### Maintenance Testing
In practice, the distribution of Effort: 
	➢ 65–70% → Perfective (enhancing functionality)  
	➢ 15–20% → Adaptive (environmental changes)  
	➢ 15–20% → Corrective (bug fixes)  

 There is risk because changes, especially in perfective maintenance can unintentionally break existing functionality. The reason behind is that software components are highly interdependent; modifying one part may trigger unexpected side effects elsewhere.
- **Side Effects:** Any error or undesirable behavior that occurs as a result of modifications to a system
- **Coding side-effects:** Inadvertent removal of vital code, changes in semantics of code, unexpected changes in execution path
- **Data side-effects:** changes in data structures render older data invalid or incomplete, changes in global constants, changes in data ranges
- **Documentation side-effects:** Forgetting to document code or data structure changes, changes not reflected in user manuals or interface

Moreover, as time goes on, the software is often maintained by programmers not involved in the  
original design and development. So they are More focused on the changes than the whole product. For this reason, testing has an even more important role in quality assurance in the maintenance phase than it does in initial development and delivery. It helps to make sure that changes have not broken anything.

---
### Continuous Testing Methods
#### Testing as a Maintenance Activity
- Thus, testing is not a one-time thing - we're never "done" testing
- As software is maintained, if we are to maintain consistent quality, we must continue testing both the old existing functionality, and the new introduced functionality
- Hence, XP calls for continuous testing (“every day”)
- At a minimum, we must re-test thoroughly after every set of changes, before the changed software is released
### Test Suites
- Most projects maintain test suites, sets of tests to be run on every release of the software
- Maintained in parallel with the software - often at least as much effort as coding the software itself!  (Automation is essential to make this practical)
- Three related kinds of continuous tests are normally performed and maintained continuously in software maintenance  
	1) Functionality (or acceptance) tests,  
	2) failure tests, and  
	3) operational tests
#### Continuous Functionality Testing
We have already seen functionality and acceptance testing suites. When used continuously over the evolution of the software, we maintain the functionality tests by:
- When new features are added new tests are added for that feature
- Every time a feature is changed or extended we change the corresponding functionality tests 
#### Failure Test Suite
A failure test is a test case that previously caused the software to fail. To be effective, failure tests must be maintained over the evolution of the software by:
- Before correcting any observed failure, create a "failure test" that causes it
- Becomes the specification of the fix - the new version must pass it
- The failure test must cause the error in the old software and not cause the error in the new software
- All these tests go in a failure test suite, re-run on all future versions of the software to ensure that the failure doesn’t reappear
#### Operational Testing
Operational tests are actual production runs observed in the use of the software. (e.g., for a banking Front End, all of the transactions done at one or more bank terminals over a whole day of operation or or a banking Back Office, all of the Transaction Summary Files from a set of real front  
ends)
- Build from real production data early in the software’s lifecycle. (e.g., Capture actual ATM transactions from customers over a day.)
- Continuous update- add new operational tests whenever features are added or changed
- Acts as a sanity check before release — ensures the software still handles real user input, not just artificial test cases.
- Prevents failures in real-world use — avoiding embarrassing releases!
#### Regression Testing
Regression testing: an automated continuous testing strategy, whose purpose is to make sure that 
the software does not "regress" - that is, become less effective than it has been in the past. Regression test suites are normally comprehensive, including three major components:
- Functionality tests, to make sure that we still meet the basic requirements  
- Failure tests, to make sure that we haven't recreated a past failure  
- Operational tests, to make sure that we can still process real production runs  
- Each of these is maintained, either together or separately, as previously described
### Summary
- Software maintenance, consisting of corrective, adaptive, and perfective steps, is the longest phase of software development  
- Continuous testing is essential to maintain quality during software maintenance  
- Regression testing combines functionality, failure, and operational testing in an automated continuous testing framework