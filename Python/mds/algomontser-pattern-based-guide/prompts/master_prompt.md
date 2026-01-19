master_prompt

To build a truly effective DSA study guide that emulates the best of **AlgoMonster** (structured flow) and **Grokking the Coding Interview** (intuitive patterns), you need a prompt that forces the AI to act as a Senior Engineer and Interview Coach.

Here is a two-step approach. First, use the **Roadmap Prompt** to set the foundation.

### Step 1: The Roadmap Generation Prompt

Copy and paste this into your LLM or Cursor to generate the master structure.

```markdown
Act as a Senior Software Engineer and DSA Coach. I want to create a comprehensive, pattern-based study guide for Data Structures and Algorithms, emulating the structured learning path of AlgoMonster and the intuitive pattern breakdown of "Grokking the Coding Interview."

Goal: Create a master roadmap that categorizes learning into three distinct phases:
1. Basic Data Structures (The Foundation)
2. Algorithms & Techniques (The Tools)
3. Problem-Solving Patterns & Simulations (The Interview Strategy)

For each phase, list the specific topics and patterns. 
- For Algorithms: Focus on Big O, Recursion, and Sorting/Searching.
- For Patterns: Include modern staples like Sliding Window, Two Pointers, Monotonic Stack, etc.

Format the output as a Table of Contents/Roadmap. Use a logical order where each topic builds on the previous one (e.g., Arrays -> Two Pointers -> Sliding Window). 

Provide the Roadmap first. Do not generate the theory yet; I will ask you to deep-dive into each section one by one in subsequent prompts.

```

---

### Step 2: The "Pattern Deep-Dive" Prompt

Once the roadmap is generated, use this prompt for **each specific pattern** (e.g., "Two Pointers" or "Sliding Window") to get your detailed notes.

```markdown
Now, let's deep-dive into the pattern: [INSERT PATTERN NAME HERE].

Please generate a comprehensive note following this exact structure:

1. INTUITION: Explain the "Why" and "When." What kind of problem keywords or constraints suggest this pattern? How does it optimize a naive approach?
2. CORE TEMPLATE (Python): Provide a clean, reusable Python code template that represents the generic structure of this pattern. Use clear variable names (e.g., left, right, window_sum).
3. THE STEP-BY-STEP LOGIC: A bulleted list of the mental steps needed to implement this pattern.
4. EDGE CASES: What should I watch out for? (e.g., empty arrays, single elements, negative numbers).
5. TOP 5 LEETCODE PROBLEMS: List 5 relevant LeetCode problems categorized by difficulty (Easy, Medium, Hard) that perfectly illustrate this pattern.
6. MINI-WALKTHROUGH: Briefly explain how the template would be slightly modified for the most famous problem of this set (e.g., for Sliding Window, explain its application to "Longest Substring Without Repeating Characters").

Keep the tone concise, technical, and focused on "Pattern Recognition."

```

### Why this works:

* **Logical Sequencing:** By asking for the roadmap first, you ensure the AI doesn't miss "bridge" topics (like how Prefix Sum often leads into Hash Map problems).
* **Template-First Learning:** Instead of memorizing 100 solutions, you focus on the **template**, which is how AlgoMonster teaches you to handle "unseen" problems.
* **Python Specifics:** It forces the AI to use Pythonic idioms (like `collections.deque` or slicing) which are crucial for interview speed.

**Would you like me to generate the initial Roadmap for you right now to get started?**