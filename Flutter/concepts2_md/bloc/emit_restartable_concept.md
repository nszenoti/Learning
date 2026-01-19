# emit_restartable_concept

Perfect 👍 — you’re asking the **core intuition**:

> *“I wrote one sequential async function: emit(loading) → await api → emit(result). How can `restartable` possibly stop that second emit?”*

Let’s untangle this step by step.

---

## 1. Your mental model right now

You see the handler like this:

```dart
on<SearchEvent>((event, emit) async {
  emit(Loading());            // step 1
  final result = await api(); // step 2
  emit(Result(result));       // step 3
});
```

Looks like one straight pipeline:

* Step 1 runs immediately.
* Step 2 suspends the function until API completes.
* Step 3 *must* run when API is done.

So you’re thinking: “How can Bloc *skip step 3* if it’s written sequentially?”

---

## 2. Reality: `emit` isn’t a function, it’s a **callback proxy**

When Bloc runs your handler, it does **not** give you the real `emit`.
Instead, it gives you a *special closure* tied to this event’s “subscription”.

* When you call `emit(state)`, you’re really doing `emitProxy(state)`.
* That proxy checks:

  * ❌ If this handler was canceled → ignore.
  * ✅ If this handler is still active → forward the state into Bloc’s stream.

So: your code *always executes step 3*, but the **proxy may decide to drop it**.

---

## 3. Where does the cancellation happen?

`restartable()` is an **event transformer**.
That means it **wraps the handler** with its own bookkeeping.

Conceptually, it does this (simplified):

```dart
on<SearchEvent>(
  (event, emit) async {
    emit(Loading());
    final result = await api();
    emit(Result(result));
  },
  transformer: restartable(),
);
```

Under the hood → the transformer turns the above into something like:

```dart
Stream<State> restartableMapper(
  SearchEvent event,
  Future<void> Function(SearchEvent, Emitter<State>) handler,
) {
  // Cancel previous task
  _activeHandler?.cancel();

  // Create a controller just for this handler
  final controller = StreamController<State>();

  // Wrap emit
  void safeEmit(State state) {
    if (!controller.isClosed) {
      controller.add(state);
    }
  }

  // Run handler async with safeEmit
  unawaited(() async {
    await handler(event, safeEmit);
    await controller.close();
  }());

  // Save reference so we can close on next event
  _activeHandler = controller;

  return controller.stream;
}
```

---

## 4. Now the timeline with intuition

1. **First event (`Sele`)**

   * Handler starts.
   * `emit(Loading)` → goes through proxy → allowed.
   * API request running.

2. **Second event (`Seli`) arrives**

   * `restartable` cancels old controller.
   * That means old `safeEmit` is now tied to a **closed controller**.

3. **Old API finishes**

   * Handler resumes.
   * Calls `emit(Result(Sele))`.
   * But `safeEmit` sees: *“controller is closed”* → drops it.

4. **New API finishes**

   * Its handler’s controller is still active.
   * `emit(Result(Seli))` is accepted and flows to Bloc’s state.

---

## 5. Intuition: Think in terms of "wires"

* Each handler execution is wired to the Bloc state stream through its own little channel.
* `restartable` **cuts the wire** of the old handler when a new event comes.
* Your function keeps running (because Dart Futures can’t be force-stopped), but its wire is dangling — so its emits go nowhere.

---

✅ So:

* Your sequential handler **always runs fully**.
* `restartable` doesn’t stop your Dart code.
* It only swaps out the **wire (`emit`) connection** so that old results are dropped, new ones survive.

---

Would it help if I drew a **diagram of two event handlers running side-by-side, showing their `emit` wires getting cut when restartable cancels one**?
