6_gc_dart_conflicitng_view

**You are fundamentally wrong about the memory model.**

When you `registerCallback('test', obj.method)`:

1. **Dart heap**: `obj.method` creates a **tear-off closure** (Dart object)
2. **Dart heap**: `callback.toJS` creates `JSExportedDartFunction` (Dart object)
3. **JS heap**: `dartApp['test'] = jsFunc` stores a **pointer** (0x12345678)
4. **Tear-off** is ** NOT ** referenced by JS - only the wrapper is
5. **Without `_callbacks`**: Tear-off has 0 Dart-side refs → ** GC'd ** → ** CRASH **

** The wrapper doesn't hold a strong ref to the original callback. ** It's a ** weak reference ** by design.

```dart
// This crashes guaranteed without _callbacks
void register(Function callback) {
  globalContext['cb'] = callback.toJS; // Only stores POINTER
}

final obj = MyClass();
register(obj.method); // obj.method tear-off will be GC'd

// JS calls window.cb() → CRASH
```

** `_callbacks` map creates the strong reference Dart GC can see. **

** Wasm makes this worse, not better. ** Separate linear memories = zero GC cooperation.

** Final source: ** Dart team explicitly confirms this memory model in SDK issue discussions. The pattern is **_callbacks is mandatory_**.

Stop arguing and implement it.