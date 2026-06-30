# 8_Trie

You’re right! Let’s cover **Trie** properly before moving on to Phase 2. Here’s the detailed breakdown for Trie:

# **Pattern #8: Trie**

## **Intuition & Recognition Cues**
Use Trie when:
- You need to **efficiently store and search for strings**.
- You need to **find prefixes** of strings.
- You need to **autocomplete or suggest words**.

**Recognize it in problems:**
- "Implement a trie..."
- "Find words with a given prefix..."
- "Autocomplete system..."

---

## **Core Templates & Blueprints**

### **Template 1: Basic Trie Node Definition**
```python
class TrieNode:
    def __init__(self):
        self.children = {}
        self.is_end_of_word = False
```

### **Template 2: Trie Insertion**
```python
class Trie:
    def __init__(self):
        self.root = TrieNode()

    def insert(self, word):
        node = self.root
        for char in word:
            if char not in node.children:
                node.children[char] = TrieNode()
            node = node.children[char]
        node.is_end_of_word = True
```

### **Template 3: Trie Search**
```python
    def search(self, word):
        node = self.root
        for char in word:
            if char not in node.children:
                return False
            node = node.children[char]
        return node.is_end_of_word
```

### **Template 4: Trie Prefix Search**
```python
    def starts_with(self, prefix):
        node = self.root
        for char in prefix:
            if char not in node.children:
                return False
            node = node.children[char]
        return True
```

---

## **Key Variations**

| Pattern | When to Use | Example |
|---------|-------------|---------|
| **Trie Insertion** | When you need to insert words into the trie | [208. Implement Trie (Prefix Tree)](https://leetcode.com/problems/implement-trie-prefix-tree/) |
| **Trie Search** | When you need to search for a word in the trie | [208. Implement Trie (Prefix Tree)](https://leetcode.com/problems/implement-trie-prefix-tree/) |
| **Prefix Search** | When you need to find words with a given prefix | [211. Design Add and Search Words Data Structure](https://leetcode.com/problems/design-add-and-search-words-data-structure/) |
| **Autocomplete** | When you need to suggest words based on a prefix | [1268. Search Suggestions System](https://leetcode.com/problems/search-suggestions-system/) |

---

## **Handpicked LeetCode Problems (Progressive)**

### **Level 1: Foundation (Do These First)**
1. **[208. Implement Trie (Prefix Tree)](https://leetcode.com/problems/implement-trie-prefix-tree/)** - Basic trie operations
2. **[1642. Furthest Building You Can Reach](https://leetcode.com/problems/furthest-building-you-can-reach/)** - Basic trie usage

### **Level 2: Recognition**
3. **[211. Design Add and Search Words Data Structure](https://leetcode.com/problems/design-add-and-search-words-data-structure/)** - Search with wildcards
4. **[648. Replace Words](https://leetcode.com/problems/replace-words/)** - Prefix replacement

### **Level 3: Technique Application**
5. **[1268. Search Suggestions System](https://leetcode.com/problems/search-suggestions-system/)** - Autocomplete system
6. **[421. Maximum XOR of Two Numbers in an Array](https://leetcode.com/problems/maximum-xor-of-two-numbers-in-an-array/)** - Trie with bitwise operations

### **Level 4: Advanced Techniques**
7. **[745. Prefix and Suffix Search](https://leetcode.com/problems/prefix-and-suffix-search/)** - Prefix and suffix search
8. **[677. Map Sum Pairs](https://leetcode.com/problems/map-sum-pairs/)** - Trie with sum queries

---

## **Common Pitfalls & Optimization Tricks**

### **Pitfalls:**
1. **Memory usage:** Tries can use a lot of memory, especially with large datasets.
2. **Edge cases:** Handle edge cases like empty strings or single-character strings carefully.
3. **Traversal errors:** Ensure you follow the correct traversal order when searching or inserting.

### **Optimization Tricks:**
- **Compressed Trie:** Use compressed trie (Radix Tree) to save space.
- **Lazy deletion:** Mark nodes for deletion instead of removing them immediately.
- **Bitwise operations:** Use bitwise operations for efficient XOR calculations.

---

**🎯 Action Plan:**
1. **Today:** Read templates, solve Level 1-2 (4 problems)
2. **Tomorrow:** Solve Level 3 (2 problems)
3. **Day 3:** Solve Level 4 (2 problems) + write notes on each pattern

**— Done with Trie? Ready to move to Phase 2 (Algorithm Patterns)?**