## Introduction to SQL and MariaDB
- **MariaDB:** A popular fork of the MySQL database management system. It is fully compatible with MySQL and is often bundled with XAMPP.
- **SQL History:** Originally developed as "Sequel" by IBM for the System R project. It was later renamed to **Structured Query Language (SQL)**.
- **Standards:** ANSI and ISO standards have evolved over decades (SQL-86, SQL-92, SQL:1999 ... SQL:2019). Most commercial systems use **SQL-92** as a common base while adding proprietary features.
---
## SQL Language Components
1. **Data Definition Language (DDL):** Used to define the database structure (schema, domains, and integrity constraints).
2. **Data Manipulation Language (DML):** Used to query and modify the data stored in the database.
---
## Integrity Constraints
Integrity constraints ensure the correctness and consistency of data by preventing invalid entries. The DBMS checks these whenever changes are made.
- **Domain Constraints:** All attribute values must come from a predefined set of allowable values (the domain).
- **Entity Integrity:** No attribute that is part of a primary key can contain a `NULL` value.
- **Referential Integrity:** A [[Relational-Model#Foreign Keys|Foreign Key]] must either reference a valid primary key in the parent table or be `NULL`.
---
## Data Definition Language (DDL)
The DDL allows for the specification of:
- The **schema** for each relation.
- The **domain** (data type) of each attribute.
- **Integrity constraints** (Primary Keys, Foreign Keys, etc.).
- **Indices** for performance optimization.
- **Security/Authorization** settings.
- **Physical storage** structure on the disk.
### Creating a Database
A database is a collection of related tables. You must create the database before defining relations.
```sql
CREATE DATABASE myDatabaseName;
```
---
## Domain Types in MySQL/MariaDB
| Type | Description |
| :--- | :--- |
| `CHAR(n)` | Fixed-length character string of length $n$. Padded with spaces if shorter. |
| `VARCHAR(n)` | Variable-length character string with a maximum length $n$. |
| `INT` | Machine-dependent integer value. |
| `DECIMAL(p, d)` | Fixed-point number with $p$ total digits and $d$ digits after the decimal. |
| `DATE` | Date format: `YYYY-MM-DD`. |
| `TIME` | Time format: `HH:MM:SS`. |
| `ENUM` | A list of allowed string values (e.g., `'A'`, `'B'`, `'C'`). |

### Char vs. Varchar
- **Recommendation:** Use `VARCHAR` unless the data length is consistently fixed (e.g., a 2-letter state code).
- **Storage:** `CHAR(10)` stores "cat" using 10 bytes (3 characters + 7 spaces). `VARCHAR(10)` stores "cat" using only 3 characters + overhead.
---
## Schema Diagram for University Database
![[./media/Pasted image 20260202100615.png]]
---
## Creating and Modifying Tables
### Basic Create Table Statement
When creating a table, you define the columns, their data types, and constraints.
```sql
CREATE TABLE instructor (
    ID CHAR(5),
    name VARCHAR(20) NOT NULL,
    dept_name VARCHAR(20),
    salary DECIMAL(8,2),
    PRIMARY KEY (ID),
    FOREIGN KEY (dept_name) REFERENCES department(dept_name)
);
```
### Foreign Key Constraints
When defining a [[Relational-Model#Foreign Keys|Foreign Key]], the referenced table must already exist. If it doesn't, use `ALTER TABLE` to add it later.
- **ON DELETE / ON UPDATE Actions:**
    - `CASCADE`: If the parent row is deleted/updated, the child rows are also deleted/updated.
    - `SET NULL`: If the parent row is deleted, the child's foreign key value is set to `NULL`.
    - `RESTRICT`: The deletion/update of the parent is rejected if any child rows reference it (this is the **default**).
---
## Drop, Delete, and Alter
### Removing Data and Tables
- **DROP TABLE:** Completely removes the table structure and all data.
    - `DROP TABLE student;`
- **DELETE FROM:** Removes all rows from the table but keeps the structure intact.
    - `DELETE FROM student;`
### Altering Table Structure
Used to add or remove columns from an existing table.
- **Add Column:**
    ```sql
    ALTER TABLE student ADD email VARCHAR(50);
    ```
- **Drop Column:**
    ```sql
    ALTER TABLE student DROP email;
    ```
