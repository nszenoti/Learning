# form_builder_isdirty_knowhow

Let me check the FormBuilderField implementation to understand how `isDirty` is handled in the fields.

[1 tool called]

Let me check the FormBuilderField to see how `_dirty` is managed:

[1 tool called]

Now I can explain why using `field.isDirty` might not be reliable enough:

1. `_dirty` is only set to true in `_informFormForFieldChange()` (Line 187):
```dart
void _informFormForFieldChange() {
  if (_formBuilderState != null) {
    _dirty = true;  // Set to true when field changes
    // ...
  }
}
```

2. It's only reset to false in `reset()` (Line 224):
```dart
void reset() {
  super.reset();
  didChange(initialValue);
  _dirty = false;  // Only reset when explicitly calling reset()
  // ...
}
```

The limitations of using `field.isDirty`:

1. It's a one-way flag - once set to true, it stays true until reset
2. It doesn't track what changed - just that something changed
3. It doesn't compare against initial values
4. If you call `reset()`, it will mark the field as not dirty even if the current value is different from the initial value

This is why comparing actual values (your current form values vs initial values) is more reliable than using `isDirty`, because:
1. It gives you the true state of changes
2. You can tell exactly what changed
3. It works correctly even after form operations like reset
4. It's not dependent on the internal dirty flag which might not accurately reflect the actual state of changes

So while `field.isDirty` is useful for simple change detection, for accurate form change tracking you should compare actual values instead.