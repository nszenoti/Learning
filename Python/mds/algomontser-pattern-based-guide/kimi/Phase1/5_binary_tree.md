# 5_binary_tree

# **Pattern #5: Trees: Binary & BST**

## **Intuition & Recognition Cues**
Use trees when:
- You need to represent **hierarchical data**.
- You need to perform **search, insertion, and deletion** operations efficiently.
- You need to **traverse data in a specific order** (pre-order, in-order, post-order).

**Recognize it in problems:**
- "Given a binary tree..."
- "Given a binary search tree..."
- "Find the lowest common ancestor..."
- "Check if a tree is balanced..."

---

## **Core Templates & Blueprints**

### **Template 1: Basic Tree Node Definition**
```python
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right
```

### **Template 2: Pre-order Traversal (Recursive)**
```python
def preorder_traversal(root):
    if not root:
        return []
    return [root.val] + preorder_traversal(root.left) + preorder_traversal(root.right)
```

### **Template 3: In-order Traversal (Recursive)**
```python
def inorder_traversal(root):
    if not root:
        return []
    return inorder_traversal(root.left) + [root.val] + inorder_traversal(root.right)
```

### **Template 4: Post-order Traversal (Recursive)**
```python
def postorder_traversal(root):
    if not root:
        return []
    return postorder_traversal(root.left) + postorder_traversal(root.right) + [root.val]
```

### **Template 5: Level-order Traversal (Iterative)**
```python
from collections import deque

def level_order_traversal(root):
    if not root:
        return []
    result = []
    queue = deque([root])
    while queue:
        level_size = len(queue)
        current_level = []
        for _ in range(level_size):
            node = queue.popleft()
            current_level.append(node.val)
            if node.left:
                queue.append(node.left)
            if node.right:
                queue.append(node.right)
        result.append(current_level)
    return result
```

### **Template 6: Insertion in BST**
```python
def insert_into_bst(root, val):
    if not root:
        return TreeNode(val)
    if val < root.val:
        root.left = insert_into_bst(root.left, val)
    else:
        root.right = insert_into_bst(root.right, val)
    return root
```

### **Template 7: Search in BST**
```python
def search_in_bst(root, val):
    if not root:
        return None
    if val == root.val:
        return root
    elif val < root.val:
        return search_in_bst(root.left, val)
    else:
        return search_in_bst(root.right, val)
```

---

## **Key Variations**

| Pattern | When to Use | Example |
|---------|-------------|---------|
| **Tree Traversal** | When you need to visit all nodes in a specific order | [144. Binary Tree Preorder Traversal](https://leetcode.com/problems/binary-tree-preorder-traversal/) |
| **BST Operations** | When you need to insert, delete, or search in a BST | [700. Search in a Binary Search Tree](https://leetcode.com/problems/search-in-a-binary-search-tree/) |
| **Lowest Common Ancestor (LCA)** | When you need to find the LCA of two nodes | [235. Lowest Common Ancestor of a Binary Search Tree](https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-search-tree/) |
| **Balanced Tree Check** | When you need to check if a tree is balanced | [110. Balanced Binary Tree](https://leetcode.com/problems/balanced-binary-tree/) |
| **Tree Diameter** | When you need to find the diameter of a tree | [543. Diameter of Binary Tree](https://leetcode.com/problems/diameter-of-binary-tree/) |

---

## **Handpicked LeetCode Problems (Progressive)**

### **Level 1: Foundation (Do These First)**
1. **[144. Binary Tree Preorder Traversal](https://leetcode.com/problems/binary-tree-preorder-traversal/)** - Basic traversal
2. **[94. Binary Tree Inorder Traversal](https://leetcode.com/problems/binary-tree-inorder-traversal/)** - Basic traversal

### **Level 2: Recognition**
3. **[145. Binary Tree Postorder Traversal](https://leetcode.com/problems/binary-tree-postorder-traversal/)** - Basic traversal
4. **[102. Binary Tree Level Order Traversal](https://leetcode.com/problems/binary-tree-level-order-traversal/)** - Level-order traversal

### **Level 3: Technique Application**
5. **[700. Search in a Binary Search Tree](https://leetcode.com/problems/search-in-a-binary-search-tree/)** - BST search
6. **[450. Delete Node in a BST](https://leetcode.com/problems/delete-node-in-a-bst/)** - BST deletion

### **Level 4: Advanced Techniques**
7. **[235. Lowest Common Ancestor of a Binary Search Tree](https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-search-tree/)** - LCA in BST
8. **[110. Balanced Binary Tree](https://leetcode.com/problems/balanced-binary-tree/)** - Check if a tree is balanced

---

## **Common Pitfalls & Optimization Tricks**

### **Pitfalls:**
1. **Null pointer dereference:** Always check if a node is `None` before accessing its children.
2. **Traversal errors:** Ensure you follow the correct traversal order (pre-order, in-order, post-order).
3. **BST properties:** Ensure you maintain BST properties during insertions and deletions.
4. **Edge cases:** Handle edge cases like empty trees or single-node trees carefully.

### **Optimization Tricks:**
- **Recursive traversal:** Use recursion for simple traversal problems.
- **Iterative traversal:** Use iterative approaches with stacks for more complex traversal problems.
- **BST properties:** Leverage BST properties (left < root < right) for efficient search and insertion.
- **Height balancing:** Use height-balanced trees (like AVL or Red-Black trees) for more efficient operations.

---

**🎯 Action Plan:**
1. **Today:** Read templates, solve Level 1-2 (4 problems)
2. **Tomorrow:** Solve Level 3 (2 problems)
3. **Day 3:** Solve Level 4 (2 problems) + write notes on each pattern

**— Done with Trees: Binary & BST? Ready to move to Pattern #6 (Heaps / Priority Queues)?**