import 'dart:io';

import 'package:hermes/models/norma_model.dart';
import 'package:hermes/models/requisito_model.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbAdmin {
  Logger logger = Logger();
  DbAdmin._();

  static final DbAdmin db = DbAdmin._();

  static Database? _myHermesDatabase;

  Future<Database> get database async {
    if (_myHermesDatabase != null) return _myHermesDatabase!;
    _myHermesDatabase = await _initDatabase();
    return _myHermesDatabase!;
  }

  Future<Database> _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String pathDatabase = join(directory.path, "HermesDB.db");
    return openDatabase(
      pathDatabase,
      version: 1,
      onCreate: (Database db, int version) async {
        
        await db.execute("""
              CREATE TABLE normas(
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                numNorma TEXT NOT NULL,
                ideNorma TEXT NOT NULL,
                sumNorma TEXT NOT NULL,
                fechPubNorma DATATIME DEFAULT CURRENT_TIMESTAMP,
                fechEntVigencia DATATIME DEFAULT CURRENT_TIMESTAMP,
                type TEXT NOT NULL
              )
        """);

        await db.execute("""
                CREATE TABLE requisitos(
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                nombre TEXT NOT NULL,
                texto TEXT NOT NULL,
                interpretacion TEXT NOT NULL,
                evidencia TEXT NOT NULL,
                periodicidad TEXT NOT NULL,
                idNorma INTEGER NOT NULL,
                  FOREIGN KEY (idNorma) 
                  REFERENCES normas(id)
                  ON DELETE CASCADE
              )
        """);
      },
      onConfigure: (Database db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },

    );
  }

  Future<List<NormaModel>> getNormas() async {
    List<NormaModel> normaModelList=[];
    try {
      Database? db = await _initDatabase();
      List<Map<String, dynamic>> data = await db.query("normas");
      logger.w(data);
       normaModelList = data
        .map((e) => NormaModel.fromDB(e))
        .toList();
    } catch (e) {
      logger.w(e.toString());
    }
    
    return normaModelList;
  }

  Future<int> insertNorma(NormaModel norma) async {
    Database? db = await _initDatabase();
    int res = await db.insert("normas", norma.toDB());
    return res;
  }

  Future<int> updateNorma(NormaModel norma) async {

    final db = await database;

    int res= await db.update(
      'normas',
      norma.toDB(),
      where: 'id = ?',
      whereArgs: [norma.id],
    );
    return res;
  }

  Future<int> deleteNorma(NormaModel norma) async {
    final db = await database;
    int res= await db.delete(
        'normas',
        where: 'id = ?',
        whereArgs: [norma.id],
    );
    logger.w(res);
    return res;
  }

  Future<List<RequisitoModel>> getRequisitos(int idNorma) async {
    List<RequisitoModel> requisitoModelList=[];
    try {
      Database? db = await _initDatabase();
      List<Map<String, dynamic>> data = await db.query("requisitos",
        where: "idNorma = ?",
        whereArgs: [idNorma],);
       requisitoModelList = data
        .map((e) => RequisitoModel.fromDB(e))
        .toList();
    } catch (e) {
      logger.w(e.toString());
    }
    return requisitoModelList;
  }

   Future<int> insertRequisito(RequisitoModel requisito) async {
    Database? db = await _initDatabase();
    int res = await db.insert("requisitos", requisito.toDB());
    return res;
  }

Future<int> updateRequisito(RequisitoModel requisito) async {

    final db = await database;

    int res= await db.update(
      'requisitos',
      requisito.toDB(),
      where: 'id = ?',
      whereArgs: [requisito.id],
    );
    return res;
  }

  Future<int> deleteRequisito(RequisitoModel requisito) async {
    final db = await database;
    int res= await db.delete(
        'requisitos',
        where: 'id = ?',
        whereArgs: [requisito.id],
    );
    return res;
  }
  

}