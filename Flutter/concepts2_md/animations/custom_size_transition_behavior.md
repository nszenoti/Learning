# custom_size_transition

Checking how `CustomSizeTransition` handles widget lifecycle to determine if `expansionBuilder` widgets are retained or destroyed.


[2 tools called]


Reading the full `CustomSizeTransition` implementation:

QUE

Can you tell me when it toggles ie via CustomSizeTransition
then does expansionBuilder initState and dispose is called ?
or it will retained it and not destroy it

----


## Answer: Widgets are retained, not destroyed

The widgets created by `expansionBuilder` are retained in the widget tree. `initState` and `dispose` are not called on toggle.

### How it works:

1. In `ExpandableSettingOption`, `CustomSizeTransition` is used with an `animation` parameter, so it uses this path:
   ```dart
   return _builder(child, animation!);
   ```

2. `_builder` wraps the child in:
   - `FadeTransition` (opacity)
   - `SizeTransition` (size)

3. Both are implicit animations that only change visual appearance. They do not remove the child from the widget tree.

### Lifecycle behavior:

- `initState`: Called once when the widget is first created (when `ExpandableSettingOption` is first built with `isExpanded = true`)
- `dispose`: Called once when `ExpandableSettingOption` is removed from the tree
- On toggle: The widget stays in the tree; only opacity and size change
  - Collapsed: `sizeFactor = 0`, `opacity = 0` (hidden but still in tree)
  - Expanded: `sizeFactor = 1`, `opacity = 1` (visible)

### Implications:

- State is preserved when collapsing/expanding
- Controllers, listeners, and subscriptions remain active
- No need to reinitialize on expand
- If you need cleanup on collapse, handle it manually (e.g., in `didUpdateWidget`)

If you need widgets to be destroyed/recreated on toggle, use `AnimatedSwitcher` or conditionally build the widget based on `isExpanded`.