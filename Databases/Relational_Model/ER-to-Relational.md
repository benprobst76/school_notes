## Question  
• The company is organized into branches. Each branch has a unique number, a name, and a  
particular employee who manages it.  
• The company makes it’s money by selling to clients. Each client has a name and a unique  
number to identify it.  
• The foundation of the company is it’s employees. Each employee has a name, birthday, sex,  
salary and a unique number.  
• Many employee can work for one branch at a time, and each branch will be managed by one  
of the employees that work there. We’ll also want to keep track of when the current  
manager started as manager.  
• An employee can act as a supervisor for other employees at the branch, an employee may  
also act as the supervisor for employees at other branches. An employee can have at most  
one supervisor.  
• A branch may handle a number of clients, with each client having a name and a unique  
number to identify it. A single client may only be handled by one branch at a time.  
• Employees can work with clients controlled by their branch to sell them stuff. If nescessary  
multiple employees can work with the same client. We’ll want to keep track of how many  
dollars worth of stuff each employee sells to each client they work with.  
• Many branches will need to work with suppliers to buy inventory. For each supplier we’ll  
keep track of their name and the type of product they’re selling the branch. A single supplier  
may supply products to multiple branches.

![[Pasted image 20260202102314.png]]
### Steps to Covert ER diagrams to Schema  
1. Mapping regular (strong) entity types  
2. For each regular entity type create a relation (table) that includes all the simple  
attributes of that entry  
3. Mapping weak entity types  
4. For each weak entity type create a relation (table) that includes all simple attributes of  
that weak entity  
5. Mapping of Binary 1:1 relationship types  
6. Include one side of the relationship as FK in the other Favor total participation  
7. Mapping of Binary 1:N:  
8. Include the 1 side’s PK as FK on the N side relation  
9. Mapping of Binary M:N relationship types  
10. Create a new relation (table) who’s PK is a combination of both entities PKs. Also include any relationship attributes
### Resultant Tables
![[Pasted image 20260202102611.png]]
![[Pasted image 20260202102647.png]]