import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MathTablesDatabase {
  late Database _database;
  String _tableName = 'math_tables';

  Future<void> open() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'math_tables.db');

    _database = await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('''
        CREATE TABLE math_tables (
          id INTEGER PRIMARY KEY,
          table_number INTEGER,
          lower_limit INTEGER,
          upper_limit INTEGER
        )
      ''');
    });
  }

  Future<void> close() async {
    await _database.close();
  }

  Future<void> insert(MathTable mathTable) async {
    await _database.rawInsert('''
      INSERT INTO math_tables (table_number, lower_limit, upper_limit)
      VALUES (?, ?, ?)
    ''', [mathTable.tableNumber, mathTable.lowerLimit, mathTable.upperLimit]);
  }

  Future<List<MathTable>> getAllMathTables() async {
    List<Map<String, dynamic>> result =
        await _database.rawQuery('SELECT * FROM math_tables');
    return result.map((map) => MathTable.fromMap(map)).toList();
  }

  Future<MathTable?> getMathTableById(int id) async {
    List<Map<String, dynamic>> result = await _database
        .rawQuery('SELECT * FROM math_tables WHERE id = ?', [id]);
    if (result.isNotEmpty) {
      return MathTable.fromMap(result.first);
    }
    return null;
  }

  Future<void> update(MathTable mathTable) async {
    await _database.rawUpdate('''
      UPDATE math_tables 
      SET table_number = ?, lower_limit = ?, upper_limit = ? 
      WHERE id = ?
    ''', [
      mathTable.tableNumber,
      mathTable.lowerLimit,
      mathTable.upperLimit,
      mathTable.id
    ]);
  }

  Future<void> delete(int id) async {
    await _database.rawDelete('DELETE FROM math_tables WHERE id = ?', [id]);
  }

  Future<void> deleteAll() async {
    await _database.rawDelete('DELETE FROM $_tableName');
  }
}

class MathTable {
  int id;
  int tableNumber;
  int lowerLimit;
  int upperLimit;

  MathTable({
    required this.id,
    required this.tableNumber,
    required this.lowerLimit,
    required this.upperLimit,
  });

  MathTable.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        tableNumber = map['table_number'],
        lowerLimit = map['lower_limit'],
        upperLimit = map['upper_limit'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'table_number': tableNumber,
      'lower_limit': lowerLimit,
      'upper_limit': upperLimit,
    };
  }
}
