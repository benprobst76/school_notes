## Phases of Database Design
![Phases of Database Design](./media/Pasted%20image%2020260112084130.png)

### Conceptual Design
- **Description:** A high-level description of the database.
- **Perspective:** Close to the user's view of the world.
- **Semantic Model:** Conveys meaning as well as structure.
- **DBMS Independent:** Remains correct even if the target DBMS changes.
- **Goal:** Create a permanent description of data requirements.

---

## The Entity-Relationship Model
- **History:** Developed by Peter Chen in 1976.
- **Usage:** The most popular model exclusively used for conceptual design.
- **Core Concept:** A database is modeled as a collection of **Entities**, **Attributes**, and **Relationships**.

### Representation (ER Diagrams)
| Component | ER Diagram Symbol |
| :--- | :--- |
| **Entity** | Rectangle |
| **Attribute** | Ellipse |
| **Relationship** | Diamond |
| **Primary Key** | Underlined Attribute Name |

![ER Representation Overview](./media/Pasted%20image%2020260112084219.png)

---

## Entities
- **Entity:** An object that exists and is distinguishable from other objects (e.g., People, Companies, Courses).
- **Entity Instance:** A specific occurrence of an entity (e.g., a particular student).

---

## Attributes
Entities have properties called attributes.

### Types of Attributes:
- **Single-valued:** Holds only one value (e.g., Student ID).
- **Multi-valued:** Can hold more than one value (e.g., Email addresses, Phone numbers).
- **Composite:** Can be decomposed into smaller sub-parts (e.g., Name -> First Name, Last Name).
- **Derived:** Values are calculated rather than stored (e.g., Age derived from Date of Birth).

---

## Keys
Keys are attributes used to distinguish between entity instances in an entity set, ensuring data integrity and efficient retrieval.

### Types of Keys
| Key Type          | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| :---------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Superkey**      | A super key is a group of single or multiple keys that uniquely identifies rows in a table. A super key can contain extra attributes that  <br>aren’t necessary for uniqueness. For example, if the "STUD_NO" column can uniquely identify a student, adding "SNAME"  <br>to it will still form a valid super key, though it's unnecessary. A super key could be a combination of STUD_NO and PHONE, as this combination uniquely identifies a student.                                         |
| **Candidate Key** | A candidate key is a minimal super key, meaning it can uniquely identify a record but contains no extra attributes. It is a super key with no repeated data is called a candidate key.  The minimal set of attributes that can uniquely identify a record. A candidate key must contain unique values, ensuring that no two rows have the same value in  <br>the candidate key’s columns. STUD_NO can be a candidate key, as it uniquely identifies each record.                                |
| **Primary Key**   | A primary key is a unique key, meaning it can uniquely identify each record (tuple) in a table. It must have unique values and cannot contain  <br>any duplicate values. A primary key cannot be NULL, as it needs to  <br>provide a valid, unique identifier for every record. Databases typically store rows ordered in memory according to primary key for fast access of records using primary key.  The primary key for each entity is underlined in the ER mode. STUD_NO is a primary key |
| **Alternate Key** | An alternate key is any candidate key in a table that is not chosen as the primary key. An alternate key can consist of one or more columns (fields) that can uniquely identify a record, but it is not the primary key                                                                                                                                                                                                                                                                         |
| **Composite Key** | A candidate/primary key that consists of more than one attribute. Customer id needs to be entered every time the order is placed  <br>Customer id can repeat in the table and can not serve as a primary key  Product id and Quantity cannot be chosen as primary key because multiple customers can  buy same product and the same quantity. \[Customer id + Product id] can be used to  identify the records uniquely.                                                                        |

---

## Relationships
A **Relationship** is an association among several entities. Relationships can also have their own attributes.
### Cardinality Constraints
Expresses the number of entities to which another entity can be associated via a relationship set.
1.  **One-to-One (1:1):** Each instance of X is associated with only one instance of Y (e.g., Marriage).
2.  **One-to-Many (1:N):** Each instance of X can be associated with many of Y, but Y is associated with only one X (e.g., Manager to Employees).
3.  **Many-to-Many (N:M):** Each instance of X can be associated with many of Y, and vice versa (e.g., Students to Courses).
### Participation Constraints
- **Total Participation:** Every entity in the set *must* participate in the relationship (indicated by a **double line** or bold line).
    - *Example:* Every Course must be taught by a Professor.
- **Partial Participation:** Some entities may not participate in the relationship (indicated by a **single line**).
    - *Example:* Not all Professors have to teach a Course.
### Special Relationships
- **Recursive Relationship:** An entity has a relationship with itself (e.g., an Employee managing other Employees).
- **Ternary Relationship:** Involves three entities simultaneously; the meaning depends on all three.
