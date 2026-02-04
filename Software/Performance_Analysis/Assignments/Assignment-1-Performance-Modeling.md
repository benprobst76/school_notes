## Overview
The goal of this project is to demonstrate the ability to model the performance of an e-business website using [[Software-Execution-Model#Use Cases|Use Cases]], [[UML#Sequence Diagrams|Sequence Diagrams]], and [[Software-Execution-Model]] techniques.

## Background
The architecture of a typical e-business site consists of:
- **Web Server:** Supports HTTP, serves home pages, and launches dynamic programs (CGI, servlets).
- **Application Server:** Implements business logic (e.g., searching catalogs).
- **Database Server:** Manages persistent storage and efficient data access.
- **Payment Server:** Handles online payments and monetary transfers.
### Online Bookstore Functions
1. **Home Page & Browsing:** Connect to home page and browse by category.
2. **Search:** Search by keywords, author, or ISBN.
3. **Select Book:** View details (description, price, shipping, reviews).
4. **Register:** New customer registration (username, password, payment info).
5. **Login:** Authenticate with username and password.
6. **Add to Cart:** Add items to the shopping cart.
7. **Pay:** Complete purchase for items in the cart.

## Miscellaneous Notes
- Servers (Web, Application, Database, Payment) are located on different computers.
- The probability of requests for static pages to the Web Server is $56\%$.

### Table 1: Average number of visits for each function
| Function | Visit Ratio (requests/sec) |
| :--- | :--- |
| Entry | 1.000 |
| Home | 1.862 |
| Browse | 2.303 |
| Search | 2.193 |
| Login | 0.274 |
| Pay | 0.058 |
| Register | 0.196 |
| Add to Cart | 0.193 |
| Select | 0.919 |
| Exit | 1.000 |

## Deliverables
1. An introduction explaining SPE and performance modeling. The report should also present the reasons for using SPE to model the performance of this online bookstore. 
2. Show the high-level structure of the online bookstore, which contains major functional components, their relationships on how the components interact with each other. Please also provide detailed design of the online bookstore which specifies the internal elements of all major system components, their properties, relationships and often their algorithms and the data structures. In your detailed design, please design the classes needed to implement a system 3 component and provide methods and data attributes contained within each class. Please provide description (e.g., the functionality, signature, parameters and return types) for each method and data attributes.
3. Select all the critical use cases for performance and explain the criteria for your selection.
4. You can create pick at most 3 critical use cases and create a sequence diagram for each of the identified critical use case. These diagrams should make use of references which can be expanded for more detail. 
5. A software execution model for each sequence diagram you created. You will need to add resource estimates for each node of your software execution model and solve the model. The processing overhead matrix is based on table 5-1 from the course’s textbook. 
6. Create a deployment diagram to show the distribution of the components of the on-line bookstore of your design. 
7. A conclusion which explains your findings and recommendations for the corporation deploying the online bookstore. You should also discuss any troubling performance problems you uncovered through the model that you created

### Table 5-1: Web Server Computer Resource Requirements
The processing overhead matrix is based on the following values:

| Devices | CPU | Disk | Delay | GINet |
| :--- | :--- | :--- | :--- | :--- |
| **Quantity** | 1 | 1 | 1 | 1 |
| **Service Units** | K Instr. | I/Os | Visits | Msgs. |
| **WorkUnits** | 25 | | | |
| **DB** | 500 | 4 | | |
| **Msgs** | 25 | 1 | | 1 |
| **Delay** | | | 1 | |

**Service Times (sec):**
- **CPU:** $0.000001$
- **Disk:** $0.05$
- **Delay:** $0.5$
- **GINet:** $0.1$
