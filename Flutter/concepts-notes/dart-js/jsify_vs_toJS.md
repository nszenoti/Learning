# jsify_vs_toJS

Perfect! Here's a **concise Dart → JS interop cheat sheet** tailored for Flutter Web, covering `toJS`, `jsify`, and `allowInterop`.

````{"id":"81102","variant":"standard","subject":"Dart → JS Interop Cheat Sheet"}  
# 🌐 Dart → JS Interop Cheat Sheet (Flutter Web)

---

## 1️⃣ `.toJS` (Static / typed interop)

| Dart Type | Can use `.toJS`? | Notes |
|-----------|-----------------|-------|
| `JSString`, `JSNumber`, `JSBoolean` | ✅ | Already JS interop types |
| `List<T extends JSAny>` | ✅ | Converts Dart List → JSArray |
| `String`, `int`, `double`, `bool` | ❌ | Use directly in JS function call instead of wrapping list |
| `Map<String, dynamic>` | ❌ | Use `jsify()` instead |
| Custom Dart objects | ❌ | Convert manually or wrap |

**Key point:** `.toJS` converts **lists or objects already typed as JS interop types**.  
Does **not** convert primitives or maps inside a list automatically.

**Example:**

```dart
import 'dart:js_interop';

final jsList = <JSString>['a'.toJS, 'b'.toJS].toJS;
```

---

## 2️⃣ `jsify()` (Dynamic / JSON-like interop)

| Dart Type | Supported? |
|-----------|-----------|
| `Map<String, dynamic>` | ✅ |
| `List<dynamic>` | ✅ |
| Nested lists/maps | ✅ |
| Primitive types (`String`, `int`, `bool`) | ✅ (auto converted) |
| Functions / callbacks | ❌ (use `.allowInterop`) |

**Example:**

```dart
import 'dart:js_interop_unsafe';

final dartMap = {
  'name': 'John',
  'age': 30,
  'tags': ['flutter', 'web']
};

final jsObj = dartMap.jsify(); // Converts to JS object recursively
```

---

## 3️⃣ `allowInterop()` (Callbacks / functions)

- Use this to **expose Dart functions to JS**.
- Needed when passing a Dart function to JS dynamically.

**Example:**

```dart
import 'dart:js_util';

void dartCallback(String msg) {
  print('From JS: $msg');
}

final jsFunction = allowInterop(dartCallback);

// Now JS can call jsFunction
```

- Works for single functions or for functions inside `jsify` maps/lists.

---

## 4️⃣ Combining `.toJS`, `jsify`, `allowInterop`

| Scenario | Approach |
|----------|---------|
| Passing Dart **primitive list** to JS function | `.map((e) => e).toList()` or `jsify(list)` |
| Passing Dart **Map<String, dynamic>** | `jsify(map)` |
| Passing Dart **function** | `allowInterop(fn)` |
| List/Map containing functions | `jsify(map/list with allowInterop(fn))` |
| Exposing typed callback globally | `@JS() external set myCallback(JSFunction f); myCallback = fn.toJS;` |

---

### 🔑 **Rule of Thumb**

1. Use **`.toJS`** only when the list or object is **already JS interop type**.  
2. Use **`jsify()`** for JSON-like Dart structures (`Map<String, dynamic>` or `List<dynamic>`).  
3. Use **`allowInterop()`** for Dart functions passed to JS.  
4. Wrap all JS interop code inside `core/platform/web/` folder for clean architecture.

---

This cheat sheet covers 99% of Flutter Web interop scenarios and keeps code safe, typed, and maintainable.  
````
