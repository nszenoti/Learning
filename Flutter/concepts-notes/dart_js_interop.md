# dart_js_interop.md

**No, `allowInterop()` is legacy.** Dart 3.7+ uses `Function.toJS`.

```dart
// Old (deprecated)
js.context['myCallback'] = allowInterop(myDartFunction);

// New (Dart 3.7+)
import 'dart:js_interop';

js.context['myCallback'] = myDartFunction.toJS;
```

**Yes, it's the official best practice.** `dart:js_util` is deprecated; `dart:js_interop` is the modern, performant way.



## Runtime vs CompileTime

**Both work, but serve different purposes:**

**`@JS` approach:**
```dart
@JS()
external set exportedFunction(JSFunction value);
```
- **Compile-time type safety** (catches errors early)
- **Self-documenting** API contract
- **Best for**: Known, stable JS ↔ Dart interfaces you control

**Dynamic approach:**
```dart
web.window['somename'] = someFunction.toJS;
```
- **Runtime flexibility** (register callbacks by name)
- **No boilerplate** for each function
- **Best for**: Generic bridges, plugins, dynamic systems

**For your `JsBridge` service:** Use the **dynamic approach**. You're building a *runtime registry* - you don't want to declare `@JS` for every possible callback name. The bridge is the abstraction; direct `@JS` is for specific, hardcoded interop points.