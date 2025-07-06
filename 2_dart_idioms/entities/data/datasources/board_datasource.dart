import '../../domain/entities/board_entity.dart';

class BoardDatasource {
  final List<BoardEntity> _boards = [];

  Future<BoardEntity> createBoard(String title) async {
    final board =
        BoardEntity(id: BoardId('board_${_boards.length + 1}'), title: title);
    _boards.add(board);
    return board;
  }

  Future<List<BoardEntity>> getAllBoards() async {
    return _boards;
  }
}
