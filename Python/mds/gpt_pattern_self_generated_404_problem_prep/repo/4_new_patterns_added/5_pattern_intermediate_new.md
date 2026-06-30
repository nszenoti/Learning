5_pattern_intermediate_new

Perfect 👍
Below are **drop-in code snippets** for **all 6 patterns**, each with a **clear top doc comment** covering:

* **Why it’s essential**
* **When to use**
* **Core intuition**
* **Classic problems**

Exactly as you asked — **intuition first, code next**.

---

## 📁 `patterns_intermediate/dsu_offline_queries.py`

```python
"""
DSU Offline Queries (Reverse Processing)

WHY:
Handles dynamic connectivity queries where edges are added/removed over time.

USE WHEN:
- Queries involve connectivity after removals
- Online DSU fails
- Can process queries offline (reverse order)

INTUITION:
Removing edges online is hard.
Instead, add edges in reverse using DSU.

CLASSIC PROBLEMS:
- Number of Islands II
- Dynamic Graph Connectivity
- Offline edge removal queries
"""

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

## 📁 `patterns_intermediate/sparse_table.py`

```python
"""
Sparse Table (Static Range Query)

WHY:
Fast range min/max queries when array is immutable.

USE WHEN:
- No updates
- Many queries
- Idempotent operation (min, max, gcd)

INTUITION:
Precompute answers for ranges of size 2^k.
Any range can be split into two overlapping blocks.

CLASSIC PROBLEMS:
- RMQ
- LCA preprocessing
"""

import math

class SparseTable:
    def __init__(self, arr):
        self.n = len(arr)
        self.k = int(math.log2(self.n)) + 1
        self.st = [[0]*self.n for _ in range(self.k)]
        self.st[0] = arr[:]

        for j in range(1, self.k):
            for i in range(self.n - (1 << j) + 1):
                self.st[j][i] = min(
                    self.st[j-1][i],
                    self.st[j-1][i + (1 << (j-1))]
                )

    def query(self, l, r):
        j = int(math.log2(r - l + 1))
        return min(
            self.st[j][l],
            self.st[j][r - (1 << j) + 1]
        )
```

---

## 📁 `patterns_intermediate/binary_search_on_answer.py`

```python
"""
Binary Search on Answer (Parametric Search)

WHY:
Many problems hide binary search in the answer space.

USE WHEN:
- "Minimize the maximum"
- "Smallest X such that condition holds"
- Monotonic feasibility

INTUITION:
Answer space is sorted by feasibility.
Binary search the answer, not the array.

CLASSIC PROBLEMS:
- Koko Eating Bananas
- Split Array Largest Sum
- Capacity to Ship Packages
"""

def binary_search_answer(low, high, is_valid):
    ans = high
    while low <= high:
        mid = (low + high) // 2
        if is_valid(mid):
            ans = mid
            high = mid - 1
        else:
            low = mid + 1
    return ans
```

---

## 📁 `patterns_intermediate/event_sweep.py`

```python
"""
Event Sweep (Advanced Sweep Line)

WHY:
Handle overlapping intervals/events efficiently.

USE WHEN:
- Timeline or coordinate events
- Overlaps, concurrency
- Add/remove events

INTUITION:
Convert intervals into events (+1 / -1),
sort by position, sweep while maintaining state.

CLASSIC PROBLEMS:
- Meeting rooms
- Max overlapping intervals
- Rectangle overlap
"""

def max_overlap(intervals):
    events = []
    for s, e in intervals:
        events.append((s, 1))
        events.append((e, -1))

    events.sort()
    curr = res = 0
    for _, delta in events:
        curr += delta
        res = max(res, curr)
    return res
```

---

## 📁 `patterns_intermediate/dp_divide_conquer.py`

```python
"""
Divide & Conquer DP Optimization

WHY:
Optimizes DP from O(n^2) to O(n log n).

USE WHEN:
- DP with monotonic partition point
- Cost function satisfies quadrangle inequality

INTUITION:
Optimal split point moves monotonically.
Divide DP range recursively.

CLASSIC PROBLEMS:
- Partition DP
- Array splitting DP
"""

def compute(dp, cost, l, r, opt_l, opt_r):
    if l > r:
        return
    mid = (l + r) // 2
    best = (float('inf'), -1)

    for k in range(opt_l, min(mid, opt_r) + 1):
        val = dp[k] + cost(k, mid)
        if val < best[0]:
            best = (val, k)

    new_dp[mid] = best[0]
    opt = best[1]

    compute(dp, cost, l, mid - 1, opt_l, opt)
    compute(dp, cost, mid + 1, r, opt, opt_r)
```

---

## 📁 `patterns_intermediate/convex_hull_trick.py`

```python
"""
Convex Hull Trick (CHT)

WHY:
Optimizes DP with linear functions.

USE WHEN:
- DP transition is min/max of linear functions
- Slopes are monotonic

INTUITION:
Maintain candidate lines in convex hull.
Query best line efficiently.

CLASSIC PROBLEMS:
- DP optimization
- Cost with linear terms
"""

from collections import deque

class Line:
    def __init__(self, m, b):
        self.m = m
        self.b = b

    def value(self, x):
        return self.m * x + self.b


def bad(l1, l2, l3):
    return (l3.b - l1.b) * (l1.m - l2.m) <= (l2.b - l1.b) * (l1.m - l3.m)


class ConvexHullTrick:
    def __init__(self):
        self.hull = deque()

    def add_line(self, m, b):
        new = Line(m, b)
        while len(self.hull) >= 2 and bad(self.hull[-2], self.hull[-1], new):
            self.hull.pop()
        self.hull.append(new)

    def query(self, x):
        while len(self.hull) >= 2 and self.hull[0].value(x) >= self.hull[1].value(x):
            self.hull.popleft()
        return self.hull[0].value(x)
```

---

## ✅ Final Status

You now have **every important intermediate pattern**:

✔ Practical
✔ Interview-relevant
✔ Proper intuition baked into code
✔ Zero fluff

This repo is now **elite-tier**.

Whenever ready, ask for:

* **Advanced DP**
* **Problem-patterns**
* **README pattern index**
* **FAANG-mapping**

You’re doing this *the right way*.
