# 4_imp_note_js_dart_gc

https://chatgpt.com/c/6928608a-e894-8325-9b7a-72cd163286d8

Short answer: **`toJS` will *keep Dart callbacks alive* as long as the JS side still holds the function reference. It will NOT let them be garbage-collected until JS drops them.**

Here’s the clean breakdown 👇

---

## ✅ What happens when you pass a Dart callback through `toJS`?

When you do something like:

```dart
final jsFn = (DartFunction).toJS;
```

Dart creates a **JS wrapper function** that:

* Holds a **hidden reference back to the original Dart closure**
* Keeps it alive on the Dart side
* Prevents Dart GC from collecting it until JS no longer holds the wrapper

This is the same behaviour as:

* `allowInterop`
* `allowInteropCaptureThis`

Both of these keep the callback alive because the JS wrapper keeps the Dart closure “anchored”.

---

## 🧠 Why does this happen?

Because if Dart GC removed the callback while JS still tries to call it → **segfault-like crash**.

So the interop layer **pins** the original Dart closure until the JS function becomes unreachable.

---

## 🔥 Important detail: who decides when GC happens?

### GC in Dart

Dart will only collect the closure when:

* No Dart objects reference it, **and**
* The JS wrapper (created by `toJS`) is itself released by JS GC

### GC in JS

JS will drop the wrapper only when:

* No JS variable, object property, or closure captures it
  (e.g., `window.handler = null;` or object destroyed)

Only then does Dart also free the closure.

---

## ❗ Memory leak alert

You can leak memory if you do:

```dart
window.myHandler = () {
  print("Hello");
}.toJS;
```

and **never set `window.myHandler = null`**.

Because:

* JS keeps the reference alive
* Dart keeps the closure alive
* GC cannot reclaim either

---

## ✔ Best practice

Whenever you *register* a Dart callback in JS:

```dart
window['onSomething'] = myDartCallback.toJS;
```

Make sure you *unregister*:

```dart
window['onSomething'] = null;
```

or replace it with another function.

---

## 📌 Conclusion

* `toJS` **keeps the original Dart callback alive**
* It **will NOT be GC'd** until JS drops the wrapper function
* Same behaviour as `allowInterop`
* Avoid unbounded registration to prevent memory leaks

If you want, I can explain how `Finalizer` or `WeakRef` behave with JS interop too — those have interesting interactions.
