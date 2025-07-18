import 'dart:io';
import 'dart:isolate';
import 'dart:math';

void main(List<String> args) async {
  int n = 100;
  int sum = await sumOfPrimesWithIsolate(n);
  print(sum);
}

Future<int> sumOfPrimesWithIsolate(int n) async {
  final int numberOfIsolates = Platform.numberOfProcessors - 1;
  final int perIsolate = n ~/ numberOfIsolates;
  final result = <Future<int>>[];

  for (int i = 0; i < numberOfIsolates; i++) {
    final receivePort = ReceivePort();
    final start = i * perIsolate;
    final end = (i + 1) * perIsolate;

    final isolate = await Isolate.spawn(calculatePartialSum,
        IsolateData(start: start, end: end, sendPort: receivePort.sendPort));
    result.add(receivePort.first.then((value) {
      receivePort.close();
      isolate.kill();
      return value;
    }));
  }
  final partialSums = await Future.wait(result);
  return partialSums.reduce((a, b) => a + b);
}

void calculatePartialSum(IsolateData data) {
  int sum = 0;
  for (int i = data.start; i < data.end; i++) {
    if (isPrime(i)) {
      sum += i;
    }
  }
  data.sendPort.send(sum);
}

bool isPrime(int number) {
  if (number == 2) {
    return true;
  }
  if (number <= 1 || number % 2 == 0) {
    return false;
  }

  final boundary = sqrt(number).toInt();
  for (int i = 3; i <= boundary; i++) {
    if (number % i == 0) {
      return false;
    }
  }
  return true;
}

class IsolateData {
  final int start;
  final int end;
  final SendPort sendPort;

  IsolateData({required this.start, required this.end, required this.sendPort});
}
