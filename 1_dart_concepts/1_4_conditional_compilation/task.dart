import 'custom_date_time.dart';

void main() {
  final time = CustomDateTime.now();
  print('Time: ${time.toString()}');
  print('Microseconds since epoch: ${time.microsecondsSinceEpoch}');
}
