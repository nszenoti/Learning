# linear_regression_OLS_notion_gist

💯 That is the *exact* philosophical and statistical root of it. Let's now clear this up **once and for all** with razor-sharp clarity.

---

## 🔥 You're asking:

> 1. Why don’t we just assume **y is normally distributed** directly?
> 2. Why do we make assumptions on **error (ε)** instead?
> 3. If ε is normal, does that mean **y is also normal**?

Let’s tackle all 3 **step by step**, then wrap it in one clean picture.

---

### ✅ **1. Why don’t we assume $y$ is normally distributed directly?**

Because **regression is conditional modeling**.

We are modeling:

$$
y = X\beta + \varepsilon
$$

We want to say:

> “Given x, what does y look like?”

So we care about:

$$
y \mid x
$$

If we assume:

$$
y \sim \mathcal{N}(\mu, \sigma^2)
$$

We're saying y is normal **no matter what x is**, i.e., *y is just floating in the air*.

🚫 That **ignores the relationship between x and y** — which defeats the point of regression.

✅ Instead, we assume:

$$
\varepsilon \sim \mathcal{N}(0, \sigma^2)
\Rightarrow
y \mid x \sim \mathcal{N}(X\beta, \sigma^2)
$$

So:
**Assuming ε is normal gives us a conditional normal distribution for y — which is what we want.**

---

### ✅ **2. Why make assumptions on ε (error), not y?**

Because:

* y is composed of a **deterministic part** (Xβ) and a **random part** (ε)
* The **only randomness** in y comes from ε

So any probabilistic statement about y needs to **start from ε**, since:

$$
y = X\beta + \varepsilon
\Rightarrow \text{All randomness in y comes from ε}
$$

We don't assume randomness in $X\beta$ — that’s fixed for any given x.

---

### ✅ **3. Does ε being normal imply y is also normal?**

**Yes — exactly.**

This is a standard result in probability:

> If a constant is added to a normal variable, the result is also normal.

So:

$$
\varepsilon \sim \mathcal{N}(0, \sigma^2)
\Rightarrow
y = X\beta + \varepsilon \sim \mathcal{N}(X\beta, \sigma^2)
$$

✅ So **y is normal** *conditioned on x*, but this normality **comes from the assumption on ε**.

---

## 🔁 Let's tie it all together with this analogy:

Imagine you’re shooting arrows (y-values) at a target (true value $X\beta$).

* Your aim (x, β) sets **where** you're trying to hit.
* The **random wobbles** (ε) in your hand affect how far off the arrow goes.

So:

* We model the **wobble**, not the arrow directly.
* That wobble defines the **distribution** of where arrows land (y-values).
* If the wobble is **normal**, the **landing points (y)** are also **normal around the true aim**.

---

## ✅ Final Summary:

| Question                        | Short Answer                                          |
| ------------------------------- | ----------------------------------------------------- |
| Why not assume y \~ Normal?     | Because y depends on x; direct normality ignores that |
| Why assume error is Normal?     | Because ε is the **source of randomness** in y        |
| Does ε \~ Normal ⇒ y \~ Normal? | ✅ Yes — **conditionally**, y ∼ Normal(Xβ, σ²)         |

---

Let me know if you want a 5-point intuitive checklist or a code demo to reinforce this.
