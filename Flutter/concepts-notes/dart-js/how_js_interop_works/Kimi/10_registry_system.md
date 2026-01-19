# 10_registry_system

**Ground reality:**

1. **Registry is owned and maintained by the Dart runtime** (a global C++ or internal Dart data structure), not by `JSFunction` or `JSAny` objects.

2. **Lifecycle is controlled by the wrapper objects:**
   - **Creation**: When you call `callback.toJS`, the runtime creates the registry entry, then creates the `JSFunction` wrapper that **holds a reference to that entry**.
   - **Deletion**: When the `JSFunction` wrapper is garbage collected, its finalizer tells the runtime to delete the registry entry.

**The wrapper is a GC root for the registry entry.** The registry itself is invisible to you; you only interact with it indirectly through the wrapper's lifecycle.

**Without a stored wrapper:** Registry entry is immediately eligible for deletion → JS stub's handle becomes invalid.