#  C++: templates

copy constructor

A template is a blueprint for creating a generic function or a class.

## 🔧 1. **What is a Template in C++?**

A template is a blueprint or formula for creating a **family of functions or classes**.

Instead of writing code that works with only a specific type (like `int`, `double`), you can write code that works with **any type**.

This is **generic programming**, and it allows:

-   Type independence
-   Code reusability
-   Type safety at compile-time

------

## 🧩 2. **Function Templates – Explained in Depth**

### 📝 Syntax

```cpp
template <typename T>  // or: template <class T>
T functionName(T param1, T param2) {
    // function logic using type T
}
```

### ✅ Example and Explanation

```cpp
template <typename T>
T add(T a, T b) {
    return a + b;
}
```

Here:

-   `T` is a **placeholder** type
-   `add<int>(2, 3)` → instantiates the function with `int`
-   `add<double>(2.5, 3.7)` → instantiates with `double`

Compiler generates actual functions based on the types used.

```cpp
int main() {
    cout << add(5, 10) << endl;        // deduced as int
    cout << add(2.1, 3.9) << endl;     // deduced as double
    return 0;
}
```

------

## 🧱 3. **Class Templates – Deep Dive**

Class templates let you write data structures or classes that can handle multiple types.

### 📝 Syntax

```cpp
template <class T>
class ClassName {
    T data;
public:
    ClassName(T val) : data(val) {}
    T getData();
};

template <class T>
T ClassName<T>::getData() {
    return data;
}
```

### ✅ Example: A Simple Box

```cpp
template <class T>
class Box {
    T value;
public:
    Box(T val) : value(val) {}
    T getValue() { return value; }
};
```

**Usage:**

```cpp
Box<int> intBox(10);
Box<string> strBox("C++");

cout << intBox.getValue() << endl;
cout << strBox.getValue() << endl;
```

Compiler creates separate classes behind the scenes:

-   `Box<int>`
-   `Box<string>`
-   this is another key design to avoid **repeated naming**! 

------

## 🧩 Extra Info: Function Template with Multiple Type Parameters

You can define **more than one** type parameter.

### 📌 Syntax:

```cpp
template <typename T1, typename T2>
void display(T1 a, T2 b) {
    cout << a << " " << b << endl;
}
```

### 🧪 Example:

```cpp
int main() {
    display(10, "apples");        // T1 = int, T2 = const char*
    display(3.14, 42);            // T1 = double, T2 = int
}
```

-   This is helpful when inputs aren’t the same type.
-   Type deduction still works automatically.

------

## 🔢 3. **Non-Type Template Parameters**

You can pass **constants** (e.g., `int`, `char`, `bool`) to templates, which are evaluated at compile time.

### 📌 Syntax:

```cpp
template <typename T, int size>
T getAtIndex(T (&arr)[size], int index) {
    return arr[index];
}
```

### 🧪 Example:

```cpp
int main() {
    int nums[5] = {1, 2, 3, 4, 5};
    cout << getAtIndex(nums, 2) << endl;  // prints 3
}
```

-   `size` is deduced as 5 automatically from the array reference.
-   Often used in generic array and algorithm code.

------

## 🎛 4. **Template Default Parameters**

Just like function arguments, template parameters can have default values.

### 📌 Syntax:

```cpp
template <typename T = int>
void show(T value) {
    cout << value << endl;
}
```

### 🧪 Example:

```cpp
int main() {
    show(10);       // uses default T = int
    show<double>(3.14); // overrides with double
}
```

-   Helpful to make APIs easier to use by hiding complexity.

------

## 🔄 5. **Overloading Function Templates**

Templates can be **overloaded** with:

-   Other templates (with different parameter sets)
-   Regular functions (for special cases)

### 🧪 Example:

```cpp
template <typename T>
void print(T val) {
    cout << "Template: " << val << endl;
}

void print(int val) {
    cout << "Non-template: " << val << endl;
}

int main() {
    print(42);          // calls non-template version
    print(3.14);        // calls template version
}
```

-   The compiler picks the **best match**: exact type match wins over template.

------

## 🧠 Summary: Function Template Parameters

| Parameter Type | Example                              | Use Case                                 |
| -------------- | ------------------------------------ | ---------------------------------------- |
| Type parameter | `template<typename T>`               | Generic types                            |
| Multiple types | `template<typename T1, typename T2>` | Mixed-type functions                     |
| Non-type       | `template<int N>`                    | Compile-time constants (like array size) |
| Default value  | `template<typename T = double>`      | Optional, for simplified API             |

------

![image-20250509134648533](../../../../AppData/Roaming/Typora/typora-user-images/image-20250509134648533.png)