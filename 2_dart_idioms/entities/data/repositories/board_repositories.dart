import '../../domain/entities/board_entity.dart';
import '../../domain/repositories/repositories.dart';
import '../datasources/board_datasource.dart';

class BoardRepositoriesImpl extends BoardsRepository {
  BoardDatasource boardDatasource;

  BoardRepositoriesImpl({required this.boardDatasource});

  @override
  Future<BoardEntity> createBoard(String title) {
    return boardDatasource.createBoard(title);
  }

  @override
  Future<List<BoardEntity>> getAllBoards() {
    return boardDatasource.getAllBoards();
  }
}
