abstract class ChatItem {}

class ChatMessage extends ChatItem {}

class ChatCall extends ChatItem {}

class ChatInfo extends ChatItem {}

class ChatForward extends ChatItem {}

abstract class ChatItemQuote {
  final ChatItem original;
  final DateTime at;

  const ChatItemQuote({
    required this.original,
    required this.at,
  });

  factory ChatItemQuote.from(ChatItem item) {
    final now = DateTime.now();
    if (item is ChatMessage) {
      return ChatMessageQuote(original: item, at: now);
    } else if (item is ChatCall) {
      return ChatCallQuote(original: item, at: now);
    } else if (item is ChatInfo) {
      return ChatInfoQuote(original: item, at: now);
    } else if (item is ChatForward) {
      return ChatForwardQuote(original: item, at: now);
    } else {
      throw ArgumentError('Unsupported ChatItem type: ${item.runtimeType}');
    }
  }
}

class ChatMessageQuote extends ChatItemQuote {
  const ChatMessageQuote({required super.original, required super.at});
}

class ChatCallQuote extends ChatItemQuote {
  const ChatCallQuote({required super.original, required super.at});
}

class ChatInfoQuote extends ChatItemQuote {
  const ChatInfoQuote({required super.original, required super.at});
}

class ChatForwardQuote extends ChatItemQuote {
  const ChatForwardQuote({required super.original, required super.at});
}
