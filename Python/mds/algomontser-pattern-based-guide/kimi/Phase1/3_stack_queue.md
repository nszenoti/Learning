# 3_stack_queue

# **Pattern #3: Stacks & Queues**

## **Intuition & Recognition Cues**
Use stacks when:
- You need **Last-In-First-Out (LIFO)** access.
- You're dealing with nested structures (parentheses, brackets).
- You need to reverse the order of elements.

Use queues when:
- You need **First-In-First-Out (FIFO)** access.
- You're dealing with breadth-first traversal (BFS).
- You need to maintain the order of elements.

**Recognize it in problems:**
- "Evaluate expression..."
- "Validate parentheses..."
- "Breadth-first search..."
- "Level-order traversal..."

---

## **Core Templates & Blueprints**

### **Template 1: Basic Stack Operations**
```python
class Stack:
    def __init__(self):
        self.items = []

    def push(self, item):
        self.items.append(item)

    def pop(self):
        if not self.is_empty():
            return self.items.pop()
        return None

    def peek(self):
        if not self.is_empty():
            return self.items[-1]
        return None

    def is_empty(self):
        return len(self.items) == 0
```

### **Template 2: Basic Queue Operations**
```python
from collections import deque

class Queue:
    def __init__(self):
        self.items = deque()

    def enqueue(self, item):
        self.items.append(item)

    def dequeue(self):
        if not self.is_empty():
            return self.items.popleft()
        return None

    def is_empty(self):
        return len(self.items) == 0
```

### **Template 3: Monotonic Stack (Decreasing)**
```python
def monotonic_stack(arr):
    stack = []
    result = []
    for i in range(len(arr)):
        while stack and arr[stack[-1]] < arr[i]:
            stack.pop()
        result.append(stack[-1] if stack else -1)
        stack.append(i)
    return result
```

### **Template 4: BFS Using Queue**
```python
def bfs(graph, start):
    visited = set()
    queue = Queue()
    queue.enqueue(start)
    while not queue.is_empty():
        node = queue.dequeue()
        if node not in visited:
            visited.add(node)
            for neighbor in graph[node]:
                queue.enqueue(neighbor)
    return visited
```

---

## **Key Variations**

| Pattern | When to Use | Example |
|---------|-------------|---------|
| **Monotonic Stack** | When you need to find next greater/lesser element | Daily Temperatures |
| **Balanced Parentheses** | When you need to validate nested structures | Valid Parentheses |
| **BFS Traversal** | When you need to traverse a graph level by level | Binary Tree Level Order Traversal |
| **Sliding Window Maximum** | When you need to find max in a sliding window | Sliding Window Maximum |

---

## **Handpicked LeetCode Problems (Progressive)**

### **Level 1: Foundation (Do These First)**
1. **[20. Valid Parentheses](https://leetcode.com/problems/valid-parentheses/)** - Basic stack for balanced parentheses
2. **[225. Implement Stack using Queues](https://leetcode.com/problems/implement-stack-using-queues/)** - Stack operations

### **Level 2: Recognition**
3. **[739. Daily Temperatures](https://leetcode.com/problems/daily-temperatures/)** - Monotonic stack
4. **[1046. Last Stone Weight](https://leetcode.com/problems/last-stone-weight/)** - Heap (priority queue)

### **Level 3: Technique Application**
5. **[102. Binary Tree Level Order Traversal](https://leetcode.com/problems/binary-tree-level-order-traversal/)** - BFS using queue
6. **[239. Sliding Window Maximum](https://leetcode.com/problems/sliding-window-maximum/)** - Monotonic deque

### **Level 4: Advanced Techniques**
7. **[84. Largest Rectangle in Histogram](https://leetcode.com/problems/largest-rectangle-in-histogram/)** - Monotonic stack
8. **[402. Remove K Digits](https://leetcode.com/problems/remove-k-digits/)** - Monotonic stack

---

## **Common Pitfalls & Optimization Tricks**

### **Pitfalls:**
1. **Stack overflow:** Be cautious of deep recursion or large input sizes.
2. **Queue underflow:** Ensure the queue is not empty before dequeuing.
3. **Incorrect order:** Ensure you're using the correct data structure (stack vs. queue) for the problem.
4. **Edge cases:** Handle empty inputs or single-element cases carefully.

### **Optimization Tricks:**
- **Monotonic stack:** Use a stack to keep track of elements in decreasing/increasing order.
- **Double-ended queue:** Use `collections.deque` for efficient O(1) operations at both ends.
- **BFS optimization:** Use a set to track visited nodes to avoid revisiting.

---

**🎯 Action Plan:**
1. **Today:** Read templates, solve Level 1-2 (4 problems)
2. **Tomorrow:** Solve Level 3 (2 problems)
3. **Day 3:** Solve Level 4 (2 problems) + write notes on each pattern

**— Done with Stacks & Queues? Ready to move to Pattern #4 (Hash Tables)?**