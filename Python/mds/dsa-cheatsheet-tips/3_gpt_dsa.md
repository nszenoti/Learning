# 3_gpt_dsa

https://chatgpt.com/c/695e06f5-6484-8321-b49d-cafea232b32a

Perfect ask 👍
Here’s a **DSA / LeetCode-focused Python cheat-sheet** — only **practical patterns, tricks, and snippets** you’ll actually use while solving problems (fast recall style).

---

## 🧠 Python DSA Cheat Sheet (LeetCode Edition)

### 1️⃣ Input / Output Mental Model

```python
# Think in terms of:
nums: List[int]
s: str
matrix: List[List[int]]
```

No stdin/stdout needed on LeetCode — focus on **functions only**.

---

## 2️⃣ Core Data Structures (Must-Know)

### List (Array)

```python
arr.append(x)
arr.pop()           # last
arr.pop(i)
arr[::-1]           # reverse copy
arr.sort()
arr.sort(reverse=True)
sorted(arr)
```

---

### Stack

```python
stack = []
stack.append(x)
stack.pop()
stack[-1]           # top
```

---

### Queue / Deque

```python
from collections import deque

q = deque()
q.append(x)
q.appendleft(x)
q.popleft()
q.pop()
```

---

### HashMap (Dict)

```python
mp = {}
mp[key] = value
mp.get(key, 0)
key in mp
```

Counter (frequency)

```python
from collections import Counter
cnt = Counter(nums)
```

---

### Set

```python
s = set()
s.add(x)
s.remove(x)
x in s
```

---

## 3️⃣ Two Pointer Patterns ⭐

### Basic Two Pointer

```python
l, r = 0, len(arr)-1
while l < r:
    if condition:
        l += 1
    else:
        r -= 1
```

---

### Sliding Window

```python
l = 0
for r in range(n):
    window.add(arr[r])
    while invalid:
        window.remove(arr[l])
        l += 1
```

---

## 4️⃣ Binary Search (VERY IMPORTANT)

### Standard

```python
l, r = 0, n-1
while l <= r:
    mid = (l + r) // 2
    if arr[mid] == target:
        return mid
    elif arr[mid] < target:
        l = mid + 1
    else:
        r = mid - 1
```

---

### Lower Bound

```python
l, r = 0, n
while l < r:
    mid = (l + r) // 2
    if arr[mid] < target:
        l = mid + 1
    else:
        r = mid
```

---

## 5️⃣ Heap (Top K, Kth largest)

```python
import heapq

heap = []
heapq.heappush(heap, x)
heapq.heappop(heap)
```

Max heap trick:

```python
heapq.heappush(heap, -x)
```

---

## 6️⃣ Prefix Sum / Difference Array

### Prefix Sum

```python
pref = [0]
for x in nums:
    pref.append(pref[-1] + x)

# sum l..r
pref[r+1] - pref[l]
```

---

### Difference Array

```python
diff = [0]*(n+1)
diff[l] += val
diff[r+1] -= val
```

---

## 7️⃣ Recursion & Backtracking

### Template

```python
def dfs(i, path):
    if base_case:
        res.append(path[:])
        return
    for choice in choices:
        path.append(choice)
        dfs(i+1, path)
        path.pop()
```

---

## 8️⃣ Graph / Tree DFS & BFS

### DFS

```python
def dfs(node):
    if not node:
        return
    dfs(node.left)
    dfs(node.right)
```

---

### BFS

```python
from collections import deque

q = deque([root])
while q:
    node = q.popleft()
    if node.left:
        q.append(node.left)
```

---

## 9️⃣ Dynamic Programming Patterns ⭐⭐⭐

### 1D DP

```python
dp = [0]*(n+1)
dp[0] = 1
for i in range(1, n+1):
    dp[i] = dp[i-1] + dp[i-2]
```

---

### 2D DP

```python
dp = [[0]*m for _ in range(n)]
dp[0][0] = 1
```

---

### Memoization

```python
from functools import lru_cache

@lru_cache(None)
def solve(i):
    if i == base:
        return 1
    return solve(i-1)
```

---

## 🔟 Strings (Tricks You’ll Use Daily)

```python
s.isalnum()
s.isdigit()
s.lower()
s.upper()
```

Reverse string:

```python
s[::-1]
```

Join:

```python
"".join(chars)
```

---

## 1️⃣1️⃣ Sorting Tricks

Sort with key:

```python
arr.sort(key=lambda x: x[1])
```

Sort by multiple fields:

```python
arr.sort(key=lambda x: (x[0], -x[1]))
```

---

## 1️⃣2️⃣ Bit Manipulation (Frequently Asked)

```python
x & 1           # odd/even
x ^ x == 0
1 << i
bin(x).count("1")
```

---

## 1️⃣3️⃣ Python Speed Tricks ⚡

* Use `set` instead of list for lookup
* Avoid recursion depth > 1000
* Use `Counter`
* Prefer list comprehension
* Use `deque` instead of list queue

---

## 1️⃣4️⃣ Classic LeetCode Patterns (REMEMBER THIS)

| Pattern        | Use Case             |
| -------------- | -------------------- |
| Two Pointers   | Sorted arrays        |
| Sliding Window | Subarray/substring   |
| Binary Search  | Search space         |
| Stack          | Next greater         |
| BFS            | Shortest path        |
| DFS            | All paths            |
| DP             | Optimal substructure |
| Heap           | Top K                |

---

## 🔥 Interview Gold One-Liners

```python
# swap
a, b = b, a

# flatten
flat = [x for row in grid for x in row]

# transpose
zip(*matrix)

# count freq
Counter(nums)
```

---

## 📌 How to use this effectively

1. **Memorize patterns, not syntax**
2. Identify problem → match pattern → paste template
3. Solve 2–3 problems/day with same pattern

---

If you want next:

* 📘 **Printable PDF**
* 🧩 **Pattern → LeetCode problem list**
* 🧠 **“Which pattern to apply?” decision tree**
* 🐍 **Python gotchas that cause WA/TLE**

Just say the word.
