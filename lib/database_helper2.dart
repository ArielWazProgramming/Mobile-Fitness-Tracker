import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper2 {
  static final DatabaseHelper2 instance = DatabaseHelper2._privateConstructor();
  static Database? _database;

  DatabaseHelper2._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'fitness_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE settings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        food TEXT,
        password TEXT,
        height TEXT,
        width TEXT
      )
    ''');
  }

  Future<int> insertSetting(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('settings', row);
  }

  Future<List<Map<String, dynamic>>> getAllSettings() async {
    Database db = await instance.database;
    return await db.query('settings');
  }

  Future<int> updateSetting(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row['id'];
    return await db.update('settings', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteSetting(int id) async {
    Database db = await instance.database;
    return await db.delete('settings', where: 'id = ?', whereArgs: [id]);
  }
}
