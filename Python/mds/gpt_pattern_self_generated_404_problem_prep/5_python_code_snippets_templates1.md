# 5_python_code_snippets_templates1

Perfect! Let’s build a **Python “cheat repo”** — minimal, reusable, and pattern-ready.
This will serve as your **go-to starter templates** for **any interview problem**. I’ll organize it **by category**, with **snippets, helpers, and common idioms**.

---

# 🐍 **Python Interview Helper / Template Repo**

---

## 1️⃣ **General Python Basics & Tricks**

### 1.1 Input & Iteration

```python
# Multiple integers in one line
a, b, c = map(int, input().split())

# Read list
arr = list(map(int, input().split()))

# Iterating with index
for i, val in enumerate(arr):
    print(i, val)
```

### 1.2 List / Dict / Set Comprehensions

```python
# List
squares = [x*x for x in range(10)]

# Dict
square_dict = {x: x*x for x in range(10)}

# Set
unique_squares = {x*x for x in range(10)}
```

### 1.3 DefaultDict / Counter

```python
from collections import defaultdict, Counter

# Frequency map
freq = Counter(arr)

# Default dict with list
d = defaultdict(list)
d['a'].append(1)
```

### 1.4 Sorting Tricks

```python
# Sort by key
arr.sort(key=lambda x: (x[1], x[0]))  # first by second, then by first
```

### 1.5 Swapping / Multiple assignment

```python
a, b = b, a
```

---

## 2️⃣ **Two Pointers / Sliding Window Helpers**

```python
# Two pointers template
i, j = 0, len(arr)-1
while i < j:
    if arr[i] + arr[j] == target:
        # do something
        i += 1
        j -= 1
    elif arr[i] + arr[j] < target:
        i += 1
    else:
        j -= 1

# Sliding window template (variable window)
window_sum = 0
left = 0
for right in range(len(arr)):
    window_sum += arr[right]
    while window_sum > target:
        window_sum -= arr[left]
        left += 1
```

---

## 3️⃣ **Fast / Slow Pointers**

```python
# Cycle detection
slow = fast = head
while fast and fast.next:
    slow = slow.next
    fast = fast.next.next
    if slow == fast:
        print("Cycle detected")
        break

# Find middle
slow = head
fast = head
while fast and fast.next:
    slow = slow.next
    fast = fast.next.next
# slow is middle
```

---

## 4️⃣ **Binary Search**

```python
# Standard binary search
def binary_search(arr, target):
    left, right = 0, len(arr)-1
    while left <= right:
        mid = left + (right-left)//2
        if arr[mid] == target:
            return mid
        elif arr[mid] < target:
            left = mid+1
        else:
            right = mid-1
    return -1

# Binary search on answer
def bs_answer(low, high, condition):
    while low < high:
        mid = (low + high) // 2
        if condition(mid):
            high = mid
        else:
            low = mid+1
    return low
```

---

## 5️⃣ **DFS / BFS (Graph / Tree)**

### 5.1 DFS Recursive

```python
def dfs(node, visited):
    if node in visited:
        return
    visited.add(node)
    # process node
    for nei in graph[node]:
        dfs(nei, visited)
```

### 5.2 BFS

```python
from collections import deque

def bfs(start):
    visited = set()
    q = deque([start])
    while q:
        node = q.popleft()
        if node in visited:
            continue
        visited.add(node)
        # process node
        for nei in graph[node]:
            if nei not in visited:
                q.append(nei)
```

### 5.3 Level Order (Tree)

```python
def level_order(root):
    if not root:
        return []
    from collections import deque
    res = []
    q = deque([root])
    while q:
        level = []
        for _ in range(len(q)):
            node = q.popleft()
            level.append(node.val)
            if node.left: q.append(node.left)
            if node.right: q.append(node.right)
        res.append(level)
    return res
```

---

## 6️⃣ **Heap / Priority Queue**

```python
import heapq

# Min-heap
heap = []
heapq.heappush(heap, 3)
heapq.heappush(heap, 1)
heapq.heappush(heap, 2)
min_val = heapq.heappop(heap)

# Max-heap
heap = []
heapq.heappush(heap, -val)  # invert sign
max_val = -heapq.heappop(heap)
```

---

## 7️⃣ **Sliding Window / Monotonic Queue**

```python
from collections import deque

# Monotonic queue (max)
q = deque()
for i, val in enumerate(arr):
    while q and arr[q[-1]] <= val:
        q.pop()
    q.append(i)
    # remove indices outside window
    if q[0] <= i - k:
        q.popleft()
    # max in window
    max_val = arr[q[0]]
```

---

## 8️⃣ **Union-Find / DSU**

```python
class DSU:
    def __init__(self, n):
        self.parent = list(range(n))
        self.rank = [0]*n

    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]

    def union(self, x, y):
        xr, yr = self.find(x), self.find(y)
        if xr == yr:
            return False
        if self.rank[xr] < self.rank[yr]:
            self.parent[xr] = yr
        elif self.rank[xr] > self.rank[yr]:
            self.parent[yr] = xr
        else:
            self.parent[yr] = xr
            self.rank[xr] += 1
        return True
```

---

## 9️⃣ **DP / Memoization Template**

```python
from functools import lru_cache

# Top-down recursive + memo
@lru_cache(None)
def dp(i, state):
    if base_case(i, state):
        return 0
    ans = float('inf')
    for choice in options:
        ans = min(ans, cost + dp(i+1, new_state))
    return ans

# Bottom-up DP
dp = [0]*(n+1)
dp[0] = 0
for i in range(1, n+1):
    dp[i] = min(dp[j] + cost[j][i] for j in range(i))
```

---

## 🔟 **Bit Manipulation Snippets**

```python
# Check bit
if n & (1<<k):
    pass

# Set bit
n |= (1<<k)

# Clear bit
n &= ~(1<<k)

# Toggle bit
n ^= (1<<k)

# Count set bits
bin(n).count('1')

# XOR trick
res = 0
for x in arr:
    res ^= x
```

---

## 1️⃣1️⃣ **Pythonic Helpers**

```python
# Flatten nested list
from itertools import chain
flat = list(chain.from_iterable(nested_list))

# Sliding window pairs
from itertools import islice
window = [arr[i:i+k] for i in range(len(arr)-k+1)]
```

---

## 1️⃣2️⃣ **Template for Pattern-Based Problems**

```python
# Generic template for all patterns
def solve(arr, target):
    # 1. Identify pattern
    # 2. Initialize pointers / data structures
    # 3. Loop / recursion
    # 4. Update answer
    pass
```

---

### ✅ Suggested Usage

* Keep as **one Python file / notebook**
* Copy functions / classes directly during prep
* Use **template comment headers** to mark **pattern**
* Add **advanced snippets** (BIT, Segment Tree, Sweep Line) here

---

I can next do a **pattern-wise Python mini-snippet repo**, i.e., for each **core + intermediate + advanced pattern**, provide a **ready-to-use Python skeleton** with **comments / invariants**, so during interviews you literally just fill logic.

Do you want me to do that next?
