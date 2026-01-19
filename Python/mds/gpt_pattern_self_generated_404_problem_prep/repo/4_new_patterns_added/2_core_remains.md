# 2_core_remains

Perfect 👍
Below are **drop-in, interview-ready snippets** for **each file you listed**, written in the **same minimal, reusable style** as before.

No explanations, no noise — **just templates**.

---

## 📁 `patterns_core/sliding_window_advanced.py`

```python
from collections import defaultdict, deque

# At most K
def subarrays_at_most_k(nums, k):
    cnt = defaultdict(int)
    left = res = 0

    for right, x in enumerate(nums):
        cnt[x] += 1
        while len(cnt) > k:
            cnt[nums[left]] -= 1
            if cnt[nums[left]] == 0:
                del cnt[nums[left]]
            left += 1
        res += right - left + 1
    return res


# Exactly K
def subarrays_exactly_k(nums, k):
    return subarrays_at_most_k(nums, k) - subarrays_at_most_k(nums, k - 1)


# Sliding window max (deque)
def sliding_window_max(nums, k):
    dq = deque()
    res = []

    for i, x in enumerate(nums):
        while dq and nums[dq[-1]] <= x:
            dq.pop()
        dq.append(i)

        if dq[0] == i - k:
            dq.popleft()

        if i >= k - 1:
            res.append(nums[dq[0]])

    return res
```

---

## 📁 `patterns_core/prefix_sum.py`

```python
# Prefix Sum Template

def prefix_sum(arr):
    ps = [0]
    for x in arr:
        ps.append(ps[-1] + x)
    return ps


def range_sum(ps, l, r):
    """inclusive l, r"""
    return ps[r + 1] - ps[l]
```

---

## 📁 `patterns_core/difference_array.py`

```python
# Difference Array for Range Updates

def range_update(n, updates):
    diff = [0] * (n + 1)

    for l, r, val in updates:
        diff[l] += val
        diff[r + 1] -= val

    arr = [0] * n
    curr = 0
    for i in range(n):
        curr += diff[i]
        arr[i] = curr

    return arr
```

---

## 📁 `patterns_core/greedy_templates.py`

```python
# Interval Scheduling (Greedy)

def max_non_overlapping(intervals):
    intervals.sort(key=lambda x: x[1])
    end = res = 0

    for s, e in intervals:
        if s >= end:
            res += 1
            end = e
    return res


# Greedy with Sorting
def can_attend_all(intervals):
    intervals.sort()
    for i in range(1, len(intervals)):
        if intervals[i][0] < intervals[i - 1][1]:
            return False
    return True
```

---

## 📁 `patterns_core/backtracking.py`

```python
# Backtracking Templates

def subsets(nums):
    res = []

    def dfs(i, path):
        if i == len(nums):
            res.append(path[:])
            return
        dfs(i + 1, path)
        path.append(nums[i])
        dfs(i + 1, path)
        path.pop()

    dfs(0, [])
    return res


def permutations(nums):
    res = []

    def dfs(path, used):
        if len(path) == len(nums):
            res.append(path[:])
            return
        for i in range(len(nums)):
            if used[i]:
                continue
            used[i] = True
            path.append(nums[i])
            dfs(path, used)
            path.pop()
            used[i] = False

    dfs([], [False] * len(nums))
    return res
```

---

## 📁 `patterns_core/monotonic_stack_variants.py`

```python
# Monotonic Stack Variants

def next_greater(nums):
    res = [-1] * len(nums)
    stack = []

    for i in range(len(nums)):
        while stack and nums[stack[-1]] < nums[i]:
            res[stack.pop()] = nums[i]
        stack.append(i)
    return res


def previous_smaller(nums):
    res = [-1] * len(nums)
    stack = []

    for i in range(len(nums)):
        while stack and nums[stack[-1]] >= nums[i]:
            stack.pop()
        res[i] = nums[stack[-1]] if stack else -1
        stack.append(i)
    return res


def largest_rectangle_histogram(heights):
    stack = []
    max_area = 0
    heights.append(0)

    for i, h in enumerate(heights):
        while stack and heights[stack[-1]] > h:
            height = heights[stack.pop()]
            width = i if not stack else i - stack[-1] - 1
            max_area = max(max_area, height * width)
        stack.append(i)

    heights.pop()
    return max_area
```

---

## ✅ Status Update

✔ All requested files added
✔ Patterns are **canonical + reusable**
✔ Histogram problem properly elevated as **pattern**

---

Whenever ready, ask the **next file / category** and we continue.
