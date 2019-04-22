import 'dart:async';
import 'dart:io' as io;
import 'package:gymcontrol/models/exercice_db.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  final String TABLE_NAME = "Exercice";

  static Database db_instance;

  Future<Database> get db async {
    if (db_instance == null) {
      db_instance = await initDB();
    }
  }

  initDB() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "GYMCONTROL.db");
    var db = await openDatabase(path, version: 1, onCreate: onCreateFunc);
    return db;
  }

//Create Table
  void onCreateFunc(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $TABLE_NAME(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,repetitions TEXT, series TEXT, actualSeries Text, weight TEXT)');
  }

//CRUD
//  GET
  Future<List<ExerciceDB>> getExercices() async {
    var db_connection = await db;
    List<Map> list = await db_connection.rawQuery('SELECT * FROM $TABLE_NAME');
    List<ExerciceDB> exercices = new List();

    for (int i = 0; i < list.length; i++) {
      ExerciceDB exercice = new ExerciceDB(
          list[i]['id'],
          list[i]['name'],
          list[i]['repetitions'],
          list[i]['series'],
          list[i]['actualSeries'],
          list[i]['weight'],
          '0',
          false);

      exercices.add(exercice);
    }
  }

//  CREATE
  void addNewExercice(ExerciceDB exercice) async {
    var db_connection = await db;
    String query =
        'INSERT INTO $TABLE_NAME(name,repetitions,series,actualSeries,weight) VALUES(\'${exercice.name}\',\'${exercice.repetitions}\',\'${exercice.series}\',\'${exercice.actualSeries}\',\'${exercice.weight}\')';
    await db_connection.transaction((transaction) async {
      return await transaction.rawInsert(query);
    });
  }

//  UPDATE
  void updateExercice(ExerciceDB exercice) async {
    var db_connection = await db;
    String query =
        'UPDATE $TABLE_NAME SET name=\'${exercice.name}\',repetitions=\'${exercice.repetitions}\',series=\'${exercice.series}\',actualSeries=\'${exercice.actualSeries}\',weight=\'${exercice.weight}\' WHERE id=${exercice.id}';
    await db_connection.transaction((transaction) async {
      return await transaction.rawQuery(query);
    });
  }

//  DELETE
  void deleteExercice(ExerciceDB exercice) async {
    var db_connection = await db;
    String query =
        'DELETE $TABLE_NAME WHERE id=${exercice.id}';
    await db_connection.transaction((transaction) async {
      return await transaction.rawQuery(query);
    });
  }
}
