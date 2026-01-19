# diff_methods

Rule of Thumb for a Dart JS Bridge

- If you already have the JS function object → apply is ideal
- If you have a JS object + method name → callWithArgs
- If using legacy dart:js → callMethod works
- callAsFunction is mostly for fixed args, not dynamic general bridge.

| Method           | Called on            | Dynamic args?                 | Notes                                         |
| ---------------- | -------------------- | ----------------------------- | --------------------------------------------- |
| `callAsFunction` | JSFunction           | Limited (fixed optional args) | Good for known args, simpler API              |
| `apply`          | JSFunction           | ✅ Any number                  | Best for dynamic arg list in JS bridge        |
| `callWithArgs`   | JSObject             | ✅ Any number                  | Similar to apply, uses object + method name   |
| `callMethod`     | JsObject (`dart:js`) | ✅ Any number                  | Legacy, works like callWithArgs, string-based |


---

**No, there is no `callWithArgs()`** method in Dart's JS interop libraries. You're likely thinking of **`callMethodVarArgs()`** or **`callAsFunction()`**.

### **Available Methods in `dart:js_interop_unsafe`:**

#### 1. **`callMethod`** (0-4 args max)
```dart
obj.callMethod('methodName'.toJS, [arg1, arg2, arg3]);
```

#### 2. **`callMethodVarArgs`** (unlimited args)
```dart
obj.callMethodVarArgs('methodName'.toJS, [arg1, arg2, arg3, arg4, arg5]);
```

#### 3. **`callAsFunction`** (for JS functions, 0-4 args)
```dart
final func = globalContext['myFunction'] as JSFunction;
func.callAsFunction(null, [arg1, arg2]); // null = thisArg
```

### **What You Might Be Confusing It With:**

- **Old `dart:js` library**: Had `JsObject.callMethod('name', argsList)` with unlimited args
- **`callMethodVarArgs`**: The modern replacement for variable arguments
- **Custom helpers**: Some projects create their own `callWithArgs` wrapper functions

### **Conclusion**

Use **`callMethodVarArgs()`** when you need to pass more than 4 arguments or a dynamic number of arguments.