class CustomDateTime {
  final DateTime _dateTime;

  CustomDateTime.now() : _dateTime = DateTime.now();

  int get microsecondsSinceEpoch {
    print('-=-=-=-');
    return _dateTime.microsecondsSinceEpoch;
  }

  @override
  String toString() => _dateTime.toIso8601String();
}
