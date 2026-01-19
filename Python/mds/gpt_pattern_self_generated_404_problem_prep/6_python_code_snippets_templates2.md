# 6_python_code_snippets_templates2

Ah, perfect — yes, we can definitely **extend point 13 (Bit / Math / Python helpers)**.
This is exactly where **Python interview “tricks + math helpers + bit hacks”** live. Let’s make a **full go-to set** for you.

---

# 🧮 **Bit, Math, Python Nuances & Helpers**

---

## 1️⃣ **Bit Manipulation Patterns (Beyond Basics)**

### Common bit operations

```python
# Check kth bit
(n >> k) & 1

# Set kth bit
n |= (1 << k)

# Clear kth bit
n &= ~(1 << k)

# Toggle kth bit
n ^= (1 << k)

# Count set bits (Pythonic)
bin(n).count('1')

# Is power of 2
n & (n-1) == 0

# Rightmost set bit
n & -n

# XOR trick (single number)
res = 0
for x in arr:
    res ^= x
```

### Bitmask patterns

```python
# Enumerate all subsets of n elements
for mask in range(1 << n):
    subset = [arr[i] for i in range(n) if mask & (1 << i)]
```

---

## 2️⃣ **Math Helpers**

### GCD / LCM

```python
from math import gcd
from functools import reduce

# GCD of two numbers
g = gcd(a, b)

# LCM of two numbers
lcm = a*b // gcd(a, b)

# GCD of a list
g = reduce(gcd, arr)
```

### Factorials / Combinations / Permutations

```python
from math import factorial, comb, perm

# factorial
factorial(5)  # 120

# combinations: n choose k
comb(5,2)     # 10

# permutations: nPk
perm(5,2)     # 20
```

### Powers / Modular Arithmetic

```python
# Power
pow(a, b)          # a**b

# Modular power
pow(a, b, mod)     # (a**b) % mod efficiently
```

### Logs / Exponentials

```python
from math import log, log2, log10, exp, ceil, floor

log(n)       # natural log
log2(n)      # base-2 log
log10(n)     # base-10 log

ceil(2.3)    # 3
floor(2.7)   # 2
```

### Primes

```python
# Check small prime
def is_prime(n):
    if n < 2: return False
    for i in range(2, int(n**0.5)+1):
        if n % i == 0: return False
    return True
```

---

## 3️⃣ **Python Idiomatic Helpers**

### List / Set / Dict operations

```python
# Count frequency
from collections import Counter
freq = Counter(arr)

# Remove duplicates
unique = list(set(arr))

# Dictionary get with default
d.get(key, default)

# Merge dicts (Python3.9+)
d3 = d1 | d2
```

### Sorting Tricks

```python
# Sort list of tuples by second value then first
arr.sort(key=lambda x: (x[1], x[0]))

# Sort dictionary by value
sorted_dict = sorted(d.items(), key=lambda x: x[1])
```

### Enumerate / Zip / Any / All

```python
# Enumerate
for i, val in enumerate(arr):
    print(i, val)

# Zip
for x, y in zip(list1, list2):
    print(x, y)

# Any / All
any(x>0 for x in arr)
all(x>0 for x in arr)
```

### Sliding / Chunking

```python
# Chunk list into k-sized sublists
def chunks(lst, k):
    for i in range(0, len(lst), k):
        yield lst[i:i+k]

list(chunks(arr, 3))
```

### Flattening

```python
from itertools import chain
flat = list(chain.from_iterable(nested_list))
```

---

## 4️⃣ **Bit + Math + Pattern Helpers Together**

These are **commonly reused in patterns**:

```python
# Count bits for subsets (subset sum / bitmask DP)
for mask in range(1 << n):
    bit_count = bin(mask).count('1')

# Fast powers for DP / Modular arithmetic
def fast_pow(a, b, mod):
    res = 1
    while b:
        if b & 1: res = (res * a) % mod
        a = (a*a) % mod
        b >>= 1
    return res

# Generate all divisors
def divisors(n):
    divs = set()
    for i in range(1, int(n**0.5)+1):
        if n % i == 0:
            divs.add(i)
            divs.add(n//i)
    return divs
```

---

## 5️⃣ **Python Nuances for Performance / Readability**

* `sys.stdin.readline()` faster for huge inputs
* `from collections import deque` → O(1) pops/pushes
* `enumerate`, `zip`, `all`, `any` → cleaner loops
* List comprehension vs generator → memory control
* `heapq` → built-in priority queue
* `bisect` → binary search on sorted arrays

```python
import bisect
idx = bisect.bisect_left(arr, x)  # leftmost position
bisect.insort(arr, x)              # insert while keeping sorted
```

* `@lru_cache(None)` for memoization
* `itertools.permutations`, `combinations` → quick backtracking helpers

---

✅ **Key principle:**
Think of this as **your “Python swiss army knife” for patterns**:

* Bit → subset / mask / xor
* Math → primes, mod, factorial, combinatorics
* Python → loops, dict, heap, bisect, enumerate, itertools
* Helpers → chunking, flattening, sliding window

---

If you want, I can **merge all of this + pattern skeletons into a single “Python Interview Template Repo”** ready to **copy-paste** per pattern — essentially a **complete go-to starter kit**.

Do you want me to do that next?
