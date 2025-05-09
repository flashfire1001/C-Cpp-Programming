The **Rule of Three** in C++ is an important concept in **Object-Oriented Programming (OOP)** that deals with **resource management**, especially when your class involves **dynamic memory allocation or ownership** (like using `new`, owning a file handle, etc.).

------

## 📜 The Rule of Three — Summary

If your class needs to **define any one** of the following:

1.  **Destructor**
2.  **Copy constructor**
3.  **Copy assignment operator**

➡️ Then you should **define all three**.

------

## 🔧 Why?

Because the compiler **generates default versions** of these functions if you don’t write them — and those defaults **do shallow copies**.

This can lead to **bugs like double deletion**, memory leaks, or dangling pointers when your class manages resources (e.g., with `new`/`delete`, file handles, sockets, etc.).

------

## 👀 Let’s Look at an Example

### ❌ Without Rule of Three:

```cpp
class MyArray {
private:
    int* data;
public:
    MyArray(int size) {
        data = new int[size];
    }

    ~MyArray() {
        delete[] data;
    }
};
```

Now if you do:

```cpp
MyArray a(10);
MyArray b = a;  // uses default copy constructor → shallow copy!
```

Both `a` and `b` now point to the **same memory**. When they go out of scope:

-   The destructor will run **twice** on the same `data` pointer → 💥 undefined behavior (double free).

------

## ✅ Applying Rule of Three

You fix this by writing:

```cpp
class MyArray {
private:
    int* data;
    int size;
public:
    MyArray(int s) : size(s) {
        data = new int[size];
    }

    // 1. Destructor
    ~MyArray() {
        delete[] data;
    }

    // 2. Copy constructor
    MyArray(const MyArray& other) : size(other.size) {
        data = new int[size];
        for (int i = 0; i < size; ++i) data[i] = other.data[i];
    }

    // 3. Copy assignment operator
    MyArray& operator=(const MyArray& other) {
        if (this == &other) return *this; // self-assignment check

        delete[] data;
        size = other.size;
        data = new int[size];
        for (int i = 0; i < size; ++i) data[i] = other.data[i];
        return *this;
    }
};
```

Now each object has its **own copy of the data**, and there are no issues when copying, assigning, or destroying.

------

## 🧠 Related Concepts

-   **Rule of Five**: If you use C++11 or later and your class also involves move semantics, then you need to manage 5 functions:
    1.  Destructor
    2.  Copy constructor
    3.  Copy assignment
    4.  Move constructor
    5.  Move assignment
-   **Rule of Zero**: Modern C++ encourages using RAII and smart pointers so that you **don’t have to write any of the five** functions — the compiler does it correctly for you.

------

Would you like a hands-on exercise or diagram showing memory ownership and copies?