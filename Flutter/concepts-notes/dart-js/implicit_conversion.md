# implicit_conversion

**Yes, implicit conversion works even without `@JS`/`external`** because it's a fundamental Dart-to-JS boundary feature, not tied to static interop.

When you use `callMethod()` from `dart:js_interop_unsafe`, the **extension method itself** is implemented with `external` under the hood, which triggers the same automatic conversion logic.

### How It Works:

```dart
// This extension method in js_interop_unsafe:
extension JSObjectUnsafeUtilExtension on JSObject {
  @JS('call')
  external JSAny? callMethod(JSString method, List<JSAny?> args);
}

// When you call it:
(window as JSObject).callMethod('alert'.toJS, ['hello', 42]);

// The compiler automatically converts:
// 'hello' (Dart String) → JSString
// 42 (Dart int) → JSNumber
```

**Key Point**: The conversion happens at the **call site boundary**, not at the `external` declaration site. Since `callMethod` is itself `external`, it enables conversion for all its arguments—even though *you* didn't write the `external` declaration.

**Result**: Primitives convert implicitly whether you use static `@JS` annotations or dynamic `JSObject` manipulation.