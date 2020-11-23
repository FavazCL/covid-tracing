
import 'package:covid_app/app/data/models/Handshake.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBAPI {

  static Database _database;
  static final DBAPI db = DBAPI._();
  final String path = '/data/user/0/covid_tracing/databases/';

  DBAPI._();

  get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {
    final tempDir = await getDatabasesPath();
    final path = join(tempDir, 'covidapp.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) => {
        print('open: ' + db.toString())
      },
    );
  }

  Future getAllHandshakes() async {
    try {
      final db = await database;

      final res = await db.query('handshakes');

      List<dynamic> list = res.isNotEmpty ? 
      res.map((result) => Handshake.fromJson(result)).toList() : [];
  
      return list;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future getHandshakeById({int id}) async {
    final db = await database;
    
    final res = await db.query('handshakes', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? Handshake.fromJson(res.first) : null;
  }

  Future updateHandshake({Handshake handshake}) async {
    final db = await database;

    final res = await db.update('handshakes', handshake.toJson(), where: 'id = ?', whereArgs: [handshake.id]);
    
    return res;
  }

  Future deleteHandshake({int id}) async {
    final db = await database;

    final res = await db.delete('handshakes', where: 'id = ?', whereArgs: [id]);

    return res;
  }

  Future deleteAllHandshakes() async {
    final db = await database;

    final res = await db.rawDelete('DELETE FROM handshakes');

    return res;
  }

}
