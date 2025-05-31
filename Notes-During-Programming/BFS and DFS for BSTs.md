# The DFS and BFS for binary tree

### DFS

DFS means you go **deep** into the tree **before** moving sideways.

There are **three types** of DFS traversal for binary trees:

| Type      | Order               |
| --------- | ------------------- |
| Inorder   | Left → Node → Right |
| Preorder  | Node → Left → Right |
| Postorder | Left → Right → Node |

as we have already know them in the traverse of a tree, here we just put  an exhibition:

```cpp
#include <iostream>
using namespace std;

struct Node {
    int data;
    Node* left;
    Node* right;
//constructor
    Node(int value) {
        data = value;
        left = right = nullptr;
    }
};

// Inorder DFS
void inorder(Node* root) {
    if (root == nullptr) return;
    inorder(root->left);
    cout << root->data << " ";
    inorder(root->right);
}

// Preorder DFS
void preorder(Node* root) {
    if (root == nullptr) return;
    cout << root->data << " ";
    preorder(root->left);
    preorder(root->right);
}

// Postorder DFS
void postorder(Node* root) {
    if (root == nullptr) return;
    postorder(root->left);
    postorder(root->right);
    cout << root->data << " ";
}

int main() {
    // Build the tree
    Node* root = new Node(1);
    root->left = new Node(2);
    root->right = new Node(3);
    root->left->left = new Node(4);
    root->left->right = new Node(5);

    cout << "Inorder: ";
    inorder(root); // 4 2 5 1 3
    cout << "\nPreorder: ";
    preorder(root); // 1 2 4 5 3
    cout << "\nPostorder: ";
    postorder(root); // 4 5 2 3 1

    return 0;
}

```

The DFS is quite basic, compare to it, BFS is less intuitive.

###BFS

To **do a breadth-first traversal** (often called **Breadth-First Search, BFS**) on a data structure like a **tree** or a **graph**, you explore all the nodes level by level—i.e., you visit all the nodes at the current depth before going to the next level.

the implementation in C++

```cpp
#include <iostream>
#include <queue>//use standard lib for container queue
using namespace std;

struct Node {
    int data;
    Node* left;
    Node* right;
    
    Node(int val) : data(val), left(nullptr), right(nullptr) {}
};

void bfs(Node* root) {
    if (!root) return;

    queue<Node*> q;//the syntax of creating a queue of a specific type
    q.push(root);

    while (!q.empty()) {
        Node* current = q.front();
        q.pop();

        cout << current->data << " ";

        if (current->left)
            q.push(current->left);
        if (current->right)
            q.push(current->right);
    }
}

int main() {
    Node* root = new Node(1);
    root->left = new Node(2);
    root->right = new Node(3);
    root->left->left = new Node(4);
    root->left->right = new Node(5);

    bfs(root); // Output: 1 2 3 4 5

    return 0;
}

```

#### ✅ Key Ideas

-   Use a **queue** to remember the next nodes (put the next level in the waiting line) to visit.
-   Push the **left and right children** of each node into the queue.
-   Keep looping until the queue is empty.

It is the key characteristic that make it : A queue keeps things in the order you added them — **first in, first out (FIFO)**

a graph for the executing process:

```markdown
        1
       / \
      2   3
     / \
    4   5



Tree:            Queue:         Output:
   1             [1]              -
                 []              1
               Push 2, 3

   2             [2, 3]           1
                 [3]             2
               Push 4, 5

   3             [3, 4, 5]        1 2
                 [4, 5]          3
               (3 has no children)

   4             [4, 5]           1 2 3
                 [5]             4
               (4 has no children)

   5             [5]             1 2 3 4
                 []              5
               (5 has no children)

Final Output: 1 2 3 4 5

```



