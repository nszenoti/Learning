# dart_js_interop_cheatsheet

# Dart ↔ JS Interop Cheat Sheet (Modern Flutter Web)

### 1️⃣ Import

```dart
import 'dart:js_interop_unsafe';
```

`globalThis` is available directly; no `@JS()` needed for dynamic assignment.

---

### 2️⃣ Assigning Primitives

```dart
globalThis.myString = "Hello JS";
globalThis.myNumber = 42;
globalThis.myBool = true;
```

* ✅ Works directly, JS sees them as standard JS types.

---

### 3️⃣ Assigning Functions

```dart
globalThis.sayHello = (String name) {
  print("Hello from Dart, $name!");
};

// JS can call: globalThis.sayHello("JS");
```

* Dart function is automatically callable from JS.
* Arguments and return types should be JS-compatible.

---

### 4️⃣ Assigning Arrays / Lists

```dart
List<int> dartList = [1, 2, 3];
globalThis.jsArray = dartList; // Works if primitive list
```

* For complex objects, convert:

```dart
import 'dart:js_util_unsafe' as js_util;

Map<String, dynamic> dartMap = {"a": 1, "b": 2};
globalThis.jsObj = js_util.jsify(dartMap);
```

---

### 5️⃣ Assigning Maps / Objects

* Only **JS-compatible objects** can be assigned.

```dart
import 'dart:js_util_unsafe' as js_util;

Map<String, dynamic> user = {"name": "Alice", "age": 25};
globalThis.user = js_util.jsify(user); // converts to JS object
```

---

### 6️⃣ Reading from JS

```dart
var value = globalThis.someProp; // dynamic
```

* Returns a dynamic JS-compatible value.

---

### 7️⃣ Notes & Caveats

* **Dart-only classes** cannot be assigned directly; wrap as `Map` or `JS object`.
* **Functions** must use JS-compatible argument/return types.
* For typed bindings / production use, consider `@JS()` + `external` declarations.

---

### 8️⃣ Quick Examples

```dart
// Dart callback
globalThis.alertFromDart = (String msg) => window.alert(msg);

// Assign primitive
globalThis.version = 1.0;

// JS array from Dart list
globalThis.items = [1, 2, 3];

// JS object from Dart map
globalThis.config = js_util.jsify({"theme": "dark", "debug": true});
```

---

This covers most **real-world JS ↔ Dart bridging scenarios** in modern Flutter Web.
