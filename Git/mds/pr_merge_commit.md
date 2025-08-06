Yes — exactly! ✅

When you write:

```bash
git show <merge_commit>^1:path/to/file
```

It is **functionally equivalent** to:

```bash
git show <first_parent_hash>:path/to/file
```

So in your case:

* Merge commit: `abc123` (example)
* First parent: `d7c2a14b9`

Then both of these are the same:

```bash
git show abc123^1:path/to/file
```

and

```bash
git show d7c2a14b9:path/to/file
```

---

### 🔁 Why use `^1` syntax?

It’s handy when:

* You don’t want to manually copy the first parent’s hash.
* You’re scripting or automating something (e.g., `git log --merges` → pipe → `^1`).
* You want to explore commits interactively without manually jumping hashes.

---

### Bonus:

* `^1` → first parent (usually the base branch)
* `^2` → second parent (usually the PR branch tip)

You can even diff them:

```bash
git diff abc123^1 abc123^2 -- path/to/file
```

This shows what the PR did to that file.

Let me know if you'd like a simple alias or script for this!
