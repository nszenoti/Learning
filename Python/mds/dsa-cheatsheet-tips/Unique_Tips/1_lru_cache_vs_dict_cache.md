# 1_lru_cache_vs_dict_cache

Here's a nuanced, practical guide to `functools.lru_cache` for algorithmic problem-solving:

## Core Advantages Over Manual Dicts

```python
# Manual approach (fragile)
def fib(n, memo={}):
    if n in memo: return memo[n]
    if n < 2: return n
    memo[n] = fib(n-1) + fib(n-2)
    return memo[n]

# lru_cache approach (robust)
from functools import lru_cache

@lru_cache(maxsize=None)
def fib(n):
    if n < 2: return n
    return fib(n-1) + fib(n-2)
```

**Hidden benefits:**
- **Thread-safe**: `lru_cache` uses a lock internally; manual dicts can corrupt in multi-threaded scenarios
- **Recursive backtracking isolation**: When recursion unwinds, manual dicts retain stale entries; `lru_cache` maintains consistent state
- **Hash collision handling**: Works with unhashable args by raising clear errors vs. silent dict key failures

## Nuanced Tricks & Edge Cases

### 1. **Cache Key Collision Avoidance**
```python
# Problem: list args cause TypeError (unhashable)
@lru_cache
def process(nums):  # Fails if nums is a list
    ...

# Solution: Convert to tuple
@lru_cache
def process(nums_tuple):
    nums = list(nums_tuple)  # Convert back inside
    ...
```

### 2. **Cache Persistence Across Instance Methods**
```python
class Solver:
    @lru_cache(maxsize=128)  # Shared across ALL instances!
    def expensive_method(self, x):
        ...

# Fix: Bind cache to instance
class Solver:
    def __init__(self):
        self.expensive_method = lru_cache(maxsize=128)(self._expensive)
    
    def _expensive(self, x):
        ...
```

### 3. **Selective Caching with `typed=True`**
```python
@lru_cache(maxsize=None, typed=True)
def func(x):
    print(f"Called with {x} (type: {type(x).__name__})")
    return x * 2

func(3)    # Integer call
func(3.0)  # Float call - NOT cached, separate entry
```

### 4. **Cache Invalidation Patterns**
```python
# Manual dict: memo.clear()
# lru_cache: Use cache_info() + cache_clear()

@lru_cache
def dp(i, j):
    ...

# Clear when problem constraints change
dp.cache_clear()  # O(1) operation
print(dp.cache_info())  # CacheInfo(hits=0, misses=0, maxsize=None, currsize=0)
```

### 5. **Dynamic Programming Space Optimization**
```python
# For grid DP: Use maxsize to limit memory
@lru_cache(maxsize=1000)  # Auto-evicts old entries
def dfs(i, j):
    if i < 0 or j < 0: return 0
    return grid[i][j] + max(dfs(i-1, j), dfs(i, j-1))

# This prevents O(n²) memory growth on large grids
```

### 6. **Introspection & Debugging**
```python
@lru_cache
def solve(n):
    ...

# Inspect cache state
print(solve.cache_info())
# CacheInfo(hits=15, misses=8, maxsize=128, currsize=8)

# View actual cache keys
print(solve.cache_parameters())
# {'maxsize': 128, 'typed': False}

# Peek at cached results (undocumented but useful)
print(solve.cache._CacheInfo__root)  # For debugging only
```

## Performance Nuances

| Aspect | Manual Dict | `lru_cache` |
|--------|-------------|-------------|
| **Lookup speed** | ~50ns | ~80ns (RLock overhead) |
| **Memory per entry** | ~72 bytes | ~120 bytes (linked list node) |
| **Thread safety** | No | Yes |
| **Eviction policy** | Manual | LRU (O(1)) |
| **Hash computation** | Once (your control) | Twice (key + lock) |

**When manual dicts win:**
- Sub-microsecond latency requirements
- Need to serialize/cache to disk
- Custom eviction logic (LFU, time-based)
- Working with massive datasets (>1M entries)

## Anti-Patterns to Avoid

```python
# ❌ NEVER: Caching with mutable default
@lru_cache
def bad(arr=[]):  # Default mutable
    ...

# ❌ NEVER: Caching I/O without timeout
@lru_cache(maxsize=None)
def fetch(url):  # Cache lives forever
    return requests.get(url).json()

# ✅ DO: Wrap with timeout logic
def fetch_with_ttl(url, ttl_seconds=3600):
    from time import time
    @lru_cache(maxsize=128)
    def _cached_fetch(url, timestamp_bucket):
        return requests.get(url).json()
    
    # Round timestamp to bucket for TTL
    bucket = int(time() / ttl_seconds)
    return _cached_fetch(url, bucket)
```

## Advanced: Custom Key Generation
```python
# For complex objects, control cache keys
@lru_cache(maxsize=None)
def solve(state_hash):  # Pass hash, not object
    state = decode_state(state_hash)
    ...

# Or use custom hash function
def custom_key(*args, **kwargs):
    return hash((args, frozenset(kwargs.items())))

manual_cache = {}
def solve(*args):
    key = custom_key(*args)
    if key not in manual_cache:
        manual_cache[key] = expensive_computation(*args)
    return manual_cache[key]
```

**Final tip**: For competitive programming, `lru_cache` is 95% superior. The 5% exception is when you need **exact control** over memory or want to implement bottom-up DP conversion later (manual dicts are easier to refactor into iterative solutions).