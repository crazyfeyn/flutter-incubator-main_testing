import '../entities/board_entity.dart';

abstract class BoardsRepository {
  Future<BoardEntity> createBoard(String title);
  Future<List<BoardEntity>> getAllBoards();
}

abstract class MessagesRepository {
  Future<Message> postMessage({
    required BoardId boardId,
    required String content,
    String? author,
  });

  Future<List<Message>> getMessages(BoardId boardId);
}
