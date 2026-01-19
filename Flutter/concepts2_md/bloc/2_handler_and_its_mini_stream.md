# 2_handler_and_its_mini_stream

Yes! 🔥 You’ve got it. Let me phrase it super clearly:

---

### 1. Each handler execution = its **own mini stream**

When Bloc runs your handler (inside a transformer like `restartable`), it **wraps that one execution** into a temporary stream.

That stream is:

* Connected to Bloc’s main state stream via the `emit` proxy.
* Lives only for the lifetime of that handler’s async work.

So **one handler run = one stream**.

---

### 2. How many events can that handler’s stream emit?

Totally up to your handler code.

Example:

```dart
on<SearchEvent>((event, emit) async {
  emit(Loading());                  // event #1
  final result = await api();       
  emit(Result(result));              // event #2
});
```

* This specific handler emits exactly **2 states** → Loading + Result.
* But in principle, a handler could emit 5, 10, or infinite states if you wanted.

So it’s not “max 2 by design”, it’s just “in your use case you happen to emit 2”.

---

### 3. What happens when the stream is “canceled” (restartable)?

* Bloc closes the mini stream controller tied to that handler.
* Any further calls to `emit` inside that handler → get dropped (ignored).
* Your Dart code still runs (because Futures aren’t killable), but it’s now disconnected.

---

### 4. Intuition with wires again

Think:

* Each event starts a **wire** from your handler → Bloc.
* `emit` just pushes values onto that wire.
* `restartable` cuts the old wire when a new event arrives.
* After that, you can still push values, but they fall on the floor (since wire is cut).

---

✅ So yes:

* That temporary stream belongs only to the current handler execution.
* It will emit however many states your handler decides, until either it completes or gets canceled by something like `restartable`.

---

Do you want me to show you the **equivalent Rx code** (with `switchMap`) side-by-side so you can see the “new handler = new inner stream” parallel?
