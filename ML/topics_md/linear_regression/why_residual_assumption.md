# why_residual_assumption

💥 Boom — you’ve landed on another critical question. This is where **math, modeling, and inference all come together**. Let's answer it **clearly and precisely**.

---

## ✅ Two-part question:

1. **Why don’t we directly assume that $y$ is normally distributed in OLS?**
2. **Are error and residual the same?**

---

### 🎯 **1. Why don’t we assume $y \sim \mathcal{N}(\mu, \sigma^2)$ directly in OLS?**

#### Because:

OLS isn't about modeling $y$ directly — it's about modeling **how $y$ depends on $x$**.

OLS assumes:

$$
y = X\beta + \varepsilon, \quad \text{with } \varepsilon \sim \mathcal{N}(0, \sigma^2)
$$

This is more precise than:

$$
y \sim \mathcal{N}(\mu, \sigma^2)
$$

Why?

* That second form loses **conditional dependence** of $y$ on $X$.
* We don’t believe $y$ has the same mean for all inputs — we believe the mean depends on $x$:

  $$
  \mathbb{E}[y \mid x] = x^\top \beta
  $$

So instead of assuming:

> “y is normal”
> We assume:
> “The **noise** around the regression line is normal”

That gives us:

* A **more flexible**, **conditional** model:

  $$
  y_i \mid x_i \sim \mathcal{N}(x_i^\top \beta, \sigma^2)
  $$

---

### 💡 Summary:

> We don’t model **y as globally normal**
> We model **y as normal *given x*** → because regression is a conditional model

---

### 🧠 Think of this like:

> We don’t say “exam scores are normal”
> We say “exam scores are normal *given how much you studied*”

---

### 📌 Now for Part 2:

## ✅ Are **error** and **residual** the same?

**Not quite.** They're related — but **not identical**.

| Term         | Symbol                                | What it is                              | Known/Unknown |
| ------------ | ------------------------------------- | --------------------------------------- | ------------- |
| **Error**    | $\varepsilon_i = y_i - x_i^\top\beta$ | True difference (uses true $\beta$)     | **Unknown**   |
| **Residual** | $e_i = y_i - x_i^\top\hat\beta$       | Estimated difference (uses $\hat\beta$) | **Known**     |

---

### 🔁 Relation:

Residual $e_i$ is an **observable proxy** for the true error $\varepsilon_i$.
We use residuals to check if our model is behaving well (e.g., homoscedasticity, normality).

---

### ✅ Final Answers:

1. **We don’t assume $y \sim \mathcal{N}$** because we're doing **conditional modeling** → we assume $\varepsilon \sim \mathcal{N}$ instead.
2. **Error** is the true unknown deviation, **residual** is the observed estimate of that error after fitting the model.

---

Would you like a little code + plot to show how errors vs residuals behave differently on real data?
