# 3_bloc_hld_flow

Perfect question 👍 You’re asking for the **end-to-end story of Bloc’s plumbing** — from `add(event)` → your handler running → `emit(state)` → subscribers seeing it. Let’s walk it slowly and intuitively:

---

## 🔄 The Full Lifecycle

### 1. Bloc has **one main state stream**

* Every `Bloc` has a single `Stream<State>` (internally a `StreamController<State>`).
* Anyone who does `bloc.stream.listen(...)` or uses `BlocBuilder` subscribes to **this one main stream**.

---

### 2. You call `bloc.add(Event e)`

* The event is pushed into Bloc’s **event stream controller**.
* Think of this as a queue of incoming events.

---

### 3. Transformer decides how to handle the event

Each `on<Event>` is registered with an **event transformer** (default: `concurrent`, but you can override with `restartable`, `droppable`, etc).

* This transformer controls **how events are scheduled into handler functions**.
* For example:

  * `concurrent` → let all handlers run in parallel.
  * `restartable` → cancel the old handler if a new event arrives.
  * `sequential` → run one at a time.

So the transformer’s job is **event scheduling and cancellation**.

---

### 4. Event handler runs

Let’s say you have:

```dart
on<SearchEvent>((event, emit) async {
  emit(Loading());                // immediately pushes Loading
  final result = await api.search(event.query);
  emit(Result(result));            // pushes Result
}, transformer: restartable());
```

When this handler starts:

* Bloc creates a **mini stream controller** tied to this handler execution.
* The `emit` function is just `controller.add(state)` under the hood.

---

### 5. Handler emits states

* When you call `emit(Loading())`, it goes into the handler’s mini controller.
* That controller is **plugged into the main Bloc state stream** (like a wire).
* So subscribers see `Loading`.

Then after the `await`:

* `emit(Result(...))` goes the same way → handler’s mini stream → main Bloc state stream → subscribers.

---

### 6. Cancellation (restartable, etc.)

If another event arrives before the handler finishes:

* `restartable` closes the mini controller for the old handler.
* Old `emit`s now become **no-ops**.
* The new event starts a new handler, with a fresh mini stream.

Main Bloc stream only gets states from the active handler(s), depending on transformer.

---

### 7. Subscribers always see just one stream

From the outside world:

* You don’t see mini streams.
* You only subscribe to the **single Bloc state stream**.
* That stream is a merged view of all mini streams created by event handlers.

---

## ⚡ Intuition Analogy

Think of it like:

* **Bloc = big loudspeaker** 🎤
* **Main state stream = the sound everyone hears**.
* Each handler execution = a **temporary microphone**.
* `emit` = speaking into that microphone.
* Transformers decide **which microphones are connected to the loudspeaker**.
* `concurrent` = all mics are on.
* `restartable` = unplug the old mic when a new singer steps up.
* `droppable` = ignore new mic if one’s already in use.

So from the crowd’s perspective (your UI), they just hear **the loudspeaker stream** — they never see the mic juggling inside.

---

✅ That’s the full flow:
`add(event)` → transformer schedules → handler creates mini stream → emits states → main Bloc stream → UI listens.

---

Do you want me to draw this flow with an **ASCII timeline diagram** (events + streams + emits) so you can visualize wires/mics and cancellation in action?
