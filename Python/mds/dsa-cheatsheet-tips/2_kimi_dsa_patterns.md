2_kimi_dsa_patterns

https://www.kimi.com/chat/19b974c5-1f52-82bc-8000-09fe66071f5f

# **Part 2: Advanced Patterns & Python Nuances for LeetCode**

Here are the **critical patterns** and Python-specific nuances that are often missed but frequently appear in medium/hard problems.

---

## **1. Monotonic Stack Pattern** ⭐⭐⭐

**Use when:** Finding next greater/smaller element, largest rectangle areas, daily temperatures.

```python
def next_greater_element(nums):
    """Returns next greater element for each position, -1 if none"""
    n = len(nums)
    result = [-1] * n
    stack = []  # Stores (value, index) pairs, decreasing order
    
    for i, num in enumerate(nums):
        # Pop while current is greater than stack top
        while stack and stack[-1][0] < num:
            _, idx = stack.pop()
            result[idx] = num
        
        stack.append((num, i))
    
    return result

# Variation: Next smaller element (change < to >)
# Variation: Previous greater/smaller by iterating right-to-left
```

**Key nuance:** Python doesn't have a built-in max-heap. For **max-heap simulation**, push negative values:
```python
# Max-heap pattern (for k smallest where we want to pop largest)
heap = []
for num in nums:
    heapq.heappush(heap, -num)  # Simulate max-heap
    if len(heap) > k:
        heapq.heappop(heap)
```

---

## **2. Overlapping Intervals Pattern** ⭐⭐⭐

**Use when:** Merging intervals, finding conflicts, inserting intervals.

```python
def merge_intervals(intervals):
    """Merge all overlapping intervals"""
    if not intervals: return []
    
    # CRITICAL: Sort by start time first
    intervals.sort(key=lambda x: x[0])
    merged = [intervals[0]]
    
    for curr in intervals[1:]:
        prev = merged[-1]
        # Check for overlap: prev[1] >= curr[0]
        if prev[1] >= curr[0]:
            # Merge: update end time
            prev[1] = max(prev[1], curr[1])
        else:
            merged.append(curr)
    
    return merged

# Insert interval variant
def insert_interval(intervals, new_interval):
    result = []
    i = 0
    n = len(intervals)
    
    # Add all intervals ending before new_interval starts
    while i < n and intervals[i][1] < new_interval[0]:
        result.append(intervals[i])
        i += 1
    
    # Merge all overlapping intervals
    merged = new_interval
    while i < n and intervals[i][0] <= merged[1]:
        merged[0] = min(merged[0], intervals[i][0])
        merged[1] = max(merged[1], intervals[i][1])
        i += 1
    
    result.append(merged)
    
    # Add remaining intervals
    while i < n:
        result.append(intervals[i])
        i += 1
    
    return result
```

**Nuances:**
- Sort by **start time** for merging, but sometimes sort by **end time** for greedy selection
- For **non-overlapping intervals**, sort by end time and count

---

## **3. Union-Find / Disjoint Set Union (DSU)** ⭐⭐⭐

**Use when:** Connectivity, cycles in graphs, dynamic connectivity, Kruskal's algorithm.

```python
class UnionFind:
    def __init__(self, n):
        self.parent = list(range(n))
        self.rank = [0] * n  # For union by rank
        self.size = [1] * n  # Alternative: union by size
    
    def find(self, x):
        """Find with path compression"""
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])  # Path compression
        return self.parent[x]
    
    def union(self, x, y):
        """Union by rank"""
        root_x = self.find(x)
        root_y = self.find(y)
        
        if root_x == root_y:
            return False  # Already connected
        
        # Union by rank (keep tree shallow)
        if self.rank[root_x] < self.rank[root_y]:
            self.parent[root_x] = root_y
        elif self.rank[root_x] > self.rank[root_y]:
            self.parent[root_y] = root_x
        else:
            self.parent[root_y] = root_x
            self.rank[root_x] += 1
        
        return True
    
    def connected(self, x, y):
        return self.find(x) == self.find(y)

# Common pattern: Count connected components
def count_components(n, edges):
    uf = UnionFind(n)
    for u, v in edges:
        uf.union(u, v)
    
    # Count unique parents
    return len({uf.find(i) for i in range(n)})
```

**Optimization:** Always use **path compression** + **union by rank/size** for near-O(1) operations.

---

## **4. Trie (Prefix Tree) Pattern** ⭐⭐

**Use when:** Word searches, prefix matching, autocomplete, word games.

```python
class TrieNode:
    def __init__(self):
        self.children = {}  # char -> TrieNode
        self.is_end = False
        self.count = 0  # Optional: track word frequency

class Trie:
    def __init__(self):
        self.root = TrieNode()
    
    def insert(self, word):
        node = self.root
        for char in word:
            if char not in node.children:
                node.children[char] = TrieNode()
            node = node.children[char]
            node.count += 1  # Optional: prefix count
        node.is_end = True
    
    def search(self, word):
        node = self._find_node(word)
        return node is not None and node.is_end
    
    def starts_with(self, prefix):
        return self._find_node(prefix) is not None
    
    def _find_node(self, prefix):
        node = self.root
        for char in prefix:
            if char not in node.children:
                return None
            node = node.children[char]
        return node
    
    def delete(self, word):
        """DFS deletion with pruning"""
        def _delete(node, word, i):
            if i == len(word):
                if not node.is_end:
                    return False  # Word not found
                node.is_end = False
                return len(node.children) == 0
            
            char = word[i]
            if char not in node.children:
                return False
            
            should_delete_child = _delete(node.children[char], word, i + 1)
            
            if should_delete_child:
                del node.children[char]
                return len(node.children) == 0 and not node.is_end
            
            return False
        
        _delete(self.root, word, 0)

# Word search in grid pattern
def find_words(board, words):
    trie = Trie()
    for word in words:
        trie.insert(word)
    
    result = set()
    rows, cols = len(board), len(board[0])
    visited = set()
    
    def dfs(r, c, node, path):
        if node.is_end:
            result.add(path)
        
        if (r < 0 or r >= rows or c < 0 or c >= cols or 
            (r, c) in visited or board[r][c] not in node.children):
            return
        
        visited.add((r, c))
        dfs(r+1, c, node.children[board[r][c]], path + board[r][c])
        dfs(r-1, c, node.children[board[r][c]], path + board[r][c])
        dfs(r, c+1, node.children[board[r][c]], path + board[r][c])
        dfs(r, c-1, node.children[board[r][c]], path + board[r][c])
        visited.remove((r, c))
    
    for r in range(rows):
        for c in range(cols):
            if board[r][c] in trie.root.children:
                dfs(r, c, trie.root.children[board[r][c]], board[r][c])
    
    return list(result)
```

---

## **5. Sliding Window Pattern (Detailed)** ⭐⭐⭐⭐

**Use when:** Subarray/substring problems with contiguous elements.

```python
# Template 1: Fixed-size window
def fixed_sliding_window(arr, k):
    """Returns list of window sums"""
    if not arr: return []
    result = []
    window_sum = sum(arr[:k])
    result.append(window_sum)
    
    for i in range(k, len(arr)):
        window_sum = window_sum - arr[i-k] + arr[i]
        result.append(window_sum)
    
    return result

# Template 2: Variable-size window (min/max subarray)
def min_subarray_length(nums, target):
    """Find minimum length subarray with sum >= target"""
    left = 0
    curr_sum = 0
    min_len = float('inf')
    
    for right in range(len(nums)):
        curr_sum += nums[right]
        
        while curr_sum >= target:
            min_len = min(min_len, right - left + 1)
            curr_sum -= nums[left]
            left += 1
    
    return 0 if min_len == float('inf') else min_len

# Template 3: Window with frequency map
def longest_substring_with_k_distinct(s, k):
    """Longest substring with at most K distinct characters"""
    char_count = defaultdict(int)
    left = 0
    max_len = 0
    
    for right in range(len(s)):
        char_count[s[right]] += 1
        
        while len(char_count) > k:
            char_count[s[left]] -= 1
            if char_count[s[left]] == 0:
                del char_count[s[left]]
            left += 1
        
        max_len = max(max_len, right - left + 1)
    
    return max_len
```

**Python nuance:** Use `defaultdict(int)` for frequency counts, but remember to `del` keys when count reaches 0 to keep `len()` accurate.

---

## **6. Topological Sort Pattern** ⭐⭐

**Use when:** Course scheduling, task ordering, dependency resolution.

```python
def topological_sort(num_courses, prerequisites):
    """Returns order of courses, or empty if cycle exists"""
    # Build graph and indegree map
    graph = defaultdict(list)
    indegree = [0] * num_courses
    
    for dest, src in prerequisites:
        graph[src].append(dest)
        indegree[dest] += 1
    
    # Queue for nodes with 0 indegree
    queue = deque([i for i in range(num_courses) if indegree[i] == 0])
    topo_order = []
    
    while queue:
        course = queue.popleft()
        topo_order.append(course)
        
        for neighbor in graph[course]:
            indegree[neighbor] -= 1
            if indegree[neighbor] == 0:
                queue.append(neighbor)
    
    # Check if all courses can be taken (no cycle)
    return topo_order if len(topo_order) == num_courses else []

# Variant: Check if cycle exists
def has_cycle(num_courses, prerequisites):
    # Same setup as above
    # ...
    return len(topo_order) != num_courses
```

---

## **7. Matrix DFS/BFS Patterns** ⭐⭐⭐

**Use when:** Grid navigation, islands, path finding, water flow.

```python
# DFS template (recursive)
def grid_dfs(grid):
    if not grid: return 0
    rows, cols = len(grid), len(grid[0])
    visited = set()
    
    def dfs(r, c):
        # Base cases
        if (r < 0 or r >= rows or c < 0 or c >= cols or 
            (r, c) in visited or grid[r][c] == 0):
            return 0
        
        visited.add((r, c))
        
        # Process current cell
        count = 1
        
        # Explore 4 directions
        count += dfs(r+1, c)
        count += dfs(r-1, c)
        count += dfs(r, c+1)
        count += dfs(r, c-1)
        
        return count
    
    result = 0
    for r in range(rows):
        for c in range(cols):
            if grid[r][c] == 1 and (r, c) not in visited:
                result = max(result, dfs(r, c))
    
    return result

# BFS template (iterative)
def grid_bfs(grid, start):
    rows, cols = len(grid), len(grid[0])
    queue = deque([start])
    visited = {start}
    directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]
    
    while queue:
        r, c = queue.popleft()
        
        for dr, dc in directions:
            nr, nc = r + dr, c + dc
            
            if (0 <= nr < rows and 0 <= nc < cols and 
                (nr, nc) not in visited and grid[nr][nc] == 1):
                visited.add((nr, nc))
                queue.append((nr, nc))

# Matrix copy pattern (avoid modifying original)
grid_copy = [row[:] for row in grid]  # Deep copy each row
```

**Python nuance:** Use `directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]` for cleaner code. For 8-direction, add diagonals.

---

## **8. Backtracking Pattern (Enhanced)** ⭐⭐⭐

**Use when:** Permutations, combinations, subsets, path finding, constraint satisfaction.

```python
def backtrack_template(candidates, target):
    """
    Universal backtracking template with pruning
    """
    result = []
    path = []
    
    # Sort for pruning (if applicable)
    candidates.sort()
    
    def backtrack(start, current_sum):
        # Base case: found valid solution
        if current_sum == target:
            result.append(path.copy())
            return
        
        # Base case: exceed target (pruning)
        if current_sum > target:
            return
        
        for i in range(start, len(candidates)):
            # Skip duplicates (if candidates sorted)
            if i > start and candidates[i] == candidates[i-1]:
                continue
            
            # Pruning: if current_sum + candidates[i] > target, break
            if current_sum + candidates[i] > target:
                break
            
            # Make choice
            path.append(candidates[i])
            current_sum += candidates[i]
            
            # Recurse (allow reuse: i, no reuse: i+1)
            backtrack(i, current_sum)  # i for reuse, i+1 for no reuse
            
            # Undo choice
            path.pop()
            current_sum -= candidates[i]
    
    backtrack(0, 0)
    return result

# Permutation template (no duplicates)
def permute(nums):
    result = []
    path = []
    used = set()
    
    def backtrack():
        if len(path) == len(nums):
            result.append(path.copy())
            return
        
        for i, num in enumerate(nums):
            if i in used:
                continue
            
            used.add(i)
            path.append(num)
            backtrack()
            path.pop()
            used.remove(i)
    
    backtrack()
    return result
```

**Python nuance:** Use `path.copy()` or `list(path)` to avoid reference issues. For strings, use `''.join(path)`.

---

## **9. Advanced DP Patterns** ⭐⭐⭐

```python
# Pattern 1: DP with bitmask (state compression)
def dp_with_bitmask(n, nums):
    """Example: Travelling salesman problem"""
    dp = [[float('inf')] * n for _ in range(1 << n)]
    
    for i in range(n):
        dp[1 << i][i] = nums[i]
    
    for mask in range(1 << n):
        for u in range(n):
            if not (mask & (1 << u)):
                continue
            
            for v in range(n):
                if mask & (1 << v):
                    continue
                
                new_mask = mask | (1 << v)
                dp[new_mask][v] = min(dp[new_mask][v], 
                                     dp[mask][u] + cost(u, v))

# Pattern 2: DP on strings (edit distance variant)
def longest_common_subsequence(text1, text2):
    m, n = len(text1), len(text2)
    dp = [[0] * (n + 1) for _ in range(m + 1)]
    
    for i in range(1, m + 1):
        for j in range(1, n + 1):
            if text1[i-1] == text2[j-1]:
                dp[i][j] = dp[i-1][j-1] + 1
            else:
                dp[i][j] = max(dp[i-1][j], dp[i][j-1])
    
    return dp[m][n]

# Space optimization: Use 1D DP when only previous row needed
def lcs_optimized(text1, text2):
    m, n = len(text1), len(text2)
    dp = [0] * (n + 1)
    
    for i in range(1, m + 1):
        prev_row = dp[:]  # Copy current state as "previous row"
        for j in range(1, n + 1):
            if text1[i-1] == text2[j-1]:
                dp[j] = prev_row[j-1] + 1
            else:
                dp[j] = max(dp[j-1], prev_row[j])
    
    return dp[n]
```

---

## **10. Segment Tree / Fenwick Tree (BIT) Basics** ⭐

**Use when:** Range sum queries with updates, range minimum queries.

```python
# Fenwick Tree (Binary Indexed Tree) - simpler and often sufficient
class FenwickTree:
    def __init__(self, n):
        self.n = n
        self.tree = [0] * (n + 1)
    
    def update(self, index, delta):
        """Add delta to element at index (0-based)"""
        i = index + 1
        while i <= self.n:
            self.tree[i] += delta
            i += i & -i  # Move to next index
    
    def query(self, index):
        """Sum from 0 to index (inclusive, 0-based)"""
        i = index + 1
        total = 0
        while i > 0:
            total += self.tree[i]
            i -= i & -i  # Move to parent
        return total
    
    def range_query(self, left, right):
        """Sum from left to right (inclusive)"""
        return self.query(right) - self.query(left - 1)

# Usage for range sum queries
nums = [1, 3, 5, 2, 6, 4]
ft = FenwickTree(len(nums))
for i, num in enumerate(nums):
    ft.update(i, num)

print(ft.range_query(1, 3))  # Sum of elements 3+5+2 = 10
```

---

## **11. String Pattern Matching** ⭐⭐

```python
# KMP (Knuth-Morris-Pratt) - Avoid TLE in string search
def kmp_search(text, pattern):
    """Return first index of pattern in text, or -1"""
    if not pattern: return 0
    
    # Build prefix table (longest prefix suffix)
    prefix = [0] * len(pattern)
    j = 0
    for i in range(1, len(pattern)):
        while j > 0 and pattern[i] != pattern[j]:
            j = prefix[j-1]
        if pattern[i] == pattern[j]:
            j += 1
            prefix[i] = j
    
    # Search
    j = 0
    for i in range(len(text)):
        while j > 0 and text[i] != pattern[j]:
            j = prefix[j-1]
        if text[i] == pattern[j]:
            j += 1
            if j == len(pattern):
                return i - j + 1
    
    return -1

# Rabin-Karp (rolling hash) - for multiple pattern searches
def rabin_karp(text, pattern):
    if not pattern: return 0
    
    base = 256
    mod = 101  # Small prime
    
    pattern_hash = 0
    window_hash = 0
    h = pow(base, len(pattern) - 1, mod)
    
    for i in range(len(pattern)):
        pattern_hash = (base * pattern_hash + ord(pattern[i])) % mod
        window_hash = (base * window_hash + ord(text[i])) % mod
    
    for i in range(len(text) - len(pattern) + 1):
        if pattern_hash == window_hash:
            if pattern == text[i:i+len(pattern)]:
                return i
        
        if i < len(text) - len(pattern):
            window_hash = (base * (window_hash - ord(text[i]) * h) + 
                          ord(text[i + len(pattern)])) % mod
            if window_hash < 0:
                window_hash += mod
    
    return -1
```

---

## **12. Critical Python Nuances & Hidden Tricks**

### **A. Memory & Performance Optimizations**

```python
# 1. List multiplication trap
bad = [[0]*3]*3  # Creates 3 references to same list!
good = [[0]*3 for _ in range(3)]  # Creates 3 separate lists

# 2. Use array module for large numeric arrays (memory efficient)
from array import array
arr = array('i', [0]*1000000)  # Type-signed integers, 4 bytes each

# 3. Local variable binding is faster
# Instead of:
for i in range(len(nums)): self.process(nums[i])
# Use:
process = self.process
local_nums = nums
for i in range(len(local_nums)): process(local_nums[i])

# 4. Use map() for simple transformations (slightly faster)
# Instead of: [int(x) for x in strs]
# Use: list(map(int, strs))
```

### **B. Edge Case Handling**

```python
# 1. Empty input guards (place at function top)
if not nums: return 0
if len(nums) == 1: return nums[0]

# 2. Single node tree check
if not root: return None
if not root.left and not root.right: return root

# 3. Integer overflow prevention (Python handles big ints, but for logic)
# Use: if x > 2**31 - 1: return 0  (for problems requiring it)

# 4. Negative modulo behavior
# In Python: -5 % 3 = 1 (not -2)
# For cyclic arrays: (i - k) % n works correctly in Python!
```

### **C. Quick Mathematical Formulas**

```python
# 1. Sum of arithmetic series
sum_1_to_n = n * (n + 1) // 2

# 2. Check if power of 2
is_power_of_2 = n > 0 and (n & (n - 1)) == 0

# 3. Swap without temp
a, b = b, a

# 4. Find missing number using XOR
def find_missing(nums):
    # For 0 to n, one number missing
    missing = 0
    for i in range(len(nums) + 1):
        missing ^= i
    for num in nums:
        missing ^= num
    return missing

# 5. Count set bits
def count_set_bits(n):
    count = 0
    while n:
        n &= n - 1  # Clear least significant set bit
        count += 1
    return count
```

### **D. Input/Output Handling (for LeetCode-style)**

```python
# 1. Convert string to 2D int matrix
matrix = [[int(x) for x in row.split(',')] for row in s.split(';')]

# 2. Parse tree from list representation (LeetCode style)
# Input: [1,2,3,null,5]
def list_to_tree(lst):
    if not lst: return None
    root = TreeNode(lst[0])
    queue = deque([root])
    i = 1
    
    while queue and i < len(lst):
        node = queue.popleft()
        
        if i < len(lst) and lst[i] is not None:
            node.left = TreeNode(lst[i])
            queue.append(node.left)
        i += 1
        
        if i < len(lst) and lst[i] is not None:
            node.right = TreeNode(lst[i])
            queue.append(node.right)
        i += 1
    
    return root

# 3. Build graph from edges
def build_graph(n, edges, directed=False):
    graph = defaultdict(list)
    for u, v in edges:
        graph[u].append(v)
        if not directed:
            graph[v].append(u)
    return graph
```

### **E. Debugging Template for Complex Problems**

```python
class DebugSolver:
    def __init__(self, debug=False):
        self.debug = debug
    
    def log(self, *args):
        if self.debug:
            print(f"DEBUG: {' '.join(map(str, args))}")
    
    def solve(self, ...):
        self.log("Starting with", ...)
        # Your logic here
        self.log("Result:", result)
        return result

# Usage: solver = DebugSolver(debug=True); solver.solve(...)
```

---

## **13. Ultimate Code Template Checklist**

Before submitting, verify:

- [ ] **Input validation:** `if not input: return ...`
- [ ] **Type hints:** Added for clarity (optional but good)
- [ ] **Variable names:** Clear and Pythonic (`snake_case`)
- [ ] **Imports:** All required modules imported at top
- [ ] **Edge cases:** Single element, empty, all same values
- [ ] **Mutability:** No accidental list/dict modifications
- [ ] **Performance:** No O(n) operations in nested loops
- [ ] **Memory:** Using generators where possible for large data
- [ ] **Recursion limit:** `sys.setrecursionlimit(10**6)` for deep recursion
- [ ] **Modulo operations:** Applied if problem requires modulo

```python
# Final template structure
import sys
from typing import List
from collections import defaultdict, deque, Counter
import heapq

class Solution:
    def __init__(self):
        sys.setrecursionlimit(10**6)  # For deep recursion
    
    def solveProblem(self, inputs: List[int]) -> int:
        # Validate
        if not inputs:
            return 0
        
        # Initialize
        n = len(inputs)
        result = 0
        
        # Main logic
        # ...
        
        return result
```

---

## **14. Pattern Frequency in Interviews**

Based on LeetCode analysis :

| Pattern | Frequency | Difficulty | Key Problems |
|---------|-----------|------------|--------------|
| **Sliding Window** | ⭐⭐⭐⭐⭐ | Easy-Med | 3, 76, 424 |
| **Two Pointers** | ⭐⭐⭐⭐⭐ | Easy-Med | 11, 15, 125 |
| **Binary Search** | ⭐⭐⭐⭐⭐ | Easy-Hard | 33, 34, 153 |
| **DFS/BFS** | ⭐⭐⭐⭐⭐ | Med-Hard | 102, 104, 207 |
| **DP** | ⭐⭐⭐⭐⭐ | Med-Hard | 70, 300, 322 |
| **Monotonic Stack** | ⭐⭐⭐ | Med | 84, 496, 739 |
| **Union-Find** | ⭐⭐⭐ | Med | 547, 684, 200 |
| **Trie** | ⭐⭐ | Med-Hard | 79, 208, 212 |
| **Bit Manipulation** | ⭐⭐ | Easy-Med | 191, 268, 338 |
| **Intervals** | ⭐⭐⭐ | Med | 56, 57, 435 |

---

**Sources:** 

For interactive practice with these patterns: https://neetcode.io/ and https://algo.monster/