# C++ Overview for Distributed Systems
C++ was created by Bjarne Stroustrup in 1979 as "C with Classes," evolving into a multi-paradigm language fundamental for [[Introduction|Distributed Systems]] due to its performance and resource control.
## File Structure
Organizing code is critical in large distributed systems.
- **Header Files (`.hpp` / `.h`)**: Contain class declarations, function prototypes, and templates. Must use include guards to prevent multiple inclusion.
```cpp
#ifndef POINT_HPP
#define POINT_HPP
class Point { /*...*/ };
#endif
// OR
#pragma once
```
- **Source Files (`.cpp`)**: Contain implementation logic.
- **Compilation**: Headers are included; source files are compiled and linked.
## Namespaces
Namespaces prevent name collisions, essential when integrating multiple libraries (e.g., networking, serialization).
```cpp
namespace DistSys {
    class Node { /* ... */ };
}
DistSys::Node n; // Access via scope resolution
using namespace DistSys; // Optional: imports all names
```
## Classes and Objects
Classes encapsulate data and behavior. Access modifiers control visibility:
- `public`: Accessible from anywhere.
- `private`: Accessible only within the class.
- `protected`: Accessible within the class and derived classes.
```cpp
class Server {
private:
    int port;
public:
    Server(int p) : port(p) {}
    void start() { /* logic */ }
};
```
### The `this` Pointer and Method Chaining
The `this` keyword is a hidden pointer passed to all non-static member functions, pointing to the invoking object. It allows for **Method Chaining** by returning a reference to the object.
```cpp
class Message {
    std::string body;
    int id;
public:
    Message& setBody(std::string b) {
        this->body = b;
        return *this; // Returns reference to current object
    }
    Message& setId(int i) {
        this->id = i;
        return *this;
    }
};
// Usage
Message m;
m.setId(1).setBody("HELLO");
```
### Friend Functions
A `friend` function is a non-member function that is granted access to a class's private and protected members. Useful for operator overloading or testing.
```cpp
class Box {
    int width;
public:
    friend void printWidth(Box b);
};
void printWidth(Box b) {
    std::cout << b.width << std::endl; // Can access private 'width'
}
```
## Parameters and Overloading
### Parameter Passing
Efficient data movement is key in high-performance systems.
- **Pass by Value**: Copies the object. Expensive for large objects.
- **Pass by Reference (`&`)**: Passes memory address but uses object syntax. Efficient.
- **Pass by Const Reference (`const &`)**: Efficient and read-only. Safe for large objects.
```cpp
void process(const std::string& data); // Efficient, read-only
void update(int& counter);             // Can modify original
```
### Overloading
C++ allows multiple functions or operators with the same name but different signatures.
- **Function Overloading**: Same name, different parameter types/counts.
- **Operator Overloading**: Custom behavior for operators like `+`, `==`, `<<`.
```cpp
struct Vector2D {
    int x, y;
    // Overload + operator
    Vector2D operator+(const Vector2D& other) {
        return {x + other.x, y + other.y};
    }
};
```
## Inheritance (Subclassing)
Inheritance enables code reuse and polymorphism.
- **Virtual Functions**: Allow derived classes to override base class behavior.
- **Pure Virtual Functions**: `virtual void f() = 0;` make a class abstract (interface).
```cpp
class Shape {
public:
    virtual void draw() = 0; // Abstract method
};
class Circle : public Shape {
public:
    void draw() override { /* Draw circle */ }
};
```
## Templates
Templates allow writing generic code that works with any data type, resolved at compile time.
```cpp
template <typename T>
T add(T a, T b) {
    return a + b;
}
// Usage
int sum = add<int>(5, 10);
```
## Dynamic Allocation and Smart Pointers
Manual memory management is prone to errors. C++11 introduced Smart Pointers (RAII) to automate resource management.
### std::unique_ptr
Enforces exclusive ownership. Only one pointer can own the object. Useful for unique resources like socket handles.
```cpp
#include <memory>
struct Point { int x, y; Point(int a, int b):x(a),y(b){} };
void f(std::unique_ptr<Point> &p) { /* do something */ }

std::unique_ptr<Point> g() {
    std::unique_ptr<Point> p = std::make_unique<Point>(2,3);
    return p; // Automatic move on return
}

int main() {
    std::unique_ptr<Point> p1 = std::make_unique<Point>(10, 11);
    std::unique_ptr<Point> p2;
    // p2 = p1; // Error: Copy not allowed
    p2 = std::move(p1); // p1 is now nullptr, p2 owns the object
}
```
### std::shared_ptr
Allows shared ownership via reference counting $R$. Object deleted when $R=0$.
$$
\begin{aligned}
R_{new} &= R_{old} + 1 \quad \text{(On Copy)}
\
R_{new} &= R_{old} - 1 \quad \text{(On Destruction)}
\end{aligned}
$$
```cpp
auto p1 = std::make_shared<Point>(10, 20);
auto p2 = p1; // R=2
p1 = nullptr; // R=1 (p2 still holds value)
```
### std::weak_ptr
Used to break **Circular References** (e.g., A points to B, B points to A). A cycle of `shared_ptr` will never be deleted because $R$ never reaches 0. `weak_ptr` provides a non-owning reference.
### Arrays and Smart Pointers
Distributed systems often need raw character buffers (e.g., for UDP packets).
```cpp
// Legacy: char * buffer = new char[1024];
// Modern:
std::shared_ptr<char[]> pdata = std::make_shared<char[]>(1024);
pdata[0] = 'H'; // Array syntax supported
char otherData[] = "Payload";
memcpy(pdata.get(), otherData, 7); // Use .get() for raw pointer
```
## Copy Constructors: Deep vs. Shallow
- **Shallow Copy**: Copies pointer values. Both objects share the same memory.
- **Deep Copy**: Copies the actual data.
```cpp
class TreeNode {
    int data;
    std::shared_ptr<TreeNode> left, right;
public:
    TreeNode(const TreeNode &other) : data(other.data) {
        // Recursive deep copy
        if (other.left) left = std::make_shared<TreeNode>(*other.left);
        if (other.right) right = std::make_shared<TreeNode>(*other.right);
    }
};
```
## Threads and Concurrency
### C Threads (pthreads)
Provided by the library `<pthread.h>`.
```cpp
void * thread_func(void* arg) { /*...*/ return nullptr; }
pthread_t t;
pthread_create(&t, nullptr, thread_func, dataPtr);
pthread_join(t, &retVal);
```
- Requires complex `struct` packing to pass multiple arguments.
- Returns `void*`.
### C++ Threads (std::thread)
Provided by the language `<thread>`.
```cpp
#include <thread>
void task(int id, std::string msg) { /*...*/ }
std::thread t(task, 1, "Hello"); // Variadic templates handle args
t.join();
```
- Requires `-pthread` flag for compiler and linker.
## Callbacks and Lambdas
### Lambdas (Closures)
Anonymous functions that can capture local variables.
Syntax: `[capture](params){ body }`
- `[]`: No capture.
- `[=]`: Capture all by value.
- `[&]`: Capture all by reference.
- `[this]`: Capture current object (to call methods).
```cpp
std::vector<int> v = {1, 2, 3};
int factor = 10;
std::for_each(v.begin(), v.end(), [factor](int &n) {
    n *= factor; // 'factor' captured by value
});
```
### Member Function Capture
```cpp
class Prt {
    void printIt(int n) { std::cout << n; }
    void go() {
        std::vector<int> pts = {1, 2};
        // Capture 'this' to call printIt
        std::for_each(pts.begin(), pts.end(), [this](int n){ printIt(n); });
    }
};
```
## STL Containers: Vectors
Dynamic arrays handling memory automatically.
```cpp
std::vector<Point> points;
points.push_back(Point(1,2));
// Iterator access
for(auto it = points.begin(); it != points.end(); ++it) {
    it->print();
}
// Range-based for loop (C++11)
for(auto& p : points) {
    p.print();
}
```
## Strings and Formatting
- `std::string`: Supports concatenation (`+`), `c_str()` for C-compat.
- `std::stringstream`: Useful for building strings from multiple types.
- `std::format` (C++20): Type-safe formatting like `std::format("ID: {}", 42)`.
## Fixed-Width Integer Types
Ensure consistent data sizes across distributed nodes (e.g., ARM vs x86).
- **Signed**: `int8_t`, `int16_t`, `int32_t`, `int64_t`
- **Unsigned**: `uint8_t`, `uint16_t`, `uint32_t`, `uint64_t`

```