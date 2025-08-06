Absolutely! Here's a concise and **wholesome Git guide** to help you easily refer back in the future — explaining **how to get the old version of a file from before a PR** and the **meaning of merge commit parents**.

---

## 🔧 Git Guide: Get Old File Version from Before a PR Merge

### 🧠 **Context**

When a Pull Request (PR) is merged via a **merge commit**, Git creates a commit with **two parents**.

### 📦 Merge Commit Anatomy

Run this to inspect the merge commit:

```bash
git show <merge_commit_hash>
```

You’ll see:

```
Merge: <parent1_hash> <parent2_hash>
```

Example:

```
Merge: d7c2a14b9 4c8ed29ef
```

#### ✅ What does this mean?

* `d7c2a14b9` → **First parent**: the commit from the base branch (e.g. `main`) **before the PR was merged**
* `4c8ed29ef` → **Second parent**: the **last commit on the feature/PR branch** before it was merged

---

## 🎯 Goal: Get the file as it existed before the PR

### 📄 View the file before PR changes:

```bash
git show <merge_commit>^1:path/to/file
```

OR (equivalent):

```bash
git show <first_parent_hash>:path/to/file
```

This shows the **clean version of the file before the PR touched it**.

---

### 💾 Save the old version locally:

```bash
git show <merge_commit>^1:path/to/file > pre_pr_file.dart
```

---

### 🔄 Restore that version into your working directory:

```bash
git checkout <merge_commit>^1 -- path/to/file
```

⚠️ This will **replace the current working version** with the old one (unstaged).

---

## 🧠 Bonus Knowledge

| Syntax           | Meaning                              |
| ---------------- | ------------------------------------ |
| `<merge>^1`      | First parent = base branch before PR |
| `<merge>^2`      | Second parent = PR tip before merge  |
| `git diff ^1 ^2` | Shows what the PR changed            |

### 🔍 Example:

```bash
git diff abc123^1 abc123^2 -- lib/foo/bar.dart
```

Shows the exact change to that file introduced by the PR.

---

### 🧪 How to Find the Merge Commit:

If you don’t know the hash:

```bash
git log --merges --oneline
```

Look for your PR title or number.

---

## ✅ Quick Summary:

| Task                          | Command Example                                     |
| ----------------------------- | --------------------------------------------------- |
| Find merge commits            | `git log --merges --oneline`                        |
| View old file before PR       | `git show <merge_commit>^1:path/to/file`            |
| Save old file to disk         | `git show <merge_commit>^1:path/to/file > old.dart` |
| Restore old file to workspace | `git checkout <merge_commit>^1 -- path/to/file`     |

---

Let me know if you'd like this in markdown or a PDF — or added as a snippet/alias in your terminal setup!
