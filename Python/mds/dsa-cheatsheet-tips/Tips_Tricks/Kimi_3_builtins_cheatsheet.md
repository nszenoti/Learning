# Kimi_3_builtins_cheatsheet

https://www.kimi.com/chat/19b974c5-1f52-82bc-8000-09fe66071f5f

# **Python DSA: Dunder & Builtins Cheat Sheet**

A quick reference for problem-solving (print-friendly).

---

## **1. Essential Dunder Methods**

```python
class TreeNode:
    __slots__ = ('val', 'left', 'right')  # MEMORY SAVER: No __dict__
    
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right
    
    def __repr__(self):  # DEBUGGING: Print-readable
        return f"TN({self.val})"
    
    def __lt__(self, other):  # SORTING/HEAP: Define < behavior
        return self.val < other.val  # For PriorityQueue of nodes
    
    def __len__(self):  # CUSTOM LENGTH: if needed
        return 1 + len(self.left or []) + len(self.right or [])
    
    def __iter__(self):  # ITERATION: yield values in-order
        yield from self.left or []
        yield self.val
        yield from self.right or []
    
    def __getitem__(self, idx):  # INDEXING: node[i] support
        return list(self)[idx]
    
    def __call__(self):  # CALLABLE: node() executes
        return self.val * 2
    
    def __contains__(self, val):  # MEMBERSHIP: 'in' operator
        return val in list(self)
    
    def __hash__(self):  # HASHABLE: For set/dict keys
        return hash((self.val, id(self.left), id(self.right)))
```

---

## **2. Critical Built-in Functions (DSA Focus)**

| Function | Usage Pattern | Example |
|----------|---------------|---------|
| **`len()`** | Get size | `if len(queue) > k:` |
| **`min/max()`** | Find extremes | `max(subarray, key=abs)` |
| **`sum()`** | Array sum | `sum(nums, start=0)` |
| **`any()/all()`** | Early exit | `if any(x < 0 for x):` |
| **`sorted()`** | Sort w/ custom key | `sorted(arr, key=lambda x: -x)` |
| **`enumerate()`** | Index+value | `for i, v in enumerate(arr, 1)` |
| **`zip()`** | Parallel iteration | `for a, b in zip(A, B)` |
| **`map()`** | Transform | `list(map(int, strs))` |
| **`filter()`** | Filter | `list(filter(lambda x: x>0, arr))` |
| **`range()`** | Loop control | `range(start, end, step)` |
| **`reversed()`** | Reverse iter | `for i in reversed(arr)` |
| **`abs()`** | Distance | `abs(a - b)` |
| **`divmod()`** | Q+R faster | `q, r = divmod(a, b)` |
| **`pow(a, b, mod)`** | Mod exponent | `pow(2, n, 10**9+7)` |
| **`ord()/chr()`** | Char↔ASCII | `ord('a') - ord('A')` |
| **`bin()/hex()`** | Base conv | `bin(5)[2:].zfill(4)` |
| **`type()`** | Type check | `if type(x) is list:` |
| **`isinstance()`** | Type check safe | `isinstance(x, (list, tuple))` |
| **`hash()`** | Hashability | `hash((1, 2))` |
| **`id()`** | Identity check | `if id(a) == id(b)` |
| **`slice()`** | Custom slice | `arr[slice(0, 10, 2)]` |

---

## **3. Built-in Exceptions (Quick Catch)**

```python
try:
    risky_code()
except (KeyError, IndexError):  # Dict/list lookup failed
    handle_missing()
except ValueError:  # Invalid conversion
    handle_invalid()
except TypeError:  # Wrong type operation
    handle_type_error()
except RecursionError:  # Max recursion depth
    sys.setrecursionlimit(10**6)
```

---

## **4. Most Common Patterns**

```python
# Sorting custom objects
@dataclass
class Point:
    x: int; y: int
    def __lt__(self, other):
        return self.x < other.x  # Or (self.x, self.y) < (other.x, other.y)

# LRU Cache structure
class LRUCache:
    def __init__(self, capacity: int):
        self.cache = OrderedDict()
        self.capacity = capacity
    
    def get(self, key: int) -> int:
        if key in self.cache:
            self.cache.move_to_end(key)
            return self.cache[key]
        return -1
```

---

**Print & keep handy.** For 99% of LeetCode, you only need `__init__`, `__repr__`, `__lt__`, `len()`, `sorted()`, `enumerate()`, `zip()`.

-------------

**Short answer:** They're **debugging tools, not solution tools**.

-  **`dir()`/`vars()`**  : Great for interactive exploration (`dir(list)` shows methods), but you **never** call them in submission code. They slow execution and clutter logic.
-  **`format()`**  : Obsolete since **f-strings** (`f"{x}"`) are faster, more readable, and the standard in competitive programming.

**Verdict:** Leave them off a *solution* cheat sheet. If you want a separate "debugging" reference, they belong there.


----

# GIST

**We covered 95%+ of relevant builtins.** What's left is **never used** in LeetCode:

- `eval()`, `exec()` - Dangerous, banned
- `compile()` - Overkill
- `property`, `staticmethod` - OOP design, not algos
- `frozenset()` - Theoretical, no benefit over `set()`
- `complex()` - Never needed
- `super()` - Inheritance, irrelevant

**Debugging:** We covered all **practical** tools. Here's the hierarchy:

| Tool | Use Case |
|------|----------|
| **`print(f"{var=}")`** | 90% of debugging |
| **`print(type(var), var)`** | Type+value check |
| **`assert condition`** | Invariant verification |
| **`dir(obj)`** | Explore methods in REPL |
| **`help(func)`** | Quick docs in REPL |
| **pdb / breakpoint()** | Step-through (rarely needed) |
| **`lru_cache.cache_info()`** | Debug memoization hits/misses |

**Verdict:** Your cheat sheet arsenal is **complete**. Time to solve problems, not memorize more Python.