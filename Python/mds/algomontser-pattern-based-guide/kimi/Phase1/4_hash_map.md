# 4_hash_map

# **Pattern #4: Hash Tables**

## **Intuition & Recognition Cues**
Use hash tables when:
- You need **fast lookups** (O(1) average time complexity).
- You need to **count occurrences** of elements.
- You need to **check for existence** of elements.
- You need to **map keys to values**.

**Recognize it in problems:**
- "Find the frequency of..."
- "Check if an element exists..."
- "Map one value to another..."
- "Group elements by..."

---

## **Core Templates & Blueprints**

### **Template 1: Basic Hash Table Operations**
```python
from collections import defaultdict

# Initialize a hash table
hash_table = defaultdict(int)

# Insert an element
hash_table[key] = value

# Check if an element exists
if key in hash_table:
    print("Key exists")

# Get the value of an element
value = hash_table[key]

# Delete an element
del hash_table[key]
```

### **Template 2: Frequency Counter**
```python
from collections import Counter

def frequency_counter(arr):
    return Counter(arr)
```

### **Template 3: Grouping Elements**
```python
from collections import defaultdict

def group_elements(arr):
    groups = defaultdict(list)
    for item in arr:
        key = some_function(item)  # Define your key function
        groups[key].append(item)
    return groups
```

### **Template 4: Two Sum Problem**
```python
def two_sum(nums, target):
    hash_table = {}
    for i, num in enumerate(nums):
        complement = target - num
        if complement in hash_table:
            return [hash_table[complement], i]
        hash_table[num] = i
    return []
```

---

## **Key Variations**

| Pattern | When to Use | Example |
|---------|-------------|---------|
| **Frequency Counter** | When you need to count occurrences of elements | [347. Top K Frequent Elements](https://leetcode.com/problems/top-k-frequent-elements/) |
| **Existence Check** | When you need to check if an element exists | [217. Contains Duplicate](https://leetcode.com/problems/contains-duplicate/) |
| **Grouping Elements** | When you need to group elements by some property | [49. Group Anagrams](https://leetcode.com/problems/group-anagrams/) |
| **Two Sum** | When you need to find pairs that sum to a target | [1. Two Sum](https://leetcode.com/problems/two-sum/) |

---

## **Handpicked LeetCode Problems (Progressive)**

### **Level 1: Foundation (Do These First)**
1. **[217. Contains Duplicate](https://leetcode.com/problems/contains-duplicate/)** - Basic existence check
2. **[1. Two Sum](https://leetcode.com/problems/two-sum/)** - Basic hash table usage

### **Level 2: Recognition**
3. **[347. Top K Frequent Elements](https://leetcode.com/problems/top-k-frequent-elements/)** - Frequency counter
4. **[49. Group Anagrams](https://leetcode.com/problems/group-anagrams/)** - Grouping elements

### **Level 3: Technique Application**
5. **[387. First Unique Character in a String](https://leetcode.com/problems/first-unique-character-in-a-string/)** - Frequency counter with additional logic
6. **[349. Intersection of Two Arrays](https://leetcode.com/problems/intersection-of-two-arrays/)** - Intersection using hash table

### **Level 4: Advanced Techniques**
7. **[76. Minimum Window Substring](https://leetcode.com/problems/minimum-window-substring/)** - Sliding window with hash table
8. **[30. Substring with Concatenation of All Words](https://leetcode.com/problems/substring-with-concatenation-of-all-words/)** - Advanced grouping and sliding window

---

## **Common Pitfalls & Optimization Tricks**

### **Pitfalls:**
1. **Hash collisions:** Be aware of potential collisions and handle them appropriately.
2. **Memory usage:** Hash tables can use a lot of memory, especially with large datasets.
3. **Key errors:** Always check if a key exists before accessing it to avoid `KeyError`.
4. **Overuse:** Avoid using hash tables when simpler data structures (like sets) can suffice.

### **Optimization Tricks:**
- **Defaultdict:** Use `collections.defaultdict` to simplify code and avoid key existence checks.
- **Counter:** Use `collections.Counter` for frequency counting.
- **Set operations:** Use set operations (union, intersection, difference) for efficient set manipulations.
- **Sliding window:** Combine hash tables with sliding window techniques for substring problems.

---

**🎯 Action Plan:**
1. **Today:** Read templates, solve Level 1-2 (4 problems)
2. **Tomorrow:** Solve Level 3 (2 problems)
3. **Day 3:** Solve Level 4 (2 problems) + write notes on each pattern

**— Done with Hash Tables? Ready to move to Pattern #5 (Trees: Binary & BST)?**