# 3_js_stub_and_dart_wrapper_reln.md

YES. Your mental model is **exactly correct**. The JS-Level Stub is precisely that: a plain JavaScript function living in the JS heap.

Here is the **absolute clarity** you requested:

---

### The JS Stub: What It *Actually* Is

When you execute `callback.toJS`, the Dart compiler **generates this function in the JavaScript output**:

```javascript
// What gets assigned to window.somename:
function(...jsArgs) {
  // Step 1: Package JS args into a format the Dart runtime expects
  const marshalledArgs = _dartInterop.marshalJSArgs(jsArgs); 
  
  // Step 2: Call the Dart runtime using the *hidden handle*
  // This handle (e.g., `0xABCD` or a registry index) is **hardcoded** into this specific stub
  const result = _dartRuntime.invoke(0xABCD, marshalledArgs); 
  
  // Step 3: Package the Dart result back to JS
  return _dartInterop.marshalDartResult(result);
}
```

**Key Point**: The handle (`0xABCD`) is an **immutable token** that identifies *your specific Dart function* in the Dart heap. **This handle is burned into the JS function's closure at creation time.**

---

### The Dart Wrapper: The Lifeline

```dart
// This is what `callback.toJS` returns
JSFunction wrapper = callback.toJS;
```

`wrapper` is a **Dart object** of type `JSExportedDartFunction`. Its *only* job is to:

1. **Hold the same handle** (`0xABCD`) that the JS stub uses
2. **Pin the original `callback` function** in Dart memory, preventing the Dart GC from collecting it

**If you allow `wrapper` to be garbage-collected, the Dart runtime will free the memory associated with handle `0xABCD`. The JS stub will still invoke `invoke(0xABCD, ...)`, but now it calls into *dead memory* → instant crash.**

---

### Memory Management: The Non-Negotiable Rule

```dart
// ❌ Broken: JS stub is created, then immediately orphaned
void broken() {
  web.window['fn'] = (() => print('hi')).toJS; 
} // Dart GC: "No one references that wrapper, collect it!"

// Later, from JS: window.fn() → CRASH (use-after-free)

// ✅ Correct: You MUST keep the wrapper alive
final List<JSFunction> _liveJSExports = []; // Dart GC root

void correct() {
  final wrapper = (() => print('hi')).toJS;
  web.window['fn'] = wrapper;
  _liveJSExports.add(wrapper); // Prevents GC
}
```

**You are not storing the JS stub. You are storing the *Dart object that keeps the JS stub's handle valid*. **

---

### Type Identity: Final Clarification

| Name | What It Is | Where It Lives |
|------|------------|----------------|
| `JSAny` | ** Dart type annotation ** (interface) | Dart source code only |
| `JSExportedDartFunction` | ** Concrete Dart class ** (the wrapper) | Dart heap |
| `window.somename` | ** Pure JavaScript function ** (the stub) | JS heap |
| The "handle" | An integer ID or native pointer | Embedded in both the Dart wrapper and the JS stub |

** JS cannot understand Dart. The JS stub doesn't *know* about Dart. It only knows how to call the `_dartRuntime.invoke()` bridge with a hardcoded handle. **

The Dart wrapper is the ** owner ** of the handle's validity. ** Kill the wrapper, and the stub's handle becomes a dangling pointer. **