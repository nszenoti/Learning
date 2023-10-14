/// Count the frequency of each element in [lst]
/// param lst: list whose elements frequency needs to be counted !
Map<T, int> counter<T>(List<T> lst) {
  final m = <T, int>{};
  for (final k in lst) {
    m[k] = (m[k] ?? 0) + 1;
  }
  return m;
}

/// Sort the given list [lst]
/// param lst: lst to be sorted
/// param key: use to compare 2 elements
/// param desc: sort in descending order
List<T> sorted<T extends Comparable>(
  List<T> lst, {
  Comparable Function(T e)? key,
  bool desc = false,
}) {
  final res = [...lst];
  if (key == null) {
    if (desc) {
      res.sort((a, b) => b.compareTo(a));
    } else {
      res.sort((a, b) => a.compareTo(b));
    }
  } else {
    if (desc) {
      res.sort((a, b) => key(b).compareTo(key(a)));
    } else {
      res.sort((a, b) => key(a).compareTo(key(b)));
    }
  }
  return res;
}

List<T> enumerateMap<E, T>(
  T Function(int i, E e) fun,
  List<E> src, {
  int start = 0,
}) =>
    List.generate(src.length, (i) => fun(i + start, src[i]));

int bisect<T extends Comparable>(List<T> lst, T x) {
  if (lst.isEmpty) return 0;
  int lo = 0, hi = lst.length - 1;
  // At the end {lo} will point to next possible loc
  while (lo <= hi) {
    final mid = lo + (hi - lo) ~/ 2;
    final elm = lst[mid];
    if (x.compareTo(elm) < 0) {
      // a < b
      hi = mid - 1;
    } else {
      lo = mid + 1;
    }
  }
  return lo;
}

void insort<T>(List<T> elms, T x, {Comparable Function(T e)? key}) {
  if (elms.isEmpty) {
    elms.add(x);
    return;
  }
  if (key == null) {
    if (elms[0] is! Comparable) {
      throw "${T.toString()} must be comparable in absence of key";
    }
    key = (e) => e as Comparable;
  }

  final lst = [for (final e in elms) key(e)];
  final toInsert = key(x);
  final idx = bisect(lst, toInsert);

  elms.insert(idx, x);
}


List<int> range({required int end, int start = 0, int step = 1}) {
  assert(end >= 0, 'end must be +ve');
  assert(start >= 0, 'start must be +ve');
  assert(step >= 0, 'start must be +ve');

  var lst = <int>[];
  var val = start;
  while (val < end) {
    lst.add(val);
    val += step;
  }
  return lst;
}