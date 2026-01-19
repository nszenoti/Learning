1_python_new_ds_featues

https://www.kimi.com/chat/19b9719d-bea2-82cb-8000-09fed1c2bbc3

You're right that there have been some significant data structure improvements in recent Python versions! Let me search for more specific information about Python 3.12 and 3.13 features as well.
Based on my research, here's a comprehensive overview of the key **data structure improvements** introduced in Python 3.9 through 3.13:

---

### **Python 3.9 (Major Data Structure Features)**

#### **1. Dictionary Merge & Update Operators**
```python
# Merge (|) - returns new dict
dict1 = {'a': 1, 'b': 2}
dict2 = {'b': 3, 'c': 4}
merged = dict1 | dict2  # {'a': 1, 'b': 3, 'c': 4}

# Update (|=) - in-place
dict1 |= dict2  # dict1 is now {'a': 1, 'b': 3, 'c': 4}
```

#### **2. Type Hinting Generics in Standard Collections**
No more `typing.List`, you can now use built-in types directly:
```python
def func(data: list[int]) -> dict[str, int]:
    return {str(i): i for i in data}
```

#### **3. New `graphlib` Module**
For topological sorting of graphs:
```python
from graphlib import TopologicalSorter

graph = {'D': {'B', 'C'}, 'C': {'A'}, 'B': {'A'}}
ts = TopologicalSorter(graph)
print(list(ts.static_order()))  # ['A', 'C', 'B', 'D']
```

#### **4. String Prefix/Suffix Removal**
```python
"HelloWorld".removeprefix("Hello")  # "World"
"HelloWorld".removesuffix("World")  # "Hello"
```

---

### **Python 3.10 (Major Data Structure Features)**

#### **1. Structural Pattern Matching** (Game-changer for data structures)
```python
# Match on dictionary structure
def process_user(user):
    match user:
        case {"name": str(name), "age": int(age)} if age >= 18:
            return f"Adult: {name}"
        case {"name": name}:
            return f"Minor: {name}"
        case _:
            return "Invalid user"

# Match on list structure
data = [1, 2, 3]
match data:
    case [x, y, z]:
        print(f"Three items: {x}, {y}, {z}")
    case [first, *rest]:
        print(f"First: {first}, Rest: {rest}")
```

#### **2. Parenthesized Context Managers**
```python
with (open('file1.txt') as f1, 
      open('file2.txt') as f2):
    # Work with both files
    pass
```

---

### **Python 3.11 (Performance & Minor Features)**

#### **1. Significant Performance Improvements**
- Faster list, dict, tuple operations (up to 10-25% speedup)
- Specializing adaptive interpreter optimizes data structure access patterns

#### **2. `tomllib` Module** (for parsing TOML files)
```python
import tomllib

with open("config.toml", "rb") as f:
    data = tomllib.load(f)  # Returns dict
```

---

### **Python 3.12 & 3.13**
- **No major new data structure methods** were added
- Focus on performance optimizations, typing improvements, and developer experience
- **Note**: The dictionary reverse operation you're thinking of **does not exist** as a built-in method

---

### **Regarding Dictionary "Reversal"**

There is **no new built-in method** to reverse key-value pairs. The standard approach remains:

```python
# For unique values
reversed_dict = {v: k for k, v in original.items()}

# For non-unique values (store keys in lists)
from collections import defaultdict
reversed_dict = defaultdict(list)
for k, v in original.items():
    reversed_dict[v].append(k)
```

**If you remember something specific about dictionary reversal methods, you might be thinking of either:**
1. The **merge operators** (`|`, `|=`) introduced in 3.9
2. **Structural pattern matching** capabilities in 3.10 that can destructure dictionaries

Is there a particular version or feature you had in mind?