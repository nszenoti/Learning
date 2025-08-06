Yes, you're spot on with both observations!

**1. Similar to OverflowBox:**
`Align(heightFactor: 1.0)` and `OverflowBox` both can cause the child to ignore parent size constraints:
- `Align(heightFactor: 1.0)`: "Make me the same height as my child, regardless of parent constraints"
- `OverflowBox`: "Let child render at natural size, regardless of parent constraints"

Both create similar constraint-breaking behavior!

**2. Unusual Pattern:**
Yes, `Align` inside `ClipRect` is quite unusual:
- `ClipRect` is meant for clipping overflowing content
- `Align` is meant for positioning within available space
- Combining them creates this weird hybrid behavior

**Normal patterns would be:**
```dart
// For positioning:
Align(child: child)

// For clipping overflow:
ClipRect(child: child)

// For both:
ClipRect(
  child: Align(child: child)  // But usually without heightFactor tricks
)
```

Your instinct is right - the current code is doing something unconventional. The `Align` with `heightFactor: 1.0` inside `ClipRect` is basically a roundabout way to achieve what `OverflowBox` does more directly.

Just using `ClipRect(child: child)` directly is the most straightforward approach.