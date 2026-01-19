# 15_day_shell_plan

Exactly 🎯 — it’s **not as complicated** as it first looks. Once you start practicing daily, shell commands will feel natural, and things like `.zshrc`, `xargs`, and dotfile tricks will become second nature.

Let me set you up with a **15-day practice roadmap** (≈15–20 mins per day). Each day has a *concept + hands-on exercise*.

---

# 🗂️ 15-Day Shell Learning Plan

### **Day 1: Navigation Basics**

* Learn: `pwd`, `ls -la`, `cd`, `mkdir`, `rmdir`
* Exercise:

  * Create a folder `practice-shell` in your home.
  * Inside it, make `day1/notes`, `day1/images`.
  * Move in and out with `cd`.

---

### **Day 2: File Operations**

* Learn: `touch`, `cp`, `mv`, `rm`
* Exercise:

  * Create a file `hello.txt` with `echo "Hello Shell!" > hello.txt`.
  * Copy → rename → delete it.

---

### **Day 3: Viewing Files**

* Learn: `cat`, `less`, `head`, `tail`, `wc -l`
* Exercise:

  * Download a log file (or use `/var/log/system.log`).
  * View first 20 lines, last 20 lines, count lines.

---

### **Day 4: Redirection & Pipes**

* Learn: `>`, `>>`, `|`, `2>`
* Exercise:

  * `echo "test error" >&2`
  * Redirect normal output vs error to different files.
  * Pipe output of `ls` to `less`.

---

### **Day 5: Searching with `grep`**

* Learn: `grep`, `grep -i`, `grep -r`
* Exercise:

  * Search for "error" in `/var/log/system.log`.
  * Make it case-insensitive.
  * Count matches with `grep -c`.

---

### **Day 6: Finding Files**

* Learn: `find`, `locate` (if available)
* Exercise:

  * Find all `.txt` files under `practice-shell`.
  * Find all files bigger than 1 MB.

---

### **Day 7: `xargs` Basics**

* Learn: `xargs -n1`, `-0`, using with `find`
* Exercise:

  * `echo "one two three" | xargs -n1 echo ITEM:`
  * Delete `.DS_Store` with `find . -name ".DS_Store" -print0 | xargs -0 rm`.

---

### **Day 8: Permissions**

* Learn: `ls -l`, `chmod`, `chown`
* Exercise:

  * Create a script, make it non-executable, then add `+x` to run it.

---

### **Day 9: Environment & Dotfiles**

* Learn: `echo $PATH`, `.bashrc`, `.zshrc`
* Exercise:

  * Add `alias ll="ls -la"` in `~/.zshrc`.
  * Reload with `source ~/.zshrc`.
  * Try your new alias.

---

### **Day 10: Variables**

* Learn: `export`, `$VAR`, `set`, `env`
* Exercise:

  * Create `NAME="Nipun"` and print it.
  * Add `export NAME="Nipun"` to `.zshrc` so it’s always available.

---

### **Day 11: Command Substitution**

* Learn: `` `command` `` or `$(command)`
* Exercise:

  * `echo "Today is $(date)"`
  * Save disk usage to a variable: `USAGE=$(df -h / | tail -1 | awk '{print $5}')`.

---

### **Day 12: Writing a Script**

* Learn: `#!/bin/bash`, running `.sh` files
* Exercise:

  * Write a `backup.sh` that copies `.zshrc` into a `backup/` folder with a timestamp.

---

### **Day 13: Loops**

* Learn: `for ... in ...; do ...; done`
* Exercise:

  * Loop through `file1 file2 file3` and print their names.
  * Extend your `backup.sh` to back up multiple dotfiles.

---

### **Day 14: Conditions**

* Learn: `if [ -f file ]`, `if [ -d dir ]`
* Exercise:

  * Write a script that checks if `~/.zshrc` exists, then prints "found" or "not found".

---

### **Day 15: Your Own Dotfile Manager**

* Exercise:

  * Write a script that:

    1. Saves `.zshrc`, `.bashrc`, `.gitconfig` to `setup-backup/`
    2. Restores them on a new machine.

🎉 Now you’ll have a **practical workflow to set up any new Mac/Linux machine fast**.

---

👉 Would you like me to actually **build the Day 12–15 scripts for you** (backup + restore dotfiles)? That way you’ll just need to run them and inspect how they work while you learn.
