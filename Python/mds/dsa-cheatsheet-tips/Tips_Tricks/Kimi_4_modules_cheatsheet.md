Kimi_4_modules_cheatsheet.md

Yes, the builtins cheat sheet is **complete for DSA** (debugging tools excluded). Here's the modules version:

---

# **Python Modules Cheat Sheet for DSA**

### **`collections`** - Data Structures Extended

```python
from collections import deque, defaultdict, Counter, OrderedDict, ChainMap

# deque: Stack + Queue O(1) both ends
dq = deque([1,2,3])
dq.appendleft(0); dq.append(4)    # deque([0,1,2,3,4])
dq.popleft(); dq.pop()            # Remove 0 and 4
dq.rotate(2)                      # Rotate right: deque([3,4,1,2])

# defaultdict: No KeyError
graph = defaultdict(list)         # graph[node].append(neighbor) - auto-creates []
freq = defaultdict(int)           # freq[char] += 1 - auto 0

# Counter: Multiset arithmetic
c = Counter(nums)                 # Count frequency
c.most_common(k)                  # Top k elements
c1 + c2; c1 - c2; c1 & c2; c1 | c2  # Union, diff, intersect, union-max

# OrderedDict: LRU pattern
od = OrderedDict(); od[key] = val; od.move_to_end(key)

# ChainMap: Layered dicts (interpreter scopes)
config = ChainMap(user_config, defaults)  # Lookup tries user first
```

---

### **`itertools`** - Iterator Power Tools

```python
from itertools import accumulate, combinations, permutations, product, groupby, chain

# accumulate: Running sum/product
prefix = list(accumulate(nums))   # [1, 3, 6, 10...]

# combinations/permutations: Subsets
list(combinations([1,2,3], 2))    # [(1,2), (1,3), (2,3)]
list(permutations([1,2], 2))      # [(1,2), (2,1)]

# product: Cartesian product
list(product([1,2], ['a','b']))   # [(1,'a'), (1,'b'), (2,'a'), (2,'b')]

# groupby: Adjacent grouping
for key, group in groupby(sorted(arr)):  # Must sort first!
    print(key, list(group))

# chain: Flatten nested
list(chain.from_iterable(nested))  # [1,2,3,4,5,6]
```

---

### **`heapq`** - Min-Heap (Max via negative)

```python
import heapq

# Min-heap default
heap = []
heapq.heappush(heap, val)         # O(log n)
smallest = heapq.heappop(heap)    # O(log n)
heap[0]                           # Peek O(1)

# Max-heap simulation
heapq.heappush(heap, -val)        # Push negative
max_val = -heapq.heappop(heap)    # Pop and negate

# Heapify existing list
heapq.heapify(arr)                # O(n) in-place

# Largest/Smallest k
k_smallest = heapq.nsmallest(k, arr)  # O(n log k)
k_largest = heapq.nlargest(k, arr)    # O(n log k)
```

---

### **`bisect`** - Binary Search

```python
import bisect

arr = [1,3,4,4,6,8]

# Insert position (sorted list required)
idx = bisect.bisect_left(arr, 4)   # First 4 → index 2
idx = bisect.bisect_right(arr, 4)  # After last 4 → index 4

# Count occurrences
count = bisect_right(arr, x) - bisect_left(arr, x)

# Insert while maintaining sort
bisect.insort_left(arr, 5)         # Insert 5 at correct position
```

---

### **`functools`** - Higher-Order Functions

```python
from functools import lru_cache, cmp_to_key, partial

# LRU Cache (memoization)
@lru_cache(maxsize=None)
def dp(i, j):
    # Recursive DP logic
    pass

# Clear cache between test cases
dp.cache_clear()

# Custom comparator for sorting
sorted_points = sorted(points, key=cmp_to_key(compare_func))

# Partial function (pre-fill args)
double = partial(mul, 2)           # double(x) = 2 * x
```

---

### **`sys`** - System & Limits

```python
import sys

# Increase recursion limit (CRITICAL for tree/graph DFS)
sys.setrecursionlimit(10**6)       # Default 1000 is too low

# Input reading (fast)
data = sys.stdin.read().split()    # Faster than input() in loops
```

---

### **`math`** - Math Constants & Functions

```python
import math

# Constants
inf = float('inf'); n_inf = -math.inf

# GCD, LCM
g = math.gcd(a, b); lcm = a * b // g

# Combinations/permutations (Python 3.8+)
math.comb(n, k); math.perm(n, k)

# Ceil/floor
math.ceil(2.3); math.floor(2.7)

# Square root
sqrt_n = int(math.isqrt(n))        # Integer sqrt (Python 3.8+)
```

---

**Print & keep both cheat sheets together.** 90% of your imports will be from these 7 modules.