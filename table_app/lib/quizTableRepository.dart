import 'quizTablesDatabase.dart';

class QuizTableRepository {
  final QuizTablesDatabase _database = QuizTablesDatabase();

  Future<void> addQuizTable(QuizTable quizTable) async {
    await _database.open();
    await _database.insert(quizTable);
    await _database.close();
  }

  Future<List<QuizTable>> getAllQuizTables() async {
    await _database.open();
    List<QuizTable> quizTables = await _database.getAllQuizTables();
    await _database.close();
    return quizTables;
  }

  Future<QuizTable?> getQuizTableById(int id) async {
    await _database.open();
    QuizTable? quizTable = await _database.getQuizTableById(id);
    await _database.close();
    return quizTable;
  }

  Future<void> updateQuizTable(QuizTable quizTable) async {
    await _database.open();
    await _database.update(quizTable);
    await _database.close();
  }

  Future<void> deleteQuizTable(int id) async {
    await _database.open();
    await _database.delete(id);
    await _database.close();
  }

  Future<void> deleteAllQuizTables() async {
    await _database.open();
    await _database.deleteAll();
    await _database.close();
  }
}
