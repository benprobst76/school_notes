## E2E Testing & Application Containerization
Ben Probst - 202284512 - November 25th 2026
### E2E Testing Approach
E2E testing was implemented using Playwright. This setup enables automated testing of user flows in a browser to validate the functionality from a user's perspective. The script `run_e2e_tests.sh` provides commands to run these tests in different modes (e.g., headless, headed, slow-motion).
**Tested Features:**
1. **Homepage Loading:** Verifies that the main page loads successfully by checking its title.
2. **Navigation:** Ensures users can navigate from the homepage to the book catalog.
3. **Catalog Display:** Confirms that the book catalog displays a list of books with all details, including columns for ID, Title, Author, ISBN, and Availability.
4. **Book Borrowing:** Simulates the full process of borrowing a book:
	* Finds an available book in the catalog.
	* Enters a valid patron ID.
	* Submits the request and verifies the action was successful.
5. **Input Validation:** Tests borrowing a book with an invalid patron ID, ensuring the form prevents submission.
**Assertions:**
The tests use Playwright's `expect` function to make assertions about the state of the web application.
* `expect(page).to_have_title()`: To verify the correct page is loaded.
* `expect(locator).to_be_visible()`: To ensure UI elements are rendered.
* `expect(locator).to_contain_text()`: To check for correct content display.
* `expect(page).to_have_url()`: To confirm navigation was successful.
* `expect(locator).to_have_attribute()`: To validate form controls and other element properties.
### Execution instructions
The E2E tests can be executed using the `run_e2e_tests.sh` script, which provides a menu-driven interface for different test modes. Alternatively, you can run `pytest` directly to run all tests.
**Building and Running the Docker Container:**
1. **Build the Docker image:**
```bash

docker build -t library-management-app .

```
2. **Run the Docker container:**
```bash

docker run -d -p 5000:5000 --name library-app library-management-app

```
### Test Case Summary
| Test Case Name                           | Description                                                                                                                                            | Feature(s) Covered               |
| :--------------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------- |
| `test_homepage_title`                    | Verifies that the application's homepage loads correctly and displays the expected title.                                                              | Homepage Loading                 |
| `test_borrow_book_user_flow`             | Simulates a successful book borrowing process, from finding an available book to confirming the borrowing action.                                      | Book Borrowing                   |
| `test_borrow_book_invalid_patron_id`     | Assesses the system's handling of invalid patron ID input during the book borrowing process, ensuring client-side validation.                          | Input Validation, Book Borrowing |
| `test_navigate_to_catalog_from_home`     | Checks the navigation flow, ensuring users can successfully reach the book catalog page from the homepage.                                             | Navigation                       |
| `test_catalog_displays_book_information` | Confirms that the book catalog page accurately displays all relevant book details for each entry, including ID, Title, Author, ISBN, and Availability. | Catalog Display                  |
### Dockerization Process
```

(venv) benprobst@Mac CISC327-CMPE327-F25 % docker build -t library-management-app .
[+] Building 8.1s (10/10) FINISHED docker:desktop-linux
=> [internal] load build definition from Dockerfile 0.0s
=> => transferring dockerfile: 174B 0.0s
=> [internal] load metadata for docker.io/library/python:3.11-slim 0.5s
=> [auth] library/python:pull token for registry-1.docker.io 0.0s
=> [internal] load .dockerignore 0.0s
=> => transferring context: 2B 0.0s
=> [1/4] FROM docker.io/library/python:3.11-slim@sha256:193fdd0bbcb3d2ae612bd6cc3548d2f7c78d65b549fcaa8af 0.0s
=> => resolve docker.io/library/python:3.11-slim@sha256:193fdd0bbcb3d2ae612bd6cc3548d2f7c78d65b549fcaa8af 0.0s
=> [internal] load build context 0.1s
=> => transferring context: 245.22kB 0.1s
=> CACHED [2/4] WORKDIR /app 0.0s
=> [3/4] COPY . /app 0.1s
=> [4/4] RUN pip install --no-cache-dir -r requirements.txt 4.4s
=> exporting to image 3.0s
=> => exporting layers 2.4s
=> => exporting manifest sha256:ad7b3471440d30e7ebce63dd228385482fb055442248b90407d8c04c47c8c75f 0.0s
=> => exporting config sha256:e39a3db7de8df78f1b1263482580c621842cd70c59a7fd0ac46cf48691598321 0.0s
=> => exporting attestation manifest sha256:f47e6dd764aa2e7861979e5ad0bdf5ef4c95e6cf7bc7e9089ac5a57f87b45 0.0s
=> => exporting manifest list sha256:6671c230b921b2f7d82d1756f374d1631873b938288a0663791b7249efaafcd0 0.0s
=> => naming to docker.io/library/library-management-app:latest 0.0s
=> => unpacking to docker.io/library/library-management-app:latest
benprobst@Mac CISC327-CMPE327-F25 % docker run -d -p 5001:5001 --name library-app library-management-app
98af1ccb6bab90ba3d7d4b081c7c856d0fcff8fa8e494fff6af88aa81ad629c4
```
### Docker Hub Deployment
https://hub.docker.com/repository/docker/benprobst76/library-management-app/general
![[Pasted image 20251125131124.png]]
```

benprobst@Mac CISC327-CMPE327-F25 % docker tag library-management-app benprobst76/library-management-app:v1
benprobst@Mac CISC327-CMPE327-F25 % docker push benprobst76/library-management-app:v1
The push refers to repository [docker.io/benprobst76/library-management-app]
3d844a11c759: Pushed
b89cf3ec7a3e: Pushed
89477b9ce6a6: Pushed
158b441f91fd: Pushed
44032d6d082a: Pushed
e4319641e308: Pushed
efa5fb8ff839: Pushed
a2d286c11fe9: Pushed
v1: digest: sha256:473ffcf00f521bdebe3c68a6f17f85cbf3692b005d92b0be1c01c3d960aa15b0 size: 856
benprobst@Mac CISC327-CMPE327-F25 % docker stop library-app
library-app
benprobst@Mac CISC327-CMPE327-F25 % docker rm library-app
library-app
benprobst@Mac CISC327-CMPE327-F25 % docker rmi benprobst76/library-management-app:v1
Untagged: benprobst76/library-management-app:v1
benprobst@Mac CISC327-CMPE327-F25 % docker pull benprobst76/library-management-app:v1
v1: Pulling from benprobst76/library-management-app
Digest: sha256:473ffcf00f521bdebe3c68a6f17f85cbf3692b005d92b0be1c01c3d960aa15b0
Status: Downloaded newer image for benprobst76/library-management-app:v1
docker.io/benprobst76/library-management-app:v1
benprobst@Mac CISC327-CMPE327-F25 % docker run -d -p 5001:5001 --name library-app library-management-app
5bec7974de24fea87bd8dcc6f1035c9188bcd9a70c598ab4463ab390acd30ea4
benprobst@Mac CISC327-CMPE327-F25 % docker ps
CONTAINER ID IMAGE COMMAND CREATED STATUS PORTS NAMES
5bec7974de24 library-management-app "python app.py" 5 seconds ago Up 5 seconds 0.0.0.0:5001->5001/tcp, [::]:5001->5001/tcp library-app
```
### Challenges and Reflections
During the implementation of E2E tests, two primary challenges were encountered. Initially, CI pipelines failed because the Flask server, required for Playwright tests, was not started before the tests attempted to connect. This was addressed by a `time.sleep()` period in the test setup to allow the server time to initialize. Additionally, understanding the actions of the Playwright tests, especially during debugging, proved difficult in headless mode. This was resolved with Playwright's `--slowmo` option when running tests in non-headless mode, which allowed me to observe and debug test flows.