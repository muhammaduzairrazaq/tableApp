import 'mathTablesDatabase.dart';


class MathTableRepository {
  final MathTablesDatabase _database = MathTablesDatabase();

  Future<void> addMathTable(MathTable mathTable) async {
    await _database.open();
    await _database.insert(mathTable);
    await _database.close();
  }

  Future<List<MathTable>> getAllMathTables() async {
    await _database.open();
    List<MathTable> mathTables = await _database.getAllMathTables();
    await _database.close();
    return mathTables;
  }


  Future<MathTable?> getMathTableById(int id) async {
    await _database.open();
    MathTable? mathTable = await _database.getMathTableById(id);
    await _database.close();
    return mathTable;
  }

  Future<void> updateMathTable(MathTable mathTable) async {
    await _database.open();
    await _database.update(mathTable);
    await _database.close();
  }

  Future<void> deleteMathTable(int id) async {
    await _database.open();
    await _database.delete(id);
    await _database.close();
  }

  Future<void> deleteAllMathTables() async {
    await _database.open();
    await _database.deleteAll();
    await _database.close();
  }
}
