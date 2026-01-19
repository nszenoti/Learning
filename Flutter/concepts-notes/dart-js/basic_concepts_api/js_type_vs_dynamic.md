# js_type_vs_dynamic

Great question — and critical for writing **safe, maintainable Dart web code in 2025**.

The difference between **`js_interop` (typed)** and **`js_interop_unsafe` (dynamic/unsafe)** boils down to:

> ✅ **Static type safety vs dynamic runtime access**

Let’s break it down clearly.

---

## 🔹 1. **`package:js_interop` → Typed (Safe)**

### ✅ What you get:
- **Compile-time type checking**
- **Autocomplete & refactoring support**
- **Null safety enforcement**
- **Tree-shaking friendly**
- **Analyzer warnings** if you misuse JS APIs

### 🔧 How it works:
You **declare JavaScript interfaces** using `@JS()` and Dart types (`JSObject`, `JSFunction`, `JSArray`, etc.). The Dart compiler treats them like real types.

### 💡 Example: Safe access to `window.location.href`

```dart
import 'package:js_interop/js_interop.dart';

// Declare JS interfaces
@JS()
extension Window on JSObject {
  JSObject get location => property<JSObject>('location');
}

@JS()
extension Location on JSObject {
  String get href => property<String>('href');
}

void main() {
  // Fully typed, no 'dynamic'
  String url = globalContext.location.href;
  print(url); // ✅ Safe, analyzed, tree-shakeable
}
```

> 🔍 The Dart analyzer knows `href` is a `String`. If you typo it → **compile error**.

---

## 🔹 2. **`package:js_interop_unsafe` → Dynamic (Unsafe)**

### ⚠️ What you get:
- **No static types** → everything is `dynamic`
- **Runtime-only errors** (failures happen in browser, not at compile time)
- **No autocomplete or refactoring**
- **Bypasses Dart’s null safety** for JS objects
- **Useful for quick prototyping or unknown APIs**

### 💡 Example: Same goal, but unsafe

```dart
import 'package:js_interop_unsafe/js_interop_unsafe.dart';

void main() {
  // globalContext is 'dynamic'
  dynamic window = globalContext;
  String url = window.location.href; // 🚨 No compile-time check!
  print(url);
}
```

> ❌ If `window.locaation.href` (typo), you get a **runtime JS error** — your app breaks in the browser.

---

## 🔍 Key Differences (Side by Side)

| Feature | `js_interop` (Typed) | `js_interop_unsafe` (Dynamic) |
|--------|------------------------|-------------------------------|
| **Type safety** | ✅ Compile-time | ❌ Runtime only |
| **Null safety** | ✅ Enforced | ❌ Bypassed |
| **Tooling support** | ✅ Autocomplete, go-to-def, rename | ❌ None |
| **Error detection** | ✅ At build time | ❌ Only in browser |
| **Performance** | ✅ Better (optimized calls) | ⚠️ Slightly slower (dynamic dispatch) |
| **Use case** | Production, stable JS APIs | Prototyping, unknown/complex JS libs |
| **Tree-shaking** | ✅ Yes | ⚠️ Limited |

---

## 🛑 When to Use Which?

### ✅ Use **`js_interop` (typed)** when:
- You’re calling a **known JS API** (e.g., `window`, `localStorage`, `WebGL`, `Stripe.js`, etc.)
- You’re building **production apps**
- You want **refactorability and safety**

### ⚠️ Use **`js_interop_unsafe`** only when:
- You’re **experimenting**
- The JS library is **too dynamic** (e.g., returns arbitrary nested objects)
- You **can’t define a stable interface** (e.g., plugin system with unknown shapes)
- You’re **migrating legacy code** temporarily

> 🔥 **Best practice**: Start with `js_interop_unsafe` to explore, then **migrate to `js_interop`** once you understand the JS shape.

---

## 💡 Pro Tip: Mix Both (Safely)

You can even **use `js_interop_unsafe` to inspect**, then define types:

```dart
// Step 1: Explore
import 'package:js_interop_unsafe/js_interop_unsafe.dart';
void debug() {
  print(globalContext.someLib.version); // see what it returns
}

// Step 2: Lock it down with types
import 'package:js_interop/js_interop.dart';
@JS()
extension SomeLib on JSObject {
  String get version => property<String>('version');
}
```

---

## ✅ Bottom Line

| Goal | Recommendation |
|------|----------------|
| **Production code** | → **`js_interop` (typed)** |
| **Quick hack / unknown API** | → **`js_interop_unsafe`**, but plan to type it later |
| **Standard browser APIs** | → **Don’t use either! Use `package:web` instead** |

---

Let me know the JS API you're working with (e.g., `window.ethereum`, `google.maps`, etc.), and I’ll write you the **exact typed `js_interop` version**!