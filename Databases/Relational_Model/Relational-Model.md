## Relational Model History
- Introduced by **Ted Codd** in 1970 in a classic paper.
- Laid the foundation for database theory and won Ted Codd the **ACM Turing Award**.
- Most modern database concepts and products are based on this model, including:
    - MySQL, DB2, Oracle, PostgreSQL, Microsoft SQL Server, and MS Access.
---
## What is the Relational Model?
- The **Relational Model** represents how data is stored in **Relational Databases**.
- Data is stored in the form of **relations** (tables).
- After designing a conceptual model (using [[../Entity_Relationship/Entity-Relationship-Modeling|ER Diagrams]]), it is converted into the relational model for implementation.
- This model can be implemented by any **RDBMS** (Relational Database Management System) such as Oracle, MySQL, or SQL.
---
## Terminology and Representation
- The relational model represents data as a table with columns and rows.
- **Tuple:** A single row in a relation.
- **Attribute:** A column in a relation, representing a specific property.
---
## Relational Schema
- A **Relational Schema** specifies the design of a table, including:
    - Table names (relations).
    - Attributes and their domains.
    - Primary keys and foreign keys.
- *Example Schema:*
    - `Customer(CustomerID, Name, Email)`
    - `Order(OrderID, OrderDate, CustomerID)`
---
## Domain Concepts
- A **Domain** is the set of allowable values for an attribute.
- It has a logical definition (e.g., Canadian phone numbers must be exactly 10 digits).
- **Common Data Types:**
    - `CHAR(n)`: A string of exactly $n$ characters.
    - `VARCHAR(n)`: A string of up to $n$ characters.
    - `INTEGER`, `FLOAT`, etc.
![[./media/Pasted image 20260202095433.png]]
---
## Characteristics of a Relation
1. **Atomic Values:** Each cell must contain exactly one value (not a set or list).
2. **Distinct Names:** Each column must have a unique name within the table.
3. **Consistent Domains:** All values in a column must be from the same domain.
4. **Unique Tuples:** No two rows can be identical; each tuple must be distinct.
5. **Order is Immaterial:** The sequence of rows or columns does not change the meaning of the data.
6. **Database Composition:** A database consists of multiple related tables.
---
## Degree and Cardinality
- **Degree:** The number of attributes (columns) in a relation. This value is typically static.
- **Cardinality:** The number of tuples (rows) in a relation. This value changes as data is added or deleted.
---
## Player Table Example
| PlayerID | RegID | PassportNo | Email | Phone | Name | Nationality | City | Age |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | R101 | P8901 | salah@mail.com | 555-1111 | Salah | Egyptian | Liverpool | 32 |
| 2 | R102 | P6723 | mane@mail.com | 555-2222 | Mane | Senegalese | Riyadh | 30 |
| 3 | R103 | P4456 | gakpo@mail.com | 555-3333 | Gakpo | Dutch | Liverpool | 27 |
| 4 | R104 | P9987 | salah2@mail.com | 555-4444 | Salah | Egyptian | Liverpool | 32 |

$$ 
\begin{aligned}
\text{Degree} &= 9 \text{ (attributes)} \\
\text{Cardinality} &= 4 \text{ (tuples)} \\
\end{aligned}
$$ 
---
## Keys and Data Integrity
- Relations are sets, which implies uniqueness among tuples.
- **Key:** A value or set of values that uniquely identifies a row.
- Refer to [[../Entity_Relationship/Entity-Relationship-Modeling#Keys|Keys]] and [[../Entity_Relationship/Entity-Relationship-Modeling#Types of Keys|Super/Primary Keys]] for more detail.
### Data Values
- All values in a cell must be **atomic**.
- **Null Values:** Represent data that is unknown, unavailable, or not applicable.
- **Entity Integrity Constraint:** No attribute part of a primary key can contain a `NULL` value.
---
## Foreign Keys
- Used to specify relationships among tuples in different relations.
- **Referencing (Child) Relation:** The table that contains the foreign key.
- **Referenced (Parent) Relation:** The table that contains the primary key being referred to.
### Characteristics of Foreign Keys
- Can be `NULL` (e.g., a person with no department).
- Do not have to be unique (many-to-one relationship).
- Must come from the same domain as the referenced primary key.
- **Self-Referencing:** A foreign key can refer to the same relation (e.g., an employee table where a `manager_id` refers to another `employee_id`).
    - *Example:* `Customer.referredByID (FK)` $\rightarrow$ `Customer.customerID (PK)`
---
## Database Integrity and Connections
Foreign keys maintain database integrity by allowing valid connections between relations.
![[./media/Pasted image 20260202100024.png]]
### Relationship Mapping Examples
- **Department $\leftrightarrow$ Student:***
    - Parent: `Department` (PK: `dept_name`)
    - Child: `Student` (FK: `dept_name`)
    - *Constraint:* Every student must belong to a valid department.
- **Department $\leftrightarrow$ Instructor:***
    - Parent: `Department` (PK: `dept_name`)
    - Child: `Instructor` (FK: `dept_name`)
- **Student $\leftrightarrow$ Advisor:***
    - Parent: `Student` (PK: `ID`)
    - Child: `Advisor` (FK: `s_id`)
- **Instructor $\leftrightarrow$ Advisor:***
    - Parent: `Instructor` (PK: `ID`)
    - Child: `Advisor` (FK: `i_id`)
    - *Constraint:* An advisor must be an instructor that exists in the database.
