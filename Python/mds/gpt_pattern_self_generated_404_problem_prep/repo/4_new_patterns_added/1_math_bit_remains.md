# math_bit_remains.md

Perfect 👍
Below are **clean, minimal, interview-ready snippets** exactly like earlier — **drop-in templates**, no extra talk.

---

## 📁 `math_bit/modular_arithmetic.py`

```python
# Modular Arithmetic Helpers
# Common MOD: 10**9 + 7

MOD = 10**9 + 7


def add(a, b, mod=MOD):
    return (a + b) % mod


def sub(a, b, mod=MOD):
    return (a - b) % mod


def mul(a, b, mod=MOD):
    return (a * b) % mod


def power(base, exp, mod=MOD):
    """Fast exponentiation: O(log exp)"""
    res = 1
    base %= mod
    while exp:
        if exp & 1:
            res = res * base % mod
        base = base * base % mod
        exp >>= 1
    return res


def mod_inverse(a, mod=MOD):
    """Fermat's Little Theorem (mod must be prime)"""
    return power(a, mod - 2, mod)


def div(a, b, mod=MOD):
    """a / b under modulo"""
    return a * mod_inverse(b, mod) % mod


def factorials(n, mod=MOD):
    """Precompute factorials and inverse factorials"""
    fact = [1] * (n + 1)
    inv_fact = [1] * (n + 1)

    for i in range(1, n + 1):
        fact[i] = fact[i - 1] * i % mod

    inv_fact[n] = mod_inverse(fact[n], mod)
    for i in range(n, 0, -1):
        inv_fact[i - 1] = inv_fact[i] * i % mod

    return fact, inv_fact
```

---

## 📁 `math_bit/number_theory.py`

```python
# Number Theory Helpers

from math import gcd, isqrt


def lcm(a, b):
    return a * b // gcd(a, b)


def is_prime(n):
    if n <= 1:
        return False
    if n <= 3:
        return True
    if n % 2 == 0 or n % 3 == 0:
        return False
    i = 5
    while i * i <= n:
        if n % i == 0 or n % (i + 2) == 0:
            return False
        i += 6
    return True


def prime_factors(n):
    """Trial division: O(sqrt(n))"""
    factors = {}
    while n % 2 == 0:
        factors[2] = factors.get(2, 0) + 1
        n //= 2
    i = 3
    while i * i <= n:
        while n % i == 0:
            factors[i] = factors.get(i, 0) + 1
            n //= i
        i += 2
    if n > 1:
        factors[n] = factors.get(n, 0) + 1
    return factors


def sieve(n):
    """Sieve of Eratosthenes"""
    is_prime = [True] * (n + 1)
    is_prime[0] = is_prime[1] = False
    for i in range(2, isqrt(n) + 1):
        if is_prime[i]:
            for j in range(i * i, n + 1, i):
                is_prime[j] = False
    return is_prime


def spf_sieve(n):
    """Smallest Prime Factor sieve"""
    spf = list(range(n + 1))
    for i in range(2, isqrt(n) + 1):
        if spf[i] == i:
            for j in range(i * i, n + 1, i):
                if spf[j] == j:
                    spf[j] = i
    return spf


def divisors(n):
    """All divisors in O(sqrt(n))"""
    res = []
    for i in range(1, isqrt(n) + 1):
        if n % i == 0:
            res.append(i)
            if i != n // i:
                res.append(n // i)
    return res


def is_power_of_two(n):
    return n > 0 and (n & (n - 1)) == 0


def is_perfect_square(n):
    r = isqrt(n)
    return r * r == n
```

---

✅ These are **final-form snippets**
✅ Minimal, reusable, interview-safe
✅ Zero redundancy

Whenever ready, ask the **next file / pattern**.
