# 7_qwen_dsa

https://chat.qwen.ai/c/6cdffbbd-9630-46ec-923b-432c1684525f

Here’s a **concise yet comprehensive Python cheat sheet** tailored for **DSA (Data Structures & Algorithms) problem solving on LeetCode**. It includes essential syntax, built-in functions, data structures, and common patterns used in coding interviews.

---

### 🔢 **1. Common Built-in Functions & Utilities**

```python
# Math
abs(x), min(a, b), max(a, b), sum(iterable)
pow(x, y) or x ** y
math.floor(), math.ceil(), math.sqrt(), math.inf

# Type conversion
int(), str(), list(), tuple(), set(), dict()

# Iteration helpers
enumerate(iterable)       # (index, value)
zip(list1, list2)         # pairs elements
range(start, stop, step)

# Sorting
sorted(iterable, key=..., reverse=...)
list.sort(key=..., reverse=...)  # in-place

# Useful constants
float('inf'), float('-inf')
```

---

### 📦 **2. Core Data Structures**

#### Lists
```python
arr = [1, 2, 3]
arr.append(x)           # O(1)
arr.pop()               # O(1)
arr.pop(i)              # O(n)
arr.insert(i, x)        # O(n)
arr[::-1]               # reverse
len(arr), x in arr      # O(n) for "in"
```

#### Strings (immutable)
```python
s = "hello"
s.split(), s.join(iterable)
s.strip(), s.lower(), s.upper()
s.replace(old, new)
s[i:j]                  # slicing (O(k))
''.join(list_of_chars)  # efficient concat
```

#### Dictionaries (`dict`)
```python
d = {}
d.get(key, default)     # safe access
d.setdefault(key, val)  # set if not exists
for k, v in d.items():
collections.defaultdict(type)  # auto-initialize
collections.Counter(iterable)
```

#### Sets
```python
s = set()
s.add(x), s.remove(x), x in s  # O(1) avg
s1 & s2  # intersection
s1 | s2  # union
s1 - s2  # difference
```

#### Heap (min-heap via `heapq`)
```python
import heapq
heap = []
heapq.heappush(heap, item)
heapq.heappop(heap)
heapq.heapify(list)     # O(n)
# For max-heap: push -value, pop -heapq.heappop()
```

#### Deque (double-ended queue)
```python
from collections import deque
dq = deque()
dq.append(x), dq.appendleft(x)
dq.pop(), dq.popleft()
# O(1) at both ends — great for BFS, sliding window
```

---

### ⚙️ **3. Common DSA Patterns & Snippets**

#### Two Pointers
```python
left, right = 0, len(arr) - 1
while left < right:
    # process arr[left], arr[right]
    if condition:
        left += 1
    else:
        right -= 1
```

#### Sliding Window (fixed/variable size)
```python
# Variable size (e.g., longest substring without repeat)
seen = set()
l = 0
for r in range(len(s)):
    while s[r] in seen:
        seen.remove(s[l])
        l += 1
    seen.add(s[r])
```

#### Fast & Slow Pointers (Linked List)
```python
slow = fast = head
while fast and fast.next:
    slow = slow.next
    fast = fast.next.next
# Detect cycle, find middle, etc.
```

#### BFS (Level-order traversal)
```python
from collections import deque
queue = deque([root])
while queue:
    for _ in range(len(queue)):  # process level by level
        node = queue.popleft()
        if node.left: queue.append(node.left)
        if node.right: queue.append(node.right)
```

#### DFS (Recursive or iterative)
```python
# Recursive
def dfs(node):
    if not node: return
    # process
    dfs(node.left)
    dfs(node.right)

# Iterative (pre-order)
stack = [root]
while stack:
    node = stack.pop()
    if node:
        # process
        stack.append(node.right)
        stack.append(node.left)
```

#### Binary Search
```python
lo, hi = 0, len(arr) - 1
while lo <= hi:
    mid = (lo + hi) // 2
    if arr[mid] == target:
        return mid
    elif arr[mid] < target:
        lo = mid + 1
    else:
        hi = mid - 1
```

#### Backtracking (e.g., subsets, permutations)
```python
def backtrack(path, choices):
    if base_case:
        result.append(path[:])
        return
    for choice in choices:
        path.append(choice)
        backtrack(path, remaining_choices)
        path.pop()  # undo
```

---

### 🧠 **4. Python Tricks for LeetCode**

- **Swap without temp**: `a, b = b, a`
- **Initialize 2D array**: `[[0]*cols for _ in range(rows)]` (⚠️ avoid `[[0]*cols]*rows`)
- **Check even/odd**: `n & 1 == 0`
- **Power of two**: `n > 0 and (n & (n - 1)) == 0`
- **Get last digit**: `n % 10`; **remove last digit**: `n // 10`
- **Reverse integer**: `int(str(n)[::-1])` (handle sign carefully)
- **One-liner frequency map**: `Counter(s)`
- **Early return with `any()` / `all()`**:
  ```python
  if any(x > 10 for x in arr): ...
  if all(x > 0 for x in arr): ...
  ```

---

### 📚 **5. Must-Know Modules**

```python
import math
import heapq
from collections import deque, defaultdict, Counter, OrderedDict
from itertools import permutations, combinations, product
from functools import lru_cache  # for memoization!
```

> 💡 Bonus: Use `@lru_cache(maxsize=None)` for recursive DP to auto-memoize!

---

### ✅ Final Tips

- Prefer **list comprehensions** for clean, fast code.
- Use **`x in set`** instead of `x in list` for O(1) lookups.
- **Edge cases**: empty input, single element, duplicates, negatives.
- Always **clarify input constraints** (e.g., can numbers be negative?).

---

You can save this as `leetcode_python_cheatsheet.py` or print it for quick reference.

Let me know if you want a printable PDF version or topic-wise (e.g., "graph snippets only")!