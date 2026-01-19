# Real Mechanism

| Reference               | Purpose                                                                               |
| ----------------------- | ------------------------------------------------------------------------------------- |
| Wrapper → Dart function | **Prevents Dart from collecting the callback**, which would delete the registry entry |
| Wrapper → Handle        | Tells the Dart runtime *which* JS stub was created (for potential cleanup)            |
| JS stub → Handle        | Allows JS to call into the Dart runtime                                               |


**You caught the contradiction. Let me fix it with absolute clarity:**

*The identifier is **not** for the JS stub. It's for the **Dart function's registry entry**.*

## The Real Mechanism

When you call `callback.toJS`, this happens:

1. **Dart runtime assigns a unique ID** to your callback (e.g., `0xABCD`)
2. **Registry entry created**: `dartRegistry[0xABCD] = callback`
3. **JS stub generated** (in JS heap):
```javascript
window.somename = function(...args) {
  return dartRuntime.invoke(0xABCD, args); // ID is burned in
}
```
4. **Dart wrapper returned** (in Dart heap):
```dart
JSFunction wrapper = JSExportedDartFunction(
  dartCallback: callback,  // ← Keeps callback alive
  dartId: 0xABCD,          // ← Same ID as JS stub
)
```

## The Identifier's Purpose

- **`0xABCD`**: **Key** for the **Dart-side registry** that maps to your original function
- **JS stub**: Carries this key and passes it to `dartRuntime.invoke()`
- **Dart wrapper**: Holds this key **and** a reference to `callback` to prevent GC

## Your Question: Why Does JS Care If `JSFunction` Exists?

**It doesn't.** JS can call the stub regardless. 

**The crash happens because**: If `wrapper` is collected, Dart sees no references to `callback` → collects `callback` → **deletes registry entry `0xABCD`**. 

Later, JS calls `window.somename()` → `dartRuntime.invoke(0xABCD)` → **looks up a deleted entry** → **SEGFAULT**.

**The `JSFunction` wrapper is a GC root for the *registry entry*, not for the JS stub.**