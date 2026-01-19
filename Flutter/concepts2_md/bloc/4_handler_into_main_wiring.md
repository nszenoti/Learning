# 4_handler_into_main_wiring

Great catch 🚀 — this is the subtle part most people miss.
Let’s zoom in on **how Bloc wires handler streams back into the main state stream**.

---

## 1️⃣ The pieces inside `bloc`

* `Bloc` has:

  * an **event stream controller** (where `add(event)` pushes events)
  * a **state stream controller** (the single stream your UI listens to)

```dart
final _eventController = StreamController<Event>();
final _stateController = StreamController<State>.broadcast();
```

When you do `bloc.stream.listen(...)`, you’re listening to `_stateController.stream`.

---

## 2️⃣ `on<Event>` registers a handler

When you write:

```dart
on<SearchEvent>((event, emit) async {
  emit(Loading());
  final result = await api.search(event.query);
  emit(Result(result));
}, transformer: restartable());
```

Bloc internally wraps that `(event, emit)` handler into a **mapper** function that turns each event → a stream of states.

Think:

```dart
Event → Stream<State>
```

---

## 3️⃣ Transformer controls merging

* `transformer` is just a function:

```dart
EventHandlerTransformer<Event> = 
  (Stream<Event> events, EventMapper<Event> mapper) → Stream<State>
```

* `mapper` calls your handler and produces a **mini stream of states**.

  * Inside, `emit` is just `controller.add(state)` from a `StreamController<State>`.
  * When handler finishes, that controller closes.

So each event = one **mini state stream**.

---

## 4️⃣ How do they get into the main stream?

👉 This is the key:

Bloc subscribes the main `_stateController` to whatever **merged stream** the transformer outputs.

Example with **concurrent** (default):

```dart
Stream<State> concurrent<Event>(
  Stream<Event> events,
  EventMapper<Event, State> mapper,
) {
  return events.asyncExpand(mapper); 
}
```

* `asyncExpand` takes each event → `mapper(event)` → mini stream.
* Then it **flattens (merges)** all those mini streams into **one unified stream**.
* That unified stream is piped into `_stateController`.

So you’re right: we don’t manually `join`, we rely on **flattening operators** (`asyncExpand`, `switchMap`, etc) to merge.

---

## 5️⃣ Flow in steps

* Event `E1` comes in → handler makes mini stream:
  `[Loading, Result1]`
* Event `E2` comes in → handler makes another mini stream:
  `[Loading, Result2]`

If transformer = `concurrent` → `asyncExpand` merges both mini streams → main state stream sees:

```
Loading, Result1, Loading, Result2
```

If transformer = `restartable` → uses `switchMap` → only latest mini stream survives → main state stream sees:

```
Loading, Result2
```

---

## 6️⃣ Analogy

* Think of mini handler streams as **garden hoses**.
* The transformer decides how to connect them to the **main water pipe**:

  * `concurrent` = all hoses flow into the pipe.
  * `restartable` = unplug the old hose when a new one attaches.
  * `droppable` = ignore new hose if one is already flowing.
  * `sequential` = line hoses up, connect one after another.

The UI drinks only from the **main pipe** (`bloc.stream`).

---

✅ So the answer:
The **mapper returns `controller.stream` for one event**.
The **transformer (`asyncExpand`, `switchMap`, etc.) merges those mini streams into one unified stream**, which is then fed into the **main Bloc state controller**.

---

Would you like me to show you a **tiny Bloc-like implementation in pure Dart** (with `StreamController`, `asyncExpand`, `switchMap`) so you can literally see how the merging works in <30 lines of code?
