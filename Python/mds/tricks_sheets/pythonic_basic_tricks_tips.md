# pythonic_basic_tricks_tips

Oh nice 😎 you’re asking for the *Python “ninja syntax”* bag of tricks!
Here’s a collection of **standard + unique Python tricks** that every advanced developer should know — with quick examples:

---

## 🔹 1. Star `*` and Double Star `**` Unpacking

* Works with iterables and dicts.

```python
a, *b, c = [1, 2, 3, 4, 5]
# a=1, b=[2,3,4], c=5

nums = [1, 2, 3]
print(*nums)        # 1 2 3

d1 = {"x": 1}
d2 = {"y": 2}
print({**d1, **d2})  # {'x': 1, 'y': 2}
```

---

## 🔹 2. Underscore `_` Conventions

* **Last expression in REPL/IPython**

```python
>>> 10 + 20
30
>>> _ * 2
60
```

* **Ignore values**

```python
x, _, y = (1, 99, 3)   # ignore 99
```

* **Loop throwaway**

```python
for _ in range(3):  
    print("Hello")  # prints 3 times
```

* **Large number readability**

```python
million = 1_000_000
```

---

## 🔹 3. Tuple Tricks

* Swapping without temp vars:

```python
a, b = 10, 20
a, b = b, a
```

* Parallel assignment:

```python
x, y, z = [1, 2, 3]
```

---

## 🔹 4. Chained Comparisons

```python
if 0 < x < 10:   # instead of (0 < x and x < 10)
    ...
```

---

## 🔹 5. Extended Iterable Unpacking

```python
head, *middle, tail = [1, 2, 3, 4, 5]
# head=1, middle=[2,3,4], tail=5
```

---

## 🔹 6. Dict & Set Comprehensions

```python
squares = {x: x*x for x in range(5)}   # {0:0, 1:1, ...}
evens = {x for x in range(10) if x%2==0}
```

---

## 🔹 7. `for ... else`

```python
for num in [2, 3, 5, 7]:
    if num == 4:
        break
else:   # runs if no break
    print("No break hit")
```

---

## 🔹 8. F-String Tricks

```python
name = "Nipun"
print(f"{name=}")   # name='Nipun'
print(f"{10+5=}")   # 10+5=15
```

---

## 🔹 9. The Walrus Operator `:=`

```python
if (n := len("python")) > 5:
    print(n)  # prints 6
```

---

## 🔹 10. Slicing Hacks

```python
lst = [1,2,3,4,5]
print(lst[::-1])   # reverse [5,4,3,2,1]
print(lst[::2])    # every second [1,3,5]
```

---

## 🔹 11. Using `zip` with `*`

```python
pairs = [(1,'a'), (2,'b'), (3,'c')]
nums, chars = zip(*pairs)
# nums=(1,2,3), chars=('a','b','c')
```

---

## 🔹 12. `any()` and `all()`

```python
any([0, 1, 0])  # True if any is truthy
all([1, 2, 3])  # True if all are truthy
```

---

## 🔹 13. The `__missing__` in dict subclass

Custom default for missing keys.

```python
class MyDict(dict):
    def __missing__(self, key):
        return 0

d = MyDict(a=1)
print(d["b"])  # 0
```

---

## 🔹 14. Itertools Gems

```python
from itertools import groupby, combinations

print(list(combinations([1,2,3], 2)))  
# [(1,2),(1,3),(2,3)]
```

---

🔥 That’s a *starter pack* of “pythonic” tricks.
Do you want me to next **expand into advanced/hidden gems** (like `__slots__`, descriptors, `functools.lru_cache`, protocols, metaclasses)? Or keep this **syntax sugar–style collection** growing first?
