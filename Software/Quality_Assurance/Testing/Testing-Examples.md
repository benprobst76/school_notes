# Pseudocode Testing Examples

This file provides pseudocode examples for various testing concepts discussed in the project notes.

## Black-Box Testing Examples

### System Under Test

```pseudocode
function calculate_ticket_price(age, is_student)
  // Base price is $10
  price = 10

  // Students get a 20% discount
  if is_student is true
    price = price * 0.8

  // Age-based discounts (applied after student discount)
  if age < 18
    // 50% discount for children
    price = price * 0.5
  else if age > 65
    // 30% discount for seniors
    price = price * 0.7

  return price
end function
```

### 1. Equivalence Partitioning

We partition the inputs into valid and invalid classes.

**Age Partitions:**
*   **EP1 (Valid Child):** 0 <= age < 18
*   **EP2 (Valid Adult):** 18 <= age <= 65
*   **EP3 (Valid Senior):** age > 65
*   **EP4 (Invalid):** age < 0

**is_student Partitions:**
*   **EP5 (Valid):** true
*   **EP6 (Valid):** false

**Test Cases:**
```pseudocode
// Test Case 1: Child, not student (EP1, EP6)
test_child_price: assert(calculate_ticket_price(10, false) == 5.0)

// Test Case 2: Adult, student (EP2, EP5)
test_student_price: assert(calculate_ticket_price(30, true) == 8.0)

// Test Case 3: Senior, not student (EP3, EP6)
test_senior_price: assert(calculate_ticket_price(70, false) == 7.0)

// Test Case 4: Invalid age (EP4)
test_invalid_age: assert(calculate_ticket_price(-5, false) throws InvalidInputError)
```

### 2. Boundary Value Analysis (BVA)

We test the boundaries of the equivalence partitions for `age`.

**Boundaries:** 18 and 65

**Test Cases:**
```pseudocode
// Lower boundary for adult
test_age_17: assert(calculate_ticket_price(17, false) == 5.0) // Child
test_age_18: assert(calculate_ticket_price(18, false) == 10.0) // Adult

// Upper boundary for adult
test_age_65: assert(calculate_ticket_price(65, false) == 10.0) // Adult
test_age_66: assert(calculate_ticket_price(66, false) == 7.0) // Senior
```

## White-Box Testing Examples

### System Under Test

```pseudocode
function check_credit(credit_score, loan_amount)
  // Path A
  if credit_score > 600
    // Path B
    if loan_amount < 50000
      return "Approved"
    else
      // Path C
      return "Requires manual review"
  else
    // Path D
    return "Declined"
end function
```

### 1. Statement Coverage

We need to ensure every statement is executed.

**Test Case:**
```pseudocode
// This single test case covers all statements (Paths A, B, C, and D are not all covered)
test_approval: assert(check_credit(700, 20000) == "Approved")
// To cover the other paths, more tests are needed.
test_manual_review: assert(check_credit(700, 60000) == "Requires manual review")
test_decline: assert(check_credit(500, 20000) == "Declined")
```

### 2. Path Coverage

We need to cover all independent paths in the control flow graph.

*   **Path 1:** A -> B (if, if)
*   **Path 2:** A -> C (if, else)
*   **Path 3:** D (else)

**Test Cases:**
```pseudocode
// Test Case for Path 1
test_path_AB: assert(check_credit(650, 40000) == "Approved")

// Test Case for Path 2
test_path_AC: assert(check_credit(650, 60000) == "Requires manual review")

// Test Case for Path 3
test_path_D: assert(check_credit(550, 40000) == "Declined")
```

### 3. Mutation Testing

We introduce a small change (a mutant) and see if our tests fail.

**Original Code:**
`if credit_score > 600`

**Mutant Code:**
`if credit_score >= 600`

**Test Case to Kill the Mutant:**

A test case with `credit_score = 600` will fail for the mutant but pass for the original.

```pseudocode
// This test passes on the original code ("Declined")
// but fails on the mutant code because it would return "Approved"
test_kill_mutant: assert(check_credit(600, 20000) == "Declined")
```

## Levels of Testing Examples

### 1. Unit Test

Testing a single function or component in isolation.

```pseudocode
function is_valid_email(email)
  return email contains "@" and "."
end function

// Test Cases
test_valid_email: assert(is_valid_email("test@example.com") is true)
test_invalid_email_no_at: assert(is_valid_email("testexample.com") is false)
test_invalid_email_no_dot: assert(is_valid_email("test@examplecom") is false)
test_empty_email: assert(is_valid_email("") is false)
```

### 2. Integration Test

Testing the interaction between two or more components.

```pseudocode
// Component 1: AuthService
class AuthService
  function login(username, password)
    // ... logic to verify credentials
    if credentials_are_valid
      user = Database.get_user(username)
      return user
    else
      return null
  end function
end class

// Component 2: OrderService
class OrderService
  function place_order(user, items)
    if user is null
      throw NotLoggedInError
    // ... logic to create an order
    return new Order(user, items)
  end function
end class

// Integration Test
function test_place_order_flow()
  // 1. Arrange
  auth_service = new AuthService()
  order_service = new OrderService()
  
  // 2. Act
  user = auth_service.login("testuser", "password123")
  order = order_service.place_order(user, ["item1", "item2"])
  
  // 3. Assert
  assert(order is not null)
  assert(order.user.username == "testuser")
end function
```
