import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if (_database == null) _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'Scans.db');
    print(path);

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
      CREATE TABLE Scans(
        id INTEGER PRIMARY KEY,
        tipus TEXT,
        valor TEXT
      )
''');
    });
  }

  Future<int> inserRawScan(ScanModel nouscan) async {
    final id = nouscan.id;
    final tipus = nouscan.tipus;
    final valor = nouscan.valor;
    final db = await database;
    final res = await db.rawInsert(
        '''Insert into Scans (id,tipus,valor) values ($id,$tipus,$valor)''');
    print(res);
    return res;
  }

  Future<int> insertScan(ScanModel nouScan) async {
    final db = await database;
    final res = await db.insert('Scans', nouScan.toMap());
    return res;
  }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final res = await db.query('Scans');
    return res.isNotEmpty ? res.map((e) => ScanModel.fromMap(e)).toList() : [];
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    if (res.isNotEmpty) {
      return ScanModel.fromMap(res.first);
    }
    return null;
  }

  Future<List<ScanModel>> getScanByTipus(String tipus) async {
    final db = await database;
    final res = await db.query('Scans', where: 'tipus = ?', whereArgs: [tipus]);

    if (res.isNotEmpty) {
      return res.map((e) => ScanModel.fromMap(e)).toList();
    } else {
      return [];
    }
  }

  Future<int> updateScan(ScanModel nouscan) async {
    final db = await database;
    final res = db.update('Scans', nouscan.toMap(),
        where: 'id = ?', whereArgs: [nouscan.id]);

    return res;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db.rawDelete('''DELETE FROM SCANS ''');
    return res;
  }

  Future<int> deleteById(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }
}
