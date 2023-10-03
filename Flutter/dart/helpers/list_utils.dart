// list_utils

extension IterableUtils<T> on Iterable<T> {
  Iterable<U> enumerateMap<U>(
    U Function(int i, T e) fun, {
    int start = 0,
  }) {
    int idx = start; // current index
    return map((e) => fun(idx++, e));
  }

  T get firstOrNull => this.isEmpty ? null : this.first;
  T get lastOrNull => this.isEmpty ? null : this.last;
}
