https://github.com/benprobst76/cmpe327-library-management-a2-4512
### Complete Function Implementation
All the remaining functions have been fully implemented. I was able to complete the implementation by only modifying the library_service.py and removing the "not implemented" warnings from the html files. Some assumptions had to be made on the implementation. For example get_patron_status_report includes all fees in the patrons history. R7 asks for "Total late fees owed" which was interpreted as sum of fees that are currently outstanding plus any unpaid fees from returned items. Since the system does not track payments, all fees owed will stay outstanding. 

### Comprehensive Test Suite Development
Completed in Assignment 1

### AI-Assisted Test Generation
Prompt Used: (Grok Code Fast 1 from VSCode Copliot Plugin)
```
Using the requirements specification, create comprehensive test cases for all the functionalities and put them in the tests/ai_tests directory. Disregard any tests already implemented in the student_tests dir.
```
The AI successfully generated a comprehensive test suite for all the functions according to the requirements_specification.md. Some errors were generated in the test cases but because it was using copilot agent mode it continued to run the test cases itself and fix the errors. 

Because I used VSCode Copilot the test cases generated were automatically added to the code space in their own files. To avoid having to copy and paste they are here: https://github.com/benprobst76/cmpe327-library-management-a2-4512/tree/main/tests/ai_tests
### Test-Case Comparison & Analysis

The test cases were useful and identified errors in the implementations for add_book_to_catalog, borrow_book_by_patron, calculate_late_fee_for_book and search_books_in_catalog. For add_book_to_catalog I had to add a condition checking that the ISBN contains only digits. For borrow_book_by_patron I had to add a check for if the patron already has this book borrowed. For calculate_late_fee_for_book the days overdue was not calculated correctly. For search_books_in_catalog I had to add a check for empty search term (although the UI blocks this). 

Overall the test cases were much more exhaustive in there coverage compared to my test cases. For example the test cases included trialing whitespace and empty fields which should not be possible given the UI. However the tests cases were very useful as writing test cases manually is an arduous and repetitive task. 

### CI/CD Pipeline
ci.yaml runs the tests on various python versions and operating systems.
https://github.com/benprobst76/cmpe327-library-management-a2-4512/actions/workflows/ci.yaml
