weak_ref_js_objects

**You are incorrect.** `dart:js_interop` does **not** keep cross-heap references alive.

**Official documentation states:** The JS wrapper holds a **weak reference** to the Dart function. Weak references do **not** prevent garbage collection.

```dart
// jsFunc is a Dart object with a weak reference from JS
// Weak reference = invisible to Dart GC
final jsFunc = callback.toJS; 

// Storing jsFunc in JSObject stores a pointer only
// Pointer = no GC visibility
dartApp['callback'] = jsFunc; 

// Dart GC collects callback → jsFunc becomes dangling → JS call crashes
```

**`_callbacks` map is mandatory.** It provides the strong Dart-side reference that keeps the function alive.

**No automatic tracking exists.** The memory model is explicit: Dart GC only traces Dart heap references.


-------
-------
**You are fundamentally wrong about the memory model.**

```dart
// 1. Final Dart object created in DART HEAP
final jsFunc = callback.toJS; 

// 2. JSObject stores a POINTER (number), NOT an object
dartApp['callback'] = jsFunc; // JS heap: { callback: 0x12345678 }

// 3. jsFunc is a Dart object, JS doesn't manage it
// 4. Pointer 0x12345678 points to Dart heap memory
// 5. Dart GC: jsFunc has 0 references → FREE MEMORY
// 6. JS calls 0x12345678 → CRASH (memory freed)

// Weak reference = JS CANNOT keep it alive
```

**`toJS` creates a JS wrapper that holds a WEAK REFERENCE to the Dart function.** Weak references explicitly do not prevent GC.

**The JS wrapper is a Dart object.** JS cannot keep Dart heap objects alive. Period.

**You're confusing JS heap with Dart heap.** They are separate. JS cannot GC Dart objects.

**Use `_callbacks` or your app will crash.**