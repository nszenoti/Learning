# static_vs_dynamic

**Yes, exactly two ways:**

1. **`@JS` static declarations** (compile-time binding)
   - Primitives auto-convert
   - Type-safe, self-documenting
   - For known JS APIs

2. **`JSObject` dynamic manipulation** (runtime binding)
   - **Manual `.toJS` required**
   - Flexible, no code-gen
   - For generic bridges, dynamic data

**Choice**: Use `@JS` for stable APIs, `JSObject` for runtime registries like your `JsBridge`.