# overlay_popup_loading_issue.

---

Query

I am using OverlayPortal, CompositedTransformTarget and CompositedTransformFollower for displaying custom popup throughout my app (ie Dropdown, etc ...)
Now the thing is I had wrapped my app main root widget in Stack and display loading indicator centrally conditionally
when loading is triggered its appearing beneath the Popup overlay 
why ?
how to avoid or fix this
and what is ideal way of dealing it

---

This is a **classic layering issue** in Flutter caused by how `OverlayPortal`, `CompositedTransformTarget`, and `CompositedTransformFollower` work — particularly when combined with a `Stack` at the root of your app for things like global loading indicators.

---

### 🔍 Why is the popup appearing **above** your loading indicator?

Because:

* `OverlayPortal` uses the app-wide `Overlay` (above the widget tree), separate from your `Stack`.
* Your global loading indicator is rendered *within* the main widget tree, wrapped in `Stack`.
* So the popup (via `Overlay`) is **higher in z-index** than your loading indicator.

---

### ✅ Ideal Fixes

#### ✅ Option 1: Use the App’s Root Overlay for the Loading Indicator

Instead of putting the loading widget inside your app's `Stack`, **use the root `Overlay`**, just like `OverlayPortal` does. This way, your loading indicator will truly be **on top of everything**, including all popups.

##### How?

You can use an `OverlayEntry` to insert your loading indicator into the overlay.

```dart
class GlobalLoader {
  static OverlayEntry? _overlayEntry;

  static void show(BuildContext context) {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (_) => const Center(
        child: ColoredBox(
          color: Colors.black54,
          child: CircularProgressIndicator(),
        ),
      ),
    );

    Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
  }

  static void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
```

> Use `GlobalLoader.show(context)` to show and `.hide()` to remove.

---

#### ✅ Option 2: Manually control z-order using a high-level OverlayEntry for your loading indicator

If you need **multiple overlays**, insert the loading indicator **after** your other popups:

```dart
final overlay = Overlay.of(context, rootOverlay: true);
overlay.insert(_popupEntry);
overlay.insert(_loadingEntry); // Last inserted appears on top
```

---

#### 🚫 Option 3: Don't rely solely on a root `Stack` for such UI

It's tempting to wrap the entire app in a `Stack` and toggle loaders, modals, etc. But this breaks down when other elements like `OverlayPortal` are used.

---

### 🧠 Best Practice Summary

| Need                  | Ideal Approach                    |
| --------------------- | --------------------------------- |
| Custom Popups         | `OverlayPortal` / `OverlayEntry`  |
| Global Loader         | `OverlayEntry` (root overlay)     |
| Ensure proper z-index | Insert loader after popups        |
| Avoid layering issues | Don’t rely solely on root `Stack` |

---

Would you like me to give you a complete example that uses both a popup and a loading indicator using `OverlayEntry` properly?

---

Query 

But If I use OverlayEntry 
then it's making loader for entire screen

Actually mine is package which is using some 60% of screen 
So my package is used in app 
and this package widget is given 60% area on screen
So ideally loading indicator should only spread in that 60% area only
---

Thanks — that's a key detail. Since your **package/widget only occupies 60% of the screen**, and you're **showing a loading indicator scoped to that portion**, the **ideal solution is *not* using the global `Overlay.of(context, rootOverlay: true)`**, but instead:

---

## ✅ Solution: Use a Local `Overlay` within Your Widget Tree

Instead of relying on the root-level `Overlay` (used by `OverlayPortal`), you should:

1. Create a **local `Overlay`** inside your package’s widget.
2. Wrap your package widget’s 60% area with an `Overlay` widget.
3. Insert the loading `OverlayEntry` there, which ensures:

   * It appears **above your dropdowns/popups within your package**
   * It stays **within your 60% scoped area**

---

### ✅ Why this works

* `OverlayPortal` inserts into the app's **root overlay**.
* A **local `Overlay`** ensures **you control the z-index** of overlays *within* your widget.
* You now have:

  * Popup overlay (`OverlayPortal` → root overlay → *beneath*)
  * Loading overlay (`OverlayEntry` → local overlay → *above*)

---

### ✅ How to Implement

```dart
class MyPackageWidget extends StatefulWidget {
  @override
  State<MyPackageWidget> createState() => _MyPackageWidgetState();
}

class _MyPackageWidgetState extends State<MyPackageWidget> {
  final _overlayKey = GlobalKey<OverlayState>();
  OverlayEntry? _loadingEntry;

  void _showLoading() {
    if (_loadingEntry != null) return;

    _loadingEntry = OverlayEntry(
      builder: (context) => Positioned.fill(
        child: ColoredBox(
          color: Colors.black45,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );

    _overlayKey.currentState?.insert(_loadingEntry!);
  }

  void _hideLoading() {
    _loadingEntry?.remove();
    _loadingEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Overlay(
      key: _overlayKey,
      initialEntries: [
        OverlayEntry(
          builder: (context) => Stack(
            children: [
              // Your 60% widget UI here
              YourMainWidget(
                onLoadStart: _showLoading,
                onLoadEnd: _hideLoading,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
```

---

### ⚠️ Additional Notes

* **`OverlayPortal` popups will still go to the app's root overlay**, so your local loading indicator (in a scoped overlay) can cleanly go above them **within your package's bounds**.
* Ensure **your popups do not break layout bounds**, or they might render *outside* your 60% region — causing the visual layering issue again.

---

### 💡 TL;DR

Since you're building a **partial-screen package**, not a full-screen app:

* ✅ Use a **local `Overlay`** inside your package widget.
* ✅ Insert loading indicator via `OverlayEntry` into this local overlay.
* ✅ This avoids global layering issues with root `OverlayPortal`-based popups.

Let me know if you want a clean reusable `LoadingOverlay` widget built around this!



