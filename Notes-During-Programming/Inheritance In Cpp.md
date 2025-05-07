# Inheritance In Cpp

Inheritance is a fundamental concept in **Object-Oriented Programming (OOP)** where a **derived class** (child) **inherits** properties and behaviors (members and methods) from a **base class** (parent).

the declaration of a inherited class is: `class derived-class: access-specifier base-class`

------

## 🔹 1. Basic Syntax of Inheritance

### 🧾 Base and Derived Class

```cpp
class Base {
public:
    int baseValue;

    void showBase() {
        std::cout << "Base class function" << std::endl;
    }
};

class Derived : public Base {
public:
    void showDerived() {
        std::cout << "Derived class function" << std::endl;
    }
};
```

### 🔄 Usage

```cpp
int main() {
    Derived d;
    d.baseValue = 10;   // Accessing inherited member
    d.showBase();       // Inherited method
    d.showDerived();    // Derived class method
    return 0;
}
```

------

## 🔹 2. Types of Inheritance

### 🔸 a. **Single Inheritance**

-   One base, one derived

```cpp
class A {};
class B : public A {};
```

### 🔸 b. **Multilevel Inheritance**

-   Chain of inheritance

```cpp
class A {};
class B : public A {};
class C : public B {};
```

### 🔸 c. **Multiple Inheritance**

-   One derived class inherits from **multiple** base classes

```cpp
class A {};
class B {};
class C : public A, public B {};
```

### 🔸 d. **Hierarchical Inheritance**

-   Multiple classes inherit from a single base

```cpp
class A {};
class B : public A {};
class C : public A {};
```

------

## 🔹 3. Access Specifiers in Inheritance

what is a protected class ? simply view it as in the medium of public and private.

The only constraint of accessibility is that you can’t call the protected method or protected attribute outside the class ; you have to write a public function to change its value or to get its value.

| Inheritance Type | `public` Members Become | `protected` Members Become | `private` Members |
| ---------------- | ----------------------- | -------------------------- | ----------------- |
| `public`         | public in derived       | protected in derived       | Not inherited     |
| `protected`      | protected in derived    | protected in derived       | Not inherited     |
| `private`        | private in derived      | private in derived         | Not inherited     |

| Specifier   | Accessible in class? | Accessible in derived class? | Accessible outside class? |
| ----------- | -------------------- | ---------------------------- | ------------------------- |
| `public`    | ✅ Yes                | ✅ Yes                        | ✅ Yes                     |
| `protected` | ✅ Yes                | ✅ Yes                        | ❌ No                      |
| `private`   | ✅ Yes                | ❌ No                         | ❌ No                      |

###Example:

```cpp
class Base {
public: int a=0;
protected: int b=1;
private: int c=2;
};

class Derived : public Base {
    // a is public, b is protected, c is not accessible(c is not in inherited)
    
    public :
    void call_protected_b{
        std::cout<<b<<endl;
    }
};

int main(){
    Derived test;
    test.call_protected_b();
    return;
}
```

------

## 🔹 4. Function Overriding

You can **redefine** a base class function in a derived class:

```cpp
class Base {
public:
    void show() {
        std::cout << "Base show" << std::endl;
    }
};

class Derived : public Base {
public:
    void show() {
        std::cout << "Derived show" << std::endl;
    }
};
```

------


## 🔹 5. Constructors and Destructors in Inheritance

### 🔄 Constructor Call Order

1.  Base class constructor is called **first**
2.  Then derived class constructor

```cpp
class Base {
public:
    Base() { std::cout << "Base Constructor\n"; }
};

class Derived : public Base {
public:
    Derived() { std::cout << "Derived Constructor\n"; }
};
```

### 💣 Destructor Call Order

-   **Opposite** of constructors:
    -   Derived destructor
    -   Then base destructor

```cpp
~Derived() { std::cout << "Derived Destructor\n"; }
~Base()    { std::cout << "Base Destructor\n"; }
```



------

## 🧩 Summary Table

| Feature             | Use case                                      |
| ------------------- | --------------------------------------------- |
| Inheritance         | Reuse code via base classes                   |
| Access specifiers   | Control visibility in derived classes         |
| Virtual functions   | Enable polymorphism                           |
| Abstract classes    | Define interfaces with pure virtual functions |
| Virtual inheritance | Solve the diamond problem                     |

------

