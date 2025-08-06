That's a great instinct — **priming the LLM** to behave a certain way upfront helps **steer it toward concise, focused, and context-aware responses.**

Here’s a **priming prompt** you can reuse at the beginning of your session or any task:

---

## 🔒 Minimal, Context-Respecting System Prompt

```
Before we dive in, I want you to follow these ground rules:

- Stick strictly to the context I provide.  
- Don’t suggest anything unless explicitly asked.  
- Avoid generic advice or redundant explanation.  
- Be concise, relevant, and focused only on what’s needed at the moment.  
- Assume I’m technically proficient — don’t over-explain basics.

I’ll share problem details shortly. Wait for my specific queries before offering code or insights.
```

---

## ⚙️ Optional Add-ons (based on preference)

You can also append things like:

* *"Use clean, production-quality Python code unless otherwise mentioned."*
* *"Prefer standard libraries like pandas, scikit-learn, matplotlib."*
* *"Avoid using deep learning unless requested."*
* *"Keep suggestions modular and comment lightly, not verbosely."*

---

## 🧠 Usage Tip:

Use this at the very **start of your session**. The model will generally honor it throughout — though if the conversation drifts, you can reassert it with:

> "Reminder: Stick to the scope I define and don't suggest things I haven’t asked for."

---

Would you like a **copy-paste snippet** for common workflows like ML project setup, backend API generation, or system design — with such strict response policies included?
