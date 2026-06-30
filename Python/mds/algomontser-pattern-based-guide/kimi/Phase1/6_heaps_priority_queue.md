# 6_heaps_priority_queue

# **Pattern #6: Heaps / Priority Queues**

## **Intuition & Recognition Cues**
Use heaps when:
- You need to **maintain a sorted order** but don't need full sorting.
- You need to **efficiently get the max/min element**.
- You need to **merge sorted streams**.

**Recognize it in problems:**
- "Find the k-th largest/smallest element..."
- "Merge k sorted lists..."
- "Maintain a running median..."

---

## **Core Templates & Blueprints**

### **Template 1: Basic Heap Operations**
```python
import heapq

# Min-heap
min_heap = []
heapq.heappush(min_heap, value)  # Push an element
min_value = heapq.heappop(min_heap)  # Pop the smallest element
peek_min = min_heap[0]  # Peek the smallest element

# Max-heap (using negative values)
max_heap = []
heapq.heappush(max_heap, -value)  # Push an element
max_value = -heapq.heappop(max_heap)  # Pop the largest element
peek_max = -max_heap[0]  # Peek the largest element
```

### **Template 2: Heapify**
```python
arr = [3, 1, 4, 1, 5, 9, 2, 6]
heapq.heapify(arr)  # Convert list to a heap in-place
```

### **Template 3: K-th Largest Element**
```python
def kth_largest(arr, k):
    min_heap = []
    for num in arr:
        heapq.heappush(min_heap, num)
        if len(min_heap) > k:
            heapq.heappop(min_heap)
    return min_heap[0]
```

### **Template 4: Merge K Sorted Lists**
```python
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

def merge_k_sorted_lists(lists):
    min_heap = []
    dummy = ListNode()
    current = dummy
    for i, node in enumerate(lists):
        if node:
            heapq.heappush(min_heap, (node.val, i))
    while min_heap:
        val, idx = heapq.heappop(min_heap)
        current.next = lists[idx]
        current = current.next
        lists[idx] = lists[idx].next
        if lists[idx]:
            heapq.heappush(min_heap, (lists[idx].val, idx))
    return dummy.next
```

---

## **Key Variations**

| Pattern | When to Use | Example |
|---------|-------------|---------|
| **K-th Largest/Smallest Element** | When you need to find the k-th largest/smallest element | [215. Kth Largest Element in an Array](https://leetcode.com/problems/kth-largest-element-in-an-array/) |
| **Merge K Sorted Lists** | When you need to merge multiple sorted lists | [23. Merge k Sorted Lists](https://leetcode.com/problems/merge-k-sorted-lists/) |
| **Running Median** | When you need to maintain a running median | [295. Find Median from Data Stream](https://leetcode.com/problems/find-median-from-data-stream/) |
| **Top K Frequent Elements** | When you need to find the top k frequent elements | [347. Top K Frequent Elements](https://leetcode.com/problems/top-k-frequent-elements/) |

---

## **Handpicked LeetCode Problems (Progressive)**

### **Level 1: Foundation (Do These First)**
1. **[215. Kth Largest Element in an Array](https://leetcode.com/problems/kth-largest-element-in-an-array/)** - Basic heap usage
2. **[23. Merge k Sorted Lists](https://leetcode.com/problems/merge-k-sorted-lists/)** - Merge k sorted lists

### **Level 2: Recognition**
3. **[295. Find Median from Data Stream](https://leetcode.com/problems/find-median-from-data-stream/)** - Running median
4. **[347. Top K Frequent Elements](https://leetcode.com/problems/top-k-frequent-elements/)** - Frequency counter with heap

### **Level 3: Technique Application**
5. **[703. Kth Largest Element in a Stream](https://leetcode.com/problems/kth-largest-element-in-a-stream/)** - K-th largest element in a stream
6. **[692. Top K Frequent Words](https://leetcode.com/problems/top-k-frequent-words/)** - Frequency counter with heap and custom sorting

### **Level 4: Advanced Techniques**
7. **[451. Sort Characters By Frequency](https://leetcode.com/problems/sort-characters-by-frequency/)** - Frequency counter with heap
8. **[378. Kth Smallest Element in a Sorted Matrix](https://leetcode.com/problems/kth-smallest-element-in-a-sorted-matrix/)** - K-th smallest element in a sorted matrix

---

## **Common Pitfalls & Optimization Tricks**

### **Pitfalls:**
1. **Heap size:** Be cautious of heap size, especially for large inputs.
2. **Heap operations:** Ensure you use the correct heap operations (push, pop).
3. **Edge cases:** Handle edge cases like empty lists or single-element lists carefully.
4. **Custom comparators:** Be careful with custom comparators in heaps.

### **Optimization Tricks:**
- **Min-heap vs. max-heap:** Use min-heap for k-th largest and max-heap for k-th smallest.
- **Heapify:** Use `heapq.heapify` to convert a list to a heap in O(n) time.
- **Two heaps:** Use two heaps (one min-heap, one max-heap) for running median problems.
- **Custom objects:** Use tuples to store custom objects in heaps (e.g., `(value, index)`).

---

**🎯 Action Plan:**
1. **Today:** Read templates, solve Level 1-2 (4 problems)
2. **Tomorrow:** Solve Level 3 (2 problems)
3. **Day 3:** Solve Level 4 (2 problems) + write notes on each pattern

**— Done with Heaps / Priority Queues? Ready to move to Pattern #7 (Graph Representation)?**