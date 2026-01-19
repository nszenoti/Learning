# 7_jsfunc_jsstub

**Final, precise answer:**

`JSFunction` **does** hold a direct reference to the JS stub via an **internal native field**. It also holds the Dart callback reference.

## The Exact Structure

**JS stub** (in JS heap):
```javascript
function(...args) {
  dartRuntime.invoke(0xABCD, args); // Hardcoded dartId
}
```

**JSFunction object** (in Dart heap):
```dart
class JSExportedDartFunction {
  final Object _dartCallback;    // ← Pins original Dart function
  final int _dartId = 0xABCD;    // ← Same ID as JS stub
  final dynamic _jsStubRef;      // ← **Native pointer to the actual JS function**
}
```

**Why both references:**
- `_jsStubRef` allows `JSFunction` to be assigned to JS properties (`window['fn'] = wrapper`)
- `_dartCallback` prevents Dart GC from deleting the callback that `0xABCD` points to

**Without `_dartCallback`**: Dart collects callback → registry entry `0xABCD` deleted → JS stub's hardcoded ID becomes dangling → crash.

**The JS stub is independent** once created, but it depends on the Dart registry entry existing. That entry exists only as long as the Dart callback is alive, which requires the `JSFunction` wrapper to hold it.