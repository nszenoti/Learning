# 1_kimi_dsa

https://www.kimi.com/chat/19b974c5-1f52-82bc-8000-09fe66071f5f

# **Python DSA Problem Solving Cheatsheet for LeetCode**

This comprehensive cheatsheet covers essential Python features, patterns, and optimization tricks specifically for data structures and algorithms problem solving.

---

## **1. Core Data Structures & Their Complexities**

### **Lists**
```python
# Initialization
arr = []
arr = [0] * n  # Fixed size
arr = [[0] * m for _ in range(n)]  # 2D list (avoid using * n!)

# Key operations
arr.append(x)    # O(1) amortized
arr.pop()        # O(1) amortized
arr.pop(0)       # O(n) - avoid
arr.insert(0, x) # O(n) - avoid
arr[i:j]         # O(j-i) slicing
```

### **Sets** - O(1) avg for lookup/insert/delete
```python
s = set()
s.add(x); s.remove(x); x in s  # All O(1) average

# String to char set
char_set = set(string)

# Remove duplicates from list
unique = list(set(my_list))
```

### **Dictionaries**
```python
# Counting pattern
freq = {}
for x in arr: freq[x] = freq.get(x, 0) + 1

# Or use Counter (see Collections section)
```

---

## **2. Essential Built-in Functions**

```python
# Enumeration
for i, val in enumerate(nums):  # Get index + value
    pass

# Multiple iteration
for a, b in zip(list1, list2):  # Iterate two lists simultaneously

# All/Any
if all(x > 0 for x in arr):     # True if all conditions met
if any(x < 0 for x in arr):     # True if any condition met

# Range with step
for i in range(start, end, step):  # step can be negative

# Divmod - quotient and remainder
q, r = divmod(a, b)  # Equivalent to (a//b, a%b)

# Type conversion
int(a < b)  # Returns 1 if True, 0 if False (useful for counting)
```

---

## **3. List/Dict/Set Comprehensions**

```python
# List comprehension
squares = [x**2 for x in range(10)]
evens = [x for x in nums if x % 2 == 0]
matrix = [[0]*n for _ in range(m)]  # 2D initialization

# Dict comprehension
freq = {x: nums.count(x) for x in set(nums)}  # Count frequency
idx_map = {val: i for i, val in enumerate(nums)}  # Value to index

# Set comprehension
unique_squares = {x**2 for x in nums}
```

---

## **4. Collections Module - Your Best Friend**

```python
from collections import defaultdict, Counter, deque

# Counter - frequency counting
freq = Counter(nums)  # O(n) initialization
most_common = freq.most_common(k)  # Get top k elements
if freq[val] > 0:  # Check existence

# defaultdict - avoid KeyError
graph = defaultdict(list)  # Auto-creates empty list
graph[node].append(neighbor)  # No need to check if key exists

# deque - Stack, Queue, and LinkedList in one
dq = deque()
dq.append(x)      # Add right (list.append)
dq.appendleft(x)  # Add left
dq.pop()          # Remove right (stack pop)
dq.popleft()      # Remove left (queue pop)
# All operations O(1) amortized
```

---

## **5. String Manipulation Tricks**

```python
# NEVER concatenate strings in a loop (O(n²))
# Instead, use join()
result = ''.join(list_of_chars)  # O(n)

# String to list of chars
chars = list(s)

# Check if string is numeric
if s.isdigit():  # For whole numbers only

# Character manipulation
ord('a')  # 97 - get ASCII value
chr(97)   # 'a' - get char from ASCII

# Build result string efficiently
parts = []
for c in some_iterable:
    parts.append(process(c))
return ''.join(parts)
```

---

## **6. Math & Bitwise Operations**

```python
import math, itertools

# Math utilities
math.inf, -math.inf  # Infinite values
math.gcd(a, b)       # Greatest common divisor
math.ceil(x), math.floor(x)
math.pow(x, y)

# Bitwise tricks
arr[l]^arr[l+1]^...^arr[r] = prefix[r] ^ prefix[l-1]  # XOR prefix sum

# Check/set bits
mask = 1 << i  # Set ith bit
if num & mask:  # Check ith bit
num |= mask    # Set bit to 1
num &= ~mask   # Set bit to 0

# Power of 2 operations
n >> 1  # n // 2 (faster)
n << 1  # n * 2

# Bitmask for state representation
state = 0
for c in word:
    state |= 1 << (ord(c) - ord('a'))  # Set bit for each char
```

---

## **7. Itertools & Functional Tools**

```python
from itertools import accumulate, pairwise, permutations, combinations
from functools import cmp_to_key, cache

# accumulate - prefix sums
prefix = list accumulate(nums, initial=0))  # [0, nums[0], nums[0]+nums[1], ...]

# pairwise - adjacent pairs
for a, b in pairwise(nums):  # (nums[0], nums[1]), (nums[1], nums[2]), ...

# Custom sorting
sorted_list = sorted(nums, key=cmp_to_key(custom_compare))  # When key function is complex

# @cache - automatic memoization
@cache
def dp(i, j):
    # Your recursive DP logic
    pass
# Equivalent to storing results in a dict, but cleaner
```

---

## **8. Common DSA Patterns**

### **Pattern 1: Leftmost Binary Search**
```python
def leftmost_bs(arr, target):
    """Returns leftmost index or insertion position"""
    left, right = 0, len(arr)  # Note: right is exclusive
    while left < right:
        mid = left + (right - left) // 2
        if arr[mid] < target:
            left = mid + 1
        else:
            right = mid
    return left  # First occurrence or insertion index

# Find first and last position:
first = leftmost_bs(arr, target)
last = leftmost_bs(arr, target + 1) - 1
```

### **Pattern 2: Two Pointers**
```python
# Slow/Fast pointers for linked lists
def find_middle(head):
    slow = fast = head
    while fast and fast.next:
        slow = slow.next
        fast = fast.next.next
    return slow

# Sliding window
left = 0
for right in range(n):
    # Add element
    while condition_violated():
        # Remove element at left
        left += 1
    # Update answer
```

### **Pattern 3: QuickSelect - Find Kth Element**
```python
def quickselect(arr, k):
    """Find k-th smallest in average O(n)"""
    if len(arr) == 1: return arr[0]
    pivot = arr[len(arr)//2]
    left = [x for x in arr if x < pivot]
    mid = [x for x in arr if x == pivot]
    right = [x for x in arr if x > pivot]
    
    if k <= len(left): return quickselect(left, k)
    elif k <= len(left) + len(mid): return mid[0]
    else: return quickselect(right, k - len(left) - len(mid))
```

---

## **9. Tree & Graph Techniques**

```python
# Dummy node for linked lists
dummy = ListNode(0, head)  # Simplifies edge cases
current = dummy
while current.next:
    # Process
    current = current.next
return dummy.next

# Inorder BST traversal gives sorted order
def inorder(root):
    return inorder(root.left) + [root.val] + inorder(root.right) if root else []

# Graph DFS/BFS patterns
def dfs(node, visited):
    visited.add(node)
    for neighbor in graph[node]:
        if neighbor not in visited:
            dfs(neighbor, visited)

def bfs(start):
    q, visited = deque([start]), {start}
    while q:
        node = q.popleft()
        for neighbor in graph[node]:
            if neighbor not in visited:
                visited.add(neighbor)
                q.append(neighbor)
```

---

## **10. Dynamic Programming Essentials**

```python
# Top-down with @cache
@cache
def dp(i):
    if i >= n: return base_case
    return max(dp(i+1), dp(i+2) + nums[i])

# Bottom-up
dp = [0] * (n+1)
dp[0] = base_case
for i in range(1, n+1):
    dp[i] = max(dp[i-1], dp[i-2] + nums[i-1])

# Space optimization
prev, curr = 0, 0
for num in nums:
    prev, curr = curr, max(curr, prev + num)
```

---

## **11. Spiral Matrix & Direction Control**
```python
# Direction vectors for 4 directions (right, down, left, up)
dirs = (0, 1, 0, -1, 0)  # Extra 0 for easy indexing
k = 0  # Current direction index

# Move in current direction
dr, dc = dirs[k], dirs[k+1]
new_r, new_c = r + dr, c + dc

# Turn right
k = (k + 1) % 4
```

---

## **12. Performance Optimization Tips**

| Operation | Slow (Avoid) | Fast (Use) |
|-----------|--------------|------------|
| String concat | `s += c` in loop | `''join(list)` |
| List prepend | `arr.insert(0, x)` | `deque.appendleft()` |
| Lookup by value | `x in list` | `x in set` |
| Function calls | Expensive in loops | Inline simple operations |
| Global variables | Slow access | Local variables |
| Dot notation in loops | `self.attr` repeated | Cache in local variable |

```python
# Example: Cache attribute access
def process(self, data):
    # Instead of repeated self.func calls
    func = self.func
    return [func(x) for x in data]
```

---

## **13. Essential Code Templates**

```python
# 1. Iterate with both index and value
for i, val in enumerate(nums):
    pass

# 2. Sort with custom comparator
sorted_pairs = sorted(pairs, key=lambda x: (x[0], -x[1]))

# 3. Count frequency efficiently
freq = Counter(words)
for word, count in freq.items():
    pass

# 4. Handle missing keys
value = my_dict.get(key, default_value)  # Returns None if not found

# 5. Reverse iteration
for i in range(len(nums)-1, -1, -1):
    pass

# 6. Use heap for top k
import heapq
heap = [-x for x in nums]  # Max heap simulation
heapq.heapify(heap)
top_k = [-heapq.heappop(heap) for _ in range(k)]
```

---

## **14. Debugging & Testing Quick Tips**

```python
# Use @cache to debug memoization
@cache
def fib(n):
    return fib(n-1) + fib(n-2) if n > 1 else n

# Print debug info
print(f"DEBUG: i={i}, dp[i]={dp[i]}")

# Test edge cases
if not nums: return 0  # Empty input
if len(nums) == 1: return nums[0]  # Single element

# Use assertions
assert len(nums) == len(expected), "Length mismatch"

# Interactive debugging
import pdb; pdb.set_trace()  # Or breakpoint() in Python 3.7+
```

---

## **15. Time/Space Complexity Quick Reference**

```python
# Lists
append/pop()       : O(1) amortized
insert(0)/pop(0)   : O(n)
slice [i:j]        : O(j-i)

# Sets/Dicts (hash table)
add/remove/lookup  : O(1) average, O(n) worst

# Sorting
sorted()           : O(n log n)
list.sort()        : O(n log n)

# Heaps (heapq)
push/pop           : O(log n)
heapify            : O(n)

# Built-in functions
any/all()          : O(n)
min()/max()        : O(n)
collections.Counter: O(n)
```

---

## **16. Final Pro Tips**

- **Pre-compute**: Store expensive calculations in variables
- **Early exit**: Use `return` as soon as you find answer
- **Dead code elimination**: Remove unused variables and functions
- **Know your defaults**: Use `math.inf, -math.inf` for comparisons
- **Type hints**: Use for clarity (not required for interviews)
- **Readability**: Clear code > Clever code

```python
# Example: Clean and efficient pattern
def find_pairs(nums):
    seen = set()
    result = []
    for num in nums:
        if target - num in seen:  # O(1) lookup
            result.append((num, target - num))
        seen.add(num)
    return result
```

---

**Sources**: 

For a complete free study guide with interactive examples, visit: https://www.piratekingdom.com/blog/my-ultimate-leetcode-tricks 