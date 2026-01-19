# Kimi_5_math_cheatsheet

# **Math & Bit Manipulation Cheat Sheet for DSA**

### **Bitwise Operators** (Essential for Optimization)

```python
# Basic operators
x << 1      # Multiply by 2
x >> 1      # Divide by 2 (floor)
x & 1       # Check odd/even (0=even, 1=odd)
x & (x-1)   # Clear least significant set bit
x & -x      # Get lowest set bit
x | (x+1)   # Set lowest zero bit

# Common patterns
if n & (n-1) == 0:  # Power of 2 check
if x & (1 << i):    # Check ith bit
x ^= 1 << i         # Toggle ith bit

# Count set bits (Population Count)
def popcount(n):
    count = 0
    while n:
        n &= n - 1  # Clear LSB
        count += 1
    return count

# Python 3.10+ built-in
count = n.bit_count()  # Much faster

# XOR properties
# a ^ a = 0, a ^ 0 = a, swap without temp: a, b = b, a = a ^ b ^ b
missing = reduce(xor, nums) ^ reduce(xor, range(1, n+1))  # Missing number
```

---

### **Math Module Essentials**

```python
import math

# Constants
inf = float('inf'); n_inf = -math.inf

# Integer operations
gcd = math.gcd(a, b)              # Greatest common divisor
lcm = a * b // math.gcd(a, b)     # Least common multiple
sqrt = int(math.isqrt(n))         # Integer sqrt (Python 3.8+)

# Combinatorics (Python 3.8+)
nCk = math.comb(n, k)             # Exact integer combination
nPk = math.perm(n, k)             # Permutation

# Trigonometry (rare)
math.radians(deg); math.degrees(rad)

# Logarithms
log2 = math.log2(n); log10 = math.log10(n)
ln = math.log(n); log_custom = math.log(n, base)

# Ceil/Floor
math.ceil(2.1); math.floor(2.9)
```

---

### **Number Theory Helpers**

```python
# Prime check (O(sqrt(n)))
def is_prime(n):
    if n < 2: return False
    if n % 2 == 0: return n == 2
    for i in range(3, int(math.sqrt(n)) + 1, 2):
        if n % i == 0: return False
    return True

# Sieve of Eratosthenes
def sieve(n):
    is_prime = [True] * (n + 1)
    is_prime[0:2] = [False, False]
    for i in range(2, int(math.sqrt(n)) + 1):
        if is_prime[i]:
            for j in range(i*i, n + 1, i):
                is_prime[j] = False
    return is_prime

# Prime factorization
def prime_factors(n):
    factors = []
    d = 2
    while d * d <= n:
        while n % d == 0:
            factors.append(d)
            n //= d
        d += 1
    if n > 1: factors.append(n)
    return factors

# Extended GCD (for modular inverse)
def egcd(a, b):
    if b == 0: return (a, 1, 0)
    g, x1, y1 = egcd(b, a % b)
    return (g, y1, x1 - (a // b) * y1)

# Modular inverse
def mod_inv(a, m):
    g, x, _ = egcd(a, m)
    return x % m if g == 1 else None
```

---

### **Combinatorics & Probability**

```python
# Factorial
import math
fact = math.factorial(n)  # n!

# But factorial grows fast - use iterative for large n
def factorial_mod(n, mod):
    res = 1
    for i in range(2, n + 1):
        res = (res * i) % mod
    return res

# Pascal's Triangle (n choose k)
def pascal_triangle(n):
    triangle = [[1]]
    for i in range(1, n):
        row = [1]
        prev = triangle[-1]
        row.extend(prev[j] + prev[j+1] for j in range(len(prev)-1))
        row.append(1)
        triangle.append(row)
    return triangle

# Stars and Bars: Distribute n identical items into k bins
# Formula: C(n + k - 1, k - 1)
def count_combinations(n, k):
    return math.comb(n + k - 1, k - 1)
```

---

### **Matrix Operations**

```python
# Create identity matrix
I = [[1 if i == j else 0 for j in range(n)] for i in range(n)]

# Matrix transpose
transpose = list(zip(*matrix))

# Matrix multiplication
def mat_mult(A, B):
    return [[sum(a * b for a, b in zip(row, col)) for col in zip(*B)] for row in A]

# Matrix power (for recurrence relations)
def mat_pow(M, power):
    result = [[1 if i == j else 0 for j in range(len(M))] for i in range(len(M))]
    while power:
        if power & 1:
            result = mat_mult(result, M)
        M = mat_mult(M, M)
        power >>= 1
    return result

# Rotate matrix 90 degrees
rotated = [list(reversed(col)) for col in zip(*matrix)]
```

---

### **Advanced: Modular Arithmetic**

```python
MOD = 10**9 + 7

# Fast mod operations
def add_mod(a, b, mod=MOD):
    return (a + b) % mod

def mul_mod(a, b, mod=MOD):
    return (a * b) % mod

# Mod exponentiation
def pow_mod(base, exp, mod=MOD):
    result = 1
    while exp:
        if exp & 1:
            result = (result * base) % mod
        base = (base * base) % mod
        exp >>= 1
    return result

# Precompute factorials modulo MOD (common pattern)
MAX_N = 10**5
fact = [1] * (MAX_N + 1)
for i in range(2, MAX_N + 1):
    fact[i] = fact[i-1] * i % MOD
```

---

**Next:** Would you like a **"Problem-Solving Strategy"** cheat sheet (how to approach different problem types)?