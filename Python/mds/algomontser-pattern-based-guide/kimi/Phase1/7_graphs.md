# 7_graphs

# **Pattern #7: Graph Representation**

## **Intuition & Recognition Cues**
Use graph representation when:
- You need to model **relationships between entities**.
- You need to perform **traversal or search** on interconnected data.
- You need to solve problems involving **networks, paths, or connections**.

**Recognize it in problems:**
- "Given a graph..."
- "Find the shortest path..."
- "Check if there is a path between..."
- "Find the connected components..."

---

## **Core Templates & Blueprints**

### **Template 1: Adjacency List Representation**
```python
from collections import defaultdict

def build_graph(edges):
    graph = defaultdict(list)
    for u, v in edges:
        graph[u].append(v)
        graph[v].append(u)  # For undirected graph
    return graph
```

### **Template 2: Adjacency Matrix Representation**
```python
def build_adj_matrix(n, edges):
    matrix = [[0] * n for _ in range(n)]
    for u, v in edges:
        matrix[u][v] = 1
        matrix[v][u] = 1  # For undirected graph
    return matrix
```

### **Template 3: BFS Traversal**
```python
from collections import deque

def bfs(graph, start):
    visited = set()
    queue = deque([start])
    while queue:
        node = queue.popleft()
        if node not in visited:
            visited.add(node)
            for neighbor in graph[node]:
                if neighbor not in visited:
                    queue.append(neighbor)
    return visited
```

### **Template 4: DFS Traversal**
```python
def dfs(graph, start, visited=None):
    if visited is None:
        visited = set()
    visited.add(start)
    for neighbor in graph[start]:
        if neighbor not in visited:
            dfs(graph, neighbor, visited)
    return visited
```

### **Template 5: Detect Cycle in Undirected Graph**
```python
def detect_cycle_undirected(graph):
    visited = set()
    for node in graph:
        if node not in visited:
            if dfs_cycle(graph, node, None, visited):
                return True
    return False

def dfs_cycle(graph, node, parent, visited):
    visited.add(node)
    for neighbor in graph[node]:
        if neighbor not in visited:
            if dfs_cycle(graph, neighbor, node, visited):
                return True
        elif neighbor != parent:
            return True
    return False
```

---

## **Key Variations**

| Pattern | When to Use | Example |
|---------|-------------|---------|
| **Graph Traversal** | When you need to visit all nodes in a graph | [100. Same Tree](https://leetcode.com/problems/same-tree/) |
| **Shortest Path** | When you need to find the shortest path in a graph | [743. Network Delay Time](https://leetcode.com/problems/network-delay-time/) |
| **Connected Components** | When you need to find connected components in a graph | [323. Number of Connected Components in an Undirected Graph](https://leetcode.com/problems/number-of-connected-components-in-an-undirected-graph/) |
| **Cycle Detection** | When you need to detect cycles in a graph | [207. Course Schedule](https://leetcode.com/problems/course-schedule/) |

---

## **Handpicked LeetCode Problems (Progressive)**

### **Level 1: Foundation (Do These First)**
1. **[200. Number of Islands](https://leetcode.com/problems/number-of-islands/)** - Basic graph traversal
2. **[130. Surrounded Regions](https://leetcode.com/problems/surrounded-regions/)** - BFS/DFS traversal

### **Level 2: Recognition**
3. **[261. Graph Valid Tree](https://leetcode.com/problems/graph-valid-tree/)** - Check if a graph is a valid tree
4. **[207. Course Schedule](https://leetcode.com/problems/course-schedule/)** - Detect cycle in directed graph

### **Level 3: Technique Application**
5. **[743. Network Delay Time](https://leetcode.com/problems/network-delay-time/)** - Shortest path using Dijkstra's algorithm
6. **[323. Number of Connected Components in an Undirected Graph](https://leetcode.com/problems/number-of-connected-components-in-an-undirected-graph/)** - Connected components

### **Level 4: Advanced Techniques**
7. **[785. Is Graph Bipartite?](https://leetcode.com/problems/is-graph-bipartite/)** - Check if a graph is bipartite
8. **[841. Keys and Rooms](https://leetcode.com/problems/keys-and-rooms/)** - DFS traversal with keys and locks

---

## **Common Pitfalls & Optimization Tricks**

### **Pitfalls:**
1. **Cycle detection:** Be cautious of cycles, especially in undirected graphs.
2. **Graph representation:** Choose the right representation (adjacency list vs. matrix) based on the problem.
3. **Edge cases:** Handle edge cases like empty graphs or single-node graphs carefully.
4. **Traversal errors:** Ensure you follow the correct traversal order (BFS vs. DFS).

### **Optimization Tricks:**
- **Adjacency list:** Use adjacency list for sparse graphs to save space.
- **Adjacency matrix:** Use adjacency matrix for dense graphs for faster lookups.
- **Cycle detection:** Use DFS with a visited set and parent tracking for cycle detection.
- **Shortest path:** Use Dijkstra's algorithm for shortest path problems.

---

**🎯 Action Plan:**
1. **Today:** Read templates, solve Level 1-2 (4 problems)
2. **Tomorrow:** Solve Level 3 (2 problems)
3. **Day 3:** Solve Level 4 (2 problems) + write notes on each pattern

**— Done with Graph Representation? Ready to move to Pattern #8 (Two Pointers)?**