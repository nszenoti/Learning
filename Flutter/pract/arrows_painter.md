# arrows_painter.md


```dart
arrowPath
  ..moveTo(size.width / 2.0, 0.0)    // Start from top middle
  ..lineTo(0.0, size.height)         // Draw to bottom left
  ..lineTo(size.width, size.height);  // Draw to bottom right

```

```dart
arrowPath
  ..moveTo(0.0, size.height)         // Start from bottom left
  ..lineTo(size.width, size.height)  // Draw bottom line
  ..lineTo(size.width / 2.0, 0.0);   // Point to top middle
```
