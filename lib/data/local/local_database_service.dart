import 'package:sqflite/sqflite.dart';
import 'package:resto_app/data/model/resto.dart';

class LocalDatabaseService {
  static const String _databaseName = 'resto-app.db';
  static const String _tableName = 'resto';
  static const int _version = 1;

  Future<void> createTables(Database database) async {
    await database.execute(
      """CREATE TABLE $_tableName(
        id TEXT PRIMARY KEY,
        name TEXT,
        pictureId TEXT,
        city TEXT,
        rating REAL
      )
      """,
    );
  }

  Future<Database> _initializeDb() async {
    return openDatabase(
      _databaseName,
      version: _version,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

  Future<int> insertItem(Resto resto) async {
    final db = await _initializeDb();

    final data = resto.toJson();
    final rowId = await db.insert(
      _tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return rowId;
  }

  Future<List<Resto>> getAllItems() async {
    final db = await _initializeDb();
    final results = await db.query(_tableName);

    return results.map((result) => Resto.fromJson(result)).toList();
  }

  Future<Resto?> getItemById(String id) async {
    final db = await _initializeDb();
    final results =
        await db.query(_tableName, where: "id = ?", whereArgs: [id], limit: 1);

    return results.isEmpty ? null : Resto.fromJson(results.first);
  }

  Future<int> removeItem(String id) async {
    final db = await _initializeDb();

    final result =
        await db.delete(_tableName, where: "id = ?", whereArgs: [id]);
    return result;
  }
}
