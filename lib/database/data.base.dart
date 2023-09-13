import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DB {
  static Database? db;

  Future<Database> fetchData() async {
    if (db == null) {
      return await iniciarBancoDeDados();
    } else {
      return db!;
    }
  }

  Map<int, String> scripts = {
    1: ''' CREATE TABLE User (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  email TEXT,
  data TEXT,
  weight Real,
  height Real,
  description TEXT
);
  '''
  };

  Future<Database> iniciarBancoDeDados() async {
    var db = await openDatabase(
        path.join(await getDatabasesPath(), 'databaseuser.db'),
        version: scripts.length, onCreate: (Database db, int index) async {
      for (var i = 1; i <= scripts.length; i++) {
        await db.execute(scripts[i]!);
        print(scripts[i]);
      }
    }, onUpgrade: (Database db, int oldVerson, int newVerson) async {
      for (var i = 1; i <= scripts.length; i++) {
        await db.execute(scripts[i]!);
        print(scripts[i]);
      }
    });
    return db;
  }
  
  Future<bool> doesEmailExist(String email) async {
  final db = await fetchData();
  final List<Map<String, dynamic>> maps = await db.query(
    'User',
    where: 'email = ?',
    whereArgs: [email],
  );

  return maps.isNotEmpty;
}


}
