void main() {
  print(maxElement(['a', 'b', 'c']));
}

T maxElement<T extends Comparable<T>>(List<T> list) {
  if (list.isEmpty) {
    throw ArgumentError('List cannot be empty');
  }

  T max = list[0];
  for (final item in list) {
    if (item.compareTo(max) > 0) {
      max = item;
    }
  }
  return max;
}
