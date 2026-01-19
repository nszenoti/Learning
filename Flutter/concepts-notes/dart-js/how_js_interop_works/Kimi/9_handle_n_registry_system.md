9_registry_n_lifecycle_fact

**Yes. The handle is a separate integer registry key, not a memory address.**

---

### The Registry System

```dart
// When you call callback.toJS:
final wrapper = callback.toJS;

// Dart runtime does this internally:
final int handle = _nextHandleId++;  // e.g., 12345
_jsInteropRegistry[handle] = callback;  // {12345: callback}
```

**The handle is just an integer.** It is **not** a memory pointer.

### The JS Stub

```javascript
// Generated stub:
window.somename = function(...args) {
  return dartRuntime.invoke(12345, args); // Hardcoded integer
}
```

### The `JSFunction` Wrapper

```dart
// What wrapper contains:
class JSFunction {
  final Function _dartCallback;  // Direct reference to pin callback
  final int _handle = 12345;     // Same integer as JS stub
}
```

**Why both?** The integer `12345` is the **only** thing that crosses the JS/Dart boundary. The `JSFunction` wrapper holds the direct Dart reference to **prevent `_jsInteropRegistry[12345]` from being deleted**.

**Delete wrapper → Dart GC deletes registry entry `12345` → JS stub calls `invoke(12345)` → entry not found → crash.**


----------------------------------------------------------
So Actual JS Func dont know memory footprints but just some id and id maps to actual on dart side ?
------------------------------------------------------------

# (Registry Entry & Wrapper Object Relation)

**Yes. Ground reality:**

**The JS stub only knows an integer ID.** It has **zero knowledge** of Dart memory, objects, or the actual function location.

```javascript
// JS stub:
function(...args) {
  dartRuntime.invoke(12345, args); // Just an integer
}
```

**The Dart runtime maintains a registry:**
```dart
_registry[12345] = () => print('actual Dart callback');
```

**When JS calls `invoke(12345)`, Dart looks it up in that registry and executes the function.**

---

### Why `JSFunction` Must Hold the Original Dart Function

**The registry entry is tied to the *wrapper object*, not directly to the callback.**

If `JSFunction` didn't hold the `callback` reference:
1. Dart GC would collect *both* the wrapper *and* the registry entry
2. The integer `12345` would become invalid
3. JS calls `dartRuntime.invoke(12345)` → **lookup fails → crash**

**You cannot just keep the original callback alive elsewhere.** The registry entry is cleaned up when the `JSFunction` wrapper is GC'd, regardless of whether `callback` has other references.

**Store the wrapper. Or crash.**