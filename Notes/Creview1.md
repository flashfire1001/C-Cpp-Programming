# C review1-“from basic compilation mechanisms to it’s data structures”

➤A sequence to translate C program: first preprocess it ,then compile it.

a preprocessor :

-   Macro substitution by C preprocessor  directive (eg : #include, #define) 
-   Source level transformation: output is  still C code.

A compiler :

-   translate the C code into assemble language.

-   link the files to together to output executable file.

## ➤Memory Layout

```text
+---------------------+
|     TEXT SEGMENT    |
|       (Code)        |
+---------------------+
|   DATA SEGMENT      |
|  +------------------+|
|  | Initialized Data  ||
|  +------------------+|
|  +------------------+|
|  | Uninitialized (BSS)||
|  +------------------+|
+---------------------+
|        HEAP         |
| (Dynamic Memory)    |
+---------------------+
|        STACK        |
| Local Variables &   |
| Function Calls      |
+---------------------+

different types of values occupies different spaces:
a int/float takes 4B; a char takes only 1 B; a double float/long int takes 8B.
```

#### Key Points:

-   **Text Segment**: Contains read-only program code.
-   **Data Segment**: Divided into initialized and uninitialized global/static variables.
-   **Heap**: Dynamic memory, manually managed with `malloc()`/`free()`.
-   **Stack**: Stores local variables, function parameters, and return addresses.

Analysis during the runtime and functions:

The codes will be loaded in prior; During runtimes, different functions are set up — prototype first then call it —  return type and parameters. the activation frame and runtime stack constructed; the programs continues to be executed.

------

## ➤Understanding **variable scope**, **linkage**, and **storage duration**

| **Category**         | **Keyword** / Concept                                        | **Meaning** |
| -------------------- | ------------------------------------------------------------ | ----------- |
| **Scope**            | Where in the code the variable is **accessible**             |             |
| **Linkage**          | Whether the variable is **accessible across multiple files** |             |
| **Storage Duration** | How long the variable **exists in memory** during execution  |             |

###declarations for different kinds of variables:

```c
void foo() {
    int a = 10;  // automatic by default. function scope
}
```

```c
void foo() {
    static int count = 0;  // retains value between calls functions scope 
    //but retains the value
}
```

```c
int *p = malloc(sizeof(int)); //before you free it
free(p);
```

#### Function/Block Scope

```c
int main() {
    int x = 5;  // block scope
    {
        int y = 10;  // y visible only inside this inner block
    }
}
```

####  File Scope

```c
int globalVar = 10;  // file scope Declared outside any function.
int main(){}
```

------

###   **Linkage**

####  Internal Linkage

-   Accessible only within the same translation unit (source file).
-   **Keyword**: `static` outside functions.
```c
static int internalVar = 42;  // not accessible from other .c files
```
####  External Linkage

-   Accessible across multiple files.
-   **Keyword**: None (default for global vars/functions), or `extern`.
```c
// file1.c
int sharedVar = 100
// file2.c
extern int sharedVar;
```
####  No Linkage

-   Exists only in one place — no sharing.
-   Applies to:
    -   Local variables.
    -   Function parameters.
      
```c
void foo(int x) {  // x has no linkage
    int y = 5;     // y has no linkage
}
```

------

### 🔸 Summary Table(block = function)

| **Keyword**       | **Scope** | **Linkage**              | **Storage Duration**            |
| ----------------- | --------- | ------------------------ | ------------------------------- |
| `auto`            | Block     | None                     | runtime stack                   |
| `register`        | Block     | None = only this block   | Automatic (during the function) |
| `static` (local)  | Block     | (N-invisible for others) | Static (for the whole program)  |
| `static` (global) | File      | Internal                 | Static (retains value)          |
| `extern`          | File      | External                 | Static (defined elsewhere)      |
| Global var        | File      | External (default)       | Static (for the whole program)  |

------



##➤Function Call in C:

-   a functions is construct by 1. the identifier(name or label for that subroutine) 2. the arguments to feed 3. the return value(1 or 0).

-   a functions is similar to a subroutine in asm: 

    >   When C-compiler compiles a program, it keeps track of variables  in a program using a symbol table.  it includes: 1. Identifier 2. type of the variable,  3.memory location allocated (by offset - see the picture) and 4.scope 
    >
    >   <img src="../../../AppData/Roaming/Typora/typora-user-images/image-20250425101246552.png" alt="image-20250425101246552" style="zoom: 50%;" />
    >
    >   the runtime stack has the the constructure (**activation record**)  which is comprise of : Arguments passed in  • Local variables defined  • Bookkeeping information(which includes the **address of return value/return value/a caller’s frame pointer(for jumping aback)** )

-   Whenever a function calls another one (nested, including itself),  the run time stack grows (pushes another activation record onto  the run-time stack)
-   the process of a function call:
-   ![image-20250425101751697](../../../AppData/Roaming/Typora/typora-user-images/image-20250425101751697.png)

In 1 and 2, the parameter are filled; R7 is stored for return

In 3-6, just before the functions is executed , the compiler adds some basic asm instructions to be completed: Given the caller’s data frame,  store the return address and the leave space for return value. What’s more store the previous frame pointer , that is , the address of the local variable receive it (eg. w = f(x) then the address of w).

After the functions is finished,  update R5 using the address of previous frame pointer, RET using return address, update the return value using return address. what’s more, after popping all the arguments, the R6 go back to the TOS of current function.

![image-20250425102945717](../../../AppData/Roaming/Typora/typora-user-images/image-20250425102945717.png)

## ➤Pointers in C

A pointer in C, is a variable whose value is the address of another  variable, i.e., direct address of the memory location. 

declaration `<type> *pt;`  <br>address of operator `&var`<br>dereference operator `*pt` — this draws out the value of var.

`in Lc-3 level`

pointer type — 1. a single var 2. null (you can’t dereference it) 3.void 4.array

-   use pointer in a function : Even if the arguments is popped out after execution of a function , you can change it using its address during the runtime.

-   ###### 

    

```c

```







