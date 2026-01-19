# add_alias_to_git_config

Perfect! Let’s create a **Git alias** that shows only the commits unique to a branch compared to its parent branch. This way, you can quickly see the “branch-only” commits.

---

### 1️⃣ Add alias in your Git config

Run this in your terminal:

```bash
git config --global alias.log-branch '!f() { git log --oneline --graph --decorate $2..$1; }; f'
```

---

### 2️⃣ How it works

```bash
git log-branch F1 M1
```

* `$1` → branch you want to inspect (`F1`)
* `$2` → base/parent branch (`M1`)
* `--oneline` → concise view
* `--graph --decorate` → shows branch structure & labels
* `$2..$1` → commits reachable from `F1` but not from `M1`

---

### 3️⃣ Example

```
* a1b2c3d (HEAD -> F1) Add new login feature
* 4e5f6g7 Update README for feature
* 8h9i0j1 Fix typo in docs
```

* Only shows commits **unique to F1**, ignoring everything that came from M1.

---

If you want, I can also make a **slightly fancier version** that **colors branch names and dates** so it’s very easy to read at a glance — basically a “super clean branch log” for everyday use.

Do you want me to do that?
