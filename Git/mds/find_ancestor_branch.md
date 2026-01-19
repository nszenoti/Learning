# find_ancestor_branch.md

Perfect! Let’s write a **standalone shell script** and then create an alias for it in iTerm/bash/zsh. This is cleaner and easier to maintain than embedding everything in an alias.

---

### 1️⃣ Create the shell script

Create a file called `git-find-parent.sh` somewhere in your PATH (e.g., `~/scripts/git-find-parent.sh`):

```bash
#!/bin/bash

# Check for argument
if [ -z "$1" ]; then
    echo "Usage: git-find-parent <branch>"
    exit 1
fi

BR="$1"

# Array to hold ancestor branches
PARENTS=()

# Loop through all branches except the target branch
for B in $(git for-each-ref --format="%(refname:short)" refs/heads | grep -v "^$BR$"); do
    if git merge-base --is-ancestor "$B" "$BR"; then
        PARENTS+=("$B")
    fi
done

# Pick the closest ancestor (most recent commit)
if [ ${#PARENTS[@]} -eq 0 ]; then
    echo "No parent branch found"
else
    LATEST_PARENT=""
    LATEST_COMMIT=0
    for P in "${PARENTS[@]}"; do
        HASH=$(git rev-parse "$P")
        COMMIT_TIME=$(git show -s --format=%ct "$HASH")
        if [ $COMMIT_TIME -gt $LATEST_COMMIT ]; then
            LATEST_COMMIT=$COMMIT_TIME
            LATEST_PARENT=$P
        fi
    done
    echo "Likely parent branch: $LATEST_PARENT"
fi
```

---

### 2️⃣ Make it executable

```bash
chmod +x ~/scripts/git-find-parent.sh
```

---

### 3️⃣ Create a convenient alias

Add this to your `~/.zshrc` or `~/.bashrc`:

```bash
alias git-find-parent="~/scripts/git-find-parent.sh"
```

Then reload your shell:

```bash
source ~/.zshrc   # or ~/.bashrc
```

---

### 4️⃣ Usage

```bash
git-find-parent F1
```

Output example:

```
Likely parent branch: main
```

---

✅ **Advantages of this approach**:

* Clean separation of logic into a script.
* Easy to update or enhance later.
* Alias is short and intuitive for daily use in iTerm.

---

If you want, I can also **enhance this script to handle remote branches**, so you can find the parent even if the branch was created from `origin/main` or any other remote.

Do you want me to do that?
