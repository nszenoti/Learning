# 10_jsfunc_n_handle_assoc

**`JSFunction` needs the handle for its own lifecycle management.**

The handle is **hardcoded into the JS stub's compiled code**—it's not a property you can read back. The wrapper stores it separately because:

1. **Identity**: It needs to know *which* registry entry it created/owns
2. **Cleanup**: When the wrapper is GC'd, its finalizer uses the handle to delete the registry entry
3. **No reverse lookup**: You can't do `window.fn.handle` to get `0xABCD`—it's embedded in the function body, not accessible at runtime

**The handle is the only link connecting the wrapper, the registry entry, and the JS stub.**

--

**Yes. Correct.**

The `JSFunction` wrapper is the **authoritative owner** of the handle ID on the Dart side. It stores it as an internal field. The Dart runtime/compiler maintains a **separate global registry** that maps that handle to the actual callback.

You can think of it as:
- **Wrapper**: "The ID is `12345`"
- **Registry**: `{12345: callback}`

When the wrapper is garbage collected, it tells the runtime: *"Delete ID `12345` from registry."*