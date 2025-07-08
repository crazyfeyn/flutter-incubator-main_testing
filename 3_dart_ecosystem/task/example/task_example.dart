import 'package:task/task.dart';

void main() {
  final calculator = Calculator();
  print('2+3= ${calculator.sum(2, 3)}');
  print('5-3= ${calculator.subtract(5, 3)}');
  print('5*3= ${calculator.multiply(5, 3)}');
  print('6/3= ${calculator.divide(6, 3)}');
}
