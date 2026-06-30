# 7_new_advance_patterns

Perfect — below are **clean, repo-ready snippets** for **advanced string patterns**, exactly in the style you’ve been following:

* 📌 **Top docstring** → why / when / intuition / classics
* 📌 **Pure templates** → no noise
* 📌 **Interview-grade completeness**

---

## 📁 `patterns_advanced/string_matching.py`

```python
"""
String Matching Algorithms

WHY:
Efficient substring search beyond brute force O(n*m).

USE WHEN:
- Pattern search in large text
- Multiple matches needed
- Constraints demand linear time

INTUITION:
Preprocess pattern to avoid re-checking characters.

CLASSIC PROBLEMS:
- Find substring
- Repeated pattern matching
- DNA / log scanning
"""
```

### KMP (Prefix Function)

```python
def kmp_search(text, pattern):
    lps = build_lps(pattern)
    i = j = 0
    res = []

    while i < len(text):
        if text[i] == pattern[j]:
            i += 1
            j += 1
            if j == len(pattern):
                res.append(i - j)
                j = lps[j - 1]
        else:
            if j > 0:
                j = lps[j - 1]
            else:
                i += 1
    return res


def build_lps(pat):
    lps = [0] * len(pat)
    j = 0

    for i in range(1, len(pat)):
        while j > 0 and pat[i] != pat[j]:
            j = lps[j - 1]
        if pat[i] == pat[j]:
            j += 1
        lps[i] = j
    return lps
```

---

## 📁 `patterns_advanced/string_algos.py`

```python
"""
Core String Algorithms

WHY:
Advanced string problems rely on preprocessing tricks.

USE WHEN:
- Palindromes
- Prefix/suffix patterns
- Repetition detection

INTUITION:
Transform string → reuse info efficiently.

CLASSIC PROBLEMS:
- Longest palindrome
- Borders
- Repeated substrings
"""
```

### Z-Algorithm

```python
def z_function(s):
    z = [0] * len(s)
    l = r = 0

    for i in range(1, len(s)):
        if i <= r:
            z[i] = min(r - i + 1, z[i - l])
        while i + z[i] < len(s) and s[z[i]] == s[i + z[i]]:
            z[i] += 1
        if i + z[i] - 1 > r:
            l, r = i, i + z[i] - 1
    return z
```

### Manacher (Longest Palindromic Substring)

```python
def manacher(s):
    t = "#" + "#".join(s) + "#"
    n = len(t)
    p = [0] * n
    c = r = 0

    for i in range(n):
        mirror = 2 * c - i
        if i < r:
            p[i] = min(r - i, p[mirror])
        while 0 <= i - p[i] - 1 and i + p[i] + 1 < n and t[i - p[i] - 1] == t[i + p[i] + 1]:
            p[i] += 1
        if i + p[i] > r:
            c, r = i, i + p[i]
    return max(p)
```

---

## 📁 `patterns_advanced/trie_template.py`

```python
"""
Trie (Prefix Tree)

WHY:
Fast prefix-based queries.

USE WHEN:
- Prefix search
- Word dictionary
- Autocomplete

INTUITION:
Each node = one character, paths = words.

CLASSIC PROBLEMS:
- Implement Trie
- Word Search II
- Replace Words
"""
```

```python
class TrieNode:
    def __init__(self):
        self.children = {}
        self.end = False


class Trie:
    def __init__(self):
        self.root = TrieNode()

    def insert(self, word):
        cur = self.root
        for ch in word:
            if ch not in cur.children:
                cur.children[ch] = TrieNode()
            cur = cur.children[ch]
        cur.end = True

    def search(self, word):
        cur = self.root
        for ch in word:
            if ch not in cur.children:
                return False
            cur = cur.children[ch]
        return cur.end

    def starts_with(self, prefix):
        cur = self.root
        for ch in prefix:
            if ch not in cur.children:
                return False
            cur = cur.children[ch]
        return True
```

---

## 📁 `patterns_advanced/trie_advanced.py`

```python
"""
Advanced Trie Patterns

WHY:
Trie combined with DFS / DP unlocks hard problems.

USE WHEN:
- Multiple word search
- Board + dictionary
- Prefix pruning

INTUITION:
Trie prunes search space aggressively.

CLASSIC PROBLEMS:
- Word Search II
- Stream of Characters
"""
```

### Trie + DFS (Word Search II core idea)

```python
def dfs(board, i, j, node, path, res):
    if node.end:
        res.add(path)
        node.end = False

    if i < 0 or j < 0 or i >= len(board) or j >= len(board[0]):
        return

    ch = board[i][j]
    if ch not in node.children:
        return

    board[i][j] = "#"
    nxt = node.children[ch]

    for dx, dy in [(1,0),(-1,0),(0,1),(0,-1)]:
        dfs(board, i + dx, j + dy, nxt, path + ch, res)

    board[i][j] = ch
```

---

## ✅ Coverage Summary (Strings)

| Pattern       | Status |
| ------------- | ------ |
| KMP           | ✅      |
| Z Algorithm   | ✅      |
| Manacher      | ✅      |
| Trie (Basic)  | ✅      |
| Trie + DFS    | ✅      |
| Prefix tricks | ✅      |

This **fully completes advanced string patterns** for interviews.

---

### 🔜 Next (you choose)

* **Suffix Array / LCP**
* **Rolling Hash (Rabin–Karp)**
* **String DP (Edit Distance, LCS)**
* **Problem-patterns folder (e.g., “Largest Palindrome”, “Word Ladder”)**

Just name it.
