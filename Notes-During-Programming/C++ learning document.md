# C++ learning document(basic intro)

C++ Is so complex in class … 

###I. some basic changes

>   .c becomes .cpp
>
>   use the compiler g++ instead of gcc
>
>   the standard library use iostream vs stdio.h No .h in the system lib
>
>   use **namespace** for function with identical name but in different library
>
>   Function can have **default argument**
>
>   Functions can **repeated and be overloaded**; so as operators(given a class)
>
>   Different dynamic memory allocation syntax
>
>   **pointers vs references**

#### The first thing that is important is the namespace in `Cpp` is the use of namespace:

>   A **namespace** in C++ is a declarative region that provides **a scope to identifiers** (like variables, functions, classes, etc.). It helps **organize code** and **prevent name conflicts**, especially in large projects or when using libraries.

```cpp
// examples for namespace:
#include <iostream>
#include <string>

using std::cout;//import the single function;
using namespace std;//import the whole namespace, usually in main.c
int a,b;
std::cin>>a>>b;
cin>>a>>b;//after import

#pragma once
namespace math {
    int multiply(int a, int b);
}
//this is to generate the user-defined namespace.
```
#### the key different between pointer and reference

-----

| Feature               | Reference (`int&`)   | Pointer (`int*`)             |
| --------------------- | -------------------- | ---------------------------- |
| Nullability           | Cannot be null       | Can be null                  |
| Rebinding             | Cannot rebind        | Can change what it points to |
| Syntax simplicity     | Clean (`ref = 5;`)   | Verbose (`*ptr = 5;`)        |
| Must be initialized   | Yes                  | No                           |
| Language-level safety | Enforced by compiler | Manual control               |

Use reference as possible. In cpp, actually it is enough for reference to replace the pointer, even though pointer still exists in cpp . remember ref = *(its value); as an argument &ref  = const *ref.

In C++, **function overloading resolution** — choosing which overloaded function to call — is done by the **compiler at compile time**, based on the arguments you pass.

**Who matches the type and number of argument , who will be called.**

#### The memory allocation in cpp

___

| Type           | Allocation | Lifetime            | Clean-up  |
| -------------- | ---------- | ------------------- | --------- |
| Local variable | Stack      | Until function ends | Automatic |
| `new`          | Heap       | Until `delete`      | Manual    |
| Smart pointer  | Heap       | Automatic (scoped)  | Automatic |
| `malloc` (C)   | Heap       | Until `free`        | Manual    |

the syntax

```cpp
// C++ style
int* p = new int;        // allocates one int
*p = 42;

int* arr = new int[10];  // allocates array of 10 ints

delete p;                // frees single int
delete[] arr;            // frees array

//delete and new are built-in operators which is same as a function

// C style less preferred in C++
int* p = (int*)malloc(sizeof(int));
*p = 42;
free(p);


//modern C++
#include <memory>

std::unique_ptr<int> p1 = std::make_unique<int>(42);
std::shared_ptr<int> p2 = std::make_shared<int>(99);
They call delete automatically when no longer used.
```

### II. key changes

>Structs vs classes
>
>further: procedural programming vs object -oriented programming
>
> The *object - oriented programming means classes and objects and concepts like*
>
>encapsulation涵盖 Inheritance继承 Polymorphism 多态性
>

#### **Basic points on `Class`**

-   object : an instance of a class
-   the attributes or members 
-   functions or methods

the access to members are granular which has two access types: **private (default)and public**

for public functions and parameters defined in a class, we need to write a function to have access to it:

```cpp
class Complex{
  double real;
  double imag;

public:
  Complex(double real, double imag){
    this->real = real;
    this->imag = imag; 
  }
};

//another way for giving methods:
class Complex{
  double real;
  double imag;

public:
  Complex(double real, double imag):real(real),imag(imag){};
  // example of operator overloading 
  Complex operator+(Complex c){
return Complex(this->real + c.real, this->imag + c.imag);
}

};

//same as a namespace ,use the :: to specify the scope.
Complex::Complex(double real, double imag){
    this->real = real;
    this->imag = imag;
}//write the definition outside the declaration of a class.
// this is a pointer that refer to its self ,which is same as the self in python


//ways to call the initializer:

int main(){
    Complex c1(3,4);
    Complex c{1,2};// preferred
    Complex c;// incorrect because you have uninitialised members:must be initialised.
    Complex c2 = Complex(4,5);
    Complex c3 = c1+c2;
    c3.print();
}
```

Special method:

constructors: like `self.__initialise__`in python

which is :

-   used to initialize the data members
-   same name as class
-   can be user defined(overload); and default argument are possible 
-   a default constructor is with no argument.
-   DO NOT attach type specifier not even tag

destructors:

-   destroy an object (de-allocate memory for primary use)
-   same name as class
-   NO argument
-   DO NOT attach type specifier not even tag

### Inheritance

---

C++ allows us to define a class based on an existing class `base class`, and the new class `derived class` inherit members of the existing class.

Things not inherited(even public):

>-   Constructors, destructors of the base class
>-   Overloaded operators of the base class
>-   Friend functions of the base class

![image-20250506141335086](C:\Users\Xujiaming\AppData\Roaming\Typora\typora-user-images\image-20250506141335086.png)

```cpp
class Base {
public:
    void show();
};

class Derived : public Base {
    // Derived has public access to Base::show()
};

class Derived : private Base {
    // Derived has private access to Base::show()
    // External code cannot call Derived::show()
};


// even though you have to read write the constructor, you can use part of it;as it is always public

class Dog: public Animal{
    bool nail_clip;
    public:
    	Dog(const chat *name, int b, int a, bool c):  Animal(name, b, a){
            nail_clip = c;
        }
};
//member initializer list syntax



```

A little more tips on member initializer list syntax: they are more efficient use them as possible.

example:

```cpp
// the class definition for context:
class MyClass {
    int x;
public:
    MyClass(int val);  // Constructor declaration

};
// using a member initializer list
MyClass::MyClass(int val) : x(val) {
    // Initialization done before the constructor body runs
}
//Assignment Inside Constructor Body; work as a overlapping function
MyClass::MyClass(int val = 0) {
    x = 0;  // Assignment happens here
}

```

some runtime explanation:

```text
+-----------------------------+
| Constructor Call: MyClass  |
|----------------------------|
| Step 1: x is default-      |
|         initialized 		|
|                            |
| Step 2: Assignment: x = val|
|         inside constructor |
|         body               |
+-----------------------------+

```

some comparison:

| Feature                      | Initializer List   | Assignment in Body |
| ---------------------------- | ------------------ | ------------------ |
| Performance                  | ✅ More efficient   | ❌ Less efficient   |
| Required for const/reference | ✅ Yes              | ❌ No               |
| Initialization Timing        | Before constructor | Inside constructor |
| Redundant Initialization     | ❌ No               | ✅ Yes              |

![ChatGPT Image May 7, 2025, 11_35_50 AM](D:/Downloads/ChatGPT Image May 7, 2025, 11_35_50 AM.png)

Further topic will be in next file!





PS: some personal confusion’s explanation

put the declaration of the function in the header file while leave the source code only definition. Then, include the header file into the source file so as to make it sound.

In essence, including the header in the `.cpp` file that defines the things declared in the header acts as a **sanity check** or a **contract fulfillment verification**. It ensures that the definition you've written actually corresponds to the declaration you promised in the header file.(that is a must when you write **functions (method) for a class**)

So, while `main.cpp` includes the header because it ***uses* the declared functions/classes** (that is required by the linker to **resolve references** to symbols generated by the complier (like function names, variable names)), `my_functions.cpp` includes the header because it ***implements*** them, and it needs to verify that its implementation matches the public interface defined in the header.

Here's a brief summary of how a c/cpp file is compiled:

1.  **Preprocessor:** (**tackle with #include**)Copies the header's content into *each* `.cpp` file that includes it. **Use guards (`#ifndef`/`#define`/`#endif` or `#pragma once`) prevent the content from being copied** more than once *within a single `.cpp` file*.(it do only some basic **translate** and code-import **paste**)
2.  **Compiler:** Compiles **each** preprocessed `.cpp` file into **an object file** (`.o`/`.obj`) and multitude of symbols. Each object file will contain *declarations* from the header. **Duplicate *declarations* across different object files are acceptable.**
3.  **Linker:** Combines the object files. Its job is to **find the** ***single definition* for each function or variable that was used**. It successfully resolves references by finding this one definition, even though the *declaration* might appear in multiple object files. **Linker errors only occur if there are duplicate *definitions*** (which proper header design avoids putting in headers).

