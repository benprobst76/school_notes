# Structured Query Language (SQL)
SQL is a standard language for accessing and manipulating databases. It provides a way to interact with the [[Relational-Model]] and is the primary tool used to manage data in most modern database systems.
## Capabilities of SQL
- **Data Querying:** Execute queries against a database to answer specific questions and retrieve data.
- **Data Manipulation:** Insert, update, and delete records within tables.
- **Schema Management:** Create new databases, tables, and views (refer to [[Data-Definition-Language]]).
- **Access Control:** Set security permissions on database objects like tables and views.
## Important Commands
SQL commands are categorized into different groups, such as [[Data-Definition-Language]] (DDL) and Data Manipulation Language (DML).
- `SELECT`: Extracts data from a database.
- `UPDATE`: Updates existing data within a table.
- `DELETE`: Deletes records from a table.
- `INSERT INTO`: Inserts new records into a table.
- `CREATE DATABASE`: Creates a new database instance.
- `CREATE TABLE`: Defines a new table structure.
- `ALTER TABLE`: Modifies an existing table structure.
- `DROP TABLE`: Deletes a table and its data.
- `CREATE INDEX`: Creates an index (search key) to speed up queries.
- `DROP INDEX`: Deletes an index.
## Basic Query Structure
A typical SQL query follows a structured format that maps closely to [[Relational-Algebra]] operations:
```sql
SELECT A1, A2, ..., An
FROM r1, r2, ..., rm
WHERE P;
```
- **Result:** The result of a query is a relation, though SQL allows for duplicate tuples unless specified otherwise.
## The SELECT Clause
The `SELECT` clause corresponds to the **Projection** operation in [[Relational-Algebra]].
- **Relational Algebra Notation:** $$\Pi_{A_1, A_2, \dots, A_n}(r)$$
- **Function:** Lists the attributes desired in the query result.
- **Example:** Find the names of all instructors:
```sql
SELECT name FROM instructor;
```
- **Eliminating Duplicates:** Use the `DISTINCT` keyword after `SELECT` to remove duplicate rows from the result.
```sql
SELECT DISTINCT dept_name FROM instructor;
```
- **Selecting All Attributes:** Use an asterisk (`*`) to denote all attributes in the relation.
```sql
SELECT * FROM instructor;
```
- **Arithmetic Expressions:** The `SELECT` clause can contain expressions involving `+`, `-`, `*`, and `/` on constants or attribute values.
```sql
SELECT ID, name, salary * 1.1 FROM instructor;
```
## The WHERE Clause
The `WHERE` clause corresponds to the **Selection** operation in [[Relational-Algebra]].
- **Relational Algebra Notation:** $$\sigma_P(r)$$
- **Function:** Specifies predicates that the result must satisfy.
- **Example:** Find all instructors in the 'Comp. Sci.' department:
```sql
SELECT name FROM instructor WHERE dept_name = 'Comp. Sci.';
```
### Logical Operators
Comparison results can be combined using `AND`, `OR`, and `NOT`.
- **Example:** Find instructors in 'Comp. Sci.' or 'Finance' with a salary > 80,000:
```sql
SELECT * FROM instructor WHERE (dept_name = 'Comp. Sci.' OR dept_name = 'Finance') AND salary > 80000;
```
- **Example:** Find all instructors in 'Comp. Sci.' except for 'Brandt':
```sql
SELECT * FROM instructor WHERE dept_name = 'Comp. Sci.' AND NOT name = 'Brandt';
```
## Advanced Filtering
### Range Searching (BETWEEN)
The `BETWEEN` operator is used to filter results within a specific range (inclusive).
- **Example:** Find instructors with salaries between 60,000 and 80,000:
```sql
SELECT name FROM instructor WHERE salary BETWEEN 60000 AND 80000;
```
### Pattern Matching (LIKE)
The `LIKE` operator searches for a specified pattern in a column.
- `%`: Matches any string of zero or more characters.
- `_`: Matches any single character.
- **Example:** Find instructors whose name starts with 'B' or has 'o' as the second letter:
```sql
SELECT name FROM instructor WHERE name LIKE 'B%' OR name LIKE '_o%';
```
### Set Membership (IN)
The `IN` operator allows you to specify multiple possible values for an attribute.
- **Example:** Find instructors whose salary is exactly 72,000 or 80,000:
```sql
SELECT name FROM instructor WHERE salary IN (72000, 80000);
```
## Ordering Results
The `ORDER BY` clause is used to sort the result set in ascending (`ASC`) or descending (`DESC`) order. The default is ascending.
- **Example:** List all instructors arranged by salary from lowest to highest:
```sql
SELECT * FROM instructor ORDER BY salary ASC;
```