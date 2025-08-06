ml_task_prompts

Great scenario — this is a **classic ML pipeline setup** with some guidance and freedom. Here’s how to **approach it using LLM prompts in a structured sequence** to get the most help at each stage, **without copy-pasting reference notebooks blindly**, but still using them wisely.

---

## 🔁 Scenario Breakdown

**Goal**: Perform an ML task (classification/regression/etc.) from scratch using:

* A given dataset
* Problem context
* Reference notebooks (optional inspirations)

---

## 🧩 Recommended Prompt Sequence (for Each Stage)

Below is a **stage-by-stage prompt structure**. Each stage includes **example prompts** and optional variants.

---

### ✅ 1. **Understand the Problem Context**

> Prompt:

```
Here's a brief of the problem:  
[Insert problem statement]

Can you help me summarize what kind of ML task this is (classification/regression/etc.), what the target variable might be, and what the success metric could look like?
```

> Variant: "Is this more of a supervised or unsupervised learning task? What kind of challenges should I expect?"

---

### ✅ 2. **Understand the Dataset**

> Prompt:

```
Here is the dataset structure (or sample):

[Paste sample rows / column names / types]

Based on this, can you help me:
- Identify features vs target
- Spot categorical/numerical columns
- Suggest likely preprocessing needs?
```

> Optional: “What questions should I explore in the EDA?”

---

### ✅ 3. **Plan the Notebook Workflow**

> Prompt:

```
Given this ML task and dataset, what would be an ideal sequence of steps in a Jupyter notebook?

Assume I want clean code, modular structure, and good EDA.

Give me a high-level outline with section headers.
```

> Output: You’ll get a ready-to-follow structure like:

* Load libraries
* Load & inspect dataset
* EDA
* Preprocessing
* Model training
* Evaluation
* Conclusion

---

### ✅ 4. **EDA Suggestions**

> Prompt:

```
Can you help suggest EDA plots and statistical summaries I should run for this dataset?

Goal: Understand relationships, distributions, missing values, outliers, and feature importance.
```

> Variant:

```
What EDA insights should I include to impress in a case study?
```

---

### ✅ 5. **Preprocessing Plan**

> Prompt:

```
Help me define preprocessing steps for the following dataset:

[Include list of columns with types or a sample]

Mention steps like encoding, scaling, missing value treatment, feature selection, etc.
```

> Follow-up: “Write a scikit-learn pipeline (or modular functions) for these preprocessing steps.”

---

### ✅ 6. **Model Selection Strategy**

> Prompt:

```
Given this is a [classification/regression] task and my dataset has [#rows, #features], what models should I try first and why?

Also suggest appropriate evaluation metrics.
```

> Optional: “Suggest baseline + advanced models.”

---

### ✅ 7. **Code Helper Prompts**

> Prompt (Reusable):

```
Write clean code in Python (pandas, sklearn) to [specific task].

e.g., 'Encode categorical variables using OneHotEncoder while preserving column names.'
```

---

### ✅ 8. **Model Evaluation**

> Prompt:

```
Once the model is trained, how should I evaluate it effectively?

Suggest metrics and plots based on this being a [binary/multi-class/regression] task.
```

> Follow-up: “Write Python code to compute and visualize them.”

---

### ✅ 9. **Reference Notebook Extraction (Smart Use)**

> Prompt:

```
Here’s a summary of what the reference notebook does:

[Brief summary]

What are the reusable ideas or techniques I should consider adopting, but how can I improve or customize them for my notebook?
```

> This keeps your work original while drawing insightfully from existing material.

---

### ✅ 10. **Final Notebook Polishing**

> Prompt:

```
How can I polish this notebook for presentation?

Suggest what I should add in terms of:
- Comments & markdown explanations
- Titles/subtitles
- Summary/conclusion cells
- Visual storytelling
```

---

## ✨ BONUS: Turn it into a Reusable Prompt Template

Here’s a compact reusable template for your ML projects:

> ```
> I'm working on an ML task: [brief description]
>
> Dataset: [sample or column list]
>
> Objective: [goal/metric]
>
> Help me with: [EDA / preprocessing / modeling / evaluation / notebook outline]
>
> Constraints: [keep code clean, follow best practices, use scikit-learn, etc.]
> ```

---

If you give a specific dataset or problem, I can also generate **tailored prompts end-to-end** for that case.

Would you like a **Notion-style or Markdown-ready checklist** version of this?
