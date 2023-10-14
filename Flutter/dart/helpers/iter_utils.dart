//iter_utils.dart

extension IterableUtils<T> on Iterable<T> {
  Iterable<U> enumerateMap<U>(
    U Function(int i, T e) fun, {
    int start = 0,
  }) {
    int idx = start; // current index
    return map((e) => fun(idx++, e));
  }
}