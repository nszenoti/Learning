# hash_routing_flutter_web

Excellent question — this touches a very fundamental (and sometimes confusing) part of **Flutter web routing** and **URL structure** in general.

Let’s break it down clearly 👇

---

### 🔹 1. What a “path with hash” means

In Flutter web, you’ll often see URLs like:

```
https://example.com/#/home
```

instead of:

```
https://example.com/home
```

That `#` (called a **hash** or **fragment**) means Flutter is using **hash-based routing**.

---

### 🔹 2. Why Flutter uses hash routing

Browsers have two main ways to handle single-page app (SPA) routing:

#### ✅ (A) **Hash-based routing**

* The part after `#` is *not* sent to the server.
* Browser treats it as a **client-side navigation hint**.
* So your app (Flutter, React, etc.) can change “routes” without reloading the page.
* Example:

  ```
  https://example.com/#/profile
  ```

  Browser requests only `/` once.
  Then Flutter reads `/profile` from the hash and shows the `ProfilePage`.

➡️ **Advantage:** No need for special server configuration.
➡️ **Disadvantage:** URLs look a bit ugly and are less SEO-friendly.

---

#### ✅ (B) **Path-based routing**

* The route is part of the normal URL path:

  ```
  https://example.com/profile
  ```
* Flutter intercepts navigation events to change views.
* But if someone directly refreshes `/profile`, the **server** must be configured to serve the same `index.html` (since Flutter handles the route in JS).

➡️ **Advantage:** Cleaner, SEO-friendly URLs.
➡️ **Disadvantage:** Needs server rewrite rules.

---

### 🔹 3. Can we have query parameters *after* the hash?

Yes — but the order and meaning change depending on **where** you put them.

#### Case 1 — Query before hash (server-level)

```
https://example.com/?lang=en#/
```

* `?lang=en` is a **query parameter** visible to both browser and server.
* The hash (`#/`) still controls the Flutter route.

#### Case 2 — Query after hash (Flutter-level)

```
https://example.com/#/products?id=42
```

* The browser ignores this on the network level.
* Flutter (using `go_router` or `Navigator 2.0`) can read `id=42` as a route parameter.
* It’s **entirely client-side**.

So yes, you can have query params after a hash — but they’re not “real” HTTP query params.

---

### 🔹 4. Example with `go_router`

```dart
GoRoute(
  path: '/products',
  builder: (context, state) {
    final id = state.uri.queryParameters['id'];
    return ProductPage(id: id);
  },
);
```

If the URL is:

```
https://example.com/#/products?id=42
```

then `state.uri.queryParameters['id']` → `"42"`

---

### 🔹 5. Summary Table

| URL Example       | Type                           | Who handles it   | Notes                     |
| ----------------- | ------------------------------ | ---------------- | ------------------------- |
| `/home`           | Path-based                     | Server + Flutter | Needs rewrite rules       |
| `/#/home`         | Hash-based                     | Flutter only     | Default safer option      |
| `/?lang=en#/home` | Query (server) + hash (client) | Both             | Mixed                     |
| `/#/home?id=42`   | Query inside hash              | Flutter only     | Works fine in `go_router` |

---

### 🔹 6. Changing behavior

In Flutter Web:

* **Default**: hash-based URLs
* You can switch to **path-based URLs** by setting:

  ```dart
  usePathUrlStrategy();
  ```

  (from `flutter_web_plugins`)

  ```dart
  import 'package:flutter_web_plugins/flutter_web_plugins.dart';

  void main() {
    usePathUrlStrategy();
    runApp(MyApp());
  }
  ```

---

### 🧠 TL;DR

| Aspect                  | Hash Routing (`/#/page`) | Path Routing (`/page`) |
| ----------------------- | ------------------------ | ---------------------- |
| Needs server config?    | ❌ No                     | ✅ Yes                  |
| SEO-friendly            | ❌ No                     | ✅ Yes                  |
| Query params after hash | ✅ Flutter-only           | ✅ Normal               |
| Default in Flutter      | ✅ Yes                    | ❌ No                   |

---

Would you like me to show a quick **example comparing both hash and path modes with query param handling** in Flutter (using `go_router`)?
