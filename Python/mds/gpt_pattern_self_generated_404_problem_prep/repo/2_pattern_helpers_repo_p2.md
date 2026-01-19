# 2_pattern_helpers_repo_p2

Good catch 👍 — you’re right.
Let’s **complete the repo properly** so **every file in the tree actually exists** and is **interview-ready**.

Below are the **missing + essential templates**, written in a **minimal, invariant-first style** (copy-paste friendly).

---

# 📌 `patterns_core/stack_monotonic.py`

```python
# Monotonic Stack
# Use when: next greater/smaller, histogram, spans

def next_greater(nums):
    res = [-1] * len(nums)
    stack = []  # indices

    for i, val in enumerate(nums):
        while stack and nums[stack[-1]] < val:
            idx = stack.pop()
            res[idx] = val
        stack.append(i)

    return res


def next_smaller(nums):
    res = [-1] * len(nums)
    stack = []

    for i, val in enumerate(nums):
        while stack and nums[stack[-1]] > val:
            idx = stack.pop()
            res[idx] = val
        stack.append(i)

    return res


def largest_rectangle_histogram(heights):
    stack = []
    max_area = 0
    heights.append(0)  # sentinel

    for i, h in enumerate(heights):
        while stack and heights[stack[-1]] > h:
            height = heights[stack.pop()]
            width = i if not stack else i - stack[-1] - 1
            max_area = max(max_area, height * width)
        stack.append(i)

    return max_area
```

---

# 📌 `patterns_core/heap_templates.py`

```python
import heapq

# Min Heap (default)
def min_heap_example(nums):
    heap = []
    for x in nums:
        heapq.heappush(heap, x)
    return heapq.heappop(heap)


# Max Heap
def max_heap_example(nums):
    heap = []
    for x in nums:
        heapq.heappush(heap, -x)
    return -heapq.heappop(heap)


# Top K largest
def top_k(nums, k):
    heap = []
    for x in nums:
        heapq.heappush(heap, x)
        if len(heap) > k:
            heapq.heappop(heap)
    return heap


# Two Heaps (Median pattern)
class MedianFinder:
    def __init__(self):
        self.small = []  # max heap
        self.large = []  # min heap

    def addNum(self, num):
        heapq.heappush(self.small, -num)

        if self.small and self.large and (-self.small[0] > self.large[0]):
            heapq.heappush(self.large, -heapq.heappop(self.small))

        if len(self.small) > len(self.large) + 1:
            heapq.heappush(self.large, -heapq.heappop(self.small))
        if len(self.large) > len(self.small):
            heapq.heappush(self.small, -heapq.heappop(self.large))

    def findMedian(self):
        if len(self.small) > len(self.large):
            return -self.small[0]
        return (-self.small[0] + self.large[0]) / 2
```

---

# 📌 `patterns_core/union_find.py` (completed)

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

# 📌 `patterns_core/dp_templates.py`

```python
from functools import lru_cache

# 1D DP
def dp_1d(nums):
    n = len(nums)
    dp = [0]*(n+1)

    for i in range(1, n+1):
        dp[i] = max(dp[i-1], dp[i-2] + nums[i-1])
    return dp[n]


# Top-down DP
@lru_cache(None)
def dp_top_down(i):
    if i <= 1:
        return 1
    return dp_top_down(i-1) + dp_top_down(i-2)


# 2D DP (Grid)
def dp_grid(grid):
    m, n = len(grid), len(grid[0])
    dp = [[0]*n for _ in range(m)]

    dp[0][0] = grid[0][0]
    for i in range(m):
        for j in range(n):
            if i == j == 0:
                continue
            dp[i][j] = grid[i][j] + min(
                dp[i-1][j] if i > 0 else float('inf'),
                dp[i][j-1] if j > 0 else float('inf')
            )
    return dp[-1][-1]
```

---

# 📌 `patterns_core/two_pointers.py`

```python
def two_sum_sorted(nums, target):
    l, r = 0, len(nums)-1
    while l < r:
        s = nums[l] + nums[r]
        if s == target:
            return l, r
        elif s < target:
            l += 1
        else:
            r -= 1
    return -1, -1
```

---

# 📌 `patterns_core/stack_basic.py` (optional but useful)

```python
# Valid parentheses
def is_valid(s):
    stack = []
    mp = {')':'(', '}':'{', ']':'['}

    for ch in s:
        if ch in mp.values():
            stack.append(ch)
        else:
            if not stack or stack.pop() != mp[ch]:
                return False
    return not stack
```

---

# 🧠 Mental Mapping (Important)

| Pattern                  | Template File        |
| ------------------------ | -------------------- |
| Next greater / histogram | `stack_monotonic.py` |
| Top-K / median           | `heap_templates.py`  |
| Connectivity             | `union_find.py`      |
| DP                       | `dp_templates.py`    |
| Two pointers             | `two_pointers.py`    |
| BFS / DFS                | `dfs_bfs.py`         |
| Binary search            | `binary_search.py`   |

---

## 🔥 Final Rule (Stick This in README)

> **If a problem feels hard → you picked the wrong template.**

This repo now:

* Covers **core + intermediate + advanced**
* Removes **syntax overhead**
* Forces **pattern thinking**

---

### Next powerful step (high ROI)

1️⃣ Merge all into **ONE mega interview file**
2️⃣ Add **pattern → template chooser checklist**
3️⃣ Add **common bug traps per template**

Reply **1 / 2 / 3** and we’ll finalize this into a killer system 💪
