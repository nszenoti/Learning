//multiple_listenable_notifier.dart

class CombinedValueListenable<T> extends ValueNotifier<T> {
  final List<Listenable> listenables;
  final T Function() computeValue;

  CombinedValueListenable({
    required this.listenables,
    required this.computeValue,
  }) : super(computeValue()) {
    for (final listenable in listenables) {
      listenable.addListener(_updateValue);
    }
  }

  void _updateValue() {
    value = computeValue();
  }

  @override
  void dispose() {
    for (final listenable in listenables) {
      listenable.removeListener(_updateValue);
    }
    super.dispose();
  }
}


// ------

final firstNotifier = ValueNotifier<bool>(true);
final secondNotifier = ValueNotifier<bool>(false);

// Combine the two ValueNotifiers
final combinedNotifier = CombinedValueListenable<bool>(
  listenables: [firstNotifier, secondNotifier],
  computeValue: () => firstNotifier.value && secondNotifier.value,
);

// Widget that listens to the combined notifier
class CombinedValidatorWidget extends StatelessWidget {
  final ValueListenable<bool> combinedNotifier;

  const CombinedValidatorWidget({required this.combinedNotifier});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: combinedNotifier,
      builder: (context, isValid, child) {
        return Text(isValid ? 'Valid' : 'Invalid');
      },
    );
  }
}

// Example usage in a widget tree
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: CombinedValidatorWidget(combinedNotifier: combinedNotifier),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        // Toggle values to test
        firstNotifier.value = !firstNotifier.value;
        secondNotifier.value = !secondNotifier.value;
      },
      child: Icon(Icons.refresh),
    ),
  );
}