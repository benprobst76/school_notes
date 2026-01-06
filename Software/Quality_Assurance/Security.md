# Software Security in Quality Assurance

Security is a paramount concern in Software Quality Assurance (SQA), often considered a crucial non-functional quality attribute. It ensures the reliability and safety of software systems and is essential for meeting industry expectations and regulatory compliance (e.g., ISO 27001, NIST, OWASP). Investing in security measures upfront is significantly more cost-effective than remediating breaches or exploits after deployment.

---

## Verification vs. Validation in Security

Just like in general SQA, security assurance involves both verification and validation activities, though with a security-specific focus.

### Verification (Process-Focused, Static)

Verification in security involves checking the software's adherence to secure coding practices and standards *without* executing the code. It's about "Are we building the secure product right?"

*   **Secure Code Reviews**: Manual inspection of code by security experts or peers to identify vulnerabilities and insecure patterns.
*   **Static Application Security Testing (SAST)**: Automated tools that analyze source code, bytecode, or binary code to detect security flaws.
    *   *Example 1*: Detecting hardcoded passwords or API keys in configuration files or source code.
    *   *Example 2*: Checking that all functions handling sensitive credentials adhere to the company's approved cryptography standards and practices.
*   **Secure Coding Standards Compliance**: Ensuring developers follow established secure coding guidelines (e.g., using prepared statements for SQL queries, proper input validation).

### Validation (Product-Focused, Dynamic)

Validation in security involves testing the running application to confirm that it behaves securely and meets security requirements. It's about "Are we building the right secure product?"

*   **Penetration Testing (Pen Testing)**: A simulated cyberattack against the system to find exploitable vulnerabilities.
*   **Dynamic Application Security Testing (DAST)**: Automated tools that test the application in its running state to find runtime vulnerabilities.
    *   *Example 1*: Testing if session cookies expire automatically after a user logs out or after a period of inactivity.
    *   *Example 2*: Attempting to access administrative endpoints with a normal user's credentials to check for privilege escalation vulnerabilities.
*   **Security-Based Test Cases**: Designing and executing specific test cases to confirm security requirements, such as access control, authentication, and data protection.

---

## The Security Terms: Threats and Attacks

A system is considered **secure** if its resources are used and accessed only as intended under all foreseeable circumstances, protecting confidentiality, integrity, and availability.

*   **Security Threats**: Any potential vulnerabilities, weaknesses, or possible negative events that could be exploited by attackers. These aim to gain unauthorized access, steal data, or cause damage to the system.
    *   *Examples*: A known software bug, an open network port, an unpatched server.
*   **Security Attacks**: Any deliberate attempt by an attacker to exploit identified vulnerabilities or breach the security mechanisms of a system.
    *   These can be **intentional** and **malicious**, often involving a third party.
    *   *Examples*: Distributed Denial of Service (DDoS) attacks, social engineering, SQL injection, brute-force login attempts.
    *   **Intruders** (often called crackers or black-hat hackers) are individuals or groups who attempt to breach security to cause harm or gain illicit access.

### The CIA Triad and Threats to Data

The **CIA Triad** (Confidentiality, Integrity, Availability) is a foundational model for information security, identifying the three core principles that should be protected.

*   Refer to [[Network-Security#CIA Triad|CIA Triad]] for a comprehensive overview of the CIA Triad.

**Impact of Loss on Each Principle:**

*   **Loss of Confidentiality**: May lead to the unauthorized disclosure of sensitive information.
    *   *Examples*: Exposure of personal user data, leakage of proprietary business secrets, release of government classified information.
*   **Loss of Integrity**: May lead to unauthorized or improper modification or destruction of data.
    *   *Examples*: Unauthorized transactions being processed, incorrect execution of software logic, corruption of critical data in a database.
*   **Loss of Availability**: May lead to the inaccessibility or denial of service for legitimate users.
    *   *Examples*: Denial of Service (DoS) attacks making a website unreachable, data loss making critical information unavailable.

---

## Sources of Software Security Vulnerabilities

The root cause of the vast majority of software vulnerabilities stems from **bad input handling**. This often includes issues with:

*   **Input Size**: Not properly validating the length of input, leading to buffer overflows or denial-of-service attacks.
*   **Input Interpretation**: Failing to sanitize or validate input content, allowing malicious code or commands to be executed (e.g., SQL injection, cross-site scripting).

**Program input** refers to any data originating outside the program, whose exact value is not known to the programmer in advance. This includes:

*   User input from forms or command lines.
*   Network packets (e.g., HTTP requests, IP packets).
*   Configuration files.
*   Operating system environment variables.

**Defensive/Secure Programming**: The core principle is to **validate all assumptions** and **check for all possible errors** related to input. This means treating all external input as untrusted until it has been thoroughly validated and sanitized.

---

## OWASP Top 10

The **Open Web Application Security Project (OWASP)** publishes a widely recognized list of the ten most critical web application security risks. This list is updated periodically to reflect current threats.

*   For the latest details, refer to the official OWASP Top 10: [https://owasp.org/Top10/](https://owasp.org/Top10/)

The 2023 version of the OWASP Top 10 includes:

*   **A01: Broken Access Control**: Flaws in enforcing access policies, allowing users to perform actions they shouldn't.
*   **A02: Cryptographic Failures**: Inadequate or improper use of cryptography to protect sensitive data.
*   **A03: Injection**: Untrusted data sent to an interpreter as part of a command or query.
*   **A04: Insecure Design**: Flaws in the design or architecture of the application that lead to security vulnerabilities.
*   **A05: Security Misconfiguration**: Improperly configured security settings across the application stack.
*   **A06: Vulnerable and Outdated Components**: Using components with known vulnerabilities.
*   **A07: Identification and Authentication Failures**: Flaws in identity management and authentication.
*   **A08: Software and Data Integrity Failures**: Violations of integrity through malicious data or code.
*   **A09: Security Logging and Monitoring Failures**: Insufficient logging and monitoring to detect and respond to security incidents.
*   **A10: Server-Side Request Forgery (SSRF)**: The web server reads from a specified URL, potentially an internal resource.

*Note: The list provided in the prompt is an older version. I've updated it to reflect common knowledge of the OWASP Top 10.*

## CWE Top 25

The **Common Weakness Enumeration (CWE)** is a community-developed list of common software security weaknesses. The CWE Top 25 is a subset of these, representing the most dangerous and frequently occurring vulnerabilities.

*   For the latest details, refer to the official CWE Top 25: [https://cwe.mitre.org/top25/archive/2024/2024_cwe_top25.html](https://cwe.mitre.org/top25/archive/2024/2024_cwe_top25.html)

Examples of weaknesses often found in the CWE Top 25 include:

*   **Cross-site Scripting (XSS)**: Injecting malicious scripts into web pages viewed by other users.
*   **Out-of-bounds Write / Read**: Accessing memory outside the allocated buffer.
*   **Improper Neutralization of Special Elements used in an SQL Command ('SQL Injection')**: Manipulating SQL queries through input.
*   **Improper Limitation of a Pathname to a Restricted Directory ('Path Traversal')**: Accessing files outside the intended directory.
*   **Improper Neutralization of Special Elements used in an OS Command ('OS Command Injection')**: Injecting and executing operating system commands.
*   **Use After Free**: Using memory after it has been deallocated, leading to crashes or exploits.
*   **Missing Authorization**: Failing to properly check if a user is authorized to perform an action.
*   **Unrestricted Upload of File with Dangerous Type**: Allowing users to upload executable files that can then be run on the server.
*   **Improper Control of Generation of Code ('Code Injection')**: Injecting and executing arbitrary code.
*   **Improper Input Validation**: General failure to validate user-supplied input, leading to various vulnerabilities.

### Example Web Application Vulnerabilities
![[Pasted image 20251130132200.png]]

---

## Static Application Security Testing (SAST)

**SAST** is a "white-box" testing method that analyzes application source code, bytecode, or binary code for security vulnerabilities *without* actually executing the application. It's primarily a **verification** activity.

*   **How it Works**: Scans the code statically, looking for patterns that indicate known vulnerabilities or insecure coding practices.
*   **Benefits**:
    *   **Early Detection**: Catches vulnerabilities early in the Software Development Life Cycle (SDLC), often during development or before deployment, reducing fix costs.
    *   **Comprehensive Code Coverage**: Can analyze 100% of the code, including parts not always executed at runtime.
    *   **Identifies Root Cause**: Pinpoints the exact line of code causing the vulnerability.
*   **Examples of SAST Tools/Scenarios**:
    *   **Tools**: SonarQube, ESLint security plugins, Bandit (for Python), Checkmarx, Fortify.
    *   *Example 1*: Detecting the use of unused or unsafe third-party libraries in Python `requirements.txt` or `package.json` files.
    *   *Example 2*: Flagging JavaScript code that uses `eval()`, which can be a security risk if used with untrusted input.
    *   *Example 3*: Flagging C code that uses `gets()` instead of `fgets()`, which is highly susceptible to buffer overflow vulnerabilities.

## Dynamic Application Security Testing (DAST)

**DAST** is a "black-box" testing method that analyzes a running application to find security vulnerabilities. It simulates external attacks and observes the application's behavior. It's primarily a **validation** activity.

*   **How it Works**: Interacts with the application through its front-end (web UI or API), sending various malicious inputs and analyzing the responses.
*   **Benefits**:
    *   **Finds Runtime Vulnerabilities**: Effective at discovering issues that only manifest when the application is running, such as misconfigurations, authentication issues, and server-side logic flaws.
    *   **Language Agnostic**: Can test any web application regardless of its underlying technology stack.
*   **Examples of DAST Tools/Scenarios**:
    *   **Tools**: OWASP ZAP (Zed Attack Proxy), Burp Suite, Acunetix, Netsparker.
    *   **Focus**: Input validation, session handling, authentication and authorization, access control mechanisms.
    *   *Example 1*: Testing if an unauthenticated user can successfully call a supposedly protected API endpoint.
    *   *Example 2*: Simulating cross-site scripting (XSS) attacks by injecting `<script>alert(1)</script>` into various input fields to see if the script executes.

## Manual Security Testing

While automated tools are powerful, manual security testing provides depth and context that tools often miss.

*   **Attack Surface Analysis**: Systematically identifying all potential entry points and vulnerabilities that an attacker could exploit.
*   **Input Fuzzing**: Supplying unexpected, malformed, or random data to inputs to trigger crashes or unexpected behavior.
*   **Authentication & Authorization Checks**: Manually testing all aspects of login, session management, role-based access, and privilege escalation.
*   **Session Management Tests**: Analyzing how sessions are created, maintained, and destroyed, looking for session fixation, hijacking, or weak session IDs.
*   **Error/Exception Handling Evaluation**: Checking how the system responds to errors, ensuring sensitive information (like stack traces, database schemas) is not leaked to users.
*   *Example 1*: Trying to manipulate or inject random values into cookie parameters to break session handling or gain unauthorized access.
*   *Example 2*: Intentionally dropping a database connection to see if the system leaks sensitive debug information or crashes gracefully.

---

## Threat Modeling

**Threat modeling** is a structured approach to identifying potential security threats, vulnerabilities, and countermeasures within a system early in the development lifecycle.

*   **Process**: It typically involves identifying assets, potential threats to those assets, and the trust boundaries within the system.
*   **Techniques**:
    *   **STRIDE**: A mnemonic for Spoofing, Tampering, Repudiation, Information Disclosure, Denial of Service, and Elevation of Privilege.
    *   **DFDs (Data Flow Diagrams)**: Visualizing how data moves through a system helps identify trust boundaries and potential interception points.
    *   **Attack Trees**: A hierarchical diagram that breaks down a high-level attack goal into more specific sub-goals, representing different ways an attack could be executed.
    *   **Risk-based Test Design**: Using threat modeling output to inform the creation of security test cases that prioritize the most critical risks.

### Threat Modeling - STRIDE

STRIDE is a common threat modeling methodology, categorizing threats by their impact on the system:

*   **S - Spoofing**: Can an attacker successfully pretend to be another user, system, or entity (e.g., via weak login mechanisms)?
*   **T - Tampering**: Can someone maliciously modify data within the system or in transit (e.g., altering a JSON Web Token to change permissions)?
*   **R - Repudiation**: Can a user or system deny having performed an action, and can we reliably prove otherwise (e.g., are user actions properly logged and auditable)?
*   **I - Information Disclosure**: Can sensitive information be accessed by unauthorized individuals (e.g., are error logs printing sensitive system details like database connection strings)?
*   **D - Denial of Service (DoS)**: Can an attacker prevent legitimate users from accessing the system or its resources (e.g., by overwhelming the API with requests)?
*   **E - Elevation of Privilege**: Can an attacker gain higher access privileges than they are authorized for (e.g., can a normal user modify their request to become an administrator)?

### Threat Modeling - Attack Tree
![[Pasted image 20251130132318.png]]

---

## Secure Coding Standards - Examples

Adhering to secure coding standards is a preventative measure against common vulnerabilities. Examples include:

*   **Input Validation**: Enforce rigorous input validation for all user-supplied data, e.g., using prepared statements in SQL queries to prevent SQL Injection.
*   **Password Management**: Require all passwords to be hashed using strong, modern, adaptive hashing algorithms like bcrypt or Argon2, not outdated ones like MD5 or SHA1.
*   **Cryptography**: Ban the usage of weak or broken cryptographic functions (e.g., MD5, SHA1 for hashing, old TLS versions). Use established, reviewed cryptographic libraries.
*   **Error Handling**: Enforce "fail secure" error handling. This means never leaking sensitive information like stack traces, debugging messages, or database errors to end-users. Instead, provide generic error messages and log details internally.
*   **Secret Management**: Prohibit hard-coding API keys, credentials, and other sensitive secrets directly into the code. Use secure environment variables, secrets management services, or dedicated configuration management.
*   **Principle of Least Privilege**: Ensure that components, services, and users operate with the minimum necessary permissions to perform their function.

---

## Designing Security Test Cases

Effective security testing requires designing specific test cases to cover known vulnerabilities and security requirements.

*   **Negative Testing**: Focus on invalid inputs and unexpected scenarios.
    *   *Examples*: Attempting to log in with blank, incorrect, or SQL injection-laden usernames and passwords.
    *   Uploading files with invalid MIME types or malicious content.
    *   Adding items to a shopping cart with negative quantities.
*   **Boundary Tests**: Test the limits of expected input ranges and data sizes.
    *   *Examples*: Testing a 255-character username if the field limit is 256.
    *   Inputting the maximum allowed length for a password field.
    *   Attempting to upload an oversized file (exceeding allowed size limits).
*   **Trusted vs. Untrusted Input Equivalence Classes**: Divide inputs into trusted and untrusted categories and design tests specifically for the untrusted ones.
*   **Fuzz Tests**: Automatically generate large numbers of invalid, unexpected, or random inputs to stress the system and uncover vulnerabilities.
*   **Regression Tests**: Re-running security tests for previously discovered and fixed vulnerabilities to ensure they haven't been reintroduced.

### Example Security Requirements in an SRS (Software Requirements Specification)

Security requirements should be clearly defined, testable, and integrated into the SRS.

1.  **Authentication**
    1.1 **User Login**:
    *   The system *must* enforce multi-factor authentication (MFA) for all user roles.
    *   Passwords *must* comply with the following rules:
        *   Minimum length of 12 characters.
        *   Contain at least one uppercase letter, one lowercase letter, one number, and one special character.
        *   Passwords *must* be hashed using a strong, adaptive algorithm (e.g., bcrypt with a cost factor of 12).
    1.2 **Session Management**:
    *   User sessions *must* expire after 15 minutes of inactivity.
    *   All session tokens *must* be securely stored and transmitted using HTTP-only and Secure flags for cookies.
    *   The system *must* support logout functionality that immediately invalidates the current session token.

### Designing Security Test Cases - Examples (Continued)

Based on the above requirements, here are further examples of test cases:

*   **Negative Test Cases**:
    *   Attempt to log in with a blank username and password.
    *   Attempt to upload a file but with an invalid MIME type (e.g., an executable disguised as an image).
    *   Attempt to add an item to the cart with a negative quantity or an extremely large quantity.
*   **Boundary Security Tests**:
    *   Test inputting a 255-character username if the database field is NVARCHAR(256).
    *   Test password input with the maximum allowed length, and then with a length exceeding the maximum.
    *   Attempt to upload a file that is slightly larger than the allowed size limit.

---

## Penetration Testing vs. Security Testing

While often used interchangeably, there's a distinction in practice:

*   **Penetration Testing**:
    *   **Offensive Simulation**: Aims to simulate a real-world attack scenario.
    *   **Goal**: To discover and exploit vulnerabilities to reveal real-world exploit paths and assess the true business risk. It's often time-boxed and goal-oriented.
*   **Security Testing (in SQA context)**:
    *   **Structured Tests**: Part of the broader SQA process, involving systematic testing based on security requirements.
    *   **Goal**: To confirm that security requirements and standards are met, and to identify specific vulnerabilities. It's generally more comprehensive in covering defined requirements.

---

## Security Metrics

Tracking security metrics helps organizations understand their security posture and the effectiveness of their security practices.

*   **Number of vulnerabilities found per sprint/release**: Indicates the effectiveness of preventative measures and testing.
*   **Mean Time to Detect (MTTD)**: The average time it takes to detect a security incident. Lower is better.
*   **Mean Time to Fix (MTTF)**: The average time it takes to remediate a detected vulnerability. Lower is better.
*   **Percentage of code scanned by SAST/DAST**: Measures the coverage of automated security analysis.
*   **Defect leakage (security-related)**: The number of security defects found in production that were missed in earlier stages.

## Threats and Attacks on Databases

Databases are critical assets and frequent targets for attackers. A prominent attack vector is **SQL Injection**.

*   **SQL Injection**: Occurs when untrusted input is directly concatenated into SQL queries without proper sanitization or parameterization. This allows attackers to manipulate database queries, leading to unauthorized data access, modification, or deletion, and sometimes even remote code execution.

---

## Questions for Reflection

*   Which security risks are most critical for your project, given its domain, data, and user base?
*   How could you integrate security checks into your design phase and throughout the development lifecycle?
*   What tools would be most beneficial for your team to enhance security assurance efforts?

---

## Summary

*   **Security Testing** is an essential and non-negotiable part of software quality assurance.
*   Embrace **Security by Design**, integrating security considerations from the very first stages of development.
*   Leverage a combination of **tools, standards, and structured practices** (like SAST, DAST, threat modeling, secure coding guidelines) to build robust and resilient software systems.
