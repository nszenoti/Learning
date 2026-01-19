# git_basic_day_to_day_commdnad

That’s a solid step 👍 — once you get comfortable with Git in the terminal, you’ll have more control, speed, and flexibility than any GUI client. Let’s build this in two parts:

1. **Core Git commands you should remember (day-to-day)**
2. **Helpful aliases for iTerm/zsh to make life easier**

---

## 🔑 Core Git Commands (Day-to-Day Workflow)

Here’s a practical flow you’ll use most often:

### 1. **Check Repo Status & Info**

```bash
git status             # See changed files, staged, unstaged
git log --oneline --graph --decorate --all   # Pretty history
git branch             # List branches
git branch -r          # Remote branches
```

### 2. **Cloning & Pulling**

```bash
git clone <url>        # Clone repo
git pull               # Get latest from remote (merge)
git fetch              # Fetch refs without merging
git fetch --prune      # Clean deleted branches
```

### 3. **Branching**

```bash
git checkout -b feature-x     # Create + switch branch
git checkout main             # Switch back
git switch -c hotfix-1        # New way (recommended)
git branch -d feature-x       # Delete local branch
git push origin --delete feature-x   # Delete remote branch
```

### 4. **Staging & Committing**

```bash
git add file.txt        # Stage one file
git add .               # Stage all
git restore --staged file.txt   # Unstage
git commit -m "Message" # Commit
```

### 5. **Pushing**

```bash
git push origin branch-name   # Push branch
git push                      # Push default tracking branch
```

### 6. **Undo / Fix Things**

```bash
git checkout -- file.txt     # Discard changes in file
git reset HEAD~1             # Undo last commit, keep changes
git reset --hard HEAD~1      # Undo last commit, discard changes
git revert <commit-hash>     # Revert commit (safe, makes new commit)
```

### 7. **Merging & Rebasing**

```bash
git merge branch-name        # Merge branch into current
git rebase main              # Replay commits on top of main
git rebase -i HEAD~3         # Interactive rebase last 3 commits
```

---

## ⚡ Aliases for Faster Workflow

You can add aliases in your `~/.zshrc` or `~/.gitconfig`.

### Option 1: **Shell Aliases (zshrc)**

Add these in `~/.zshrc`:

```bash
alias gs="git status"
alias gl="git log --oneline --graph --decorate --all"
alias gb="git branch"
alias gco="git checkout"
alias gcb="git checkout -b"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gpl="git pull"
alias gdf="git diff"
alias gcm="git checkout main"
```

Then reload:

```bash
source ~/.zshrc
```

### Option 2: **Git Config Aliases**

Add in `~/.gitconfig`:

```ini
[alias]
  st = status
  co = checkout
  cob = checkout -b
  br = branch
  cm = commit -m
  lg = log --oneline --graph --decorate --all
  df = diff
  pl = pull
  ps = push
```

Then you can do:

```bash
git st
git lg
git cob new-feature
```

---

👉 Suggestion: Start **without aliases** for a week so you get muscle memory of real commands. Then add aliases to save typing once you’re fluent.

Would you like me to create a **daily practice cheat-sheet (one scenario per day for a week)** so you can get used to using only terminal Git?
