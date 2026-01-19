# dynamic_assignments.md

Ah — now I understand exactly what you’re asking. Let’s clarify carefully.

You’re talking about **dynamic assignment to a JS object or `globalThis`** (i.e., **not using `@JS` / static interop**), like:

```dart
globalThis.foo = someValue;
```

---

### 1️⃣ What happens on the right-hand side?

* **Dynamic assignment is “JS-like”**: Dart will try to convert the value on the right-hand side to a JS-compatible value.

* **JS-compatible values include:**

  * Primitives: `int`, `double`, `bool`, `String` ✅
  * JS objects or functions ✅
  * Arrays / Lists via `jsify()` ✅
  * Maps via `jsify()` ✅

* **Dart-only objects** (plain Dart class instances) ❌ cannot be directly assigned; JS won’t understand them.

---

### 2️⃣ Example

```dart
import 'dart:js_interop_unsafe';

class Foo {
  String name = "dart";
}

void main() {
  // Primitives
  globalThis.myString = "hello"; // ✅ works
  globalThis.myNumber = 42;      // ✅ works
  globalThis.myBool = true;      // ✅ works

  // Function
  globalThis.sayHi = (String name) {
    print("Hi $name");
  }; // ✅ works

  // List / Map needs jsify for dynamic assignment
  globalThis.myList = jsify([1, 2, 3]); // ✅
  globalThis.myMap = jsify({"a": 1});   // ✅

  // Dart object
  globalThis.myObj = Foo(); // ❌ NOT automatically JS-compatible
}
```

---

### 3️⃣ Key takeaway

> For **dynamic assignment** to a JS object or `globalThis`:
>
> * **Primitives** (`int`, `double`, `bool`, `String`) ✅ work directly
> * **Functions** ✅ work
> * **Collections** (`List`/`Map`) ✅ need `jsify()`
> * **Dart-only objects** ❌ won’t work — must convert to JS-friendly type

So yes, **you can assign primitives directly**, because Dart automatically converts them to JS-compatible values in dynamic assignments — you don’t always need a JS-specific type on the right-hand side.

---

If you want, I can make a **small table showing exactly which Dart types can be directly assigned to JS objects in dynamic interop** — so you have a “one glance” reference. It’s very handy. Do you want me to do that?
