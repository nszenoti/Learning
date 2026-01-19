# Python_Nuance_Hidden_Tricks

https://www.kimi.com/chat/19b974c5-1f52-82bc-8000-09fe66071f5f

# **Python Nuances & Hidden Tricks for LeetCode Masters**

These are the **Pythonista secrets** that separate good solutions from great ones—and help debug WA/TLE faster.

---

## **1. Introspection & Debugging Arsenal**

```python
# dir() - Explore object attributes
print(dir([]))  # Shows all list methods: append, pop, reverse...
print(dir(set))  # Discover 'isdisjoint', 'issubset' you forgot about

# vars() - See object's __dict__ (great for custom classes)
print(vars(trie_node))  # Shows all instance variables and values

# locals() & globals() - Debug variable state in functions
def dfs(node):
    if not node: 
        print("LOCALS:", locals())  # Shows node, path, visited, etc.
        return

# help() - Quick documentation in shell
help(list.extend)  # Shows signature and docstring instantly

# type() with __mro__ - Understand inheritance
print(type(my_obj).__mro__)  # Shows method resolution order

# __repr__ override for debugging
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right
    
    def __repr__(self):  # Makes print(tree) useful!
        return f"TreeNode({self.val}, {self.left}, {self.right})"
```

---

## **2. Performance Killers & TLE Traps**

```python
# ❶ NEVER concatenate strings in loops - O(n²) copying
# BAD
s = ""
for char in chars: s += char  # Creates new string each time

# GOOD
s = ''.join(chars)  # O(n) single allocation

# ❷ List multiplication trap - shallow copies
# BAD
matrix = [[0]*3]*3  # 3 references to SAME inner list
matrix[0][0] = 1    # Modifies all rows!

# GOOD
matrix = [[0]*3 for _ in range(3)]  # Separate lists

# ❸ Global variable access is SLOW
# BAD
def dfs():
    global result  # Slower lookup
    result += 1

# GOOD
def solve():
    result = 0  # Local variable
    def dfs():
        nonlocal result  # Faster than global
        result += 1

# ❹ Chained attribute access
# BAD
for i in range(n): self.graph[i].append(...)  # Repeated attribute lookup

# GOOD
graph = self.graph  # Cache in local variable
for i in range(n): graph[i].append(...)

# ❺ Inefficient list operations
# BAD
for x in arr: arr.insert(0, x)  # O(n²) - shifts entire list each time

# GOOD
arr.reverse()  # Or use deque for O(1) prepend
```

---

## **3. Hidden Python Features for DSA**

```python
# ❶ Walrus operator Python 3.8+ (assign in expressions)
# Instead of:
while queue:
    node = queue.popleft()
    if node: process(node)

# Do:
while (node := queue.popleft()):
    process(node)

# Use in list comprehensions
squares = [y for x in nums if (y := x*x) < 100]

# ❷ Underscore _ for unused variables
for _ in range(10):  # When index not needed
    do_something()

# ❸ Ellipsis ... as placeholder
matrix = [[...]*n for _ in range(n)]  # Mark unvisited cells
def dfs(x):
    if x == target: return [...]  # Placeholder return

# ❹ collections._replace for namedtuples
from collections import namedtuple
Point = namedtuple('Point', ['x', 'y'])
p = Point(1, 2)
p = p._replace(x=5)  # Creates new Point(5, 2) - immutable update

# ❺ bisect module - Binary search without writing it
import bisect
arr = [1, 3, 4, 4, 6, 8]

bisect_left(arr, 4)   # Index of first 4 → 2
bisect_right(arr, 4)  # Index after last 4 → 4

# Count occurrences of x
count = bisect_right(arr, x) - bisect_left(arr, x)

# Find insertion point to maintain sorted order
idx = bisect.bisect(arr, 5)  # → 4 (insert before 6)

# ❺ math.comb & math.perm Python 3.8+
math.comb(5, 2)  # C(5,2) = 10
math.perm(5, 2)  # P(5,2) = 20
```

---

## **4. Common WA Pitfalls**

```python
# ❶ Modifying dict while iterating
# WRONG - RuntimeError
for k in my_dict:
    if condition: del my_dict[k]

# CORRECT
keys_to_del = [k for k in my_dict if condition]
for k in keys_to_del: del my_dict[k]

# Or iterate over list of keys
for k in list(my_dict.keys()):
    if condition: del my_dict[k]

# ❷ Default mutable arguments
# WRONG - Same list shared across calls!
def append(value, lst=[]):
    lst.append(value)
    return lst

# CORRECT
def append(value, lst=None):
    if lst is None: lst = []
    lst.append(value)
    return lst

# ❸ Copying references
# WRONG
path = [1, 2, 3]
result.append(path)  # Appends reference
path.append(4)       # Modifies result[-1] too!

# CORRECT
result.append(path.copy())  # Or list(path), path[:]

# ❹ Float('inf') vs None for initialization
# WRONG for comparisons
min_val = None
if x < min_val:  # TypeError!

# CORRECT
min_val = float('inf')
if x < min_val: min_val = x

# ❺ Integer division pitfalls
# Python 3: / is float division, // is floor division
-3 // 2  # Returns -2 (floors toward negative infinity)
# For problems requiring truncation:
int(-3 / 2)  # Returns -1 (truncates toward zero)

# ❻ is vs == with None
# ALWAYS use 'is' for None, True, False
if x is None:  # Correct
if x == None:  # Wrong - slower, can be overridden
```

---

## **5. Pythonic Idioms That Save Time**

```python
# ❹ Swap values in one line
a, b = b, a

# ❺ Reverse list with slice
nums[::-1]  # Returns reversed copy
nums.reverse()  # In-place reversal

# ❻ Use any() / all() with generators (short-circuits)
if any(node.val == target for node in level):  # Fast exit
if all(x < y for x, y in zip(arr1, arr2)):

# ❼ Enumerate with start index
for i, val in enumerate(nums, 1):  # Start from 1, not 0

# ❽ Flatten nested lists
flat = [x for sublist in nested for x in sublist]

# ❾ Ternary operator
value = x if x > 0 else y  # More readable than value = x > 0 and x or y

# ❿ Check multiple conditions
if a < x < b:  # Chained comparison (a < x and x < b)
```

---

## **6. Debugging WA with Python Tools**

```python
# ❶ Assertions for invariants
def binary_search(arr, target):
    left, right = 0, len(arr)
    while left < right:
        mid = left + (right - left) // 2
        assert 0 <= mid < len(arr), f"Invalid mid: {mid}"  # Catches bugs early
        # ...

# ❷ Debugging recursive DFS
def dfs(node, depth=0):
    print(f"{'  '*depth}dfs({node.val if node else None})")  # Visualize recursion tree
    if not node: return
    # ...

# ❸ Use __slots__ for memory optimization
class TreeNode:
    __slots__ = ('val', 'left', 'right')  # Reduces memory by ~30% for many nodes
    def __init__(self, val=0, left=None, right=None):
        self.val = val; self.left = left; self.right = right

# ❹ Context managers for resource tracking
from contextlib import contextmanager
import time

@contextmanager
def timer(name):
    start = time.perf_counter()
    yield
    print(f"{name} took {time.perf_counter() - start:.4f}s")

with timer("dfs"):
    dfs(root)

# ❺ Use f-strings for readable debug output
print(f"{node.val=}, {left_height=}, {right_height=}")  # Prints: node.val=5, left_height=3, ...
```

---

## **7. LeetCode-Specific Hacks**

```python
# ❶ Quick tree/node creation for testing
# LeetCode format: [1,2,3,null,5]
def build_tree(arr):
    if not arr: return None
    nodes = [None if val is None else TreeNode(val) for val in arr]
    kids = nodes[::-1]
    root = kids.pop()
    for node in nodes:
        if node:
            if kids: node.left = kids.pop()
            if kids: node.right = kids.pop()
    return root

# ❷ Custom comparator for sorted() (Py2 style via functools)
# For complex sorting where lambda won't work
from functools import cmp_to_key

def compare(a, b):
    # Return negative if a < b, 0 if equal, positive if a > b
    if len(a) != len(b): return len(a) - len(b)
    return -1 if a < b else (1 if a > b else 0)

sorted_strings = sorted(words, key=cmp_to_key(compare))

# ❸ Reversing linked list (in-place pointer manipulation)
def reverse_list(head):
    prev, curr = None, head
    while curr:
        curr.next, prev, curr = prev, curr, curr.next  # Tuple assignment magic
    return prev

# ❹ Detect cycle in linked list (Floyd's Tortoise-Hare)
def has_cycle(head):
    slow = fast = head
    while fast and fast.next:
        slow, fast = slow.next, fast.next.next
        if slow is fast:  # 'is' for object identity
            return True
    return False

# ❺ LRU Cache pattern (Python's built-in!)
from functools import lru_cache

@lru_cache(maxsize=None)  # None = unlimited cache
def expensive_function(n):
    # Your DP logic here
    pass

# ❻ Use array for grid problems (memory efficient)
from array import array
grid = [array('b', row) for row in matrix]  # 'b' = signed char
```

---

## **8. The "Pythonista" One-Liners**

```python
# Count frequency of all elements
freq = {k: nums.count(k) for k in set(nums)}  # O(n²) - BAD
freq = Counter(nums)  # O(n) - GOOD

# Find first index matching condition
next(i for i, x in enumerate(nums) if x > 5)  # Returns first match
next((i for i, x in enumerate(nums) if x > 5), -1)  # With default -1

# Cartesian product
pairs = [(x, y) for x in arr1 for y in arr2]

# Group by key
from itertools import groupby
grouped = {k: list(g) for k, g in groupby(sorted(arr, key=key_func), key=key_func)}

# Get both max and min
_max, _min = max(arr), min(arr)  # Two passes
_min, _max = minmax = min(arr), max(arr)  # One pass (tuple unpacking)
```

---

## **9. Final Pro Tips to Avoid TLE/WA**

```python
# ❶ Set recursion limit (critical for tree problems)
import sys
sys.setrecursionlimit(10**6)  # Default is 1000!

# ❷ Clear memoization between test cases
@lru_cache(maxsize=None)
def dp(...):
    pass

# In solve():
dp.cache_clear()  # Clear cache if function reused

# ❸ Use typing for clarity (not required but helpful)
from typing import List, Dict, Set, Optional, Tuple

def twoSum(self, nums: List[int], target: int) -> List[int]:
    seen: Dict[int, int] = {}
    # ...

# ❹ For extremely large inputs, use sys.stdin
import sys
data = sys.stdin.read().split()  # Faster than input() in loops

# ❺ Memory trick: Delete large variables when done
del large_matrix  # Hint to GC, frees memory
```

---

## **10. The Ultimate Debugging Cheat Sheet**

When WA/TLE hits, check:
1. **Print types**: `print(type(var), var)` - caught many bugs
2. **Check mutability**: `print(id(var))` - verify references
3. **Use repr()**: `print(repr(solution))` - shows escape characters
4. **Slice validation**: `print(nums[:10])` - verify transformed data
5. **Time complexity**: Add `print(len(data))` - verify input size
6. **Edge cases**: `assert solve([]) == expected_empty`
7. **State visualization**: `pprint.pprint(matrix)` - pretty print nested structures

```python
import pprint
pprint.pprint(dp_table)  # Readable matrix printing
```

**You now have 95%+ of Python DSA knowledge.** The remaining 5% is problem-specific insight that comes with practice.