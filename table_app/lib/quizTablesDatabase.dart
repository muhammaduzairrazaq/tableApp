import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class QuizTablesDatabase {
  late Database _database;
  String _tableName = 'quiz_tables';

  Future<void> open() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'quiz_tables.db');

    _database = await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('''
        CREATE TABLE quiz_tables (
          id INTEGER PRIMARY KEY,
          table_number INTEGER,
          quiz_type INTEGER,
          question_numbers INTEGER,
          marks INTEGER
        )
      ''');
    });
  }

  Future<void> close() async {
    await _database.close();
  }

  Future<void> insert(QuizTable quizTable) async {
    await _database.rawInsert('''
      INSERT INTO quiz_tables (table_number, quiz_type, question_numbers, marks)
      VALUES (?, ?, ?, ?)
    ''', [quizTable.tableNumber, quizTable.quizType, quizTable.questionNumbers, quizTable.marks]);
  }

  Future<List<QuizTable>> getAllQuizTables() async {
    List<Map<String, dynamic>> result = await _database.rawQuery('SELECT * FROM quiz_tables');
    return result.map((map) => QuizTable.fromMap(map)).toList();
  }

  Future<QuizTable?> getQuizTableById(int id) async {
    List<Map<String, dynamic>> result = await _database.rawQuery('SELECT * FROM quiz_tables WHERE id = ?', [id]);
    if (result.isNotEmpty) {
      return QuizTable.fromMap(result.first);
    }
    return null;
  }

  Future<void> update(QuizTable quizTable) async {
    await _database.rawUpdate('''
      UPDATE quiz_tables 
      SET table_number = ?, quiz_type = ?, question_numbers = ?, marks = ? 
      WHERE id = ?
    ''', [quizTable.tableNumber, quizTable.quizType, quizTable.questionNumbers, quizTable.marks, quizTable.id]);
  }

  Future<void> delete(int id) async {
    await _database.rawDelete('DELETE FROM quiz_tables WHERE id = ?', [id]);
  }

  Future<void> deleteAll() async {
    await _database.rawDelete('DELETE FROM $_tableName');
  }
}

class QuizTable {
  int id;
  int tableNumber;
  int quizType;
  int questionNumbers;
  int marks;

  QuizTable({
    required this.id,
    required this.tableNumber,
    required this.quizType,
    required this.questionNumbers,
    required this.marks,
  });

  QuizTable.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        tableNumber = map['table_number'],
        quizType = map['quiz_type'],
        questionNumbers = map['question_numbers'],
        marks = map['marks'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'table_number': tableNumber,
      'quiz_type': quizType,
      'question_numbers': questionNumbers,
      'marks': marks,
    };
  }
}
