# patterns_factories_adapters

Ah, great question! Let me explain both approaches and their trade-offs:

**Approach 1 (What I Suggested) - Abstract Class + Adapter Pattern:**
```dart
abstract class _AppointmentInfo {
  String get groupId;
  // ... other properties
}

class _GuestApptInfoAdapter implements _AppointmentInfo {
  final GuestApptInfoModel model;
  _GuestApptInfoAdapter(this.model);
  @override String get groupId => model.groupId;
  // ... other properties
}
```

**Approach 2 (Model + Factories) - What you suggested:**
```dart
class _AppointmentInfo {
  final String groupId;
  // ... other properties
  
  _AppointmentInfo({
    required this.groupId,
    // ... other required properties
  });

  factory _AppointmentInfo.fromGuestApptInfo(GuestApptInfoModel model) {
    return _AppointmentInfo(
      groupId: model.groupId,
      // ... map other properties
    );
  }

  factory _AppointmentInfo.fromOtherModel(OtherModel model) {
    return _AppointmentInfo(
      groupId: model.someId, // different mapping
      // ... map other properties differently
    );
  }
}
```

**Trade-offs:**

Model + Factories Approach:
👍 Pros:
- Simpler to understand - just a data class with factory constructors
- More Dart-like approach (factories are common in Dart)
- Memory efficient as it creates a new object with just needed properties
- Clear immutability if properties are final

👎 Cons:
- Creates new objects, copying data
- If source model changes, we need to update all factory constructors
- More memory usage as we're duplicating data

Abstract Class + Adapter:
👍 Pros:
- No data copying - just delegates to original object
- Memory efficient - just wrapper references
- If source model changes, only adapter needs updating
- True "duck typing" - any object that has these properties can work

👎 Cons:
- More complex pattern to understand
- Less common in Dart (more common in Java/C#)
- Mutable if source object is mutable
- Extra level of indirection when accessing properties

You're right to question this! The Model + Factories approach is probably better here because:
1. We're working in Dart where factories are idiomatic
2. The data set is small (appointment info) so memory isn't a big concern
3. It's simpler to understand and maintain
4. We get immutability for free with final properties

Would you like me to show how we would implement this using the Model + Factories approach instead?

---

## Essence of Adapter Pattern

The essence of the Adapter pattern is to make incompatible interfaces work together - it acts as a bridge between two incompatible interfaces. Think of it like a real-world power adapter:

**Real World Analogy:**
- You have a US electronic device (120V) but are in Europe (220V socket)
- You don't modify your device or the European socket
- Instead, you use a power adapter that makes them work together

**In Code Terms:**
```dart
// Existing interface/class we can't modify
class GuestApptInfoModel {
  String get groupId => ...;
  String get someOtherField => ...;
}

// Interface we want to work with
abstract class AppointmentInfo {
  String get id;
  String get status;
}

// Adapter makes GuestApptInfoModel work with AppointmentInfo
class GuestApptAdapter implements AppointmentInfo {
  final GuestApptInfoModel _model;  // <- Original object
  
  GuestApptAdapter(this._model);
  
  @override
  String get id => _model.groupId;  // <- Adapts groupId to id
  
  @override 
  String get status => ...;  // <- Adapts other fields as needed
}
```

Key Points:
1. **No Modification**: We don't change existing code (GuestApptInfoModel)
2. **Wrapper**: Adapter wraps the existing object and translates its interface
3. **Bridge**: Acts as a bridge between incompatible interfaces
4. **Delegation**: Forwards requests to the wrapped object with necessary translations

Common Use Cases:
1. Working with legacy code you can't modify
2. Making third-party libraries work with your system
3. Having multiple versions of an API work together
4. Converting data formats between systems

In our case though, since we're just extracting properties for internal use and not really making incompatible interfaces work together, a simple model with factories would be more appropriate. The Adapter pattern would be overkill unless we were truly trying to make different appointment systems work together.