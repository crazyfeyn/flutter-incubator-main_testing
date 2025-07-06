class BoardId {
  final String value;
  const BoardId(this.value);
}

class MessageId {
  final String value;
  const MessageId(this.value);
}

class Board {
  final BoardId id;
  final String title;

  Board({required this.id, required this.title});
}

class Message {
  final MessageId id;
  final BoardId boardId;
  final String content;
  final String? author;

  Message({
    required this.id,
    required this.boardId,
    required this.content,
    this.author,
  });
}
