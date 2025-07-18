import 'dart:async';
import 'dart:math';

class Server {
  StreamController<int>? _controller;
  Timer? _timer;

  void init() async {
    Random random = Random();

    while (true) {
      _controller = StreamController();
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        _controller?.add(timer.tick);
      });

      await Future.delayed(
        Duration(milliseconds: (1000 + (5000 * random.nextDouble())).round()),
      );
      _controller?.addError(DisconnectedException());
      _controller?.close();
      _controller = null;
      _timer?.cancel();
      _timer = null;

      await Future.delayed(
        Duration(milliseconds: (1000 + (5000 * random.nextDouble())).round()),
      );
    }
  }

  Future<Stream<int>> connect() async {
    if (_controller != null) {
      return _controller!.stream;
    } else {
      throw DisconnectedException();
    }
  }
}

class Client {
  Future<void> connect(Server server) async {
    const int maxDelaySeconds = 30;
    int delaySeconds = 1;

    while (true) {
      try {
        final stream = await server.connect();
        print('Connected to server');

        delaySeconds = 1;

        await for (final data in stream) {
          print('Received: $data');
        }
      } on DisconnectedException {
        print('Connection failed, retrying in $delaySeconds seconds...');
        await Future.delayed(Duration(seconds: delaySeconds));
        delaySeconds = min(delaySeconds * 2, maxDelaySeconds);
      } catch (e) {
        print('Unexpected error: $e');
        await Future.delayed(Duration(seconds: delaySeconds));
        delaySeconds = min(delaySeconds * 2, maxDelaySeconds);
      }
    }
  }
}

Future<void> main() async {
  Client()..connect(Server()..init());
}

class DisconnectedException implements Exception {}
