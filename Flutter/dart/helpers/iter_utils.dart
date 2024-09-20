//iter_utils.dart

extension IterableUtils<T> on Iterable<T> {
  Iterable<U> enumerateMap<U>(
    U Function(int i, T e) fun, {
    int start = 0,
  }) {
    int idx = start; // current index
    return map((e) => fun(idx++, e));
  }

  List seperatedBy(dynamic seperator) {
    if(isEmpty){
      return List.empty();
    }
    final itr = iterator;
    return List.generate((length * 2) - 1, (i) {
      if (i.isEven) {
        itr.moveNext();
        return itr.current;
      }
      return seperator;
    });
  }

  Iterable<E> filterMap<E>({
    required bool Function(T) filterFunc,
    required E Function(T) mapFunc,
  }) sync* {
    final itr = iterator;
    while (itr.moveNext()) {
      final cur = itr.current;
      if (filterFunc(cur)) {
        yield mapFunc(cur);
      }
    }
  }

  /// return true if [test] return true for single element
  /// <br>
  /// In case of empty iterable, returns false
  bool any(bool Function(T e) test) {
    final itr = iterator;
    while (itr.moveNext()) {
      if (test(itr.current)) {
        return true;
      }
    }
    return false;
  }

  /// return true if [test] return true for all elements
  /// <br>
  /// In case of empty iterable, returns true
  bool all(bool Function(T e) test) {
    final itr = iterator;
    while (itr.moveNext()) {
      if (!test(itr.current)) {
        return false;
      }
    }
    return true;
  }

  Iterable<List<T>> batched(int n) sync* {
    if (n < 1) throw Exception('n must be atleast 1');

    final iter = iterator;

    int count = 0;
    final batch = <T>[];
    while (iter.moveNext()) {
      print('Moving to next $count');
      batch.add(iter.current);
      count++;
      if (count == n) {
        yield List.from(batch);
        // reset
        count = 0;
        batch.clear();
      }
    }
  }
}