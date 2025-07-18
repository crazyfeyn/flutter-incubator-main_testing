import 'dart:html';

class CustomDateTime {
  final int _milliseconds;
  final int _simulatedMicro;

  CustomDateTime.now()
      : _milliseconds = DateTime.now().millisecondsSinceEpoch,
        _simulatedMicro = (window.performance.now() * 1000).toInt() % 1000;

  int get microsecondsSinceEpoch {
    print('--00000--');
    return _milliseconds * 1000 + _simulatedMicro;
  }

  @override
  String toString() =>
      DateTime.fromMillisecondsSinceEpoch(_milliseconds).toIso8601String() +
      '.$_simulatedMicro';
}
