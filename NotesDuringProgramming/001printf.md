### **How to Use `printf()` in C**
The `printf()` function in C is used to print output to the console. It comes from the **stdio.h** library.

---

## **Basic Usage**
```c
#include <stdio.h>

int main() {
    printf("Hello, World!\n");
    return 0;
}
```
### **Output**
```
Hello, World!
```
✅ The `\n` adds a **new line** after printing.

---

the conversion specification:
%m.pX
m,p both a integer
X = {f,d,i,X,lf,c,s,e} 

m: minimum field width
p: precision 

scanf leave enter in the input buffer
Use getchar() to consume the leftover newline character

## **Using Format Specifiers**
Format specifiers tell `printf()` how to format different types of data.

| Format Specifier | Type        | Example |
|-----------------|------------|---------|
| `%d` or `%i`   | Integer     | `printf("%d", 42);` |
| `%f`           | Float       | `printf("%f", 3.14);` |
| `%.2f`         | Float (2 decimals) | `printf("%.2f", 3.14159);` → `3.14` |
| `%c`           | Character   | `printf("%c", 'A');` |
| `%s`           | String      | `printf("%s", "Hello");` |
| `%x` / `%X`    | Hexadecimal | `printf("%x", 255);` → `ff` |
| `%o`           | Octal       | `printf("%o", 8);` → `10` |

---

## **Examples**
### **Printing Different Data Types**
```c
#include <stdio.h>

int main() {
    int age = 25;
    float pi = 3.14159;
    char letter = 'A';
    char name[] = "Alice";

    printf("Age: %d\n", age);
    printf("Pi: %.2f\n", pi);
    printf("Letter: %c\n", letter);
    printf("Name: %s\n", name);

    return 0;
}
```
### **Output**
```
Age: 25
Pi: 3.14
Letter: A
Name: Alice
```

---

## **Printing Multiple Values**
```c
#include <stdio.h>

int main() {
    int x = 10, y = 20;
    printf("x = %d, y = %d\n", x, y);
    return 0;
}
```
✅ Values are printed in the same order as the format specifiers.

### **Output**
```
x = 10, y = 20
```

---

## **Aligning Output (Width and Precision)**
| Format | Example | Output |
|--------|---------|--------|
| `%5d` | `printf("%5d", 42);` | `   42` (Right-aligned) |
| `%-5d` | `printf("%-5d", 42);` | `42   ` (Left-aligned) |
| `%7.2f` | `printf("%7.2f", 3.14);` | `   3.14` (Right-aligned float) |

---

## **Escape Sequences**
| Escape Sequence | Meaning | Example |
|----------------|---------|---------|
| `\n` | New line | `printf("Hello\nWorld");` |
| `\t` | Tab space | `printf("Hello\tWorld");` |
| `\\` | Print backslash | `printf("C:\\Program Files");` |
| `\"` | Print double quote | `printf("\"Hello\"");` |

---

### **Example: Escape Sequences**
```c
#include <stdio.h>

int main() {
    printf("Hello\nWorld!\n");
    printf("C:\\Users\\Documents\n");
    printf("She said, \"C is fun!\"\n");
    return 0;
}
```
### **Output**
```
Hello
World!
C:\Users\Documents
She said, "C is fun!"
```

---

### **Key Takeaways**
✔ Use **format specifiers** to print different data types.  
✔ Use **escape sequences** for special formatting.  
✔ **Width and precision** control alignment and decimal places.  

Would you like an example of **printing user input** with `printf()` and `scanf()`? 🚀


Most modern C compilers can detect incorrect format specifiers if you enable warnings.
gcc -Wall -Wextra -o program program.c