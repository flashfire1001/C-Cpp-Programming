# C++ STL: Standard Template Library

The **Standard Template Library (STL)** is a powerful feature of C++ that provides a collection of **template-based classes and functions.** It enables developers to use well-tested, generic components for **common data structures and algorithms,** promoting code reusability and efficiency.

The STL is composed of five key components:

-   **Algorithms**
-   **Containers**
-   **Iterators**
-   **Function objects (functors)**
-   **Adaptors**

In this article, we will focus on the first three: **algorithms**, **containers**, and **iterators**.

------

## 1. Algorithms

STL contains standard and vetted (compatible) implementation of algorithm for sorting searching and partitioning.

**Examples of STL algorithms:**

-   `sort()`: Sorts a range in ascending order.
-   `find()`: Searches for a value in a range.
-   `count()`: Counts occurrences of a value.
-   `reverse()`: Reverses the order of elements in a range.
-   `accumulate()` (from `<numeric>`): Computes the sum of a range.

**Example:**

```cpp
#include <iostream>
#include <vector>
#include <algorithm> // for sort, find, count, reverse
#include <numeric>   // for accumulate

int main() {
    std::vector<int> numbers = {4, 2, 5, 2, 7, 2, 9, 1};

    // 1. Sort the vector in ascending(default) order using std::sort
    std::sort(numbers.begin(), numbers.end());// give the range (pointers)
    std::cout << "Sorted: ";
    for (int n : numbers) std::cout << n << " ";
    std::cout << '\n';
    // Output: 1 2 2 2 4 5 7 9

    // 2. Find the first occurrence of 5
    auto it = std::find(numbers.begin(), numbers.end(), 5);
    if (it != numbers.end()) {
        std::cout << "Found 5 at index: " << std::distance(numbers.begin(), it) << '\n';
    }

    // 3. Count how many times 2 appears
    int count_2 = std::count(numbers.begin(), numbers.end(), 2);
    std::cout << "Number of times 2 appears: " << count_2 << '\n';

    // 4. Reverse the vector
    std::reverse(numbers.begin(), numbers.end());
    std::cout << "Reversed: ";
    for (int n : numbers) std::cout << n << " ";
    std::cout << '\n';

    // 5. Compute the sum of all elements
    int sum = std::accumulate(numbers.begin(), numbers.end(), 0);
    std::cout << "Sum of elements: " << sum << '\n';

    return 0;
}

output:

Sorted: 1 2 2 2 4 5 7 9 
Found 5 at index: 5
Number of times 2 appears: 3
Reversed: 9 7 5 4 2 2 2 1 
Sum of elements: 32

```

------

## 2. Containers

STL containers store collections of objects. Each container is designed for a specific purpose and offers unique performance characteristics. Containers are categorized into three main types:

### a. Sequence Containers

Maintain the order of inserted elements.

-   `vector`
-   `deque`
-   `list`
-   `array` (from C++11)

### b. Associative Containers

Store elements in sorted order with fast lookup.`set`,`map`,etc.

### c. Unordered Associative Containers (from C++11)

Use hash tables for faster access.`unordered_set`,`unordered_map`

**Example:**(key points on vector):

```cpp
/*
基本特性:

动态大小：vector 的大小可以根据需要自动增长和缩小。
连续存储：vector 中的元素在内存中是连续存储的，这使得访问元素非常快速。
可迭代：vector 可以被迭代，你可以使用循环（如 for 循环）来访问它的元素。
元素类型：vector 可以存储任何类型的元素，包括内置类型、对象、指针等。

使用场景：

当你需要一个可以动态增长和缩小的数组时。
当你需要频繁地在序列的末尾添加或移除元素时。
当你需要一个可以高效随机访问元素的容器时

*/


#include <iostream>
#include <vector>

int main() {
    // 创建一个整数向量
    std::vector<int> myVector = {1,2};//initialise using vector <type> name = {elements};
	
    // 添加元素到向量中
    myVector.push_back(3);
    myVector.push_back(7);
    myVector.push_back(11);
    myVector.push_back(5);
    
	myVector.pop_back();//remove an element from the end of the vector
    
    // 访问向量中的元素并输出 method 1
    std::cout << "Elements in the vector: ";
    for (int element : myVector) {
        std::cout << element << " ";
    }
    std::cout << std::endl;
    //access the element, method 2
    std::cout << "Elements in the vector: ";
	for (int i = 0; i< myVector.size(); i++){
        std::cout << myVector.at(i)<<" ";
    }
    // 访问向量中的第一个元素并输出
    std::cout << "First element: " << myVector[0] << std::endl;

    // 访问向量中的第二个元素并输出
    std::cout << "Second element: " << myVector.at(1) << std::endl;

    // 获取向量的大小并输出
    std::cout << "Size of the vector: " << myVector.size() << std::endl;

    // 删除向量中的第三个元素
    myVector.erase(myVector.begin() + 2); //

    // 输出删除元素后的向量
    std::cout << "Elements in the vector after erasing: ";
    for (int element : myVector) {
        std::cout << element << " ";
    }
    std::cout << std::endl;

    // 清空向量并输出
    myVector.clear();
    std::cout << "Size of the vector after clearing: " << myVector.size() << std::endl;

    return 0;
}
```

------



------

## 3. Iterators

Iterators are used to access and navigate through the elements of STL containers. They act as generalized pointers and are crucial for connecting containers and algorithms. STL provides various types of iterators:

-   **Input Iterator**: Reads data from the container.
-   **Output Iterator**: Writes data to the container.
-   **Forward Iterator**: Can read and write in a single forward pass.
-   **Bidirectional Iterator**: Can move forward and backward.
-   **Random Access Iterator**: Supports full pointer arithmetic.

**Example:**

```cpp
#include <iostream>
#include <vector>

/*
- auto meanings get the type dynamically
- ++it is same as it++ but more efficient
- in the rbegin and rend() the ++it is still used because the ++ operator is overloaded for convenience.
*/
int main() {
    std::vector<int> v = {1, 2, 3, 4, 5};

    std::cout << "Forward: ";
    for (auto it = v.begin(); it != v.end(); ++it)
        std::cout << *it << " ";

    std::cout << "\nReverse: ";
    for (auto rit = v.rbegin(); rit != v.rend(); ++rit)
        std::cout << *rit << " ";

    return 0;
}

```

This demonstrates how iterators provide access to the elements in a container.

------





