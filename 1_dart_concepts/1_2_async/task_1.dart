import 'dart:async';

class Chat {
  Chat(this.onRead);

  final void Function(int message) onRead;

  final List<int> messages = List.generate(30, (i) => i);

  Timer? _debounceTimer;

  int? _latestMessage;

  void read(int message) {
    _latestMessage = message;

    _debounceTimer?.cancel();

    _debounceTimer = Timer(Duration(seconds: 1), () {
      if (_latestMessage != null) {
        onRead(_latestMessage!);
        _latestMessage = null;
      }
    });
  }

  void dispose() {
    _debounceTimer?.cancel();
  }
}

Future<void> main() async {
  final Chat chat = Chat((i) => print('Read until $i'));

  chat.read(0);

  await Future.delayed(Duration(milliseconds: 1000));

  chat.read(4);
  await Future.delayed(Duration(milliseconds: 100));
  chat.read(10);
  await Future.delayed(Duration(milliseconds: 100));
  chat.read(11);
  await Future.delayed(Duration(milliseconds: 100));
  chat.read(12);
  await Future.delayed(Duration(milliseconds: 100));
  chat.read(13);
  await Future.delayed(Duration(milliseconds: 100));
  chat.read(14);
  await Future.delayed(Duration(milliseconds: 100));

  chat.read(15);

  await Future.delayed(Duration(milliseconds: 1000));

  chat.read(20);

  await Future.delayed(Duration(milliseconds: 1000));

  chat.read(35);
  await Future.delayed(Duration(milliseconds: 100));
  chat.read(36);
  await Future.delayed(Duration(milliseconds: 500));
  chat.read(37);
  await Future.delayed(Duration(milliseconds: 800));

  chat.read(40);
}
