# 2_api_usecases

Perfect — let's cut through everything and give you the **one true, up-to-date (Dart 3.7+, late 2025), non-deprecated, official guidance** for **Dart web development**.

---

## ✅ **Official, Non-Deprecated Stack for Dart Web (2025)**

| Use Case | ✅ **What to Use** | ❌ **Avoid** |
|--------|-------------------|-------------|
| **Standard browser APIs**<br>(`window.location`, `localStorage`, `fetch`, DOM, etc.) | → **`package:web`** | `dart:html`, `dart:js`, manual `@JS()` |
| **Calling JavaScript libraries / custom interop** | → **`package:js_interop`** (typed) **or** `package:js_interop_unsafe` (dynamic) | `package:js`, `dart:js`, `dart:js_util` (for new code) |
| **Global JS object (`window`)** | → **`globalContext` from `package:js_interop`** | `dart:js_util.globalContext`, `@JS('window')` |

---

### 🔹 1. **For Standard Web APIs → Use `package:web`**

This is the **official, type-safe, tree-shakeable**, Dart-native wrapper for browser APIs.

```yaml
# pubspec.yaml
dependencies:
  web: ^1.0.0
```

```dart
import 'package:web/web.dart' as web;

void main() {
  print(web.window.location.href);
  web.window.alert('Hello');
  web.localStorage.setItem('key', 'value');
}
```

✅ **Use this for**:  
- `window`, `document`, `localStorage`, `fetch`, `history`, `navigator`, etc.  
- Anything that’s a standard web platform API.

> 🟢 This is **actively maintained**, **not deprecated**, and **recommended by the Dart team**.

---

### 🔹 2. **For JavaScript Interop → Use `package:js_interop` (Typed) or `js_interop_unsafe` (Dynamic)**

The Dart team now splits interop into two packages:

#### A. **`package:js_interop`** → **Type-safe JS interop**
- Use when you can define JS interfaces (recommended).
- Fully static, null-safe, analyzer-friendly.

```yaml
dependencies:
  js_interop: ^0.4.0
```

```dart
import 'package:js_interop/js_interop.dart';

@JS()
extension Window on JSObject {
  JSObject get location => property<JSObject>('location');
}

@JS()
extension Location on JSObject {
  String get href => property<String>('href');
}

void main() {
  final href = globalContext.location.href; // ✅ type-safe
}
```

#### B. **`package:js_interop_unsafe`** → **Dynamic fallback**
- Use only when you **can’t define types** (e.g., calling unknown plugin APIs).
- Still modern, but skips static checks.

```yaml
dependencies:
  js_interop_unsafe: ^0.1.0
```

```dart
import 'package:js_interop_unsafe/js_interop_unsafe.dart';

void main() {
  dynamic window = globalContext;
  window.alert('Unsafe but works');
  print(window.location.href);
}
```

> ✅ Both are **official**, **non-deprecated**, and **the future**.

---

### 🔥 Critical: What’s **DEPRECATED** or **DISCOURAGED**

| Package / Library | Status | Why |
|------------------|--------|-----|
| `dart:html` | ❌ **Deprecated for new code** | Not tree-shakeable, too broad |
| `dart:js` | ❌ **Legacy** | Replaced by `js_interop` |
| `package:js` | ⚠️ **Soft-deprecated** | Still works, but no new features; Dart team migrating to `js_interop` |
| `dart:js_util` | ⚠️ **Legacy utility** | Still available, but **use `js_interop` instead** |
| `package:js_util` (pub) | ❌ Unofficial / obsolete | Not from Dart team |

> 🚫 **Do NOT use `@JS()` from `package:js` in new projects.**

---

### 🧭 Decision Flowchart (2025)

```text
Need to use browser API (location, localStorage, etc.)?
  │
  ├─ YES → Use `package:web`
  │
  └─ NO → Need to call JavaScript code?
         │
         ├─ Can define types? → Use `package:js_interop`
         │
         └─ Can't define types? → Use `package:js_interop_unsafe`
```

---

### 📌 Summary: The Only Three Packages You Need

1. **`web`** → for browser APIs  
2. **`js_interop`** → for typed JS interop  
3. **`js_interop_unsafe`** → for dynamic JS (last resort)

All three are:
- ✅ Official (published by `dart.dev`)
- ✅ Null-safe
- ✅ Actively maintained (as of Dec 2025)
- ✅ Compatible with Flutter Web and plain Dart web

---

### 🔗 Official Resources

- [`package:web`](https://pub.dev/packages/web)
- [`package:js_interop`](https://pub.dev/packages/js_interop)
- [`package:js_interop_unsafe`](https://pub.dev/packages/js_interop_unsafe)
- [Dart Web Interop Guide (2025)](https://dart.dev/web/js-interop)

---

Let me know your exact use case (e.g., "I need to call `window.ethereum` from MetaMask"), and I’ll give you the **exact modern code** using the right package.