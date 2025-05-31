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

### Key Points:

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

------

### Summary Table(block = function)

| **Keyword**       | **Scope** | **Linkage**              | **Storage Duration**            |
| ----------------- | --------- | ------------------------ | ------------------------------- |
| `auto`            | Block     | None                     | runtime stack                   |
| `register`        | Block     | None = only this block   | Automatic (during the function) |
| `static` (local)  | Block     | (N-invisible for others) | Static (for the whole program)  |
| `static` (global) | File      | Internal                 | Static (retains value)          |
| `extern`          | File      | External                 | Static (defined elsewhere)      |
| Global var        | File      | External (default)       | Static (for the whole program)  |



##➤Function Call in C:

-   a functions is construct by 

-   1.   the identifier(name or label for that subroutine) 
    2.   the arguments to feed 
    3.   the return value(1 or 0).
    4.   you should give a declaration before defining it.

-   a functions is similar to a subroutine in asm: 

    >   When C-compiler compiles a program, it keeps track of variables  in a program using a symbol table.  it includes: 1. Identifier 2. type of the variable,  3.memory location allocated (by offset - see the picture) and 4.scope 
    >
    >   <img src="C:\Users\Xujiaming\AppData\Roaming\Typora\typora-user-images/image-20250425101246552.png" alt="image-20250425101246552" style="zoom: 50%;" />
    >
    >   the runtime stack has the the constructure (**activation record**)  which is comprise of : 
    >
    >   -   Arguments passed in  
    >
    >   Bookkeeping information
    >
    >   -   **return value**
    >
    >   -   **address of return value : preserved R7 for recursive call**
    >
    >   -   **a caller’s frame pointer: a fixed anchor- the address of the first caller’s local variable (often)**
    >   -   In some design, FP points to the saved old FP (often called the frame base). Locals are at negative offsets below FP; arguments at positive offsets above FP.
    >   -   **Local variables defined** 

-   Whenever a function calls another one (nested, including itself),  the run time stack grows (pushes another activation record onto  the run-time stack)

-   the process of a function call:

    ![image-20250425101751697](C:\Users\Xujiaming\AppData\Roaming\Typora\typora-user-images/image-20250425101751697.png)

![image-20250425102945717](C:\Users\Xujiaming\AppData\Roaming\Typora/typora-user-images/image-20250425102945717.png)

Hence, the **Sequence** modifying the register is:

before JSR:

R5 is not changed;(**again, the previous R5’s addr is stored independently, current R5’s value is addr of the First local variable**)

-    all you need to do is push the arguments : use R5 to access the local variables and arguments and calculate the callee’s required arguments.

-   decrement your R6 for the arguments
-   decrement your R6 for the return value slot
-   JSR [ ]
-   decrement R6 again for return address ;
-   then store R7: ST R7, R6, #0;
-   decrement R6 again for frame pointer
-   store the FP: ST R5, R6, #0;
-   decrement R6 for new frame pointer as well as a TOS;
-   change R5 : ADD R5, R6, #0;
-   began your program!

After the program finished, and before return:

-   use a register to contain the result value
-   use STR to update the return value : STR Rx, R5, #3;
-   increase R6 to pop local variable
-   restore the caller’s frame pointer
-   increase R6 to get return address ;  restore R7 
-   RET
-   the caller should deal with the ret value in the ret value slot. 
-   afterward, pop both the arguments and the return value!





## Double Pointer and Link List



##  **Pointers in C**

### 🔹 Definition

A **pointer** is a variable that stores the **memory address** of another variable.

```c
int x = 10;
int *p = &x; // 'p' holds the address of 'x'
```

-   `*p`: dereferencing — access the value stored at the address.
-   `&x`: address-of — gives the memory address of `x`.

### 🔹 Why Use Pointers?

-   Efficient memory access and manipulation
-   Enables **dynamic memory allocation**
-   Needed for **function arguments by reference**
-   Essential in **data structures** (like linked lists, trees)

------

### 🔸 Application of Pointers

#### ✅ 1. **Strings**

In C, a string is a **char array** terminated with `'\0'`, and often handled via pointers.

```c
char *str = "Hello";
```

-   `str` points to the first character `'H'`
-   You can traverse the string with:
     `while (*str != '\0') { putchar(*str); str++; }`

#### ✅ 2. **Arrays**

Arrays and pointers are tightly connected:

```c
int arr[] = {1, 2, 3};
int *p = arr;
```

-   `p[i]` is same as `*(p + i)` // in memory here i equals size_of (element by p)
-   Array name (`arr`) is a pointer to the first element

📌 Note: Arrays are not modifiable l-values, but pointers are. 

------

## ➤ **Double Pointer and Linked List**

A **double pointer** is a pointer to another pointer.

```c
int x = 5;
int *p = &x; 
int **pp = &p; 
```

-   `**pp` gives `x`

-   几点要点:

    1.   double pointer 怎么定义和assign: 你不能用 `int **pp =&&x or int **ptr; **ptr =x;`

    2.   `**p`可以指向一个列表的int , 你只需要把**p 传入函数,就能实现列表整个传进去了

    3.   key error : undefined! 

         ```c
         int *p =10;
         int **p = &"12334";
         free(p);
         *p = 10; //error! instead,
         *ptr = a? still invalid!
         *p = &a; //correct!
         ```

         4.   memory leak

              ```c
              不能:
              *node ptr = Node->next;
              return ptr;
              //then you do a recursion...
              free(ptr);//when you want to delete this ptr
              ptr = NULL;
              //now Node->next points to a undefined area; but is not NULL! this is really bad!
              //segfault.
              
              instead,//especially in deletion
              **node ptr = &Node->next;
              free(*ptr);
              *ptr = NULL; // correct!
              ```

              

💡 **Example: Allocating memory**

```c
void allocate(int **ptr) {
    *ptr = malloc(sizeof(int) * 10);
    //you must free *ptr
   	//OR.. return what? reaturn the *ptr's value, which should be given to it's caller! 
    //that is because, either this *ptr's value or addr will be inaccessible
    //*ptr's addr is ptr's value
    //However , you must get its' value this is the address of an array of int
}
// but sometimes it't valid : when you are writing a function to assign a ptr
int *p;
allocate(&p); 
```

### 🔹 Linked List and Pointers

Linked lists require pointers to dynamically allocate memory and link elements.

```c
typedef struct Node {
    int data;
    struct Node *next;
} node;
```

-   Each `Node` contains a pointer to the next node
-   To insert/delete nodes, we use **pointer to pointer** (`node **head`) to update the head of the list from within a function

#### Example: Insert at beginning

```c
void insertFront(node *head, int val) {
    node *newNode = malloc(sizeof(Node));
    newNode->data = val;
    newNode->next = *head;
    head = newNode;
}
//in deletion Double pointer is a must.
```

------

## ✅ Summary

| Concept           | Meaning / Use Case                        |
| ----------------- | ----------------------------------------- |
| `*`               | Dereference pointer                       |
| `&`               | Address of a variable                     |
| `T *p`            | Pointer to type `T`                       |
| `T **pp`          | Pointer to pointer to type `T`            |
| String as `char*` | Traversable with pointer arithmetic       |
| Array & Pointer   | Arrays decay to pointers in most contexts |
| Double Pointer    | Needed for dynamic pointer manipulation   |
| Linked List       | Implemented with struct + pointe          |



