# Relational Algebra
Relational algebra is a procedural query language that takes instances of relations as input and yields instances of relations as output. It provides a formal foundation for the [[Relational-Model]] and is used to define the operations that can be performed on data stored in a relational database.
## Fundamental Operators
Relational algebra uses operators to perform queries. These operators can be either unary (operating on one relation) or binary (operating on two relations). They always accept relations as their input and yield relations as their output, allowing for nested expressions.
### Select Operation ($\sigma$)
The select operation identifies a subset of tuples in a relation that satisfy a specific predicate.
- **Notation:** $\sigma_p(r)$
- **Predicate ($p$):** A condition involving attributes of the relation and constants, combined using logical operators like $\land$ (and), $\lor$ (or), and $\neg$ (not).
- **Example:** To find all instructors working in the 'Finance' department from the `INSTRUCTOR` relation:
$\sigma_{Dept\_Name = 'Finance'}(INSTRUCTOR)$
### Project Operation ($\Pi$)
The project operation creates a new relation by selecting specific columns (attributes) from the input relation and eliminating the rest.
- **Notation:** $\Pi_{A_1, A_2, \dots, A_k}(r)$
- **Duplicate Removal:** Since relations are sets, any duplicate rows resulting from the projection are automatically removed.
- **Example:** To list the ID, name, and salary of all instructors while ignoring their department names: $\Pi_{ID, name, salary}(INSTRUCTOR)$
### Union Operator ($\cup$)
The union operator combines all tuples from two relations into a single result.
- **Notation:** $r \cup s$
- **Definition:** $r \cup s = \{t \mid t \in r \text{ or } t \in s\}$
- **Union Compatibility:** For the operation to be valid, the relations must be union-compatible:
1. Both relations must have the same number of attributes (arity).
2. The domains (data types) of corresponding attributes must be compatible.
- **Compatibility Examples:**
- **Compatible:** $r(student\_id, age)$ and $s(emp\_id, age)$.
- **Incompatible:** $r(student\_id, age)$ and $s(course\_name, semester)$.
- **Example Query:** To find all names that appear as either a student name or an instructor name:
$\Pi_{name}(STUDENT) \cup \Pi_{name}(INSTRUCTOR)$
### Set Intersection ($\cap$)
The intersection operator returns only the tuples that are present in both input relations.
- **Notation:** $r \cap s$
- **Definition:** $r \cap s = \{t \mid t \in r \text{ and } t \in s\}$
- **Requirements:** The relations must be union-compatible. Note that intersection is a derived operator: $r \cap s = r - (r - s)$
- **Example:** To find names of individuals who are both students and instructors: $\Pi_{name}(STUDENT) \cap \Pi_{name}(INSTRUCTOR)$
### Set Difference ($-$)
The set difference operator finds tuples that are in one relation but not in another.
- **Notation:** $r - s$
- **Definition:** $r - s = \{t \mid t \in r \text{ and } t \notin s\}$
- **Requirements:** The relations must be union-compatible.
- **Example:** To find the names of instructors who are not students:
$\Pi_{name}(INSTRUCTOR) - \Pi_{name}(STUDENT)$
### Cartesian Product ($\times$)
The Cartesian product combines every tuple from the first relation with every tuple from the second relation.
- **Notation:** $r \times s$
- **Result:** If $r$ has $n$ tuples and $s$ has $m$ tuples, $r \times s$ will have $n \times m$ tuples.
- **Example:** To find the names of all instructors in the 'Physics' department together with the course ID of all courses they taught:
$\Pi_{name, course\_id}(\sigma_{dept\_name = 'Physics' \land Instructor.ID = Teaches.ID}(INSTRUCTOR \times TEACHES))$
## Join Operations
A Join operation is a high-level operator that combines a Cartesian product with a selection process. It is used to link related data across multiple tables.
### Inner Join
Inner joins only include tuples that satisfy the matching criteria.
#### Theta Join ($\bowtie_\theta$)
The Theta join is a general join where the condition $\theta$ can be any valid comparison predicate.
- **Definition:** $r \bowtie_\theta s = \sigma_\theta(r \times s)$
#### Equi-Join
An Equi-join is a variant of the Theta join where the predicate uses only equality operators ($=$).
#### Natural Join ($\bowtie$)
The natural join is a specialized Equi-join that automatically matches relations on all attributes sharing the same name.
- **Notation:** $r \bowtie s$
- **Properties:** It performs an Equi-join on common attributes and then projects the result to eliminate redundant columns.
- **Example:** Joining `INSTRUCTOR` and `TEACHES` on their shared `ID`:
$INSTRUCTOR \bowtie TEACHES$
### Outer Join
Outer joins extend the inner join by preserving tuples that have no match in the other relation. These missing values are represented as `null`.
- **Left Outer Join ($⟕$):** Includes all tuples from the left relation, padding with nulls where no match exists in the right relation.
- **Right Outer Join ($⟖$):** Includes all tuples from the right relation, padding with nulls where no match exists in the left relation.
- **Full Outer Join ($⟗$):** Includes all tuples from both relations, ensuring no data is lost even if matches are absent.
## Extended Relational Algebra
These operations extend basic relational algebra to provide more powerful data manipulation and summarization capabilities.
### Aggregate Functions
Aggregate functions perform a calculation on a collection of values and return a single value. They are essential for summarizing data.
- **Common Functions:**
- `avg`: returns the average value of a numeric attribute.
- `min`: returns the minimum value.
- `max`: returns the maximum value.
- `sum`: returns the total sum of values.
- `count`: returns the number of values in the collection.
- **Notation:** $_{G_1, G_2, \dots, G_n} \mathcal{G}_{F_1(A_1), F_2(A_2), \dots, F_m(A_m)}(r)$
- $G_1, G_2, \dots, G_n$ is a list of attributes used for grouping (this list can be empty).
- Each $F_i$ represents an aggregate function applied to an attribute $A_i$.
- **Grouping:** When grouping attributes are specified, the relation is partitioned into groups where each group shares the same values for the grouping attributes. The aggregate functions are then applied independently to each group.
- **Example:** To find the average salary of instructors in each department:
$$_{dept\_name} \mathcal{G}_{avg(salary)}(INSTRUCTOR)$$
- **Example:** To find the total number of instructors in the database:
$$\mathcal{G}_{count(ID)}(INSTRUCTOR)$$
- **Renaming Results:** Since aggregate results don't have a default name, it is common practice to use the rename operation ($\rho$) for clarity:
$$\rho_{avg\_salary}(_{dept\_name} \mathcal{G}_{avg(salary)}(INSTRUCTOR))$$