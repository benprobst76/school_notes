## Phases of Database Design
![[Pasted image 20260112084130.png]]

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

![[Pasted image 20260112084219.png]]

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
| Key Type | Description |
| :--- | :--- |
| **Superkey** | A super key is a group of single or multiple keys that uniquely identifies rows in a table. A super key can contain extra attributes that aren’t necessary for uniqueness. For example, if the "STUD_NO" column can uniquely identify a student, adding "SNAME" to it will still form a valid super key, though it's unnecessary. A super key could be a combination of STUD_NO and PHONE, as this combination uniquely identifies a student. |
| **Candidate Key** | A candidate key is a minimal super key, meaning it can uniquely identify a record but contains no extra attributes. It is a super key with no repeated data. The minimal set of attributes that can uniquely identify a record. A candidate key must contain unique values, ensuring that no two rows have the same value in the candidate key’s columns. STUD_NO can be a candidate key, as it uniquely identifies each record. |
| **Primary Key** | A primary key is a unique key, meaning it can uniquely identify each record (tuple) in a table. It must have unique values and cannot contain any duplicate values. A primary key cannot be NULL, as it needs to provide a valid, unique identifier for every record. Databases typically store rows ordered in memory according to primary key for fast access of records using primary key. The primary key for each entity is underlined in the ER mode. STUD_NO is a primary key. |
| **Alternate Key** | An alternate key is any candidate key in a table that is not chosen as the primary key. An alternate key can consist of one or more columns (fields) that can uniquely identify a record, but it is not the primary key. |
| **Composite Key** | A candidate/primary key that consists of more than one attribute. Customer id needs to be entered every time the order is placed. Customer id can repeat in the table and can not serve as a primary key. Product id and Quantity cannot be chosen as primary key because multiple customers can buy same product and the same quantity. [Customer id + Product id] can be used to identify the records uniquely. |

---

## Relationships
A **Relationship** is an association among several entities. Relationships can also have their own attributes.

### Cardinality Constraints
Expresses the number of entities to which another entity can be associated via a relationship set.
1. **One-to-One (1:1):** Each instance of X is associated with only one instance of Y (e.g., Marriage).
2. **One-to-Many (1:N):** Each instance of X can be associated with many of Y, but Y is associated with only one X (e.g., Manager to Employees).
3. **Many-to-Many (N:M):** Each instance of X can be associated with many of Y, and vice versa (e.g., Students to Courses).

### Participation Constraints
- **Total Participation:** Every entity in the set *must* participate in the relationship (indicated by a **double line** or bold line).
    - *Example:* Every Course must be taught by a Professor.
- **Partial Participation:** Some entities may not participate in the relationship (indicated by a **single line**).
    - *Example:* Not all Professors have to teach a Course.

### Special Relationships
- **Recursive Relationship:** An entity has a relationship with itself (e.g., an Employee managing other Employees).
- **Ternary Relationship:** Involves three entities simultaneously; the meaning depends on all three.

---

## Weak Entities
- Some entities would not be in the database unless they are related to some other entity that is in the database.
- We call the dependent entity a **“weak entity”**.
- A weak entity has no primary key but can be uniquely identified by association with another **strong entity** (known as the owner entity).

### Characteristics
- **No Primary Key:** Weak entities do not have any primary key.
- **Dependency:** They cannot be identified on their own, so they depend on some other entity (known as owner entity).
- **Total Participation:** The weak entities have total participation constraints (existence dependency) in its identifying relationship with owner identity.
- **Partial Keys:** Weak entity types have partial keys. Partial keys are set of attributes, with the help of which the tuples of weak entities can be identified and distinguished.

### Representation
- Weak entities are represented with a **double rectangular box** in the ER diagram.
- The identifying relationships are represented with a **double diamond**.
- Partial key attributes are represented with **dotted lines**.

![[Pasted image 20260119143049.png]]

---

## Specialization (Extended ER Model)
**Specialization** focuses on dividing a general entity type, or **superclass**, into smaller, more specific categories called **subclasses**.

### Constraints on Specialization
While working on specializations, we face some constraints:

1. **Disjoint:**
    - Entities can belong to only one subclass.
    - *Example:* An `EMPLOYEE` cannot simultaneously be a `TECHNICIAN` and an `ENGINEER`.
2. **Overlapping:**
    - Entities can belong to multiple subclasses.
    - *Example:* A salaried engineer could belong to both `SALARIED_EMPLOYEE` and `ENGINEER`.

### Completeness Constraint
- **Total:** Every entity in the superclass must belong to at least one subclass.
    - *Example:* All `EMPLOYEES` are either `HOURLY_EMPLOYEES` or `SALARIED_EMPLOYEES`.
- **Partial:** Some entities may not belong to any subclass.
    - *Example:* Not every `EMPLOYEE` is a `SECRETARY`, `ENGINEER`, or `TECHNICIAN`.

### Symbols Used in ER Model
![[Pasted image 20260119143208.png]]

---

## ER Diagram Construction Steps
1. Read the question.
2. Read the question (again).
3. Read the question (again).
4. Identify the **entity sets**.
5. Identify the **relevant attributes**.
6. Identify the **primary keys** (and any other keys).
7. Identify the **relationships**.
8. Complete the diagram.

---
## Practice Question: NHL Database
**Requirements:**
- The NHL has many teams.
- Each team has a name, a city, a coach, a captain, and a set of players.
- Each player belongs to only one team.
- Each player has a name, a position (such as left wing or goalie), a skill level, and a set of injury records.
- A team captain is also a player.
- A game is played between two teams (referred to as host team and guest_team) and has a date (such as May 11th, 1999) and a score (such as 4 to 2).
**Goal:** Construct a clean and concise ER diagram for the NHL database.
### Solution Process
#### 1. Identify the Entity Sets
- `TEAM`
- `PLAYER`
- `INJURY_RECORD`
#### 2. Identify the Relevant Attributes
- **Team:** `tname`, `city`, `coach`
- **Player:** `pid`, `pname`, `position`, `skill_level`
- **Injury records:** `injury_id`, `description`
#### 3. Identify the Primary Keys
- **TEAM:** `tname`
- **PLAYER:** `pid`
- **INJURY_RECORD:** `{pid, injury_id}`
#### 4. Identify the Relationships
- Each team has a name, a city, a coach, a captain, and a set of players.
- Each player belongs to only one team.
- A team captain is also a player.
- Each player has a name, a position, a skill level, and a set of injury records.
- A game is played between two teams (host team and guest_team) with a date and score. (Recursive relationship on TEAM or many-to-many relationship).
#### 5. Complete ER Diagram
![[Pasted image 20260119143357.png]]
