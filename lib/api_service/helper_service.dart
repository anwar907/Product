extension ExtendedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }

  void forEachIndexed(void Function(E e, int i) f) {
    var i = 0;
    forEach((e) => f(e, i++));
  }

  Iterable<int> indexesWhere(bool Function(E e) f) sync* {
    int elementIndex = 0;
    for (E element in this) {
      if (f(element)) yield elementIndex;
      elementIndex++;
    }
  }
}
