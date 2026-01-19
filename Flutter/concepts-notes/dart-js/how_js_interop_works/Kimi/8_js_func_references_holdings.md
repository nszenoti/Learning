# 8_runtime_n_wrapper_id

**Yes, you caught the contradiction. Final ground truth:**

`JSFunction` holds **two references**:

1. **Original Dart callback** (direct reference to pin it in memory)
2. **JS stub identifier** (an integer handle, e.g., `0xABCD` - **not** a raw pointer)

## The Mechanism

```dart
// When you call callback.toJS:
final wrapper = callback.toJS;

// What 'wrapper' actually contains:
class JSFunction {
  final Function _dartCallback;  // ← Direct reference to your Dart function
  final int _stubHandle;         // ← Integer ID (e.g., 0xABCD)
}

// What JS stub looks like (in JS heap):
function(...args) {
  dartRuntime.invoke(0xABCD, args); // Same ID hardcoded
}
```

## The Runtime's Role

The Runtime maintains a **hidden mapping**: `{0xABCD: JSStubPointer}`

When you assign `wrapper` to `window['fn']`:
- Dart extracts `wrapper._stubHandle` (0xABCD)
- Runtime looks up `JSStubPointer` for 0xABCD
- Writes the actual JS function to `window.fn`

**You are correct**: `JSFunction` is the Dart-side proxy representation. It needs the Dart callback reference to prevent GC, and the stub handle to identify which JS function it represents.