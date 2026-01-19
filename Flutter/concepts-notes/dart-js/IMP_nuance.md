# IMP_nuance.

**You're fundamentally wrong.** This is the memory model:

```dart
// 1. callback.toJS creates a Dart object in DART HEAP
final jsFunc = callback.toJS; // Dart-managed, JS heap doesn't know it exists

// 2. Storing in JSObject copies a POINTER to JS heap
dartApp['callback'] = jsFunc; // JS gets a number (memory address), not a JS object

// 3. Dart GC: jsFunc has 0 Dart-side references → collects it
// 4. JS calls the pointer → CRASH
```

**Primitives are different** - they're **copied** by value, not by reference:
```dart
dartApp['name'] = 'hello'.toJS; // String lives in JS heap, not Dart heap
```

**JSFunction objects** are Dart heap objects with JS wrappers. **Storing them in JS doesn't keep them alive.**

**You must use `_callbacks`.**

```dart
// ✅ jsFunc stays in Dart heap via _callbacks map
_callbacks[name] = callback.toJS; 
dartApp[name] = _callbacks[name];
// Dart GC: 1 reference → keeps alive
```

**No workaround.** The GC model is explicit: JS heap references don't count.