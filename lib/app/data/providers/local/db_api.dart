import 'dart:convert';

import 'package:covid_app/app/data/models/Contact.dart';
import 'package:covid_app/app/data/models/Handshake.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBAPI {
  static Database _database;
  static final DBAPI db = DBAPI._();
  final String path = '';

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
      onOpen: (db) => {print('open: ' + db.toString())},
    );
  }

  // Handshakes

  Future<List<Handshake>> getAllHandshakes() async {
    List<Handshake> _handshakes = List<Handshake>();
    try {
      final db = await database;
      final res = await db.query('handshakes');

      var list = res.isNotEmpty
          ? await res.map((result) => Handshake.fromJson(result)).toList()
          : [];

      // Parse to Handshake list
      for (Handshake handshake in list) {
        _handshakes.add(handshake);
      }

      return _handshakes;
    } catch (e) {
      print('Error on getAllHandshakes: $e');
      return [];
    }
  }

  Future getHandshakeById({int id}) async {
    final db = await database;

    final res = await db.query('handshakes', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? Handshake.fromJson(res.first) : null;
  }

  Future updateHandshake({Handshake handshake}) async {
    final db = await database;

    final res = await db.update('handshakes', handshake.toJson(),
        where: 'id = ?', whereArgs: [handshake.id]);

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

  // Contacts

  Future<List<Contact>> getAllContacts() async {
    List<Contact> _contacts = List<Contact>();
    try {
      final db = await database;

      final res = await db.query('contacts');

      List<dynamic> list = res.isNotEmpty
          ? res.map((result) => Contact.fromJson(result)).toList()
          : [];

      // Parse to Handshake list
      for (Contact contact in list) {
        _contacts.add(contact);
      }

      return _contacts;
    } catch (e) {
      print('Error on getAllContacts: $e');
      return null;
    }
  }

  Future createContact({Contact contact}) async {
    try {
      final db = await database;
      await db.execute(
          'CREATE TABLE IF NOT EXISTS contacts (id INTEGER PRIMARY KEY AUTOINCREMENT, createdAt INTEGER NOT NULL, handshakes TEXT NOT NULL, duration INTEGER NOT NULL, shared INTEGER NOT NULL)');
      await db.rawInsert(
          'INSERT INTO contacts(createdAt, handshakes, duration, shared) VALUES(?, ?, ?, ?)',
          [
            contact.createdAt,
            json.encode(contact.handshakes),
            contact.duration,
            contact.shared
          ]);
      return true;
    } catch (e) {
      print('Error on createContact: $e');
      return false;
    }
  }

  Future getContactById({int id}) async {
    final db = await database;

    final res = await db.query('contacts', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? Contact.fromJson(res.first) : null;
  }

  Future updateContact({Contact contact}) async {
    final db = await database;

    final res = await db.update('contacs', contact.toJson(),
        where: 'id = ?', whereArgs: [contact.id]);

    return res;
  }

  Future deleteContact({int id}) async {
    final db = await database;

    final res = await db.delete('contacts', where: 'id = ?', whereArgs: [id]);

    return res;
  }

  Future deleteAllContacts() async {
    final db = await database;

    final res = await db.rawDelete('DELETE FROM contacts');

    return res;
  }
}
