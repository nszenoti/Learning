# 5_gpt_python_dsa_wa_tle

Perfect — this is **exactly** what causes most LeetCode WA/TLE in Python 😄
Below is a **Python-specific WA/TLE trap list**, distilled from real LeetCode failures.
Read this once → you’ll instantly fix 30–40% of silent bugs.

---

# 🐍 Python-Specific WA / TLE Traps (LeetCode Survival Guide)

## 🚨 1️⃣ Mutable Default Arguments (Classic WA)

```python
def dfs(path=[]):   # ❌
```

Why? Same list reused across calls.

✅ Fix

```python
def dfs(path=None):
    if path is None:
        path = []
```

---

## 🚨 2️⃣ `list.pop(0)` = O(n) (Hidden TLE)

```python
q.pop(0)   # ❌
```

✅ Use deque

```python
from collections import deque
q.popleft()
```

---

## 🚨 3️⃣ Using List for Membership (TLE)

```python
if x in arr:    # ❌ O(n)
```

✅ Use set

```python
seen = set(arr)
if x in seen:
```

---

## 🚨 4️⃣ String Concatenation in Loop (TLE)

```python
s = ""
for c in chars:
    s += c    # ❌
```

✅ Use list + join

```python
res = []
res.append(c)
"".join(res)
```

---

## 🚨 5️⃣ Recursion Depth Error (Runtime Error)

Python limit ≈ **1000**

```python
dfs(0)   # deep recursion ❌
```

✅ Fix options:

```python
import sys
sys.setrecursionlimit(10**7)
```

OR convert to iterative DFS/BFS.

---

## 🚨 6️⃣ Forgetting to Copy Lists in Backtracking (WA)

```python
res.append(path)   # ❌
```

✅ Always copy

```python
res.append(path[:])
```

---

## 🚨 7️⃣ Sorting Inside Loop (TLE)

```python
for i in range(n):
    arr.sort()    # ❌
```

✅ Sort once outside.

---

## 🚨 8️⃣ Using `len()` Repeatedly on Growing List

```python
while len(stack) > 0:  # slower
```

✅ Pythonic

```python
while stack:
```

---

## 🚨 9️⃣ Using `range(len(arr))` When Not Needed

```python
for i in range(len(arr)):
    print(arr[i])
```

✅ Faster + cleaner

```python
for x in arr:
```

---

## 🚨 🔟 Modifying List While Iterating (WA)

```python
for x in nums:
    nums.remove(x)   # ❌
```

✅ Use new list or iterate copy

```python
for x in nums[:]:
```

---

## 🚨 1️⃣1️⃣ Using Floating Point for Equality (WA)

```python
if a / b == 0.3:   # ❌
```

✅ Use integer math or tolerance

```python
abs(a/b - 0.3) < 1e-9
```

---

## 🚨 1️⃣2️⃣ Missing Memoization (TLE)

```python
def solve(i):
    return solve(i-1) + solve(i-2)   # ❌
```

✅ Add cache

```python
from functools import lru_cache

@lru_cache(None)
def solve(i):
```

---

## 🚨 1️⃣3️⃣ Using `deepcopy` in Backtracking (TLE)

```python
import copy
res.append(copy.deepcopy(path))   # ❌
```

✅ Use slice

```python
res.append(path[:])
```

---

## 🚨 1️⃣4️⃣ Python Modulo with Negatives (WA)

```python
-1 % 5  # 4 (Python behavior!)
```

Be careful in hashing / cyclic problems.

---

## 🚨 1️⃣5️⃣ Dictionary KeyError (WA)

```python
mp[x] += 1   # ❌
```

✅ Safe

```python
mp[x] = mp.get(x, 0) + 1
```

---

## 🚨 1️⃣6️⃣ TLE Due to Nested Loops (Hidden)

```python
for i in range(n):
    for j in range(n):   # ❌ n²
```

👉 Ask yourself:

* Can I use **prefix sum**?
* **Sliding window**?
* **Hash map**?

---

## 🚨 1️⃣7️⃣ Using Python List as Stack of Tuples (Memory TLE)

```python
stack.append((i, j, path))   # ❌ big objects
```

✅ Use indices / reuse structures when possible.

---

## 🚨 1️⃣8️⃣ Not Using `defaultdict` (Verbose + Bug Risk)

```python
if k not in mp:
    mp[k] = []
mp[k].append(v)
```

✅

```python
from collections import defaultdict
mp = defaultdict(list)
```

---

## 🚨 1️⃣9️⃣ Shadowing Built-ins (WEIRD BUGS)

```python
sum = 0
list = []
```

❌ You just killed Python built-ins.

---

## 🚨 2️⃣0️⃣ Using `print()` in Submission (TLE)

```python
print(x)   # ❌
```

Remove before submit.

---

## 🧠 MENTAL CHECKLIST BEFORE SUBMIT

Ask yourself:

* Any **O(n²)** hidden?
* Any **list pop(0)**?
* Any **missing memoization**?
* Any **mutable default**?
* Any **deep recursion**?

---

## 🎯 FINAL ADVICE

> Most Python TLEs are **not algorithmic**, they are **language traps**.

Master these → Python becomes as strong as C++ for interviews.

---

### Want next?

* ⚡ **Python speed-optimized templates**
* 🧪 **Most common Python WA test cases**
* 📄 **One-page “Before Submit” checklist**
* 🔥 **C++ → Python mental conversion guide**

Just say 👍
