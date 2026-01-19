# debounce_plus_stale_handler

Great catch 🙌 — let me untangle this for you.

There are actually **two equivalent ways** to achieve “debounce + cancel old requests” in Bloc land:

---

## 1. Using **RxDart + switchMap**

(as I showed in the last snippet)

```dart
transformer: (events, mapper) {
  return events
      .debounceTime(const Duration(milliseconds: 500))
      .switchMap(mapper); // cancel old, keep latest
}
```

Here:

* `debounceTime` = Rx operator
* `switchMap` = same idea as `restartable`

This needs `rxdart` as a dependency.

---

## 2. Using **bloc\_concurrency.restartable()**

(no RxDart needed)

```dart
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

on<SearchEvent>(
  (event, emit) async {
    emit(SearchState(isLoading: true));
    final res = await api.search(event.query);
    emit(SearchState(results: res));
  },
  transformer: (events, mapper) {
    return events
        .debounce(const Duration(milliseconds: 500)) // from stream_transform
        .transform(restartable<SearchEvent>()(mapper));
  },
);
```

Here:

* `debounce` comes from `stream_transform` (a tiny package, already in `bloc` deps).
* `restartable` is built into `bloc_concurrency`.

So no need for RxDart if you don’t want it. ✅

---

## ✨ Intuition

* **`debounce`** = wait until typing stops.
* **`restartable`** = if a new event arrives, drop the old handler’s emissions (ignore late API results).

Together → you get exactly what you want:
smooth search UX with no stale results.

---

👉 So, to answer your earlier question:
Yes — the *“earlier restartable”* I used is exactly what you’d use here.
The only difference is whether you combine it with **Rx’s `switchMap`** or **bloc’s `restartable`**. They are conceptually the same.

---

Do you want me to **write out both full Bloc classes side-by-side** (Rx vs. restartable) so you can see they’re functionally identical?
