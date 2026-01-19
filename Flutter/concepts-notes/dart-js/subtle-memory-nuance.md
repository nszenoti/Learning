# subtle-memory-nuance

**Yes, exactly correct.**

```dart
// 1. Dart function exists
void func1() => print('hello');

// 2. You create JS wrapper and store only in JS
dartApp['callback1'] = func1.toJS; 

// 3. func1 now unreachable from Dart's perspective
// Dart GC collects it → frees memory

// 4. JS later calls dartApp.callback1() 
// JS wrapper tries to call collected Dart function → CRASH
```

**The `_callbacks` map keeps the JS wrapper reachable from Dart, preventing GC.**

```dart
// ✅ Safe: Store JS wrapper in Dart map
_callbacks['callback1'] = func1.toJS; 
dartApp['callback1'] = _callbacks['callback1'];
```

**Bottom line**: Dart GC cannot see JS-side references; you must keep a Dart-side reference.