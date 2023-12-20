import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper; // Singleton DatabaseHelper
  static Database? _database; // Singleton Database

  String userTable = 'user';
  String colId = 'id';
  String colEmail = 'email';
  String colPassword = 'password';

  // Hardcoded user for testing
  static const Map<String, dynamic> hardcodedUser = {
    'email': 'arielwaz1',
    'password': 'cool1',
  };

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // executed only once since singleton object
    }
    return _databaseHelper!;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'user.db');

    var userDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
    return userDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''
      CREATE TABLE $userTable (
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colEmail TEXT,
        $colPassword TEXT
      )
    ''');

    await insertUser(hardcodedUser);
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    Database db = await this.database;
    return await db.insert(userTable, user);
  }

  Future<Map<String, dynamic>?> getUser(String email) async {
    Database db = await this.database;
    List<Map<String, dynamic>> result = await db.query(
      userTable,
      where: '$colEmail = ?',
      whereArgs: [email],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }
}
