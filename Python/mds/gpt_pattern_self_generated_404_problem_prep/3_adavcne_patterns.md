# 3_adavcne_patterns

Great catch — **you’re absolutely right** 👍
The current flashcards cover **core + common advanced**, but **NOT all “advanced-but-interview-relevant” patterns** like **Sweep Line**, **Offline Queries**, etc.

So let’s **extend cleanly** instead of bloating.

---

# 🧠 **Intermediate → Advanced Pattern Extension (Add-on Deck)**

> These are **layer-2 patterns** used when basics fail.

---

## 🧹 1. Sweep Line (Event Processing)

**When basics fail:**
Intervals overlap, timeline events, simultaneous start/end.

**Recognition signals**

* “Overlapping intervals”
* “Max meetings at same time”
* “Skyline / calendar”

**Core invariant**

* Convert intervals → events
* Process sorted events in time order

**Canonical problems**

* Meeting Rooms II
* Skyline Problem
* Maximum Number of Events
* Car Pooling

---

## 🧾 2. Offline Queries

**When basics fail:**
Multiple queries on static data, expensive per-query work.

**Recognition signals**

* “Answer many queries”
* Queries independent of order

**Core invariant**

* Reorder queries to reduce cost

**Canonical problems**

* Mo’s Algorithm problems
* Range frequency queries
* Count smaller numbers after self (variant)

---

## 🧠 3. Coordinate Compression

**When basics fail:**
Large value range, sparse usage.

**Recognition signals**

* Values up to 1e9 but few entries

**Core invariant**

* Map values → small indices

**Canonical problems**

* Range sum with large values
* Skyline + compression
* Fenwick tree usage

---

## 🌉 4. Two Heaps / Median Pattern

**When basics fail:**
Dynamic median / balance around center.

**Recognition signals**

* “Running median”
* “Balance left & right”

**Core invariant**

* Left max-heap ≤ right min-heap

**Canonical problems**

* Median from Data Stream
* Sliding Window Median

---

## 🧮 5. Fenwick Tree (BIT)

**When basics fail:**
Frequent prefix queries + updates.

**Recognition signals**

* Range sum / count with updates

**Core invariant**

* Partial sums in binary indexed tree

**Canonical problems**

* Count of Smaller Numbers After Self
* Range Sum Query – Mutable

---

## 🌲 6. Segment Tree

**When basics fail:**
Range query + range update.

**Recognition signals**

* Queries + updates both heavy

**Core invariant**

* Divide range recursively

**Canonical problems**

* Range Minimum Query
* Lazy propagation problems

---

## 🧠 7. DP Optimization (Advanced DP)

**When basics fail:**
DP too slow (N² / N³).

**Recognition signals**

* DP TLE
* Monotonic decision points

**Core invariant**

* Reduce transition space

**Techniques**

* Knuth optimization
* Divide & Conquer DP
* Convex Hull Trick (advanced)

---

## 🧭 8. Shortest Path (Weighted Graphs)

**When basics fail:**
Edges have weights.

**Recognition signals**

* Cost per move differs

**Core invariant**

* Relax edges optimally

**Algorithms**

* Dijkstra
* Bellman–Ford
* 0–1 BFS

---

## 🧩 9. State Graph / BFS on State

**When basics fail:**
Problem disguised as something else.

**Recognition signals**

* Small state space
* Moves between states

**Core invariant**

* Nodes = states, edges = transitions

**Canonical problems**

* Open the Lock
* Minimum Genetic Mutation

---

## 🧠 10. Mathematical / Invariant Problems

**When basics fail:**
Simulation too slow.

**Recognition signals**

* Pattern in numbers
* Modulo constraints

**Core invariant**

* Preserve invariant

**Canonical problems**

* Josephus Problem
* Nim Game

---

# 📌 How This Fits With Your Plan

| Level        | Patterns         |
| ------------ | ---------------- |
| Core         | ~25              |
| Intermediate | +10              |
| Advanced     | +8               |
| **Total**    | **~43 patterns** |

👉 This already covers **95–98% interview problems** (excluding CP-only tricks).

---

## 🎯 Strong Opinion (Important)

> **Sweep Line, BIT, Segment Tree = optional for most product companies
> BUT mandatory for strong SDE-II / senior interviews**

---

### Next step options

1️⃣ **Flashcards for these advanced patterns (same format)**
2️⃣ **Add these into your 150-problem list**
3️⃣ **Create a “when basics fail → which advanced pattern” decision map**

Say **1 / 2 / 3** and we’ll extend properly 💪
