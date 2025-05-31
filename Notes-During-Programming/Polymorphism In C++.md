#Polymorphism In C++

**Polymorphism** means **"many forms."** In C++, polymorphism lets you use a **single interface** (e.g., a base class pointer) to represent **different types of objects**, and **call the correct function** for the actual object type — even if you don’t know the exact type at compile time.

| Type             | When It's Resolved | Feature Used                               |
| ---------------- | ------------------ | ------------------------------------------ |
| **Compile-time** | At compile time    | Function overloading, operator overloading |
| **Run-time**     | At runtime         | Virtual functions, inheritance             |



## part1: compile time polymorphism (static binding)

this is achieved using function overloading and operator overloading.



##📘 Part 1: Compile-Time Polymorphism (Static Binding)

This is achieved using **function overloading** and **operator overloading**.(this is simple)

### 🔹 Function Overloading

Multiple functions with the **same name**, but different parameters.

```cpp
class Print {
public:
    void show(int x)    { std::cout << "Int: " << x << "\n"; }
    void show(double x) { std::cout << "Double: " << x << "\n"; }
};
```

### 🔹 Operator Overloading

Define how operators like `+`, `-`, `==` work for your classes.

```cpp
class Complex {
    double real, imag;
public:
    Complex(double r, double i) : real(r), imag(i) {}

    Complex operator+(const Complex& other) {
        return Complex(real + other.real, imag + other.imag);
    }
};
```

>   ✅ Compile-time polymorphism is resolved during compilation and is **faster** but **less flexible**.

------

## 📗 Part 2: Run-Time Polymorphism (Dynamic Binding)

This is the **real power** of polymorphism in C++. It allows you to write **flexible, reusable code**

some basic syntax and concepts that will be cover:

| Feature               | Description                                                |
| --------------------- | ---------------------------------------------------------- |
| `virtual` keyword     | Enables runtime dispatch                                   |
| `override` keyword    | Ensures proper overriding                                  |
| Virtual destructor    | Needed for base class destruction                          |
| `vtable`/`vptr`       | Internal mechanism enabling dynamic dispatch               |
| Use base pointers/ref | Required for polymorphism to work                          |
| Avoid slicing         | Always use pointers or references for polymorphic behavior |

| Concept | What It Does                           |
| ------- | -------------------------------------- |
| vtable  | Table of function pointers (per class) |
| vptr    | Pointer in each object to the vtable   |
| Purpose | Enables dynamic (runtime) dispatch     |

### Rule from the C++ Standard (Simplified)

>   During the construction of an object of class `X`, the vptr must point to the vtable for `X`.

 the compiler:

-   **Generates the vtable** for each class with virtual functions.
-   **Inserts code** into each constructor to **set the vptr** appropriately.

​	The first thing to understand the Polymorphism is to understand its working mechanism: virtual functions = `vtable + vptr + dynamic dispatch.` In the base function the function with the label **virtual** means that **they will be override**. For the class with virtual functions, every object(instances), a hidden vector pointer will be set **uniquely for it.** It creates the mapping relationship **between the object and the virtual function table (vtable)**, which is a function pointers. The vtable for the object shows the **real class** of it, no matter what the type specifier you declare it. The dynamic dispatch is used and the program will **execute the functions specified by the vtable.**

Here is an example:

```cpp
class Animal {
public:
    virtual void speak() {
        std::cout << "Animal speaks\n";
    }
};

class Dog : public Animal {
public:
    void speak() override {
        std::cout << "Dog barks\n";
    }
};

class Cat : public Animal {
public:
    void speak() override {
        std::cout << "Cat meows\n";
    }
};

Animal* a1 = new Dog();
Animal* a2 = new Cat();

a1->speak();  // 🔁 Looks up Dog's vtable → Dog::speak()
a2->speak();  // 🔁 Looks up Cat's vtable → Cat::speak()


+----------------+
| Dog object     |
|----------------|
| data members   |
| vptr unique!---> +------------------------+
+--------------- + | Dog vtable             |
                   | [0] => Dog::speak()    |
                   +------------------------+

```

Likewise for animal vtable:

`[0] => Animal::speak()`

Even though `Dog` and `Cat` share the same base class, their **vtable entries are unique** because each overrides the function differently. THEN, OUR FINDING:

**✅ The base class (`Animal`) defines the *interface* (like `speak()`).**

Why this is Powerful:

>   ✅ **You can write code using a base class pointer (`Animal*`), but get behavior from derived classes (`Dog`, `Cat`, etc.) — automatically, at runtime.**

------

###:white_check_mark:1. **Unified Interface**

You don’t need to care **which animal** it is — just that it’s *some kind* of `Animal`.

```cpp
void makeItSpeak(Animal* a) {
    a->speak();  // Might call Dog::speak, Cat::speak, etc.
}
```

You write one function, and it works with **any subclass** of `Animal`.

------

### ✅ 2. **Runtime Flexibility**

You can create different objects at runtime:

```cpp
Animal* a1 = new Dog();
Animal* a2 = new Cat();

a1->speak();  // Dog::speak
a2->speak();  // Cat::speak
```

The code doesn’t change, but the behavior does — based on the actual object.

------

### ✅ 3. **Easy Extension**

You can add new classes (`Bird`, `Lion`, `Horse`) that inherit from `Animal` without touching old code.

This is a key principle of **open/closed design**:

-   Open for extension
-   Closed for modification

------

### ✅ 4. **Works with Containers**

```cpp
std::vector<Animal*> zoo;
zoo.push_back(new Dog());
zoo.push_back(new Cat());
zoo.push_back(new Bird());

for (Animal* a : zoo) {
    a->speak();  // Each animal behaves differently
}
```

>   You treat all animals the same, but each one behaves in its own way.
>    This is **true polymorphism** — "many forms" through one interface.

In summary — the bonus is:

-   **Simple code** (`Animal*`),
-   **Clean design** (base class interface),
-   **Dynamic behavior** (derived class logic),
-   **Flexible & scalable** system.

##Extended Topics: Pure Virtual functions, Avoid slicing and Virtual Destructor

---

##### Important Notes & Best Practices

###:small_blue_diamond::one:pure virtual functions and abstract class

A **pure virtual function** is a function declared in a base class **without an implementation**, meaning **derived classes must override it**.

Syntax:

```cpp
class Base {
public:
    virtual void foo() = 0;  // Pure virtual function
};
```

The `= 0` syntax tells the compiler:
 ➡️ “This function has **no implementation in the base class**, and **must** be implemented by derived classes.”

------

A class that has **at least one pure virtual function** is called an **abstract class**.

-   You **cannot instantiate** an abstract class.
-   It is used as a **blueprint or interface** for derived classes.

example:

```cpp
class Animal {
public:
    virtual void speak() = 0;  // pure virtual
};
Animal a;  // ❌ ERROR: Cannot create object of abstract class

//another more example
class Base {
public:
    virtual void foo() = 0;  // pure virtual
};

void Base::foo() {
    cout << "Base implementation\n";
}
```

------

#### Why Use Pure Virtual Functions?

They are used to:

-   **Enforce an interface**: Every derived class **must** implement certain methods.(clear contracts)
-   **Prevent instantiation** of base classes.
-   Enable **polymorphic behavior** in a controlled way.

### 📌 Summary

| Concept                 | Description                                          |
| ----------------------- | ---------------------------------------------------- |
| `virtual void f() = 0;` | Pure virtual function                                |
| Abstract class          | Class with at least one pure virtual function        |
| Cannot instantiate      | Abstract classes cannot be directly instantiated     |
| Must override           | Derived class must implement pure virtual functions  |
| Optional base impl      | You can define a body in base, but it’s not required |

###🔹:two: Use `override` (C++11+)

Indicates your intent to override a base class virtual function.

```cpp
void draw() override;  // safer and compiler-checked
```

### 🔹:three:Virtual Destructors Are a Must!

If your class is meant to be a base class, **make its destructor `virtual`** to ensure proper cleanup.

When using **polymorphism** (base class pointers or references), if the **destructor is not virtual**, **only the base class destructor will be called**, even if the object is actually of a derived class.

(that is because without virtual, you switch to the static polymorphism! then, only the base destructor)

### The Core Issue: **Static vs. Dynamic Type**

Let’s break this down:

```cpp
class Animal {
public:
    ~Animal() {
        std::cout << "Animal destroyed\n";
    }
};

class Dog : public Animal {
public:
    ~Dog() {
        std::cout << "Dog destroyed\n";
    }
};
```

Now:

```cpp
Animal* a = new Dog();
delete a;
```

You might **expect** both `Dog` and `Animal` destructors to run, but you'll only see:

```bash
Animal destroyed
```

### ❌ Why? Because:

-   `a` is an `Animal*`
-   Its static type is `Animal`
-   The compiler calls `Animal::~Animal()` **statically** (no vtable lookup)
-   So `Dog::~Dog()` is never called — **memory is leaked!**

------

## ✅ The Fix: Use a **Virtual Destructor**

```cpp
class Animal {
public:
    virtual ~Animal() {
        std::cout << "Animal destroyed\n";
    }
};
```

Now the compiler adds the destructor to the **vtable**, and when `delete a;` is called:

-   The vtable is used
-   `Dog::~Dog()` is called **first**
-   Then `Animal::~Animal()`

Output:

```
Dog destroyed
Animal destroyed
```

✅ **Proper destruction.**

------

## 🎯 Why It Matters

If you don’t make the destructor virtual:

-   The derived class destructor won't be called when deleting via base pointer
-   This leads to **memory/resource leaks**
-   It's **undefined behavior** in C++

------

## 🔑 Rule of Thumb:

>   **Always make the base class destructor virtual if you intend to use polymorphism.**

### 🔹:four: Avoid Object Slicing

This happens when you assign a derived object to a base class **by value**, losing derived parts.

```cpp
Circle c;
Shape s = c;  // SLICING! Circle's parts are lost
```

Use **pointers or references** instead.

### 🔍 Example:

```cpp
class Shape {
public:
    virtual void draw() {
        std::cout << "Drawing a shape\n";
    }
};

class Circle : public Shape {
public:
    void draw() override {
        std::cout << "Drawing a circle\n";
    }
};

int main() {
    Circle c;
    Shape s = c;  // ❌ Object slicing!
    s.draw();     // Outputs: Drawing a shape (not "circle"!)
}
```

### ❗ What Happened?

-   `Shape s = c;` creates a **copy** of only the `Shape` part of `c`.
-   The `Circle` part is **sliced away** — it never makes it into `s`.
-   So `s.draw()` calls `Shape::draw()`, **not** `Circle::draw()`.

Use **pointers or references** to the base class instead:

### ✔️ Pointer:

```
cppCopyEditShape* s = new Circle();
s->draw();  // Calls Circle::draw()
```

### ✔️ Reference:

```
cppCopyEditCircle c;
Shape& s = c;
s.draw();  // Calls Circle::draw()
```

>   🔑 Why this works:
>    When you use a **pointer or reference**, the compiler doesn’t slice — instead, it keeps track of the **actual derived object** and uses **virtual dispatch (vtable)** to call the right function.

---

### Again: Key Takeaways

| Feature               | Description                                                |
| --------------------- | ---------------------------------------------------------- |
| `virtual` keyword     | Enables runtime dispatch                                   |
| `override` keyword    | Ensures proper overriding                                  |
| Virtual destructor    | Needed for base class destruction                          |
| `vtable`/`vptr`       | Internal mechanism enabling dynamic dispatch               |
| Use base pointers/ref | Required for polymorphism to work                          |
| Avoid slicing         | Always use pointers or references for polymorphic behavior |

---

Bonus: 

![image-20250507134415661](C:\Users\Xujiaming\AppData\Roaming\Typora\typora-user-images\image-20250507134415661.png)
