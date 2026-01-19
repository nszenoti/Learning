# 1_web_vs_globalcontext.md

Here is the **correct, modern, Dart-2025 explanation** of:

# ✅ **When to use `globalContext` vs when to use `package:web`**

---

# 1️⃣ **Where does `globalContext` come from?**

### `globalContext` exists in:

✔ **`dart:js_interop_unsafe`**
✔ **`dart:js_interop`** (as `globalThis`)

Depending on the import:

```dart
import 'dart:js_interop_unsafe' as jsu;

jsu.globalContext;   // old name (still available)
jsu.globalThis;      // preferred new name
```

OR:

```dart
import 'dart:js_interop' as js;

js.globalThis;       // safe version
```

👉 **Preferred modern API name = `globalThis`**
(`globalContext` is just backward-compatible alias.)

---

# 2️⃣ **What is `globalThis` / `globalContext`?**

It is the **raw JS global object**, exactly like JavaScript's:

```js
globalThis  // window in browser
```

In Dart, this is the entry point for:

* Adding global JS functions
* Storing Dart callbacks into JS
* Accessing global JS variables dynamically
* Calling arbitrary JS libraries not exposed in `package:web`

Example:

```dart
jsu.globalThis.setProperty('myFunc', myDartFunc.toJS);
```

This is low-level, dynamic, no static checking.

---

# 3️⃣ **What is `package:web`?**

`package:web` is **typed** Web API bindings for the browser.

It gives you:

* `Window`
* `Document`
* `Element`
* `HTMLElement`
* `Navigator`
* `Fetch API`
* `Geolocation`
* `History`
* `Location`
* …and 700+ DOM interfaces

Example:

```dart
import 'package:web/web.dart';

window.document.body!.append(Element.div()..innerText = "Hello");
```

This is **safe**, **typed**, **recommended**.

---

# 4️⃣ **When should you use which?**

## ✔ Use **`package:web`** when:

### You are interacting with standard Web APIs.

Examples:

* DOM manipulation (`document`, `querySelector`)
* Fetch API
* LocalStorage / SessionStorage
* Event listeners
* History API
* HTMLCanvas
* WebWorkers
* Anything normally provided by browser

This replaces all old `@JS('window')` patterns.

---

## ✔ Use **`globalThis/globalContext`** when:

### You interact with *non-Web API JS*, such as:

* JS libraries not covered by `package:web`
* Your own JS injected into the page
* Third-party scripts (Stripe, Razorpay, Firebase JS, etc.)
* Defining globals or bridges

Example: Use Dart to attach your callback to JS:

```dart
jsu.globalThis['onLogin'] = loginCallback.toJS;
```

Example: Calling a JS library:

```dart
final result = jsu.callMethod(jsu.globalThis['firebase'], 'initializeApp', [config]);
```

---

# 5️⃣ Summary Cheat Table

| Task                                   | Use           | Why                      |
| -------------------------------------- | ------------- | ------------------------ |
| Access DOM (`window/document`)         | `package:web` | Type safe, modern        |
| Call browser APIs                      | `package:web` | Official WebIDL bindings |
| Call arbitrary JS functions            | `globalThis`  | Dynamic interop          |
| Attach Dart callback to JS             | `globalThis`  | Only way                 |
| Access custom JS loaded via script tag | `globalThis`  | Not in WebIDL            |
| Read/write global variables            | `globalThis`  | JS global namespace      |
| Call legacy JS code                    | `globalThis`  | Required                 |
| Define JS function from Dart           | `globalThis`  | Required                 |

---

# 6️⃣ Quick rule-of-thumb

### 👉 **If it's in MDN → use `package:web`.**

### 👉 **If it's your JS or 3rd-party JS → use `globalThis`.**

---

If you want, I can create a **JS interop “decision tree”** so you instantly know which API to use in any case.
