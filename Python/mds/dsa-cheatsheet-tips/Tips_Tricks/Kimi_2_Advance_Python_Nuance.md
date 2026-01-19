# 2_Kimi_Advance_Python_Nuance

# **Part 3: Python Wizardry - Rare & Advanced Features for DSA Mastery**

Here are the **deep cuts** - features even experienced Python developers often miss, but can be game-changers for LeetCode and competitive programming.

---

## **1. Advanced Introspection & Debugging**

```python
# ❶ inspect module - Deep object inspection
import inspect

# Get source code of any function (including your own!)
print(inspect.getsource(my_function))

# Check if something is a generator/function/class
print(inspect.isgenerator(my_func))     # True/False
print(inspect.isfunction(my_func))
print(inspect.isclass(my_class))

# Get call signature with defaults
sig = inspect.signature(my_func)
for param in sig.parameters.values():
    print(param.name, param.default, param.annotation)

# Stack trace inspection (in exception handling)
def debug_print_vars():
    frame = inspect.currentframe().f_back
    print(f"Locals: {frame.f_locals}")
    print(f"Globals: {frame.f_globals}")

# Usage in recursive DFS:
def dfs(node):
    if not node: 
        debug_print_vars()  # See all variables at this recursion level
        return

# ❷ traceback module - Beautiful error parsing
import traceback

try:
    risky_code()
except:
    print(traceback.format_exc())  # Full stack trace as string
    # Or get the last exception's type, value, and tb
    exc_type, exc_value, exc_traceback = sys.exc_info()

# ❸ pdb++ (if available) or built-in pdb tricks
import pdb; pdb.pm()  # Post-mortem debugging - starts debugger at exception point

# In debugger:
# p variable - print
# pp variable - pretty print  
# n - next line
# s - step into
# c - continue
# whatis variable - show type
# where - full stack trace

# ❹ locals() with f-strings for quick debug
def debug_state(**kwargs):
    """Print all local variables with values"""
    frame = inspect.currentframe().f_back
    for k, v in frame.f_locals.items():
        print(f"{k} = {v!r}")  # !r calls repr()

# Usage: debug_state() anywhere to see all variables
```

---

## **2. Metaprogramming Magic**

```python
# ❶ Type creation on-the-fly (for dynamic programming)
Node = type('Node', (object,), {
    '__init__': lambda self, val: setattr(self, 'val', val) or setattr(self, 'next', None),
    '__repr__': lambda self: f"Node({self.val})"
})

# Create a class in one line!
# Equivalent to:
# class Node:
#     def __init__(self, val):
#         self.val = val
#         self.next = None

# ❷ Monkey patching for quick fixes (but be careful!)
def patch_old_function():
    """Temporarily replace a method for testing"""
    original_method = SomeClass.method
    SomeClass.method = lambda self, x: x * 2  # New implementation
    # Use it...
    SomeClass.method = original_method  # Restore

# ❸ __prepare__ for metaclasses (rare but powerful)
class MyMeta(type):
    @classmethod
    def __prepare__(mcs, name, bases):
        return {'start_value': 42}  # Pre-populate class namespace

class MyClass(metaclass=MyMeta):
    def get_start(self):
        return start_value  # No self needed!

# ❹ Singleton pattern using __new__ (for caching managers)
class Singleton:
    _instance = None
    def __new__(cls, *args, **kwargs):
        if cls._instance is None:
            cls._instance = super().__new__(cls)
        return cls._instance

# Usage in memoization:
class DPManager(Singleton):
    def __init__(self):
        self.cache = {}
    
    def get(self, key):
        return self.cache.get(key)
```

---

## **3. Advanced Collections Module**

```python
# ❶ ChainMap - Stack dictionaries for fallback lookups (MUST-KNOW for config)
from collections import ChainMap

# LeetCode use: Layered scopes in interpreters, default configs
defaults = {'timeout': 10, 'retries': 3}
user_config = {'timeout': 30}
config = ChainMap(user_config, defaults)  # lookups try user_config first

print(config['timeout'])    # 30 (from user_config)
print(config['retries'])    # 3 (from defaults)
print(config.maps)          # List of underlying dicts

# ❷ UserDict/UserList/UserString - When you need to subclass but preserve dict behavior
from collections import UserDict

class CaseInsensitiveDict(UserDict):
    def __getitem__(self, key):
        return super().__getitem__(key.lower())
    
    def __setitem__(self, key, value):
        super().__setitem__(key.lower(), value)

# LeetCode use: Custom graph adjacency lists with extra methods
class Graph(UserDict):
    def add_edge(self, u, v):
        self.setdefault(u, []).append(v)
    
    def has_edge(self, u, v):
        return v in self.get(u, [])

# ❸ OrderedDict.move_to_end() - Essential for LRU cache implementation
from collections import OrderedDict

class LRUCache:
    def __init__(self, capacity):
        self.cache = OrderedDict()
        self.capacity = capacity
    
    def get(self, key):
        if key in self.cache:
            self.cache.move_to_end(key)  # Mark as recently used
            return self.cache[key]
        return -1
    
    def put(self, key, value):
        if key in self.cache:
            self.cache.move_to_end(key)
        self.cache[key] = value
        if len(self.cache) > self.capacity:
            self.cache.popitem(last=False)  # Remove least recently used

# ❹ Counter arithmetic - Multiset operations
c1 = Counter(a=5, b=3)
c2 = Counter(a=1, b=2, c=4)

print(c1 + c2)      # Counter({'a': 6, 'b': 5, 'c': 4})  - union
print(c1 - c2)      # Counter({'a': 4, 'b': 1})          - difference
print(c1 & c2)      # Counter({'a': 1, 'b': 2})          - intersection (min)
print(c1 | c2)      # Counter({'a': 5, 'b': 3, 'c': 4})  - union (max)

# ❺ deque.rotate() - Circular buffer magic
from collections import deque

d = deque([1, 2, 3, 4, 5])
d.rotate(2)         # deque([4, 5, 1, 2, 3])  - right rotation
d.rotate(-1)        # deque([5, 1, 2, 3, 4])  - left rotation

# LeetCode use: Sliding window with rotation pattern
def max_sliding_window(nums, k):
    dq = deque()
    result = []
    
    for i, num in enumerate(nums):
        while dq and nums[dq[-1]] <= num:
            dq.pop()
        dq.append(i)
        
        if dq[0] <= i - k:
            dq.popleft()
        
        if i >= k - 1:
            result.append(nums[dq[0]])
    
    return result
```

---

## **4. itertools Power Tools (Beyond Basics)**

```python
# ❶ itertools.accumulate with custom function
from itertools import accumulate
import operator

nums = [1, 2, 3, 4, 5]

# Running sum
print(list(accumulate(nums)))  # [1, 3, 6, 10, 15]

# Running product
print(list(accumulate(nums, operator.mul)))  # [1, 2, 6, 24, 120]

# Running max
print(list(accumulate(nums, max)))  # [1, 2, 3, 4, 5]

# ❷ itertools.groupby with key function
data = ['apple', 'apricot', 'banana', 'blueberry', 'cherry']
for key, group in groupby(sorted(data), key=lambda x: x[0]):
    print(key, list(group))
# a ['apple', 'apricot']
# b ['banana', 'blueberry']
# c ['cherry']

# ❸ itertools.product - Cartesian product (avoid nested loops)
# All pairs (i, j) where i in [1,2] and j in [3,4]
pairs = list(product([1, 2], [3, 4]))  # [(1,3), (1,4), (2,3), (2,4)]

# ❹ itertools.chain.from_iterable - Flatten nested lists
nested = [[1, 2], [3, 4], [5, 6]]
flat = list(chain.from_iterable(nested))  # [1, 2, 3, 4, 5, 6]

# ❺ itertools.islice - Memory-efficient slicing
# Get every 3rd element from index 10 to 20
subset = list(islice(nums, 10, 20, 3))

# ❻ itertools.pairwise (Python 3.10+) - Adjacent pairs
# Equivalent to: zip(arr, arr[1:])
pairs = list(pairwise([1, 2, 3, 4]))  # [(1,2), (2,3), (3,4)]

# ❼ itertools.count with zip for indexed infinite sequences
from itertools import count

# Start enumeration from 1 instead of 0
for i, val in zip(count(1), ['a', 'b', 'c']):
    print(i, val)  # 1 a, 2 b, 3 c

# ❽ itertools.tee - Clone iterators (use with caution)
# Split an iterator into multiple independent iterators
it = iter([1, 2, 3, 4])
it1, it2 = tee(it, 2)

print(list(it1))  # [1, 2, 3, 4]
print(list(it2))  # [1, 2, 3, 4]  - Still works!
```

---

## **5. functools Hidden Gems**

```python
# ❶ functools.partial - Pre-fill arguments
from functools import partial

# Instead of lambda: lambda x: my_func(x, constant=10)
my_partial = partial(my_func, constant=10)  # Faster than lambda

# Pre-fill comparator for sorting
def compare_with_target(a, target):
    return abs(a - target)

closest = partial(compare_with_target, target=5)
sorted(nums, key=closest)

# ❷ functools.singledispatch - Function overloading
from functools import singledispatch

@singledispatch
def process(data):
    raise NotImplementedError

@process.register
def _(data: list):
    return sum(data)

@process.register
def _(data: dict):
    return sum(data.values())

@process.register
def _(data: str):
    return len(data)

process([1, 2, 3])      # 6
process({'a': 1, 'b': 2})  # 3
process("hello")        # 5

# ❸ functools.lru_cache with maxsize=None vs @cache
from functools import lru_cache, cache

# @cache is Python 3.9+, equivalent to @lru_cache(maxsize=None)
@cache
def fib(n):
    return fib(n-1) + fib(n-2) if n > 1 else n

# But lru_cache can be CLEARED (important for multiple test cases)
@lru_cache(maxsize=None)
def dp(i, j):
    pass

# After each test case:
dp.cache_clear()  # Critical to avoid memory blow-up!

# ❸ functools.reduce with operator module
from functools import reduce
import operator

# Instead of: reduce(lambda a,b: a+b, arr)
total = reduce(operator.add, nums)  # Faster

# Product of array
product = reduce(operator.mul, nums, 1)

# Chain comparisons
all_equal = reduce(operator.eq, nums)  # Check if all elements equal

# ❹ functools.wraps for decorators (preserves metadata)
from functools import wraps

def debug(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        print(f"Calling {func.__name__} with {args}")
        return func(*args, **kwargs)
    return wrapper

# ❺ cached_property (Python 3.8+)
from functools import cached_property

class Tree:
    def __init__(self, root):
        self.root = root
    
    @cached_property
    def height(self):
        # Computed once, cached forever
        return self._compute_height(self.root)
```

---

## **6. Typing Module for Clarity (Not Just for show)**

```python
# ❶ Type hints with Union, Optional, List, Dict, Set
from typing import List, Dict, Set, Optional, Union, Tuple, Any, Callable

def two_sum(nums: List[int], target: int) -> Tuple[int, int]:
    ...

# For complex nested structures
def matrix_operations(matrix: List[List[int]]) -> Dict[str, List[int]]:
    ...

# ❷ Type aliases for readability
Graph = Dict[int, List[int]]
TreeNodeType = Optional['TreeNode']  # Forward reference

def bfs(graph: Graph, start: int) -> List[int]:
    ...

# ❸ Callable for function signatures
def process_strategy(nums: List[int], 
                     strategy: Callable[[int, int], bool]) -> List[int]:
    ...

# ❹ Generic TypeVar for reusable components
from typing import TypeVar, Generic

T = TypeVar('T')

class Stack(Generic[T]):
    def __init__(self) -> None:
        self.items: List[T] = []
    
    def push(self, item: T) -> None:
        self.items.append(item)
    
    def pop(self) -> Optional[T]:
        return self.items.pop() if self.items else None

# ❺ @typing.overload - For functions with different behavior based on types
from typing import overload

@overload
def process(data: List[int]) -> int: ...

@overload
def process(data: Dict[str, int]) -> str: ...

def process(data):  # Actual implementation
    if isinstance(data, list):
        return sum(data)
    elif isinstance(data, dict):
        return str(data)
```

---

## **7. Memory Management & Performance**

```python
# ❶ __slots__ - Reduce memory by 30-50% for many instances
class TreeNode:
    __slots__ = ('val', 'left', 'right', 'parent')  # No __dict__ created
    def __init__(self, val):
        self.val = val
        self.left = None
        self.right = None
        self.parent = None

# When NOT to use: If you need dynamic attributes or weakref
# Trade-off: Slightly faster attribute access

# ❷ weakref for caching without preventing GC
import weakref

# Cache that doesn't keep objects alive unnecessarily
cache = weakref.WeakValueDictionary()

def get_expensive_object(key):
    if key in cache:
        return cache[key]
    obj = create_expensive_object(key)
    cache[key] = obj
    return obj

# ❸ array module - For C-style arrays (memory efficient)
from array import array

# For massive numeric data (e.g., 1M+ elements)
nums = array('i', [0] * 1000000)  # 'i' = signed int, 4 bytes each
# vs list: [0] * 1000000 uses 28 bytes per element

# ❹ memoryview - Zero-copy slicing
data = bytearray(b'hello world')
view = memoryview(data)
subview = view[6:]  # No copy!
subview[0] = ord('W')  # Modifies original!

# ❺ gc module - Force garbage collection (rarely needed)
import gc

# After deleting large data structures
del huge_matrix
gc.collect()  # Force cleanup

# ❻ sys.getsizeof - Check actual memory usage
import sys

print(sys.getsizeof([]))        # 56 bytes (empty list overhead)
print(sys.getsizeof([1] * 1000)) # 8056 bytes
print(sys.getsizeof(array('i', [1] * 1000))) # 4072 bytes (half!)
```

---

## **8. Advanced Syntax & Operators**

```python
# ❶ Chained assignment with different values
a, b = [1, 2, 3], [4, 5]  # Unpacking works with any iterable

# ❷ := walrus operator in list comprehensions
# Find first index where nums[i] > target
if (idx := next((i for i, x in enumerate(nums) if x > target), None)):
    process(idx)

# ❸ ** exponent operator tricks
# Check if power of 2: not (n & (n - 1)) 
# Get next power of 2: 1 << (n - 1).bit_length()

# ❹ Bitwise assignment operators
x = 5
x <<= 1   # x = x << 1 (multiply by 2)
x >>= 1   # x = x >> 1 (divide by 2)

# ❺ Ellipsis (...) for slicing higher dimensions
matrix = [[1, 2, 3], [4, 5, 6]]
submatrix = [row[...] for row in matrix[1:]]  # All columns from row 1 onward

# ❺ Exception chaining (rare but useful)
try:
    risky_op()
except Exception as e:
    raise ValueError("Custom message") from e  # Preserves original traceback

# ❻ for...else clause (executes if loop completes without break)
for i in range(n):
    if condition: break
else:
    # Only runs if no break occurred
    return -1  # Not found case

# ❼ Match-case (Python 3.10+) - Structural pattern matching
def process_node(node):
    match node:
        case TreeNode(val, None, None):
            return val  # Leaf node
        case TreeNode(val, left, None):
            return val + process_node(left)
        case TreeNode(val, None, right):
            return val + process_node(right)
        case TreeNode(val, left, right):
            return val + process_node(left) + process_node(right)
        case None:
            return 0
```

---

## **9. Rare Built-in Functions**

```python
# ❶ divmod() - Quotient and remainder in one operation
q, r = divmod(17, 5)  # q = 3, r = 2  (faster than separate // and %)

# ❷ enumerate with start parameter
for i, val in enumerate(nums, 1):  # Start at 1, not 0

# ❸ zip with strict=True (Python 3.10+) - Fails if lengths mismatch
pairs = zip(list1, list2, strict=True)  # Raises ValueError if unequal lengths

# ❹ pow() with modulus - Modular exponentiation (critical for number theory)
# Instead of: (base ** exp) % mod
result = pow(base, exp, mod)  # Much faster, avoids overflow

# ❺ reversed() returns an iterator
for i in reversed(range(10)):  # Memory efficient
    pass

# ❻ enumerate on reversed sequence
for idx, val in enumerate(reversed(nums)):
    print(-idx-1, val)  # Negative indices

# ❼ id() - Get object's memory address (for debugging identity issues)
a = [1, 2, 3]
b = a
print(id(a) == id(b))  # True - same object

# ❌ hash() - Hashability check (why some objects can't be dict keys)
print(hash([1, 2, 3]))  # TypeError: unhashable type: 'list'
print(hash((1, 2, 3)))  # Works fine
```

---

## **10. Pathlib for File-Based Problems**

```python
# For problems involving file paths (rare but appears)
from pathlib import Path

# Clean path manipulation
p = Path('root') / 'subdir' / 'file.txt'  # OS-independent

# Read all lines
lines = p.read_text().splitlines()

# Iterate files in directory
for file in Path('.').glob('*.txt'):
    process(file.read_text())
```

---

## **11. Time Complexity Testing**

```python
# ❶ timeit module - Micro-benchmarks
import timeit

# Compare two approaches
setup = 'nums = list(range(1000))'
time1 = timeit.timeit('sum(nums)', setup=setup, number=10000)
time2 = timeit.timeit('reduce(lambda a,b: a+b, nums)', 
                      setup='from functools import reduce; ' + setup, 
                      number=10000)

print(f"Built-in sum: {time1:.4f}s")
print(f"Reduce: {time2:.4f}s")

# ❷ dis module - Bytecode inspection
import dis

def my_function():
    result = []
    for i in range(10):
        result.append(i * 2)
    return result

dis.dis(my_function)
# Shows actual Python bytecode - helps understand performance
```

---

## **12. Generator Advanced Patterns**

```python
# ❶ Generator.send() - Two-way communication
def coroutine():
    print("Starting")
    while True:
        x = yield  # Receives value from send()
        print(f"Got: {x}")

c = coroutine()
next(c)        # Prime the generator
c.send(10)     # "Got: 10"
c.send(20)     # "Got: 20"

# ❷ Generator.throw() - Inject exceptions
try:
    c.throw(ValueError("Boom!"))
except ValueError:
    pass

# ❸ yield from - Delegate to sub-generator
def flatten(nested):
    for sublist in nested:
        if isinstance(sublist, list):
            yield from flatten(sublist)  # Recursive delegation
        else:
            yield sublist

# ❹ Generator.close() - Clean shutdown
gen = my_generator()
gen.close()  # Raises GeneratorExit inside generator
```

---

## **13. Serialization for Memoization**

```python
# ❶ pickle module - Serialize Python objects (faster than json)
import pickle

# Save state
state = {'dp_table': dp_table, 'cache': cache}
with open('state.pkl', 'wb') as f:
    pickle.dump(state, f)

# Load state
with open('state.pkl', 'rb') as f:
    state = pickle.load(f)

# ❷ pickle with highest protocol for speed
pickle.dumps(obj, protocol=pickle.HIGHEST_PROTOCOL)

# ❸ marshal module - Faster but less secure (for built-in types only)
import marshal

# Only for int, float, complex, tuple, list, dict, set, frozenset, str, bytes
data = marshal.dumps([1, 2, 3])
back = marshal.loads(data)
```

---

## **14. The "One Weird Trick" Section**

```python
# ❶ The "or" trick for default values
# Instead of: x = some_val if some_val is not None else default
x = some_val or default  # Works for None, False, 0, empty string

# ❷ The "and" trick for chaining conditions
# Instead of: if a and b and c: do_something()
result = a and b and c and do_something()  # Short-circuits

# ❸ isinstance with tuple of types
if isinstance(x, (list, tuple, set)):  # Check multiple types at once

# ❹ The "starred expression" for extended unpacking
head, *middle, tail = [1, 2, 3, 4, 5]  # middle = [2, 3, 4]

# ❺ The "@" operator (matrix multiplication)
# For custom classes: define __matmul__ and __rmatmul__
class Matrix:
    def __matmul__(self, other):
        return self.multiply(other)

# ❻ sys.intern - Intern strings for memory savings
import sys
a = sys.intern("hello_world")  # Reuses memory for identical strings
b = sys.intern("hello_world")  # Same object as 'a'

# ❼ The "Ellipsis" singleton
# Can use ... instead of pass in abstract methods
def abstract_method(self, x): ...

# In type hints: Callable[..., int] means any arguments, returns int

# ❽ The "del" statement with slices
arr = [1, 2, 3, 4, 5]
del arr[::2]  # Delete every other element

# ❾ Multiple context managers
with open('a.txt') as f1, open('b.txt') as f2:
    process(f1, f2)

# ❿ The "f" prefix for f-strings can be combined with r""
path = fr"C:\Users\{username}\file.txt"  # Raw + formatted string
```

---

## **15. When All Else Fails - Extreme Measures**

```python
# ❶ ctypes - Call C functions (for raw performance)
import ctypes

# Access libc qsort
libc = ctypes.CDLL('libc.so.6')
qsort = libc.qsort
qsort.restype = None

# Comparison function
CMPFUNC = ctypes.CFUNCTYPE(ctypes.c_int, ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int))

def compare(a, b):
    return a[0] - b[0]

# Use C's faster qsort for massive arrays
arr = (ctypes.c_int * 1000000)(*nums)
qsort(arr, len(arr), ctypes.sizeof(ctypes.c_int), CMPFUNC(compare))

# ❷ numpy (if allowed) - For heavy matrix operations
import numpy as np

# Much faster than list comprehensions for large arrays
matrix = np.array([[1, 2], [3, 4]])
result = matrix @ matrix  # Matrix multiplication

# ❸ numba - JIT compilation (if allowed)
from numba import jit

@jit(nopython=True)
def expensive_computation(arr):
    # Compiled to machine code
    result = 0
    for i in range(len(arr)):
        for j in range(len(arr)):
            result += arr[i] * arr[j]
    return result

# ❹ sys.settrace - Line-by-line debugging
def trace_calls(frame, event, arg):
    if event == 'line':
        lineno = frame.f_lineno
        print(f"Line {lineno}: {frame.f_locals}")
    return trace_calls

sys.settrace(trace_calls)
# Your code here - will print every line's local variables
```

---

**Final Rule:** If you think "there must be a better way," there probably is. Python's standard library is vast. When stuck, check `dir()` and `help()` on modules and objects - you'll often discover hidden methods that solve your problem.