## What is Data? What is a Database?

**Data:**
- A collection of raw facts and figures.
- Must have meaning.
- Often unprocessed and unorganized.
- *Examples:* 101, Bus, Bird.

**Database:**
- An organized collection of related data.
- Structured and meaningful.
- Managed using a **Database Management System (DBMS)**.
- *Example:* Student database (ID, Name, Age, Grade).

### Examples of Database Usage
- **Enterprise Information:** Sales, customers, products, and purchase history.
- **HR Department:** Employee details, salaries, payroll, and taxes.
- **Banking and Finance:** Credit card purchases and monthly statements.
- **Universities:** Student records, course registrations, and grades.

---

## Types of Data in Databases

| Feature | Structured | Semi-structured | Unstructured |
| :--- | :--- | :--- | :--- |
| **Definition** | Organized in rows and columns. | Partially organized using tags or markers. | No predefined format; raw data. |
| **Schema** | Strict, predefined (e.g., tables). | Flexible schema with metadata. | No schema; highly flexible. |
| **Storage Format** | Relational database (SQL). | JSON, XML, YAML, NoSQL. | Text files, images, NoSQL. |
| **Scalability** | Vertical scaling (bigger server). | Horizontal scaling (distributed). | Requires special storage/indexing. |
| **Examples** | Customer records. | HTML, JSON. | Social media posts. |

To **Create, Read, Update, and Delete (CRUD)** data, you need a **DBMS**.

---

## Why Study Databases?

Data is a key resource for most organizations. DBMSs are critical components in applications for:
- Banking and reservations.
- Online shopping and catalogs.
- Social networks and search engines.
- Data warehouses and interactive maps.

### Core Computer Science Concepts in DB Systems:
- **Abstraction:** Data models and languages (SQL, relational algebra).
- **Concurrency:** Locking and control protocols.
- **Security.**
- **Optimization.**
- **Performance Management.**

---

## History and Types of DBMS

### Relational Databases (RDBMS)
One of the most successful software systems.
- **IBM DB2 (1974):** Originated from System-R; created SQL.
- **Oracle (1977):** First commercial relational product; dominant in large corporations.
- **MySQL (1995):** Popular open-source and enterprise database.
- **Microsoft SQL Server (1989):** Preferred for Windows/.NET environments.
- **PostgreSQL (1988):** Feature-rich and strict open-source database.

### Non-Relational Databases (NoSQL)
- **Document Stores:** MongoDB, CouchDB (JSON-like).
- **Key/Value Pairs:** Redis, DynamoDB.
- **Columnar Stores:** Cassandra, HBase (Analytics).
- **Graph Databases:** Neo4j, Amazon Neptune (Social networks, recommendations).

*Note: This course focuses on Relational Systems.*

---

## Concepts and Terminology

### Data Model
A collection of tools (diagrams, vocabulary) used to describe data.
- **Types:** Relational, Entity-Relationship (ER), Hierarchical, Object-Based, Network.

### Schema
The actual description/blueprint of a database using a data model.
- Describes what data is stored, its structure, relationships, and constraints.

### DBMS
A set of programs that enable users to perform operations on a database (e.g., MySQL, Oracle).

---

## Evolution of Data Management

### Life Before DBMS
- Applications and data were tightly coupled.
- Data stored in **flat files**.
- High redundancy (repeated storage).
- **Data Silos:** Data was inaccessible across different departments.

### Advantages of an Integrated DBMS
1. **Sharing of Data:** Multiple users can access the same data.
2. **Reduced Redundancy:** Data is stored once, reducing errors.
3. **Data Consistency:** Updates happen in one place.
4. **Better Security:** Centralized access control.
5. **Improved Integrity:** Enforced rules and constraints.
6. **Decoupling:** Separation of data from applications.
7. **Concurrency Control:** Manages simultaneous access.

---

## Human Roles in DBMS
- **End Users:**
    - *Sophisticated:* Use query languages.
    - *Data Scientists:* Use AI/Analytics tools.
    - *Naïve:* Use simple application interfaces.
- **Application Programmers:** Build database access into software.
- **Database Administrator (DBA):** Designs, secures, maintains, and manages backups/restores.

---

## Phases of Database Design
1. **Requirement Analysis:** Understand and document needs and business rules.
2. **Conceptual Design:** Create a high-level model (ER Diagram) independent of DBMS.
3. **Logical Design:** Convert ER diagram into a logical schema (Relational tables/keys).
4. **Physical Design:** Specify physical implementation (Data types, storage optimization).

---

## 3-Schema Architecture

1. **External Schema (View Level):** Closest to users; hides complexity and ensures security.
2. **Conceptual Schema (Logical Level):** Describes the structure of the entire DB (what data is stored).
3. **Internal Schema (Physical Level):** Deals with actual physical storage on disks.

### Data Independence
- **Logical Data Independence:** Ability to change the logical level (e.g., adding columns) without changing the view level.
- **Physical Data Independence:** Ability to change the physical level (e.g., switching from HDD to SSD) without changing the logical level.

---

## Database System Environment
![Database Environment](./media/Pasted%20image%2020260112081055.png)
