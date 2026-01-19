# GPT_2_ultimate_leetcode_helpers

Perfect. Below is the **Ultimate 2-Page Python LeetCode Handbook** — compressed, battle-tested, and **mentally scannable**.
If you internalize *this*, you’re genuinely **interview-ready in Python**.

I’ll format it as **Page 1 (Patterns + Templates)** and **Page 2 (Python Mastery + Traps)**.

---

# 📘 ULTIMATE PYTHON LEETCODE HANDBOOK

*(2 pages · zero fluff · maximum signal)*

---

## 📄 PAGE 1 — DSA PATTERNS & TEMPLATES (WHAT TO APPLY)

---

## 1️⃣ Arrays / Hashing

```python
from collections import Counter, defaultdict
freq = Counter(nums)
mp = defaultdict(list)
```

Use when:

* frequency
* lookup
* counting pairs

---

## 2️⃣ Two Pointers

```python
l, r = 0, n-1
while l < r:
    if ok: l += 1
    else: r -= 1
```

Use when:

* sorted array
* reverse traversal
* pair sum

---

## 3️⃣ Sliding Window

```python
l = 0
for r in range(n):
    add(nums[r])
    while invalid:
        remove(nums[l])
        l += 1
```

Use when:

* subarray / substring
* max/min window

---

## 4️⃣ Binary Search (Index)

```python
l, r = 0, n-1
while l <= r:
    mid = (l+r)//2
```

---

## 5️⃣ Binary Search on Answer ⭐

```python
def can(x): ...
l, r = lo, hi
while l < r:
    mid = (l+r)//2
    if can(mid): r = mid
    else: l = mid+1
```

Use when:

* minimize max
* capacity / days / speed

---

## 6️⃣ Stack (Monotonic)

```python
stack = []
for i in range(n):
    while stack and bad(stack[-1], i):
        stack.pop()
    stack.append(i)
```

Use when:

* next greater/smaller
* histogram
* temperatures

---

## 7️⃣ Heap

```python
import heapq
heapq.heappush(h, x)
heapq.heappop(h)
```

Max heap:

```python
heapq.heappush(h, -x)
```

---

## 8️⃣ DFS / BFS

```python
# DFS
def dfs(u):
    for v in graph[u]:
        dfs(v)

# BFS
from collections import deque
q = deque([start])
```

---

## 9️⃣ Tree DFS

```python
def dfs(node):
    if not node: return
    dfs(node.left)
    dfs(node.right)
```

---

## 🔟 Dynamic Programming

```python
dp = [0]*(n+1)
dp[0] = 1
```

Memo:

```python
from functools import lru_cache
@lru_cache(None)
def solve(i):
```

---

## 1️⃣1️⃣ Union Find

```python
def find(x):
    if p[x]!=x: p[x]=find(p[x])
```

---

## 1️⃣2️⃣ Topological Sort

```python
from collections import deque
q = deque(i for i in range(n) if indeg[i]==0)
```

---

## 1️⃣3️⃣ Intervals

```python
intervals.sort()
```

---

## 1️⃣4️⃣ Backtracking

```python
path.append(x)
dfs()
path.pop()
```

---

## 📄 PAGE 2 — PYTHON MASTERY (HOW NOT TO FAIL)

---

## ⚠️ TOP WA / TLE TRAPS

❌ `list.pop(0)` → use `deque`
❌ mutable default args
❌ `dp = [[0]*m]*n`
❌ string concat in loop
❌ recursion depth > 1000
❌ missing memoization
❌ list membership instead of set
❌ modifying list while iterating

---

## ⚡ PERFORMANCE RULES

* prefer `set` / `dict`
* avoid nested loops
* generator > list
* early return aggressively
* iterative DP > recursive when deep

---

## 🐍 PYTHON POWER BUILT-INS (USE INTENTIONALLY)

### Introspection / Debug

```python
type(x)
isinstance(x, list)
dir(obj)
vars(obj)
getattr(obj, 'left', None)
hasattr(obj, 'left')
id(obj)
```

---

### Formatting / Debug

```python
f"{i=}, {j=}"
format(x, 'b')
repr(obj)
```

---

### Iteration Tools

```python
enumerate(arr)
zip(a, b)
zip(*matrix)
any(...)
all(...)
```

---

### Binary Search Helpers

```python
from bisect import bisect_left, bisect_right
```

---

### Math / Edge

```python
float('inf')
from math import inf
0 <= i < n
```

---

## 🧠 PYTHON SEMANTICS THAT CAUSE WA

* `-3 // 2 == -2`
* `(-1) % 5 == 4`
* dict order preserved, set not
* slicing is O(n)
* `arr[:]` copies
* `del` removes reference, not memory

---

## 🧠 BACKTRACKING GOLD RULES

* always copy: `path[:]`
* prune early
* avoid deepcopy
* avoid global state

---

## 🧠 BEFORE SUBMIT CHECKLIST ✅

* any hidden O(n²)?
* any list pop(0)?
* recursion depth safe?
* memoization present?
* mutable default?
* print removed?

---

## 🎯 FINAL TRUTH

> **Pattern recognition beats Python tricks.**
> Python tricks prevent WA/TLE — they don’t replace thinking.

You now have:

* ✅ Full DSA coverage
* ✅ Python edge-case mastery
* ✅ Interview-grade templates

This is **as complete as a Python LeetCode handbook gets**.

---

If you want next:

* 📄 Printable **PDF version**
* 🧠 **Pattern → Problem mapping**
* 🔥 **Top 50 Python-danger problems**
* ⚔️ **Python vs C++ interview strategy**

Just say 👍
