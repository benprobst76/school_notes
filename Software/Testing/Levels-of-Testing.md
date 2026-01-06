Most checks start at unit test, contracts at integration test and start-to-finish goal flow test at System/E2E test. Tells when in the lifecycle you test, and what size of the system you test.
- Unit Testing: smallest pieces of code (functions, classes).  
- Integration Testing: interactions between modules/services.  
- System Testing: whole system end-to-end.  
- Acceptance Testing: validation against user/business requirements. 
## Unit
Small and fast; deterministic; heavy on mocks/fakes 
- Deterministic to make sure same result every time  the code runs under the same conditions  
-  Used for algorithms, validators (e.g. email formats), pure functions, error handling  
- Evidence: assertions + coverage; mutation on core logic

| Language           | Popular Tools                       |
| ------------------ | ----------------------------------- |
| Java               | JUnit (Very widely adopted), TestNG |
| .Net (C#)          | NUnit, xUnit.net                    |
| Python             | Pytest, unittest (PyUnit)           |
| C++                | CppUnit, GoogleTest (GTest)         |
| JavaScript/Node.js | Jest, Mocha                         |

#### Example
```
def is_valid_password(pwd):  
	if len(pwd) < 8:  
		return False  
	if not any(c.isdigit() for c in pwd):  
		return False  
	return True
```
Example with pwd = "abc1":  
-  "a".isdigit() → False  
- "b".isdigit() → False  
- "c".isdigit() → False  
- "1".isdigit() → True
![[Pasted image 20251019103549.png]]
## Integration
Integration testing (a.k.a. component testing) verifies that the groups of units corresponding to  
architectural elements of the design specification can be integrated to work as a whole  
- Integration tests = test interactions between pieces (database + API, frontend + backend, etc.).
- Check and verify module boundaries: DB <-> ORM, service <-> service, API <-> queue
	- Boundaries are the ones where two distinct systems meet
-  Real dependencies at boundary; fakes outside scope
- Evidence: contract tests, schema validation, idempotency checks
	- Idempotency checks = If you retry the same request (e.g., POST /pay order=123), the result should not double-charge the customer.
#### Example 1 
Integration of Cart + Payment + Order services.
The sequence: add items → calculate total → charge payment → create order.
Each service on its own may pass unit tests, but this test ensures they work together correctly.
```
def test_checkout_flow():
    # Arrange
    cart = CartService()
    cart.add_item("Laptop", 1000)
    cart.add_item("Mouse", 50)
    payment = PaymentService(fake_gateway=True)  # using fake, not real bank
    order_service = OrderService(database="test_db")
    
    # Act
    total = cart.calculate_total()     # should be 1050
    result = payment.charge("4111111111111111", total)
    order = order_service.create_order("user123", cart.items, result)
    
    # Assert
    assert total == 1050
    assert result["status"] == "success"
    assert order["status"] == "confirmed"
```
The above example follows the principle “**Real deps at boundary; fakes outside scope**”. At the boundary between two modules/systems, you want to use the real **dependency**, because the goal is to check that integration point is working. e.g., If you’re testing your app ↔ database, you actually connect to a real test database. However, for outside the boundary (out of scope) issues, you can use fakes/mocks/stubs so your test stays focused. For example: If the database itself calls an external payment API, but your current test isn’t about that API, you replace it with a fake.
#### Example 2
Testing the flow where a user logs in.
Modules involved: AuthService (code), DB containing user credentials, and Email service (sends login alerts)
Integration test boundary here: AuthService ↔ Database
```
def test_login_success():  
    db = RealTestDB()  
    auth = AuthService(db)  
    email = FakeEmailService()  
      
    db.insert_user("john", "secure123")  
    result = auth.login("john", "secure123")  
      
    assert result["status"] == "ok"  
    assert result["user"] == "john"
```
**Real dep**: Use a real test database, since we want to verify that password checks, queries, and ORM work.
**Fake**: Use a fake Email service so you don’t actually send emails. The test code:
## System/E2E
System testing verifies that the complete product meets the functional specification  
- Validate critical flows across stack, e.g. signup, login, checkout, password reset  
 - Validating end-to-end flows that a real user would go through
- The tests assert the end result and key side-effects  
- Prefer API-level where possible; UI is last one  
- Evidence: screenshots/videos, HTTP traces, DB state diffs

A system test for checkout would do the following 
1. Open the website/app as a user.
2. Add an item to the cart.  
3. Proceed to checkout.  
4. Enter payment details.  
5. Confirm order.  
6. Validate that:  
	- The order confirmation page shows up.  
	- Payment is recorded in the DB.  
	- Confirmation email is sent.  
	- This covers the whole stack, not just isolated parts.
### Non-Functional Levels
- Performance, throughput, resource use  
- Security (authentication, input validation, dependency scans)  
- Reliability/Resilience (chaos, retries); usability