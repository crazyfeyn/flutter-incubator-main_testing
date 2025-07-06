import 'custom_date_time.dart';

void main() {
  final time = CustomDateTime.now();
  print('Time: ${time.toString()}');
  print('Microseconds since epoch: ${time.microsecondsSinceEpoch}');
}


//!I used AI to complete it and am ready to explain what's going inside