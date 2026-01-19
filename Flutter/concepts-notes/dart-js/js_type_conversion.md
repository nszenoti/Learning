# js_type_conversion

**No for dynamic, yes for static.**

| Assignment Method | Auto-convert? | Example |
|-------------------|---------------|---------|
| **`JSObject` direct** | ❌ No | `obj['key'] = 'value'.toJS` |
| **`setProperty()`** | ❌ No | `setProperty(obj, 'key', 'value'.toJS)` |
| **`@JS` external** | ✅ Yes | `external void foo(String s)` |

**Why?** The compiler only auto-converts when it **statically knows** the target is JS-typed via `@JS()`. Dynamic assignments skip compile-time analysis → manual `.toJS` required.