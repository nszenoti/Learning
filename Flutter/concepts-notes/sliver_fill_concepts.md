# sliver_fill_concepts.

Perfect — you’ve reached the *heart* of how Flutter’s **sliver layout system** works 👏

Let’s go step by step (visually and mentally) — because once you “see” it, everything about `SliverFillRemaining` and scroll behavior will click permanently.

---

## 🧠 Step 1 — Two types of scrolling in Flutter

### 1️⃣ **Normal box scrollables** — `ListView`, `SingleChildScrollView`, etc.

These measure children vertically and clip anything outside their viewport.
They control scroll **inside themselves**.

```
SingleChildScrollView
 └── Column (children)
```

They say:

> “My children can be taller than me, I’ll handle the scrolling myself.”

---

### 2️⃣ **Sliver-based scrollables** — `CustomScrollView`

Instead of having children directly, they have **slivers** (scrollable portions).
Each sliver reports to the viewport:

> “I need this much scroll extent.”

So the parent (`CustomScrollView`) takes care of scrolling all slivers **together**.

```
CustomScrollView
 ├── SliverToBoxAdapter (header)
 ├── SliverFillRemaining (body)
```

---

## ⚙️ Step 2 — What happens with `SliverFillRemaining`

Let’s say your viewport (screen) height = 600px.
You have:

```dart
CustomScrollView(
  slivers: [
    SliverToBoxAdapter(child: SizedBox(height: 100, child: Header())),
    SliverFillRemaining(
      hasScrollBody: true, // default
      child: Column(   // <-- NOT scrollable
        children: [...100 items...],
      ),
    ),
  ],
);
```

---

### 🧩 Layout process

1️⃣ **Header SliverToBoxAdapter**
→ reports: “I take 100px.”

2️⃣ **Now 500px remains.**

3️⃣ **SliverFillRemaining**
→ sees `hasScrollBody: true`, so it says:

* “I’ll take as much space as my child wants (childExtent = say 1200px).”
* It reports to `CustomScrollView`:

  > “My scrollExtent = 1200px.”
  > “My paintExtent = 500px (the visible viewport part).”

So the *outer* `CustomScrollView` knows:

* There’s a total scrollable height = `100 (header) + 1200 (body) = 1300px`.
* It can scroll through that.

✅ So technically, the **outer scroll view** *does handle* the tall content — by scrolling the entire sliver block upward as you drag.

---

### 🧱 But here’s the problem

The **child Column itself** is not scrollable.
During layout, it’s told:

> “You can be as tall as you want.”
> So it expands fully (1200px), but its parent sliver (which has only 500px of visible paint space) **doesn’t clip it** — because `SliverFillRemaining` doesn’t clip children.

That’s why you see:

> **RenderFlex overflowed by 700px**

So you’re right — the outer scroll view *does handle the extra scroll space*,
but the child *still overflows during initial paint pass* because it paints outside the viewport until you scroll.

---

## 🧠 Step 3 — Why wrapping in `ListView` fixes it

When you do:

```dart
SliverFillRemaining(
  hasScrollBody: true,
  child: ListView(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    children: [...100 items...],
  ),
)
```

Now, the inner `ListView` **constrains its child area** and handles internal layout correctly.
It knows to clip and measure within the visible area (like a scrollable would).
The outer `CustomScrollView` still scrolls, but now there’s no overflow because the inner list participates in scroll-aware layout.

---

## 🧩 Step 4 — The key mental model

Let’s simplify:

| Concept                                     | Who scrolls?           | Who sizes children?                | Overflow chance              |
| ------------------------------------------- | ---------------------- | ---------------------------------- | ---------------------------- |
| `SingleChildScrollView`                     | inner widget itself    | inner widget                       | never                        |
| `CustomScrollView` + `SliverFillRemaining`  | outer sliver viewport  | each sliver independently          | possible during first layout |
| `SliverFillRemaining` + internal `ListView` | outer viewport scrolls | inner list handles layout properly | none                         |

---

## 🧱 Step 5 — Intuitive analogy

Think of `SliverFillRemaining` as a **container telling the scroll view**:

> “Hey, I’ll take this much height, let the user scroll me later.”

But unlike `ListView`, it doesn’t **scroll inside** itself or clip its children —
it depends on the *outer scroll physics* to move it.
So before you actually scroll, its oversized child visually sticks out.

That’s why the overflow disappears *after* scrolling.

---

## ✅ TL;DR mental rule

> `CustomScrollView` scrolls **slivers**,
> not the **widgets inside a sliver**.
>
> If a sliver’s child is taller than the viewport and not scrollable,
> you’ll get a one-frame overflow — because the sliver doesn’t clip, only the viewport scrolls it later.

---

### 🧠 So in your words:

> “Child has its own natural height, outer scroll handles it” — yes.
> But *outer scroll handles it by shifting the entire sliver block*,
> not by clipping or resizing the child — hence the temporary overflow.

---

Would you like me to show a small **visual diagram (ASCII or image)** that shows exactly how the viewport and sliver rectangles relate during layout vs scroll?
It’ll make this mental model instant and permanent.
