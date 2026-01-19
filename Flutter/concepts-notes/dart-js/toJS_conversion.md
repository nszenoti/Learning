# toJS_conversion

For **primitive types**, you **do not need** explicit `toJS` or `jsify` conversion when using `package:web` interop methods like `callMethod()`, `callAsFunction()`, etc. Dart automatically handles the conversion to JavaScript types at the boundary.

### What Converts Automatically?

The following Dart primitives are implicitly converted to their JS equivalents:

| Dart Type | JS Type | Example |
|-----------|---------|---------|
| `String` | `JSString` | `'hello'` |
| `int` | `JSNumber` | `42` |
| `double` | `JSNumber` | `3.14` |
| `bool` | `JSBoolean` | `true` |
| `Null` | `JSNull` | `null` |

### Practical Examples

```dart
import 'package:web/web.dart' as web;
import 'dart:js_interop';

// No conversion needed for primitives
void examples() {
  final window = web.window as JSObject;

  // ✅ String (automatically becomes JSString)
  callMethod(window, 'alert'.toJS, ['Hello World'.toJS]); // Or just: ['Hello World']
  
  // ✅ Number (automatically becomes JSNumber)
  callMethod(window, 'setTimeout'.toJS, [
    () { print('timeout!'); }.toJS, // Function needs .toJS
    1000 // int converts automatically - no .toJS needed
  ]);

  // ✅ Boolean (automatically becomes JSBoolean)
  setProperty(window, 'myFlag'.toJS, true); // true converts automatically

  // ✅ Null
  setProperty(window, 'myValue'.toJS, null); // null converts automatically
}
```

### When You *Do* Need Explicit Conversion

You **must** use `.toJS` or `jsify()` for:

1. **Functions**: Dart functions need `.toJS` to become `JSFunction`
2. **Collections**: `List`, `Map`, `Set` need `toJS` or `jsify()`
3. **Dart objects**: Any custom class instances
4. **Type ambiguity**: When the parameter is `dynamic` or `Object`

```dart
// ❌ Wrong - will cause type errors
callMethod(window, 'myFunc'.toJS, [() => print('hi')]); // Missing .toJS

// ✅ Correct
callMethod(window, 'myFunc'.toJS, [() => print('hi').toJS]);

// ❌ Wrong
callMethod(window, 'process'.toJS, [{'key': 'value'}]); // Map needs conversion

// ✅ Correct
callMethod(window, 'process'.toJS, [{'key': 'value'}.jsify()]);
```

### Best Practice

Even though primitives convert automatically, **using `.toJS`** on them can improve **type safety** and **clarity**:

```dart
// More explicit and type-safe
callMethod(window, 'alert'.toJS, ['Hello'.toJS]);
```

But this is optional for primitives and mainly a matter of coding style preference.