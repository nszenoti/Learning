# basics_plan

Perfect 👌 You’re basically asking:

> “Where do I start to **learn Unix shell basics** (bash/zsh/iTerm), so I can actually *understand and use* things like `.zshrc`, `xargs`, piping, dotfiles, etc.?”

That’s exactly the right mindset — most DevOps/Linux power comes from being comfortable in the shell. Let me guide you with a **practical learning roadmap** for iTerm/macOS/Linux shell.

---

## 🛠 Step 1: Get Comfortable with the Shell

* **What you’re learning**: navigation, file management, permissions.
* **Commands to start with**:

  * `ls`, `pwd`, `cd`, `mkdir`, `rm`, `cp`, `mv`
  * `cat`, `less`, `head`, `tail`
  * `chmod`, `chown`
  * `which`, `man`
* **Practice**:
  Try moving around (`cd`), create folders, copy files, inspect logs.

👉 Resource:

* [MIT Missing Semester: Shell Tools & Scripting (Lecture 1–3)](https://missing.csail.mit.edu/) – free, practical, modern.

---

## 🛠 Step 2: Understand Dotfiles (`.zshrc`, `.bashrc`, etc.)

* **What they are**: Hidden config files that load when your shell starts.

* `.zshrc` → config for zsh (default in macOS now).

* `.bashrc` → config for bash.

* `.gitconfig`, `.vimrc`, etc. → config for other tools.

* **Practice**:
  Add an alias in your `.zshrc`:

  ```bash
  alias gs='git status'
  ```

  Reload it with:

  ```bash
  source ~/.zshrc
  ```

👉 Resource:

* Blog post: *“Dotfiles are meant to be shared”* → [dotfiles.github.io](https://dotfiles.github.io/)

---

## 🛠 Step 3: Pipes, Redirection & Filters

* **What you’re learning**: chaining commands.

* Symbols:

  * `|` → pipe output to next command
  * `>` → redirect output to file
  * `>>` → append to file
  * `2>` → redirect errors

* **Practice**:

  ```bash
  cat /var/log/system.log | grep error | less
  ```

👉 Resource:

* Learn `grep`, `awk`, `sed` basics — they are your text superpowers.

---

## 🛠 Step 4: `xargs`, `find`, and Loops

* `find` → locate files
* `xargs` → run commands on them
* Shell `for` loops → automate things

**Example**: remove all `.DS_Store` files

```bash
find . -name ".DS_Store" -print0 | xargs -0 rm
```

---

## 🛠 Step 5: Shell Scripting Basics

* Learn writing small scripts (`.sh`) with:

  * `#!/bin/bash`
  * variables (`$VAR`)
  * conditionals (`if [ ... ]; then`)
  * loops (`for item in ...`)
* **Practice**: automate backup of your dotfiles.

👉 Resource:

* [Bash Guide for Beginners](https://tldp.org/LDP/Bash-Beginners-Guide/html/)
* MIT Missing Semester (Shell Scripting lecture)

---

## 🛠 Step 6: Power Up iTerm2

Since you’re on macOS with iTerm:

* Explore **splits & tabs** (`⌘D`, `⌘Shift+D`)
* Use **search, autocomplete, profiles**
* Install **oh-my-zsh** or **zinit** → plugins like `zsh-autosuggestions`, `zsh-syntax-highlighting`.

---

## 🛠 Step 7: Git + Shell Integration

* Learn `git` commands in terminal (`git status`, `git add`, `git log`).
* Customize prompt in `.zshrc` to show branch.

---

🔥 **Learning Style I’d Suggest for You (practical approach)**:

1. Go through **MIT Missing Semester (lectures 1–4)** → that will give you the “aha!” basics.
2. Every day in iTerm, pick one **new command** and actually use it (`grep`, `find`, `xargs`, `alias`, `awk`).
3. Start maintaining your own **dotfiles repo** (`.zshrc`, `aliases.sh`, `gitconfig`).

---

Do you want me to create a **daily 15-day practice plan** for you (like “Day 1: navigation + aliases, Day 2: redirection + pipes, … Day 15: write your first dotfile backup script”)? That way you’ll build muscle memory step by step.
