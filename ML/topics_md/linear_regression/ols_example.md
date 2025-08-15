# ols_example

Absolutely! Let's create a **tiny, intuitive example** to explain **which OLS assumptions actually matter, when, and why** — without getting buried in formulas.

---

## 🎯 Goal

We'll walk through a **small dataset**, run OLS, and then reflect on what happens **with or without assumptions**. We'll focus on the **difference between estimation and inference**, and when assumptions start to matter.

---

## 🧪 Example Setup

Let’s say you're studying how **hours studied** ($x$) affects **exam score** ($y$) for 5 students:

| Student | Hours Studied ($x$) | Exam Score ($y$) |
| ------- | ------------------- | ---------------- |
| A       | 1                   | 50               |
| B       | 2                   | 55               |
| C       | 3                   | 65               |
| D       | 4                   | 70               |
| E       | 5                   | 75               |

Let’s assume:

$$
y = \beta_0 + \beta_1 x + \varepsilon
$$

---

## 🔍 Step 1: Estimate $\hat\beta_0$, $\hat\beta_1$

You run OLS and get:

$$
\hat\beta_0 = 45,\quad \hat\beta_1 = 6
$$

> So the model is:

$$
\hat{y} = 45 + 6x
$$

🎯 **This is estimation** — we simply computed the line that best fits the data.

---

## ✅ What assumptions did we use so far?

> **None!**
> You can always compute $\hat\beta$ — it's just math. Even if errors are weird or predictors are strange, the line still exists.

---

## 🔬 Step 2: Suppose now you ask:

> "How sure are we that the **true** effect of studying (i.e., $\beta_1$) is 6?"

Now you want to build:

* A **confidence interval** for $\beta_1$
* A **p-value** to test:

  $$
  H_0: \beta_1 = 0
  $$

> 🎯 **This is inference** — now, assumptions **matter.**

---

## 🧠 Where do assumptions kick in?

| Assumption                 | Do we need it for...                  | Why it matters                            |
| -------------------------- | ------------------------------------- | ----------------------------------------- |
| Linearity                  | ✅ Estimation + Inference              | If model form is wrong, everything is off |
| No multicollinearity       | ✅ Estimation                          | Need invertible $X^TX$                    |
| Zero mean errors           | ✅ Estimation                          | Ensures unbiased $\hat\beta$              |
| Homoscedasticity           | ❌ Estimation<br>✅ Inference           | Affects standard errors                   |
| Independent errors         | ❌ Estimation<br>✅ Inference           | Affects validity of CI/p-values           |
| Normality of errors        | ❌ Estimation<br>✅ Inference (small n) | Needed for exact p-values                 |
| Exogeneity (Cov(X, ε) = 0) | ✅ Estimation + Inference              | If violated → biased $\hat\beta$          |

---

## 🧠 So what if assumptions are violated?

Let’s tweak our example:

### ❌ Violated Homoscedasticity:

Suppose error is small for students who study more, but large for those who study less.

| Student | x | y  | Error |
| ------- | - | -- | ----- |
| A       | 1 | 50 | -5    |
| B       | 2 | 55 | 0     |
| C       | 3 | 65 | 0     |
| D       | 4 | 70 | 0     |
| E       | 5 | 75 | +5    |

* Your line **still fits well** (estimation OK)
* But **standard errors are off**
* So your **confidence interval and p-value are wrong**
* You might wrongly conclude that "studying has a huge effect" — or miss that it does

---

## ✅ Conclusion

* **OLS estimation** is always possible → algebra only
* But for **interpreting** that estimate:

  * "Is it statistically significant?"
  * "How much uncertainty is there?"
  * "Can I trust this for the population?"

  👉 **That's where assumptions matter**

---

## 🔁 Want to try a code version?

I can show how the same estimate is produced under different assumptions (heteroscedastic vs homoscedastic) — but inference changes.

Would you like to see that in Python?
