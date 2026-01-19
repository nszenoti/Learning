# 2_patterns_flashcards

Perfect 👍
Here are **Pattern Recognition Flashcards** — **interview-ready, fast recall**, zero fluff.

Use them **daily (5–10 min)**.

---

# 🧠 **DSA Pattern Recognition Flashcards**

> **Front = Interview clue**
> **Back = Pattern + invariant**

---

## 🃏 1. Two Pointers 👉👈

**Front:**
“Array / string is sorted or monotonic. Need pairs / reverse / shrink.”

**Back:**
**Pattern:** Two pointers
**Invariant:** Move pointers to reduce search space
**Key signal:** `i < j`, sorted input
**Trap:** Unsorted → won’t work

---

## 🃏 2. Sliding Window 🪟

**Front:**
“Contiguous subarray / substring with constraint.”

**Back:**
**Pattern:** Sliding Window
**Invariant:** Window maintains validity
**Key signal:** “longest / shortest / count subarrays”
**Trap:** Window validity logic incorrect

---

## 🃏 3. Fast–Slow Pointers 🐢🐇

**Front:**
“Cycle / middle / duplicate detection.”

**Back:**
**Pattern:** Floyd’s cycle
**Invariant:** Fast meets slow if cycle exists
**Key signal:** Linked list / number transform
**Trap:** Forget reset logic

---

## 🃏 4. Binary Search 🔍

**Front:**
“Answer is monotonic (true → false).”

**Back:**
**Pattern:** Binary Search on answer
**Invariant:** Search space halves
**Key signal:** “minimum / maximum possible”
**Trap:** Off-by-one

---

## 🃏 5. Prefix Sum ➕

**Front:**
“Repeated range sum queries.”

**Back:**
**Pattern:** Prefix sum
**Invariant:** `sum(i,j) = pref[j] - pref[i-1]`
**Key signal:** Subarray sums
**Trap:** Index misalignment

---

## 🃏 6. Hashing 🗂️

**Front:**
“Need O(1) lookup / frequency.”

**Back:**
**Pattern:** Hash map / set
**Invariant:** Store seen info
**Key signal:** Complements / duplicates
**Trap:** Space ignored

---

## 🃏 7. Monotonic Stack 📚

**Front:**
“Next greater / smaller element.”

**Back:**
**Pattern:** Monotonic stack
**Invariant:** Stack maintains order
**Key signal:** Histogram, temperature
**Trap:** Wrong stack direction

---

## 🃏 8. Heap ⛰️

**Front:**
“Top K / streaming median.”

**Back:**
**Pattern:** Heap
**Invariant:** Root is extreme
**Key signal:** “largest / smallest K”
**Trap:** Min vs max confusion

---

## 🃏 9. Greedy 🎯

**Front:**
“Local choice feels optimal.”

**Back:**
**Pattern:** Greedy
**Invariant:** Choice doesn’t break future
**Key signal:** Sorting helps
**Trap:** No proof

---

## 🃏 10. Backtracking 🔙

**Front:**
“All combinations / permutations.”

**Back:**
**Pattern:** Backtracking
**Invariant:** Explore → undo
**Key signal:** Decision tree
**Trap:** Forget to revert state

---

## 🃏 11. Tree DFS 🌳

**Front:**
“Path / height / depth problem.”

**Back:**
**Pattern:** DFS
**Invariant:** Combine left + right
**Key signal:** Recursive structure
**Trap:** Global variable misuse

---

## 🃏 12. Tree BFS 🌲

**Front:**
“Level / distance matters.”

**Back:**
**Pattern:** BFS
**Invariant:** Process level by level
**Key signal:** Queue
**Trap:** Mixing levels

---

## 🃏 13. Graph BFS 🚶

**Front:**
“Shortest path (unweighted).”

**Back:**
**Pattern:** BFS
**Invariant:** First visit = shortest
**Key signal:** Queue
**Trap:** No visited set

---

## 🃏 14. Graph DFS 🌐

**Front:**
“Connected components / cycles.”

**Back:**
**Pattern:** DFS
**Invariant:** Visit all reachable
**Key signal:** Grid / graph
**Trap:** Stack overflow

---

## 🃏 15. Topological Sort 📐

**Front:**
“Dependency ordering.”

**Back:**
**Pattern:** Kahn / DFS topo
**Invariant:** Zero indegree first
**Key signal:** DAG
**Trap:** Cycle not handled

---

## 🃏 16. Union Find 🤝

**Front:**
“Dynamic connectivity.”

**Back:**
**Pattern:** DSU
**Invariant:** Parent compression
**Key signal:** Merge & query
**Trap:** Forget path compression

---

## 🃏 17. DP – 1D 📈

**Front:**
“Overlapping subproblems, linear state.”

**Back:**
**Pattern:** DP
**Invariant:** `dp[i]` depends on prev
**Key signal:** Choices per index
**Trap:** Wrong base case

---

## 🃏 18. DP – 2D 📊

**Front:**
“Grid / string comparison.”

**Back:**
**Pattern:** 2D DP
**Invariant:** Top-left dependency
**Key signal:** LCS / edit
**Trap:** Index shift

---

## 🃏 19. Bit Manipulation 🔢

**Front:**
“Even/odd / uniqueness.”

**Back:**
**Pattern:** XOR / bitmask
**Invariant:** XOR cancels
**Key signal:** Single number
**Trap:** Sign bits

---

## 🃏 20. Design 🏗️

**Front:**
“State + operations.”

**Back:**
**Pattern:** Data structure design
**Invariant:** Operations complexity
**Key signal:** LRU/LFU
**Trap:** Overengineering

---

## 🔁 How to Use (5-min rule)

* Daily: **10 flashcards**
* Read **front → answer aloud**
* If hesitation >5s → revise pattern

---

### Want me to:

* 🧾 Convert these into **Anki-ready CSV**
* 🗓️ Create **7-day flashcard + problem loop**
* 🎤 Add **interviewer follow-up questions per card**

Just say which one 🔥
