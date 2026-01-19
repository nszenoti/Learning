# compile-time-constants-objects

**Use a namespaced object** (`window.dartApp.callback1()`). It's cleaner and avoids global conflicts.

### **Recommended Pattern**

```dart
import 'dart:js_interop';
import 'dart:js_interop_unsafe';

final _callbacks = <String, JSFunction>{};

/// Register Dart callback as window.dartApp[name]
void registerCallback(String name, Function callback) {
  final jsFunc = callback.toJS;
  _callbacks[name] = jsFunc;
  
  final dartApp = globalContext['dartApp'] as JSObject? ?? JSObject();
  dartApp.setProperty(name.toJS, jsFunc);
  globalContext['dartApp'] = dartApp;
}

/// Unregister callback
void unregisterCallback(String name) {
  _callbacks.remove(name);
  (globalContext['dartApp'] as JSObject?)?.setProperty(name.toJS, null);
}
```

### **Why This Over Direct `window` Registration?**

✅ **Organized**: All Dart callbacks in one namespace  
✅ **No pollution**: Avoids conflicts with other JS libs  
✅ **Easy cleanup**: Clear ownership and lifecycle

### **Alternative: `@JSExport` (For Static Exports)**

If callbacks are known at compile-time, use `@JSExport` instead of dynamic registration:

```dart
@JSExport
class DartApp {
  void callback1(String data) => print(data);
}

// In main()
globalContext['dartApp'] = createJSInteropWrapper(DartApp());
```

**Bottom line**: Use the `dartApp` namespace for dynamic registration; use `@JSExport` for static exports.