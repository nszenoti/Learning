Here's how to install packages from **conda-forge** using `conda` — both for single and multiple packages:

---

### ✅ **1. Single Package from conda-forge**

```bash
conda install -c conda-forge notebook
```

This installs `notebook` from the `conda-forge` channel.

---

### ✅ **2. Multiple Packages from conda-forge**

```bash
conda install -c conda-forge notebook ipykernel ipython numpy pandas
```

This installs **all listed packages** from `conda-forge`.

---

### ✅ **Optional: Set conda-forge as default channel (so you don’t repeat `-c` every time)**

```bash
conda config --add channels conda-forge
conda config --set channel_priority strict
```

Then you can just run:

```bash
conda install notebook ipykernel numpy pandas
```

> It will now **always prefer** conda-forge packages unless otherwise specified.

---

Would you like a complete `environment.yml` for a full LLM+Notebook setup using conda-forge?


---

conda install -c conda-forge --override-channels numpy pandas

