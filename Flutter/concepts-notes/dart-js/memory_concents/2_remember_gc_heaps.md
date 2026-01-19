2_remember_gc_heaps

**Top-level functions** (static symbols) are **permanently reachable** and won't be GC'd. You could skip `_callbacks` **only if**:
- You **never** register anonymous closures or instance methods
- You **never** unregister individual callbacks

**But your `registerCallback` accepts `Function callback` - it can't guarantee this.** Someone will eventually pass `() => print('hi')` and crash.

**`_callbacks` protects against this.** It's cheap insurance. Use it.