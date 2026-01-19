# 3_dart_types_implicit_explicit

// ✅ ALLOWED:
- JS types from `dart:js_interop` (JSString, JSNumber, JSObject, JSFunction, etc.)
- @staticInterop types
- Primitives: void, bool, num, double, int, String
- Extension types that erase to one of the above
- ExternalDartReference (for opaque Dart objects)
- Type parameters bound to static interop types

// ❌ NOT ALLOWED (causes compile-time error):
- Dart Function types (must use JSFunction)
- Dart List/Map (must use JSArray/JSObject)
- Any other Dart class
- dynamic (unless specifically handled)