# Kimi_6_problem_solving_strategy.md

https://www.kimi.com/chat/19b974c5-1f52-82bc-8000-09fe66071f5f

# **Problem-Solving Strategy Cheat Sheet**

### **Universal Framework (5-Step Process)**

1. **Read & Parse** (1 min)
   - Identify input/output types and constraints
   - Highlight keywords: *"substring"*, *"path"*, *"sorted"*, *"duplicate"*, *"minimum"*
   - Edge cases: empty, single element, max constraints

2. **Brute Force First** (30 seconds)
   - Write O(n³) or O(2ⁿ) solution in comments
   - This reveals the pattern to optimize

3. **Pattern Match** (1 min)
   - Use "Pattern Signals" table below
   - Choose 1-2 likely patterns

4. **Code Template** (3-5 min)
   - Fill in pattern template from previous cheat sheets
   - Add early exits and edge case checks at top

5. **Test & Debug** (1-2 min)
   - Run on given example
   - Test your own edge cases
   - Use "Debugging Checklist" below

---

### **Pattern Signals (Problem → Pattern)**

| **Keyword/Signal** | **Pattern** | **Complexity Target** |
|-------------------|-------------|----------------------|
| *"subarray/substring"* + *"max/min"* | **Sliding Window** | O(n) time, O(1) space |
| *"pairs"*, *"two numbers"*, *"target sum"* | **Two Pointers** or **Hash Map** | O(n) or O(n log n) |
| *"sorted array"* + *"search"* | **Binary Search** | O(log n) |
| *"next greater/smaller"*, *"stock span"* | **Monotonic Stack** | O(n) |
| *"k largest/smallest"* | **Heap** | O(n log k) |
| *"path"*, *"connected"*, *"cycle"* | **DFS/BFS** or **Union-Find** | O(V+E) |
| *"levels"*, *"distance"* | **BFS** (queue) | O(V+E) |
| *"intersect/merge intervals"* | **Sort + Merge** | O(n log n) |
| *"ways to"*, *"number of combinations"* | **DP** (top-down/bottom-up) | O(n²) or O(n) |
| *"character frequency"* | **Counter** | O(n) |
| *"prefix"* comparison | **Trie** | O(m) per word |
| *"order of courses/tasks"* | **Topological Sort** | O(V+E) |
| *"palindrome"* | **Two pointers from ends** | O(n) |
| *"tree traversal"* | **DFS (recursion)** | O(n) |

---

### **Category-Specific Playbooks**

#### **Arrays/Strings**
- **Sorted?** → Binary search, two pointers
- **Unsorted?** → Hash map for O(1) lookup
- **Fixed window?** → Two pointers at distance `k`
- **Variable window?** → Expand right, shrink left
- **In-place modification?** → Swap with two pointers from ends
- **Pattern matching?** → KMP or Python's `str in str` (O(n*m) avg)

#### **Linked Lists**
- **Fast-slow pointers** for middle/cycle detection
- **Dummy node** at head to avoid edge case checks
-  **`prev, curr = None, head`**  , then `curr.next, prev, curr = prev, curr, curr.next`
- **Recursion** for reversal/merge (but watch recursion depth)

#### **Trees**
- **DFS → paths, sums, existence** (use `@lru_cache`)
- **BFS → levels, distances, averages** (use `deque`)
- **BST?** → Inorder traversal gives sorted order
- **Recursive?** Always check `if not node: return base`
- **Iterative?** Use `stack = [(root, state)]` where state tracks visited children

#### **Graphs**
- **Adjacency list** via `defaultdict(list)`
- **DFS** for connectivity, path finding, topological sort
- **BFS** for shortest path (unweighted), levels
- **Union-Find** for dynamic connectivity, cycles, Kruskal's
- **Matrix BFS/DFS** → Directions array `[(0,1),(0,-1),(1,0),(-1,0)]`

#### **Dynamic Programming**
- **Top-down:** `@lru_cache` + recursive
- **Bottom-up:** Table `dp = [[0]*(n+1) for _ in range(m+1)]`
- **State compression:** Use `prev, curr` variables instead of full table
- **Initialization:** `dp[0] = base_case`, others `= -inf` (max) or `+inf` (min)
- **Return:** `dp[-1]` or `dp[n][m]`

---

### **Complexity Decision Tree**

```
Need O(n log n) or better?
├─ Yes → Can you sort first? → Sort + greedy/2 pointers
├─ Need O(log n)? → Is it sorted? → Binary search
├─ Need O(n)? → Can you use hash map? → Space for time
├─ Need O(1) space? → Two pointers, in-place modification
├─ Exponential? → DP memoization or backtracking with pruning
└─ Graph? → O(V+E) always achievable with BFS/DFS
```

---

### **Time/Space Tradeoff Rules**

- **Space is cheap → Use it!** A `set()` or `dict` can turn O(n²) → O(n)
- **Precompute → Store** Prefix sums, suffix arrays, hash maps
- **Memoization → Cache** `@lru_cache` is your best friend
- **Only optimize space after** you have O(n) time working

---

### **Debugging Checklist (WA → TLE → AC)**

#### **Wrong Answer (WA)**
- [ ] **Edge cases:** `[]`, `[1]`, `None`, duplicates, negative numbers
- [ ] **Off-by-one:** Loop conditions, array sizes, `left < right` vs `<=`
- [ ] **Type issues:** `int vs float`, `list vs tuple`, `str vs list`
- [ ] **Mutable defaults:** Are you modifying a shared list/object?
- [ ] **Sort order:** Ascending vs descending, `key` function correct?
- [ ] **Integer overflow:** Use `int` (Python), but check modulo operations

#### **Time Limit Exceeded (TLE)**
- [ ] **Brute force?** Did you skip pattern recognition?
- [ ] **Complexity:** Calculate O() - is it feasible for n=10⁵?
- [ ] **Recursion depth:** Add `sys.setrecursionlimit(10**6)`
- [ ] **String concat:** Replace `+` with `''.join()`
- [ ] **In-loop lookups:** Move `len()`, attribute access outside loops
- [ ] **Data structure:** Using `list` for lookups? Use `set/dict`
- [ ] **Cache misses:** Add `@lru_cache` to recursive DP

---

### **Final Sanity Check (Before Submit)**

```python
def solve_problem(...):
    # 1. Edge cases at top
    if not input: return base_case
    if len(input) == 1: return input[0]
    
    # 2. Type hints (clarity)
    def dfs(node: TreeNode) -> int:
        # 3. Early returns
        if not node: return 0
        
        # 4. Use helpers with lru_cache
        @lru_cache(None)
        def dp(i, j):
            # 5. Recursion base cases
            if i >= n: return 0
    
    # 6. Readable variable names
    left, right = 0, len(arr) - 1
    
    # 7. Precompute expensive values
    n = len(arr)
    prefix = list(accumulate(arr))
    
    # 8. Return the obvious answer
    return result[-1]  # or result[n][m] or result
```

---

**Next:** When stuck, **brute force → pattern → optimize → submit**. The pattern is always there.