SetState on OverlayEntry
----

Great question about the traditional `Overlay` and `OverlayEntry` approach!

## Overlay vs OverlayPortal State Management

When using the traditional `Overlay.of(context).insert(OverlayEntry())` approach, the behavior is quite different:

### Traditional Overlay + OverlayEntry:

1. **NOT automatically rebuilt**: When you call `setState()` in the parent widget, the `OverlayEntry` will **NOT** automatically rebuild.

2. **Separate widget tree**: Unlike `OverlayPortal`, an `OverlayEntry` creates a separate widget subtree that's disconnected from the parent widget's build cycle.

3. **Manual updates required**: To update the content of an `OverlayEntry`, you need to explicitly call `overlayEntry.markNeedsBuild()` or create a new `OverlayEntry` and replace the old one.

### Example with traditional Overlay:

```dart
// In parent widget
late OverlayEntry _overlayEntry;
Set<YourItemType> _selectedItems = {};

void _showOverlay() {
  _overlayEntry = OverlayEntry(
    builder: (context) {
      return PopupMenu<YourItemType>(
        // ... other properties
        isMultiSelect: _isMultiSelect,
        selectedItems: _selectedItems,
        onSelect: _handleItemSelect,
      );
    },
  );
  
  Overlay.of(context).insert(_overlayEntry);
}

void _handleItemSelect(YourItemType item) {
  if (_isMultiSelect) {
    // Toggle selection
    setState(() {
      if (_selectedItems.contains(item)) {
        _selectedItems.remove(item);
      } else {
        _selectedItems.add(item);
      }
    });
    
    // Must explicitly rebuild the overlay
    _overlayEntry.markNeedsBuild();
  } else {
    // Single select - close overlay and use the item
    _overlayEntry.remove();
    _useSingleSelectedItem(item);
  }
}
```

## Key Differences:

1. With `OverlayPortal`, the overlay content is part of your widget's build method and rebuilds automatically when state changes.

2. With traditional `Overlay`+`OverlayEntry`, you must manually call `markNeedsBuild()` to update the overlay content after state changes.

This is one of the main advantages of the newer `OverlayPortal` API - it simplifies state management by keeping the overlay content connected to your widget's build cycle.

So to directly answer your question: No, the same theory does not apply. With traditional overlays, the `OverlayEntry` is indeed "unbothered" by `setState` calls in the widget that created it, and you need to explicitly tell it to rebuild.
