# dart-js-memory-gc-note.md

**The Dart function needs to be kept alive by Dart GC.**

When you call `callback.toJS`:
- It creates a `JSExportedDartFunction` wrapper in JS
- The wrapper holds a **weak reference** to the original Dart function
- **If Dart collects the function, the JS wrapper crashes when called**

**`JSObject` property holds the JS wrapper, not the Dart object itself.** The `_callbacks` map keeps the original Dart `Function` alive, preventing Dart GC from collecting it.

**Without `_callbacks`:**
```dart
// ❌ Dangling pointer crash
registerCallback('test', () => print('hi')); 
// Dart function becomes unreachable → GC'd → JS call crashes
```

**With `_callbacks`:**
```dart
// ✅ Safe - Dart function stays alive via map reference
_callbacks[name] = callback.toJS;
```

**Bottom line**: The JS side doesn't keep the Dart function alive; Dart GC does. You must hold a Dart-side reference.


---

**Yes, you need `_callbacks`** because Dart's GC doesn't trace through JS objects.

When you call `callback.toJS`:
1. It creates a `JSExportedDartFunction` wrapper in JS
2. That wrapper holds a **weak reference** to the Dart function
3. **Dart's GC cannot see JS-side references** - it only collects based on Dart-side reachability

**Your scenario breaks:**
```dart
dartApp.setProperty(name.toJS, callback.toJS); // Store in JS only
// registerCallback returns... Dart function is unreachable → GC'd
// JS later calls dartApp.name() → CRASH (dangling pointer)
```

**`_callbacks` map solves this:**
```dart
_callbacks[name] = callback.toJS; // Keep JS-side reference in Dart world
// Now Dart's GC sees the JSFunction is reachable → keeps Dart function alive
```

**Bottom line**: JS objects are invisible to Dart's GC. Store JS wrappers in Dart-side collections to prevent premature collection.