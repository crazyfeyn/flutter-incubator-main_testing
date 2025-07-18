void main(List<String> args) {
  print(maxElement([1, 5, 3])); // int
  print(maxElement([1.2, 4.5, 2.1])); // double
  print(maxElement(['apple', 'banana'])); // String
}

T maxElement<T extends Comparable>(List<T> list) {
  if (list.isEmpty) {
    throw ArgumentError('List cannot be empty');
  }

  T max = list[0];

  for (var i in list) {
    if (i.compareTo(max) > 0) {
      max = i;
    }
  }
  return max;
}
