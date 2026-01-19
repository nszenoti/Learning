# static_vs_dynamic

**Correct.**

**Static `@JS()` declarations** (compile-time known):
```dart
@JS()
external void foo(String s); // ✅ Auto-converts String → JSString
```

**Dynamic `JSObject` assignments** (runtime):
```dart
web.window['key'] = 'value'; // ❌ Error - must be JS type
web.window['key'] = 'value'.toJS; // ✅ Manual conversion required
```

**Rule**: Dynamic binding bypasses compile-time checks → **you must always convert manually**.



## Static vs Dynamic Auto Conversion


Excellent question! This gets to the very heart of how the new `dart:js_interop` system is designed.

The short answer is: **Yes, the automatic primitive conversion works in both cases.**

The `dart:js_interop` system is designed to be consistent. The conversion is a fundamental feature of the **interop boundary itself**, not a feature of the `@JS` annotation specifically.

Let's break down why.

---

### The Core Principle: The Interop Boundary

Think of the "interop boundary" as a gate between Dart and JavaScript. Any time data passes through this gate, the `dart:js_interop` system inspects it and performs a conversion if possible.

The way you *open* the gate doesn't change the rules for what can pass through it.

1.  **`@JS` Annotation (Static Binding):** This is like creating a permanent, named door in the gate. The `@JS()` annotation tells the compiler, "This Dart code represents a specific thing on the other side of the gate." When you use the setter `exportedFunction = ...`, you are passing a value through that pre-defined door.

2.  **`JSObject` (Dynamic Binding):** This is like creating a temporary, on-demand door in the gate. When you write `dartCallbacks[name] = ...`, you are telling the system, "I want to pass this value through the gate and assign it to a property named `name` on this specific JS object."

In **both scenarios**, you are passing a Dart value to JavaScript. The system's responsibility is to handle that conversion consistently.

### How It Works in Practice

Let's look at the type system. The assignment operator `[]=` on a `JSObject` is defined to accept a value of type `JSAny?`.

```dart
// From the dart:js_interop library
void operator []=(String property, JSAny? value);
```

This is the key. The `JSObject` property setter *demands* a type that is compatible with JavaScript (`JSAny`).

*   **Primitives:** Dart knows that its `String`, `int`, `bool`, etc., can be implicitly converted to `JSString`, `JSNumber`, `JSBool` (all of which are subtypes of `JSAny`). So when you do `dartCallbacks['myNumber'] = 123;`, Dart implicitly converts the `int` `123` to a `JSNumber` before the assignment. This is **automatic**.

*   **Functions:** A Dart `Function` is **not** a `JSAny`. This is why you **must** explicitly call `.toJS` on it.
    ```dart
    // This FAILS at compile time
    dartCallbacks['myFunc'] = someDartFunction; // Error: Type 'Function' is not a subtype of type 'JSAny?' in type cast.

    // This WORKS
    dartCallbacks['myFunc'] = someDartFunction.toJS; // .toJS() returns a JSFunction, which IS a JSAny.
    ```

### Unified Rule

The rule is the same regardless of whether you use `@JS` or dynamic `JSObject` access:

> When you assign a value to a JavaScript property or pass it as an argument to a JavaScript function, **primitives are converted automatically**, but **complex Dart objects (like classes and functions) require an explicit `.toJS` conversion.**

### Summary Table

| Feature | Static Binding (`@JS`) | Dynamic Binding (`JSObject`) | Conclusion |
| :--- | :--- | :--- | :--- |
| **Primitive Conversion**<br>(e.g., `String`, `int`) | Yes, automatic. | Yes, automatic. | **Consistent Behavior** |
| **Function Conversion** | Requires `.toJS`. | Requires `.toJS`. | **Consistent Behavior** |
| **Custom Object Conversion**<br>(e.g., `class User`) | **Fails**. Must be converted to a `Map` first. | **Fails**. Must be converted to a `Map` first. | **Consistent Behavior** |

So, to your final question: **"So does auto primitive conversion will work?"**

**Yes, absolutely.** Whether you are using a statically bound `@JS` setter or dynamically assigning a property to a `JSObject` at runtime, you can rely on Dart's primitive types being converted to their JavaScript equivalents automatically.