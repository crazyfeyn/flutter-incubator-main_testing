import 'dart:io';
import 'dart:isolate';
import 'dart:math';

void main() async {
  // Write a program calculating a sum of all prime numbers from 1 to N using
  // [Isolate]s to speed up the algorithm.

  const n = 1000000;
  final sum = await sumOfPrimesWithIsolate(n);
  print('Sum is: $sum');
}

Future<int> sumOfPrimesWithIsolate(int n) async {
  final numberOfIsolates = max(1, Platform.numberOfProcessors - 1);
  final perIsolate = n ~/ numberOfIsolates;
  final results = <Future<int>>[];

  for (int i = 0; i < numberOfIsolates; i++) {
    final receivePort = ReceivePort();
    final start = i * perIsolate;
    final end = (i == numberOfIsolates) ? n : (i + 1) * perIsolate;

    final isolate = await Isolate.spawn(
      _calculatePartialSum,
      _IsolateData(start, end, receivePort.sendPort),
    );

    results.add(receivePort.first.then((value) {
      receivePort.close();
      isolate.kill();
      return value as int;
    }));
  }

  final partialSums = await Future.wait(results);
  return partialSums.reduce((a, b) => a + b);
}

class _IsolateData {
  final int start;
  final int end;
  final SendPort sendPort;

  _IsolateData(this.start, this.end, this.sendPort);
}

void _calculatePartialSum(_IsolateData data) {
  int sum = 0;
  for (int i = data.start; i <= data.end; i++) {
    if (_isPrimeFunc(i)) {
      sum += i;
    }
  }
  data.sendPort.send(sum);
}

bool _isPrimeFunc(int number) {
  if (number <= 1) return false;
  if (number == 2) return true;
  if (number % 2 == 0) return false;

  final boundary = sqrt(number).toInt();
  for (int i = 3; i <= boundary; i += 2) {
    if (number % i == 0) return false;
  }
  return true;
}
