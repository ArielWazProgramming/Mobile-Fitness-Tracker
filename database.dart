import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DateStore {
  late Database db; // open the database for storing the data

  Future open() async {
    // get a location using getDatabasepath

    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'demo1.db');
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
      create user if not exists rooms (
      id primary key auto_increment,
      username varchar(32) not null,
      password varchar(64) not null,
      height int not null,
      weight int not null
      );
      ''');
        });
  }

/*Future<Map<dynamic, dynamic>?> getStudent(int ssn) async {
    List<Map> maps =
    await db.query('rooms', where: 'ssn = ?', whereArgs: [ssn]);
    // getting student with roll no
    if (maps.length > 0) {
      return maps.first;
    }
    return null;
  }*/
}