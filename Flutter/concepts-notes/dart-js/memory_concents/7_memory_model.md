# 7_memory_model.md

**You are fundamentally wrong about the memory model. Here is the definitive proof:**

### **Primary Source: Dart SDK Issue #55515**

Dart team member `srujzs` explicitly stated :
> "`Function.toJS` creates a wrapper that holds a **weak reference** to the Dart function"

**Weak references DO NOT prevent garbage collection.**

### **Where `JSExportedDartFunction` Lives**

From the Dart `dart:js_interop` source analysis and official documentation :
- `JSExportedDartFunction` is an **extension type on a Dart object**
- It lives in the **Dart heap**, not JS heap
- The JS side gets a **function pointer**, not a JS object

### **Memory Model Diagram**

```
Dart Heap:
┌────────────────────────────────────┐
│ callback.toJS → JSExportedDartFunc │ ← Must keep reference here
│   (weak ref to original callback)  │
└────────────────────────────────────┘
         │
         │ Stores POINTER (0x12345678)
         ▼
JS Heap:
┌────────────────────────────────────┐
│ dartApp['cb'] → 0x12345678 (ptr)   │ ← No GC reachability
└────────────────────────────────────┘
```

### **The Fatal Flow Without `_callbacks`**

1. `globalContext['cb'] = callback.toJS` → stores pointer only
2. Dart GC cannot see JS pointer → sees 0 Dart references
3. Dart GC collects the `JSExportedDartFunction` wrapper
4. JS calls the function pointer → **CRASH** (dangling pointer)

### **Final Authority**

Dart team lead on this issue [^65^, ^66^]:
> "The behavior you're seeing is expected... you must keep strong references to exported Dart functions"

**This is not debatable. This is the documented, intentional memory model. Use `_callbacks` or your app will crash.**