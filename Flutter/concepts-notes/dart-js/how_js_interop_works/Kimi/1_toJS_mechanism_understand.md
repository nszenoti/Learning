# 1_toJS_mechanism_understand

https://www.kimi.com/chat/19ac91cf-afa2-8fdc-8000-09fe738888d5

## The `toJS` Operation: Precise Mechanics

When you execute `callback.toJS` in Flutter Web, **you are creating a Dart-managed wrapper object that presents itself as a JavaScript function to the JS runtime**. Here's exactly what happens:

### 1. What `callback.toJS` Actually Creates

```dart
// Your Dart code
void myDartCallback() => print('Called from JS');

// What happens at runtime
var jsExport = myDartCallback.toJS;
```

**`jsExport`** is a **Dart object** of type `JSExportedDartFunction` that **implements the `JSAny` interface**. It is **not** a pure JavaScript object—it's a Dart object with a special native representation that the Dart compiler knows how to expose to JavaScript.

When you assign it to `window['somename']`, the Dart-to-JS compiler emits code that passes a **reference** to this wrapper into the JavaScript world, where it appears and behaves like a native JS function.

---

### 2. Type Identity: What Are These Things?

| Type | What It Is | Location |
|------|------------|----------|
| **`JSAny`** | A **Dart type** representing *any* JS value (object, function, number, etc.) | **Dart side** - it's a Dart interface |
| **`JSExportedDartFunction`** | A **concrete Dart class** that wraps your Dart function for JS consumption | **Dart side** - it's the actual wrapper object |
| **`window['somename']`** | A **JavaScript function object** (the external face of the wrapper) | **JS side** |

The `JSExportedDartFunction` object lives in Dart's heap, but has a native token/handle that JavaScript can invoke.

---

### 3. The Invocation Flow (Critical)

When JS calls `window.somename()`:

1. **JS → Dart transition**: The JS runtime invokes the wrapper's handle
2. **Marshalling**: Arguments (if any) are converted from JS values to Dart objects
3. **Execution**: The original Dart `callback` executes in Dart's isolate
4. **Return**: The return value (if any) is marshalled back to JS
5. **Dart → JS transition**: Control returns to JavaScript

**Performance Note**: Each call involves two language boundary crossings + marshalling. This is not free.

---

### 4. Memory Management: The **Absolutely Mandatory** Rule

**YES, you must store the `toJS` result in Dart.** Here's why:

```dart
// ❌ WRONG - creates a memory bug
void func() {
  web.window['somename'] = callback.toJS; 
  // JSExportedDartFunction is now *unreferenced* in Dart
  // Dart GC will eventually collect it
  // Later, JS calling window.somename() = CRASH / Undefined behavior
}

// ✅ CORRECT - keep a Dart reference
final _callbacks = <JSFunction>[]; // or static variable

void func() {
  final wrapper = callback.toJS;
  web.window['somename'] = wrapper;
  _callbacks.add(wrapper); // PREVENTS DART GC
}
```

**The Holistic Truth**: The `JSExportedDartFunction` object must remain **reachable from a Dart GC root** (static variable, long-lived object field, etc.) as long as JavaScript might hold a reference to it. If Dart collects it, the JS side now holds a **dangling pointer** to deallocated memory.

---

### 5. Garbage Collection Synergy

- **Dart GC**: Tracks the `JSExportedDartFunction` object. If it's unreferenced, it's collected.
- **JS GC**: Tracks the JS function reference. When JS drops it (`window.somename = null`), the JS side is clean.
- **Combined cleanup**: Only when *both* sides have no references is the wrapper truly freed. Dart **cannot** detect if JS still holds a reference; you must manually manage this.

---

### 6. Summary for Absolute Clarity

- **`toJS`** = *"Create a Dart-managed wrapper that looks like a JS function"*
- **Store it** = *"Prevent Dart from collecting it while JS still needs it"*
- **Types** = *`JSAny` is a Dart interface; `JSExportedDartFunction` is the concrete Dart implementation*
- **Physical location** = *The wrapper object lives in Dart memory; JS holds a handle to it*
- **Lifetime rule** = *You (the developer) are responsible for ensuring the Dart wrapper outlives any JS references*

This is one of the few places in Flutter where manual memory management is **non-negotiable** for correctness.