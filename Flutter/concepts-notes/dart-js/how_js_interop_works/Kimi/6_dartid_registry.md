# 6_dartid_registry

**Yes. Ground reality:**

1. **`dartId`** is a numeric key (e.g., `0xABCD`) assigned to your callback in a **Dart-side registry**
2. **JS stub** is generated with this ID **hardcoded** in its body: `dartRuntime.invoke(0xABCD, args)`
3. **`JSFunction`** is the **Dart-side representation** of that JS stub—it holds the same `dartId` and a reference to the original Dart callback

The JS stub and `JSFunction` are linked **only** by this shared `dartId`. They don't hold direct references to each other.

----
