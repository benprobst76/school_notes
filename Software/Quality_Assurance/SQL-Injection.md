## The Problem: Trusting User Input
In the real world, while most users are well-intentioned, malicious actors exist who will try to exploit vulnerabilities in your application. A fundamental principle of secure coding is to **never trust user input by default**.
*   Users will not always submit data in the format your application expects. This can be unintentional (e.g., names with apostrophes like "O'Neal") or malicious.
*   All sources of external data should be considered untrusted, including URL parameters, form data, cookies, and API inputs.
## What is SQL?
SQL (Structured Query Language) is the standard language for interacting with relational databases like MySQL, PostgreSQL, SQL Server, and Oracle. It's used to create, retrieve, update, and delete data.
### SQL Data Model
Data in a relational database is stored in tables, which are like spreadsheets.
*   A table consists of rows (records) and columns (attributes).
*   Each row represents a single entity (e.g., a user, a product).
*   All records in a table have the same set of attributes.

**Example `users` Table:**

| User ID | First_Name | Last_Name | Email    | SIN         |
| :------ | :--------- | :-------- | :------- | :---------- |
| 1       | John       | Taylor    | JS@a.com | 123-456-789 |
| 2       | Adam       | Taylor    | AT@a.com | 987-654-321 |
### SQL `SELECT` Statement
The `SELECT` statement is used to retrieve data.
`SELECT SIN FROM users WHERE User_ID = '1'`
This query retrieves the `SIN` for the user with `User_ID` 1, which is `123-456-789`.
`SELECT SIN FROM users WHERE Last_Name = 'Taylor'`
This would return both SINs: `123-456-789` and `987-654-321`.

## SQL Injection Attacks
SQL Injection is a code injection technique where an attacker inserts malicious SQL code into an application's queries. This is possible when the application does not properly sanitize user input and instead directly concatenates it into a SQL string.

**Impact of SQL Injection:**
*   **Retrieve Unauthorized Data:** Dump the contents of the entire database.
*   **Modify Data:** Delete or alter records in the database.
*   **Gain Administrative Control:** Execute administrative commands on the database server.

### Example: Bypassing Authentication
Consider a login form in a PHP application that builds a query like this:
```php
$query = "SELECT * FROM `users` WHERE name = '" + $user_name + "';";
```
*   **Normal Input:** If a user enters `Scott Grant`, the query becomes:
    ```sql
    SELECT * FROM `users` WHERE name = 'Scott Grant';
    ```
*   **Malicious Input:** An attacker enters `' OR 1=1 --` as their username. The application constructs the following query:
    ```sql
    SELECT * FROM `users` WHERE name = '' OR 1=1 --';
    ```
    *   The `name = ''` part is false, but the `OR 1=1` is always true, so the `WHERE` clause evaluates to true for *every single row*.
    *   The `--` is a comment in SQL, which causes the database to ignore the rest of the line, including the closing single quote (`'`).
    *   **Result:** The query returns all users from the `users` table, and the attacker bypasses authentication, often logging in as the first user in the table (frequently an admin).

### Example: Destroying Data
An even more dangerous attack uses a similar vulnerability to modify the database.
*   **Malicious Input:** An attacker enters `'; DROP TABLE `users`; --`
*   **Resulting Query:** The application constructs two separate, valid SQL statements:
    ```sql
    SELECT * FROM `users` WHERE name = '';
    DROP TABLE `users`;
    --';
    ```
    *   The first query will likely return nothing.
    *   The second command, `DROP TABLE `users``, will be executed, deleting the entire `users` table.

## Attacker Tools
Attackers don't always perform these attacks manually. Automated tools make it easy to find and exploit these vulnerabilities.
*   **sqlmap:** An open-source penetration testing tool that automates the process of detecting and exploiting SQL injection flaws and taking over database servers.
*   **sqlsus:** A similar tool focused on MySQL, designed for speed.
*   **SQLdict:** A dictionary attack tool for brute-forcing passwords on SQL Server.

## Preventing SQL Injection
The application layer is responsible for preventing SQL injection. Never rely on the database alone to protect itself.

### 1. Use Parameterized Queries (Prepared Statements)
This is the **most effective** way to prevent SQL injection. The SQL query is sent to the database separately from the user-provided parameters. The database pre-compiles the query template and then safely inserts the parameters into it, treating them strictly as data, not executable code.

**Example (Java JDBC):**
```java
String sql = "SELECT * FROM users WHERE username = ?;";
PreparedStatement stmt = connection.prepareStatement(sql);
stmt.setString(1, username); // User input is bound as a parameter
ResultSet rs = stmt.executeQuery();
```

**Example (Python with `mysql-connector`):**
```python
cursor = cnx.cursor()
query = "SELECT * FROM users WHERE username = %s"
cursor.execute(query, (username,)) # User input is passed as a tuple
```
The database engine *knows* that the `?` or `%s` is a placeholder for data and will not interpret any SQL commands within the `username` variable.

### 2. Sanitize and Escape User Input
If you cannot use parameterized queries, you must sanitize user input by "escaping" special characters. This tells the database to treat them as literal parts of a string rather than as special SQL characters.

**Example:**
*   **User Input:** `O'Neal`
*   **Escaped Input:** `O\'Neal`
*   **Resulting Query:**
    ```sql
    SELECT * FROM users WHERE name = 'O\'Neal';
    ```
    The `\'` ensures the apostrophe is treated as part of the name, not as the end of the string.

*   **Malicious Input:** `' OR 1=1 --`
*   **Escaped Input:** `\' OR 1=1 --`
*   **Resulting Query:**
    ```sql
    SELECT * FROM users WHERE name = '\' OR 1=1 --';
    ```
    The injection payload is now just a literal string, and the query will search for a user with that exact, strange name (and likely find nothing).

### 3. Enforce Strong Typing
Always validate that the data is of the expected type on the server-side.
*   If a variable should be a number, ensure it is a number. If an attacker tries to submit `1; DROP TABLE users`, it is clearly not a valid integer, and the application should reject it.
```php
$query = "SELECT * FROM `users` WHERE id = " + $user_id + ";";
```
If `$user_id` is validated as an integer, an injection is impossible.

### 4. Whitelist Valid Input
Instead of trying to blacklist what's *invalid* (a losing game), define exactly what is *valid*.
*   **Length:** Limit the maximum length of input fields.
*   **Format:** Use regular expressions or other methods to enforce strict formats for things like email addresses, usernames, and passwords.
*   **Range:** For numbers, check that they fall within a reasonable range (e.g., `Age` shouldn't be 65589).
*   **Important:** Always perform validation on the **server-side**. Client-side validation (in JavaScript) is for user experience only and can be easily bypassed.

### 5. Apply the Principle of Least Privilege
Do not connect to the database using an all-powerful `root` or `admin` account.
*   Create dedicated database user accounts for each application.
*   Grant these accounts the minimum permissions they need to function. For example, a web application's user account that only reads data should not have `UPDATE`, `INSERT`, or `DELETE` permissions on sensitive tables. It certainly should not have permission to `DROP` tables or databases.

Fundamentally, it is the application's role to defend against SQL injection attacks.
