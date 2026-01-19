# 1_pattern_helpers_repo_p1

Perfect 👍
Below is a **clean, copy-paste–ready “Python Interview Template Repo”** — exactly what you asked for:

* **General → helpers**
* **Pattern-wise skeletons**
* **Bit / Math / Python nuance toolbox**
* **Minimal but complete**

You can literally keep this as a repo and **start every problem from here**.

---

# 📁 `python-dsa-templates/` (Recommended Repo Structure)

```
python-dsa-templates/
│
├── README.md
│
├── basics/
│   ├── io_and_loops.py
│   ├── collections_helpers.py
│   ├── sorting_tricks.py
│   └── python_nuances.py
│
├── math_bit/
│   ├── bit_helpers.py
│   ├── math_helpers.py
│   └── combinatorics.py
│
├── patterns_core/
│   ├── two_pointers.py
│   ├── sliding_window.py
│   ├── binary_search.py
│   ├── dfs_bfs.py
│   ├── stack_monotonic.py
│   ├── heap_templates.py
│   ├── union_find.py
│   └── dp_templates.py
│
├── patterns_intermediate/
│   ├── sweep_line.py
│   ├── coordinate_compression.py
│   ├── fenwick_tree.py
│   ├── segment_tree.py
│   └── two_heaps_median.py
│
└── patterns_advanced/
    ├── dijkstra.py
    ├── interval_dp.py
    ├── bitmask_dp.py
    └── string_algos.py
```

---

# 🧠 README.md (Mental Model)

```md
1. Identify pattern
2. Open corresponding template
3. Fill invariant logic
4. Done
```

---

## 🔹 basics/python_nuances.py

```python
import sys
input = sys.stdin.readline  # faster input

# Common built-ins
bin(10)        # '0b1010'
int('1010', 2) # 10
round(3.6)     # 4

from math import log, log2, log10, ceil, floor

log2(8)   # 3.0
ceil(2.3) # 3
floor(2.9)# 2
```

---

## 🔹 math_bit/bit_helpers.py

```python
# Bit checks
def is_power_of_two(n):
    return n > 0 and (n & (n - 1)) == 0

def count_bits(n):
    return bin(n).count("1")

def rightmost_set_bit(n):
    return n & -n

# Subset enumeration
def all_subsets(arr):
    n = len(arr)
    for mask in range(1 << n):
        yield [arr[i] for i in range(n) if mask & (1 << i)]
```

---

## 🔹 math_bit/math_helpers.py

```python
from math import gcd
from functools import reduce

def lcm(a, b):
    return a * b // gcd(a, b)

def gcd_list(arr):
    return reduce(gcd, arr)

def divisors(n):
    res = []
    for i in range(1, int(n**0.5)+1):
        if n % i == 0:
            res.append(i)
            if i != n//i:
                res.append(n//i)
    return res
```

---

## 🔹 patterns_core/sliding_window.py

```python
def sliding_window(arr, k):
    left = 0
    window = 0
    ans = 0

    for right in range(len(arr)):
        window += arr[right]

        while window > k:
            window -= arr[left]
            left += 1

        ans = max(ans, right - left + 1)

    return ans
```

---

## 🔹 patterns_core/binary_search.py

```python
def binary_search(arr, target):
    l, r = 0, len(arr)-1
    while l <= r:
        m = (l + r) // 2
        if arr[m] == target:
            return m
        elif arr[m] < target:
            l = m + 1
        else:
            r = m - 1
    return -1

# Binary search on answer
def bs_answer(lo, hi, check):
    while lo < hi:
        mid = (lo + hi) // 2
        if check(mid):
            hi = mid
        else:
            lo = mid + 1
    return lo
```

---

## 🔹 patterns_core/dfs_bfs.py

```python
from collections import deque

def bfs(start, graph):
    q = deque([start])
    visited = set([start])

    while q:
        node = q.popleft()
        for nei in graph[node]:
            if nei not in visited:
                visited.add(nei)
                q.append(nei)

def dfs(node, graph, visited):
    if node in visited:
        return
    visited.add(node)
    for nei in graph[node]:
        dfs(nei, graph, visited)
```

---

## 🔹 patterns_intermediate/sweep_line.py

```python
def sweep_line(intervals):
    events = []
    for s, e in intervals:
        events.append((s, +1))
        events.append((e, -1))

    events.sort()
    cur = ans = 0

    for _, delta in events:
        cur += delta
        ans = max(ans, cur)

    return ans
```

---

## 🔹 patterns_intermediate/fenwick_tree.py

```python
class Fenwick:
    def __init__(self, n):
        self.bit = [0]*(n+1)

    def update(self, i, delta):
        while i < len(self.bit):
            self.bit[i] += delta
            i += i & -i

    def query(self, i):
        s = 0
        while i > 0:
            s += self.bit[i]
            i -= i & -i
        return s
```

---

## 🔹 patterns_advanced/dijkstra.py

```python
import heapq

def dijkstra(graph, src):
    dist = {src: 0}
    pq = [(0, src)]

    while pq:
        d, node = heapq.heappop(pq)
        if d > dist[node]:
            continue

        for nei, w in graph[node]:
            nd = d + w
            if nei not in dist or nd < dist[nei]:
                dist[nei] = nd
                heapq.heappush(pq, (nd, nei))
    return dist
```

---

## 🔹 patterns_advanced/bitmask_dp.py

```python
from functools import lru_cache

def bitmask_dp(cost):
    n = len(cost)

    @lru_cache(None)
    def dp(mask):
        if mask == (1 << n) - 1:
            return 0

        ans = float('inf')
        for i in range(n):
            if not (mask & (1 << i)):
                ans = min(ans, cost[i] + dp(mask | (1 << i)))
        return ans

    return dp(0)
```

---

# 🎯 How YOU Should Use This

* Start every problem by **choosing the pattern**
* Open that file
* Fill only the logic inside
* Never start from a blank file again

---

## 🔥 Strong Advice (Important)

> **Patterns live in your brain,
> templates live in your repo.**

This repo removes **syntax load**, so you can focus on **thinking**.

---

### Next powerful upgrades (pick one):

1️⃣ Convert this into **one single mega-template file**
2️⃣ Add **inline comments = invariants per pattern**
3️⃣ Add **interviewer-style “why this works” notes**

Just say **1 / 2 / 3** 💪
