# 6_glm_dsa



# Python DSA Cheatsheet for LeetCode

## Table of Contents
1. [Basic Python Features](#basic-python-features)
2. [Data Structures](#data-structures)
3. [Algorithm Patterns](#algorithm-patterns)
4. [Python Tricks for DSA](#python-tricks-for-dsa)
5. [Common LeetCode Patterns](#common-leetcode-patterns)

## Basic Python Features

### List Comprehensions
```python
# Create a list of squares
squares = [x**2 for x in range(10)]

# Conditional list comprehension
even_squares = [x**2 for x in range(10) if x % 2 == 0]
```

### Dictionary Comprehensions
```python
# Create a dictionary from two lists
keys = ['a', 'b', 'c']
values = [1, 2, 3]
my_dict = {k: v for k, v in zip(keys, values)}

# Conditional dictionary comprehension
filtered_dict = {k: v for k, v in my_dict.items() if v > 1}
```

### Set Operations
```python
set1 = {1, 2, 3}
set2 = {3, 4, 5}

# Union
union_set = set1 | set2  # or set1.union(set2)

# Intersection
intersection_set = set1 & set2  # or set1.intersection(set2)

# Difference
difference_set = set1 - set2  # or set1.difference(set2)

# Symmetric difference
sym_diff = set1 ^ set2  # or set1.symmetric_difference(set2)
```

### Enumerate
```python
# Iterate with index
for idx, value in enumerate(['a', 'b', 'c']):
    print(idx, value)

# Start from 1 instead of 0
for idx, value in enumerate(['a', 'b', 'c'], start=1):
    print(idx, value)
```

### Zip
```python
# Iterate over multiple lists
names = ['Alice', 'Bob', 'Charlie']
ages = [25, 30, 35]
for name, age in zip(names, ages):
    print(f"{name} is {age} years old")

# Create a dictionary from two lists
my_dict = dict(zip(names, ages))
```

## Data Structures

### Stack
```python
# Using list as a stack
stack = []
stack.append(1)  # push
stack.append(2)
top = stack[-1]  # peek
stack.pop()      # pop

# Using collections.deque (more efficient)
from collections import deque
stack = deque()
stack.append(1)  # push
stack.append(2)
top = stack[-1]  # peek
stack.pop()      # pop
```

### Queue
```python
from collections import deque

queue = deque()
queue.append(1)  # enqueue
queue.append(2)
front = queue[0]  # peek
queue.popleft()   # dequeue
```

### Priority Queue (Min-Heap)
```python
import heapq

# Create a min-heap
heap = [3, 1, 4, 1, 5, 9]
heapq.heapify(heap)

# Push element
heapq.heappush(heap, 2)

# Pop smallest element
smallest = heapq.heappop(heap)

# Get n smallest elements
n_smallest = heapq.nsmallest(3, heap)

# Max-heap (using negative values)
max_heap = [-x for x in heap]
heapq.heapify(max_heap)
largest = -heapq.heappop(max_heap)
```

### Trie
```python
class TrieNode:
    def __init__(self):
        self.children = {}
        self.is_end = False

class Trie:
    def __init__(self):
        self.root = TrieNode()
    
    def insert(self, word):
        node = self.root
        for char in word:
            if char not in node.children:
                node.children[char] = TrieNode()
            node = node.children[char]
        node.is_end = True
    
    def search(self, word):
        node = self.root
        for char in word:
            if char not in node.children:
                return False
            node = node.children[char]
        return node.is_end
    
    def startsWith(self, prefix):
        node = self.root
        for char in prefix:
            if char not in node.children:
                return False
            node = node.children[char]
        return True
```

### Disjoint Set Union (Union-Find)
```python
class DSU:
    def __init__(self, n):
        self.parent = list(range(n))
        self.rank = [0] * n
    
    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])  # Path compression
        return self.parent[x]
    
    def union(self, x, y):
        x_root, y_root = self.find(x), self.find(y)
        if x_root == y_root:
            return False  # Already in the same set
        
        # Union by rank
        if self.rank[x_root] < self.rank[y_root]:
            self.parent[x_root] = y_root
        elif self.rank[x_root] > self.rank[y_root]:
            self.parent[y_root] = x_root
        else:
            self.parent[y_root] = x_root
            self.rank[x_root] += 1
        return True
```

## Algorithm Patterns

### Binary Search
```python
def binary_search(arr, target):
    left, right = 0, len(arr) - 1
    while left <= right:
        mid = left + (right - left) // 2
        if arr[mid] == target:
            return mid
        elif arr[mid] < target:
            left = mid + 1
        else:
            right = mid - 1
    return -1  # Not found

# Binary search on answer
def binary_search_on_answer():
    # Example: Find the smallest x such that condition(x) is True
    left, right = 0, 10**9  # Adjust range based on problem
    while left < right:
        mid = left + (right - left) // 2
        if condition(mid):  # Replace with actual condition
            right = mid
        else:
            left = mid + 1
    return left
```

### Sliding Window
```python
def sliding_window(arr, k):
    # Example: Find maximum sum of any subarray of size k
    if len(arr) < k:
        return 0
    
    window_sum = sum(arr[:k])
    max_sum = window_sum
    
    for i in range(k, len(arr)):
        window_sum += arr[i] - arr[i-k]
        max_sum = max(max_sum, window_sum)
    
    return max_sum

# Variable size sliding window
def variable_sliding_window(s):
    # Example: Find longest substring with all unique characters
    seen = {}
    left = 0
    max_len = 0
    
    for right, char in enumerate(s):
        if char in seen and seen[char] >= left:
            left = seen[char] + 1
        seen[char] = right
        max_len = max(max_len, right - left + 1)
    
    return max_len
```

### Two Pointers
```python
def two_pointers(arr):
    # Example: Find if there's a pair with sum equal to target
    arr.sort()  # If not already sorted
    left, right = 0, len(arr) - 1
    
    while left < right:
        current_sum = arr[left] + arr[right]
        if current_sum == target:
            return True
        elif current_sum < target:
            left += 1
        else:
            right -= 1
    
    return False
```

### BFS
```python
from collections import deque

def bfs(graph, start):
    visited = set()
    queue = deque([start])
    visited.add(start)
    result = []
    
    while queue:
        node = queue.popleft()
        result.append(node)
        
        for neighbor in graph[node]:
            if neighbor not in visited:
                visited.add(neighbor)
                queue.append(neighbor)
    
    return result
```

### DFS
```python
def dfs(graph, start, visited=None):
    if visited is None:
        visited = set()
    
    visited.add(start)
    result = [start]
    
    for neighbor in graph[start]:
        if neighbor not in visited:
            result.extend(dfs(graph, neighbor, visited))
    
    return result

# Iterative DFS
def iterative_dfs(graph, start):
    visited = set()
    stack = [start]
    result = []
    
    while stack:
        node = stack.pop()
        if node not in visited:
            visited.add(node)
            result.append(node)
            
            # Add neighbors in reverse order to process them in order
            for neighbor in reversed(graph[node]):
                if neighbor not in visited:
                    stack.append(neighbor)
    
    return result
```

### Dynamic Programming
```python
# Memoization (Top-Down)
def memoization_example(n, memo=None):
    if memo is None:
        memo = {}
    
    if n in memo:
        return memo[n]
    
    if n <= 1:
        return n
    
    memo[n] = memoization_example(n-1, memo) + memoization_example(n-2, memo)
    return memo[n]

# Tabulation (Bottom-Up)
def tabulation_example(n):
    if n <= 1:
        return n
    
    dp = [0] * (n + 1)
    dp[0], dp[1] = 0, 1
    
    for i in range(2, n + 1):
        dp[i] = dp[i-1] + dp[i-2]
    
    return dp[n]

# Space-optimized DP
def space_optimized_dp(n):
    if n <= 1:
        return n
    
    prev, curr = 0, 1
    
    for _ in range(2, n + 1):
        prev, curr = curr, prev + curr
    
    return curr
```

## Python Tricks for DSA

### Using Counter
```python
from collections import Counter

# Count occurrences
counts = Counter(['a', 'b', 'a', 'c', 'b', 'a'])

# Most common elements
most_common = counts.most_common(2)  # Returns [('a', 3), ('b', 2)]

# Check if two strings are anagrams
def is_anagram(s1, s2):
    return Counter(s1) == Counter(s2)
```

### Using Defaultdict
```python
from collections import defaultdict

# Default value for new keys
d = defaultdict(int)
d['a'] += 1  # Works without initializing

# Using list as default value
d = defaultdict(list)
d['a'].append(1)  # Works without initializing

# Using set as default value
d = defaultdict(set)
d['a'].add(1)  # Works without initializing
```

### Using itertools
```python
import itertools

# Permutations
perms = itertools.permutations([1, 2, 3])

# Combinations
combs = itertools.combinations([1, 2, 3], 2)

# Product (Cartesian product)
prod = itertools.product([1, 2], [3, 4])

# Accumulate
acc = itertools.accumulate([1, 2, 3, 4])  # Returns [1, 3, 6, 10]

# Groupby
data = sorted([('a', 1), ('b', 2), ('a', 3), ('b', 4)])
for key, group in itertools.groupby(data, lambda x: x[0]):
    print(key, list(group))
```

### Using functools
```python
from functools import lru_cache, reduce

# Memoization with lru_cache
@lru_cache(maxsize=None)
def fib(n):
    if n < 2:
        return n
    return fib(n-1) + fib(n-2)

# Reduce
product = reduce(lambda x, y: x * y, [1, 2, 3, 4])  # Returns 24
```

### Bit Manipulation Tricks
```python
# Check if a number is even
is_even = lambda x: x & 1 == 0

# Check if a number is a power of 2
is_power_of_2 = lambda x: x > 0 and (x & (x - 1)) == 0

# Get the least significant bit
lsb = lambda x: x & -x

# Count set bits (Brian Kernighan's algorithm)
def count_set_bits(n):
    count = 0
    while n:
        n &= n - 1
        count += 1
    return count

# Swap without temporary variable
a, b = b, a

# XOR swap (not recommended in Python due to tuple unpacking)
a ^= b
b ^= a
a ^= b
```

### String Manipulation
```python
# Check if a string is a palindrome
is_palindrome = lambda s: s == s[::-1]

# Check if a string is a palindrome (ignoring case and non-alphanumeric)
import re
def is_clean_palindrome(s):
    cleaned = re.sub(r'[^a-zA-Z0-9]', '', s).lower()
    return cleaned == cleaned[::-1]

# Split string into words
words = s.split()

# Join list of strings
result = ' '.join(words)

# String formatting
name = "Alice"
age = 25
formatted = f"{name} is {age} years old"  # f-string (Python 3.6+)
```

### Math Operations
```python
import math

# GCD
gcd = math.gcd(a, b)

# LCM
lcm = a * b // math.gcd(a, b)

# Check if a number is prime
def is_prime(n):
    if n <= 1:
        return False
    if n <= 3:
        return True
    if n % 2 == 0 or n % 3 == 0:
        return False
    i = 5
    while i * i <= n:
        if n % i == 0 or n % (i + 2) == 0:
            return False
        i += 6
    return True

# Generate prime numbers up to n (Sieve of Eratosthenes)
def sieve_of_eratosthenes(n):
    is_prime = [True] * (n + 1)
    is_prime[0] = is_prime[1] = False
    
    for i in range(2, int(n ** 0.5) + 1):
        if is_prime[i]:
            for j in range(i * i, n + 1, i):
                is_prime[j] = False
    
    return [i for i, prime in enumerate(is_prime) if prime]
```

## Common LeetCode Patterns

### Fast and Slow Pointers (Linked List Cycle Detection)
```python
def has_cycle(head):
    if not head or not head.next:
        return False
    
    slow = fast = head
    
    while fast and fast.next:
        slow = slow.next
        fast = fast.next.next
        
        if slow == fast:
            return True
    
    return False
```

### Merge Intervals
```python
def merge_intervals(intervals):
    if not intervals:
        return []
    
    # Sort intervals by start time
    intervals.sort(key=lambda x: x[0])
    
    merged = [intervals[0]]
    
    for current in intervals[1:]:
        last = merged[-1]
        
        # If overlapping
        if current[0] <= last[1]:
            # Merge the intervals
            merged[-1] = [last[0], max(last[1], current[1])]
        else:
            merged.append(current)
    
    return merged
```

### Subarray Sum Equals K
```python
def subarray_sum(nums, k):
    count = 0
    current_sum = 0
    prefix_sums = {0: 1}  # Initialize with sum 0 occurring once
    
    for num in nums:
        current_sum += num
        
        # If (current_sum - k) exists in prefix_sums, it means there's a subarray
        if (current_sum - k) in prefix_sums:
            count += prefix_sums[current_sum - k]
        
        # Update prefix_sums with current_sum
        prefix_sums[current_sum] = prefix_sums.get(current_sum, 0) + 1
    
    return count
```

### Topological Sort (Kahn's Algorithm)
```python
from collections import deque

def topological_sort(num_courses, prerequisites):
    # Build graph and in-degree count
    graph = [[] for _ in range(num_courses)]
    in_degree = [0] * num_courses
    
    for course, prereq in prerequisites:
        graph[prereq].append(course)
        in_degree[course] += 1
    
    # Initialize queue with courses having no prerequisites
    queue = deque([i for i in range(num_courses) if in_degree[i] == 0])
    result = []
    
    while queue:
        course = queue.popleft()
        result.append(course)
        
        for neighbor in graph[course]:
            in_degree[neighbor] -= 1
            if in_degree[neighbor] == 0:
                queue.append(neighbor)
    
    return result if len(result) == num_courses else []  # Return empty if cycle exists
```

### Dijkstra's Algorithm
```python
import heapq

def dijkstra(graph, start):
    n = len(graph)
    distances = [float('inf')] * n
    distances[start] = 0
    
    # Priority queue: (distance, node)
    pq = [(0, start)]
    
    while pq:
        current_dist, node = heapq.heappop(pq)
        
        # Skip if we've already found a shorter path
        if current_dist > distances[node]:
            continue
        
        for neighbor, weight in graph[node]:
            distance = current_dist + weight
            
            if distance < distances[neighbor]:
                distances[neighbor] = distance
                heapq.heappush(pq, (distance, neighbor))
    
    return distances
```

### Floyd-Warshall Algorithm
```python
def floyd_warshall(graph):
    n = len(graph)
    # Initialize distance matrix
    dist = [[float('inf')] * n for _ in range(n)]
    
    # Set distance from node to itself as 0
    for i in range(n):
        dist[i][i] = 0
    
    # Set initial distances from graph
    for i in range(n):
        for j, weight in graph[i]:
            dist[i][j] = weight
    
    # Main algorithm
    for k in range(n):
        for i in range(n):
            for j in range(n):
                if dist[i][k] + dist[k][j] < dist[i][j]:
                    dist[i][j] = dist[i][k] + dist[k][j]
    
    return dist
```

### KMP Algorithm (Pattern Matching)
```python
def kmp_search(text, pattern):
    # Build LPS (Longest Prefix Suffix) array
    def build_lps(pattern):
        lps = [0] * len(pattern)
        length = 0  # Length of the previous longest prefix suffix
        
        i = 1
        while i < len(pattern):
            if pattern[i] == pattern[length]:
                length += 1
                lps[i] = length
                i += 1
            else:
                if length != 0:
                    length = lps[length - 1]
                else:
                    lps[i] = 0
                    i += 1
        return lps
    
    lps = build_lps(pattern)
    i = j = 0  # i for text, j for pattern
    matches = []
    
    while i < len(text):
        if pattern[j] == text[i]:
            i += 1
            j += 1
            
            if j == len(pattern):
                matches.append(i - j)
                j = lps[j - 1]
        else:
            if j != 0:
                j = lps[j - 1]
            else:
                i += 1
    
    return matches
```

### Rabin-Karp Algorithm (Pattern Matching)
```python
def rabin_karp(text, pattern):
    n, m = len(text), len(pattern)
    if m > n:
        return []
    
    # Choose a prime number for modulo
    prime = 101
    # Choose a base for hashing (typically number of characters in alphabet)
    base = 256
    
    # Calculate hash for pattern and first window of text
    pattern_hash = 0
    window_hash = 0
    h = 1  # The value of base^(m-1) % prime
    
    for i in range(m - 1):
        h = (h * base) % prime
    
    for i in range(m):
        pattern_hash = (base * pattern_hash + ord(pattern[i])) % prime
        window_hash = (base * window_hash + ord(text[i])) % prime
    
    matches = []
    
    # Slide the pattern over text one by one
    for i in range(n - m + 1):
        # Check if hash values match
        if pattern_hash == window_hash:
            # If hash values match, check characters one by one
            if text[i:i+m] == pattern:
                matches.append(i)
        
        # Calculate hash for next window
        if i < n - m:
            window_hash = (base * (window_hash - ord(text[i]) * h) + ord(text[i+m])) % prime
            
            # Make sure window_hash is positive
            if window_hash < 0:
                window_hash += prime
    
    return matches
```

### Trie for Word Search
```python
class TrieNode:
    def __init__(self):
        self.children = {}
        self.is_end = False

class Trie:
    def __init__(self):
        self.root = TrieNode()
    
    def insert(self, word):
        node = self.root
        for char in word:
            if char not in node.children:
                node.children[char] = TrieNode()
            node = node.children[char]
        node.is_end = True

def word_search(board, words):
    # Build trie from words
    trie = Trie()
    for word in words:
        trie.insert(word)
    
    rows, cols = len(board), len(board[0])
    result = set()
    
    def dfs(r, c, node, path):
        if r < 0 or r >= rows or c < 0 or c >= cols or board[r][c] not in node.children:
            return
        
        char = board[r][c]
        next_node = node.children[char]
        path += char
        
        if next_node.is_end:
            result.add(path)
        
        # Mark as visited
        board[r][c] = '#'
        
        # Explore neighbors
        dfs(r+1, c, next_node, path)
        dfs(r-1, c, next_node, path)
        dfs(r, c+1, next_node, path)
        dfs(r, c-1, next_node, path)
        
        # Restore
        board[r][c] = char
    
    for r in range(rows):
        for c in range(cols):
            dfs(r, c, trie.root, "")
    
    return list(result)
```

This cheatsheet covers essential Python features, data structures, algorithm patterns, and common LeetCode problem-solving techniques. Keep it handy as you practice DSA problems, and you'll find yourself becoming more efficient and effective at solving these challenges!