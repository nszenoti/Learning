# 1_Array_String

 # **Pattern #1: Arrays & Strings**

## **Intuition & Recognition Cues**
This is your **default data structure**. When you see:
- **Fixed-size collection** of same-type elements
- **Random access** needed (O(1) lookups)
- **Ordered sequence** to maintain
- **String manipulation** (treat strings as immutable char arrays)

**Use arrays when:** You need fast access by index, or when the problem screams "linear sequence" (most common pattern).

---

## **Core Templates & Blueprints**

### **Template 1: In-place Two-Way Swap**
```python
def reverse_in_place(arr, left, right):
    """Foundation for many array problems"""
    while left < right:
        arr[left], arr[right] = arr[right], arr[left]
        left += 1
        right -= 1
```

### **Template 2: Prefix Sum Array (Golden Pattern)**
```python
def prefix_sum(arr):
    """Transform O(n²) range queries to O(1)"""
    prefix = [0] * (len(arr) + 1)
    for i in range(len(arr)):
        prefix[i+1] = prefix[i] + arr[i]
    return prefix

# Use: sum_range(i, j) = prefix[j+1] - prefix[i]
```

### **Template 3: String Builder (For immutable strings)**
```python
# BAD: s += "a"  # O(n²) due to string copying
# GOOD:
chars = []
for c in some_sequence:
    chars.append(c)
result = "".join(chars)  # O(n) total
```

### **Template 4: Frequency Counter (HashMap from Array)**
```python
from collections import Counter
freq = Counter(arr)  # O(n)
```

---

## **Key Variations**

| Pattern | When to Use | Example |
|---------|-------------|---------|
| **Two Pointers** | Sorted array, or in-place operations | Remove duplicates, 3Sum |
| **Sliding Window** | Subarray/substring problems | Max sum subarray of size k |
| **Cyclic Sort** | Range [0..N], find missing/repeated | Find Duplicate Number |
| **In-place reversal** | Rotate, reverse words | Reverse String, Rotate Array |
| **Char-bitmask** | Only lowercase letters (26) | Anagrams, palindrome permutations |

---

## **Handpicked LeetCode Problems (Progressive)**

### **Level 1: Foundation (Do These First)**
1. **[1929. Concatenation of Array](https://leetcode.com/problems/concatenation-of-array/)** - Basic array manipulation
2. **[344. Reverse String](https://leetcode.com/problems/reverse-string/)** - In-place two-pointer
3. **[1480. Running Sum of 1d Array](https://leetcode.com/problems/running-sum-of-1d-array/)** - Prefix sum intro

### **Level 2: Recognition**
4. **[1. Two Sum](https://leetcode.com/problems/two-sum/)** - HashMap from array
5. **[26. Remove Duplicates from Sorted Array](https://leetcode.com/problems/remove-duplicates-from-sorted-array/)** - In-place two-pointer
6. **[242. Valid Anagram](https://leetcode.com/problems/valid-anagram/)** - Frequency counter

### **Level 3: Technique Application**
7. **[905. Sort Array By Parity](https://leetcode.com/problems/sort-array-by-parity/)** - In-place partition pattern
8. **[349. Intersection of Two Arrays](https://leetcode.com/problems/intersection-of-two-arrays/)** - Counter + set operations

### **Level 4: String Intensive**
9. **[125. Valid Palindrome](https://leetcode.com/problems/valid-palindrome/)** - Two pointers on string
10. **[14. Longest Common Prefix](https://leetcode.com/problems/longest-common-prefix/)** - Vertical scanning

### **Level 5: Edge Cases & Optimization**
11. **[443. String Compression](https://leetcode.com/problems/string-compression/)** - In-place string modification
12. **[238. Product of Array Except Self](https://leetcode.com/problems/product-of-array-except-self/)** - Prefix/suffix product (no division)

---

## **Common Pitfalls & Optimization Tricks**

### **Pitfalls:**
1. **String immutability:** `s += "x"` in loops = O(n²). Always use `list + join()`
2. **Off-by-one errors:** `range(len(arr))` vs `range(len(arr)-1, -1, -1)`
3. **Modifying while iterating:** Never do `for i in arr: arr.remove(i)`
4. **Space misuse:** Don't create new arrays when problem says "in-place"

### **Optimization Tricks:**
- **Early termination:** If sorted, break loops when `arr[i] > target`
- **Sentinel values:** Append `float('inf')` to avoid boundary checks
- **Modulo for rotation:** `k % len(arr)` handles `k > len(arr)`
- **Bit manipulation for 26 letters:** `int` bitmask instead of `Counter` (micro-optimization)

---

**🎯 Action Plan:**
1. **Today:** Read templates, solve Level 1-2 (4 problems)
2. **Tomorrow:** Solve Level 3-4 (4 problems)
3. **Day 3:** Solve Level 5 (2 problems) + write notes on each pattern

**— Done with Arrays? Ready to move to Pattern #2 (LinkedLists)?**