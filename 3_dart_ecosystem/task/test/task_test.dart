import 'package:test/test.dart';
import 'package:task/task.dart';

void main() {
  late Calculator calculator;

  setUp(() {
    calculator = Calculator();
  });

  group('Calculator', () {
    test('sum should add two numbers correctly', () {
      expect(calculator.sum(1, 2), equals(3));
      expect(calculator.sum(-5, 3), equals(-2));
      expect(calculator.sum(0, 0), equals(0));
    });

    test('subtract should subtract two numbers correctly', () {
      expect(calculator.subtract(5, 3), equals(2));
      expect(calculator.subtract(3, 5), equals(-2));
      expect(calculator.subtract(0, 0), equals(0));
    });

    test('multiply should multiply two numbers correctly', () {
      expect(calculator.multiply(5, 3), equals(15));
      expect(calculator.multiply(-5, 3), equals(-15));
      expect(calculator.multiply(0, 5), equals(0));
    });

    test('divide should divide two numbers correctly', () {
      expect(calculator.divide(6, 3), equals(2));
      expect(calculator.divide(5, 2), equals(2.5));
    });

    test('divide should throw ArgumentError when dividing by zero', () {
      expect(() => calculator.divide(5, 0), throwsArgumentError);
    });
  });
}
