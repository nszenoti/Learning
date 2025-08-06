Perfect! Let’s split this into **3 core algorithmic functions**, as you said:

---

### **INPUT ASSUMPTION (common to all):**
You have:
- List of words
- Each word’s frequency or corresponding font size
- Fixed box of size `width x height`

---

### **Variant 1: Position (dx, dy) using Spiral Search**

**Purpose**: Find a non-overlapping `(dx, dy)` for a given word using **spiral expansion** from center.

```dart
Offset? findSpiralPosition(Size wordSize, double width, double height, List<Rect> occupied) {
  double centerX = width / 2;
  double centerY = height / 2;
  double radius = 0;
  double angle = 0;
  double step = 5; // step size per spiral turn

  while (radius < width) {
    double dx = centerX + radius * math.cos(angle) - wordSize.width / 2;
    double dy = centerY + radius * math.sin(angle) - wordSize.height / 2;
    Rect newRect = Offset(dx, dy) & wordSize;

    if (dx >= 0 && dy >= 0 &&
        dx + wordSize.width <= width &&
        dy + wordSize.height <= height &&
        !occupied.any((r) => r.overlaps(newRect))) {
      occupied.add(newRect);
      return Offset(dx, dy);
    }

    angle += 0.5;
    if (angle >= 2 * math.pi) {
      angle = 0;
      radius += step;
    }
  }

  return null; // not found
}
```

---

### **Variant 2: Position (dx, dy) using Grid Search**

**Purpose**: A more brute-force, top-to-bottom left-to-right scan.

```dart
Offset? findGridPosition(Size wordSize, double width, double height, List<Rect> occupied) {
  const double gridStep = 10;

  for (double dy = 0; dy <= height - wordSize.height; dy += gridStep) {
    for (double dx = 0; dx <= width - wordSize.width; dx += gridStep) {
      Rect newRect = Offset(dx, dy) & wordSize;
      if (!occupied.any((r) => r.overlaps(newRect))) {
        occupied.add(newRect);
        return Offset(dx, dy);
      }
    }
  }

  return null;
}
```

---

### **Variant 3: Rotation Decision (0 or 90 degrees)**

**Purpose**: Decide if the word should be rotated based on width/height ratio of the box.

```dart
bool shouldRotate(String word, double fontSize, double boxAspectRatio) {
  // Simple heuristic: rotate long words if box is taller than wider
  if (boxAspectRatio < 1.0 && word.length > 6) {
    return true;
  }
  return false;
}
```

Alternate logic: Rotate every alternate word for aesthetics.

```dart
bool shouldRotateAlternating(int index) {
  return index % 2 == 0;
}
```

---

### Summary:

| Function | Purpose | Output |
|---------|---------|--------|
| `findSpiralPosition` | Elegant central spread | `(dx, dy)` |
| `findGridPosition` | Simple left-to-right layout | `(dx, dy)` |
| `shouldRotate` | Choose 0 or 90 rotation | `bool` |

---

Let me know which one you'd like me to demonstrate in Flutter first (or all 3 together), and I’ll build a full widget with a working layout.