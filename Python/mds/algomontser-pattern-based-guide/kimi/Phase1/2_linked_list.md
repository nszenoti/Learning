# 2_linked_list

# **Pattern #2: Linked Lists**

## **Intuition & Recognition Cues**
Use linked lists when:
- You need **dynamic size** (frequent insertions/deletions).
- **Sequential access** is more frequent than random access.
- Memory overhead of pointers is acceptable.

**Recognize it in problems:**
- "Given a linked list..."
- "Insert/delete nodes in a list..."
- "Reverse a linked list..."

---

## **Core Templates & Blueprints**

### **Template 1: Basic Node Definition**
```python
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next
```

### **Template 2: Traversal (Iterative)**
```python
def traverse(head):
    current = head
    while current:
        print(current.val)
        current = current.next
```

### **Template 3: Insertion at Head**
```python
def insert_at_head(head, val):
    new_node = ListNode(val)
    new_node.next = head
    return new_node
```

### **Template 4: Deletion by Value**
```python
def delete_by_value(head, val):
    dummy = ListNode(0)
    dummy.next = head
    current = dummy
    while current.next:
        if current.next.val == val:
            current.next = current.next.next
        else:
            current = current.next
    return dummy.next
```

### **Template 5: Reverse Linked List (Iterative)**
```python
def reverse_linked_list(head):
    prev = None
    current = head
    while current:
        next_node = current.next
        current.next = prev
        prev = current
        current = next_node
    return prev
```

---

## **Key Variations**

| Pattern | When to Use | Example |
|---------|-------------|---------|
| **Reverse Linked List** | When you need to traverse in reverse or reverse the list | Reverse Linked List |
| **Detect Cycle (Floyd's Tortoise and Hare)** | When you suspect a cycle in the list | Linked List Cycle |
| **Merge Two Sorted Lists** | When you need to combine two sorted lists | Merge Two Sorted Lists |
| **Remove Nth Node From End of List** | When you need to remove a node based on position from the end | Remove Nth Node From End of List |
| **Palindrome Linked List** | When you need to check if the list is a palindrome | Palindrome Linked List |

---

## **Handpicked LeetCode Problems (Progressive)**

### **Level 1: Foundation (Do These First)**
1. **[206. Reverse Linked List](https://leetcode.com/problems/reverse-linked-list/)** - Basic reverse pattern
2. **[21. Merge Two Sorted Lists](https://leetcode.com/problems/merge-two-sorted-lists/)** - Merge pattern

### **Level 2: Recognition**
3. **[141. Linked List Cycle](https://leetcode.com/problems/linked-list-cycle/)** - Floyd's Tortoise and Hare
4. **[83. Remove Duplicates from Sorted List](https://leetcode.com/problems/remove-duplicates-from-sorted-list/)** - Deletion pattern

### **Level 3: Technique Application**
5. **[19. Remove Nth Node From End of List](https://leetcode.com/problems/remove-nth-node-from-end-of-list/)** - Two-pointer technique
6. **[234. Palindrome Linked List](https://leetcode.com/problems/palindrome-linked-list/)** - Reverse and compare

### **Level 4: Advanced Techniques**
7. **[146. LRU Cache](https://leetcode.com/problems/lru-cache/)** - Use of doubly linked list (optional)
8. **[147. Insertion Sort List](https://leetcode.com/problems/insertion-sort-list/)** - Insertion pattern

---

## **Common Pitfalls & Optimization Tricks**

### **Pitfalls:**
1. **Null pointer dereference:** Always check `if current is None` before accessing `current.next`.
2. **Cycle in list:** Be cautious of infinite loops; use Floyd's cycle detection if needed.
3. **Lost references:** When modifying pointers, ensure you don't lose track of the head or other nodes.
4. **Memory leaks:** In languages like C++, ensure you free nodes properly.

### **Optimization Tricks:**
- **Sentinel nodes:** Use dummy nodes to simplify edge cases (like inserting at head).
- **Two-pointer technique:** Use fast and slow pointers for cycle detection and removing nth node from end.
- **Reverse in place:** Reverse the list in place to save space and improve efficiency.

---

**🎯 Action Plan:**
1. **Today:** Read templates, solve Level 1-2 (4 problems)
2. **Tomorrow:** Solve Level 3 (2 problems)
3. **Day 3:** Solve Level 4 (2 problems) + write notes on each pattern

**— Done with Linked Lists? Ready to move to Pattern #3 (Stacks & Queues)?**