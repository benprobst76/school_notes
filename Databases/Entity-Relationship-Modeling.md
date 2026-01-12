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
| Key Type | Description |
| :--- | :--- |
| **Superkey** | A set of one or more attributes that uniquely identifies a row. It may contain extra, unnecessary attributes (e.g., `[STUD_NO + PHONE]`). |
| **Candidate Key** | A minimal superkey. It uniquely identifies a record without any redundant attributes. |
| **Primary Key** | The specific candidate key chosen to uniquely identify every record. It **cannot be NULL** and must be unique. |
| **Alternate Key** | Any candidate key that was *not* selected as the primary key. |
| **Composite Key** | A candidate/primary key that consists of more than one attribute (e.g., `[Customer_ID + Product_ID]`). |

![Key Relationships](./media/Pasted%20image%2020260112084322.png)

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
