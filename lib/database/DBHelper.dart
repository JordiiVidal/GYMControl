import 'dart:async';
import 'dart:io' as io;
import 'package:gymcontrol/models/exercice_db.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  final String tableName = "Exercice";

  static Database instanceDB;

  Future<Database> get db async {
    if (instanceDB == null) instanceDB = await initDB();
    return instanceDB;
  }

  initDB() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "GYMControl.db");
    var db = await openDatabase(path, version: 1, onCreate: onCreateFunc);
    return db;
  }

//Create Table
  void onCreateFunc(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,repetitions TEXT, series TEXT, actualSeries TEXT, weight TEXT);');
  }

//CRUD
//  GET
  Future<List<ExerciceDB>> getExercices() async {
    var concetionDB = await db;
    List<Map> list = await concetionDB.rawQuery('SELECT * FROM $tableName');
    List<ExerciceDB> exercices = new List();

    for (int i = 0; i < list.length; i++) {
      ExerciceDB exercice = new ExerciceDB();
      exercice.id = list[i]['id'];
      exercice.name = list[i]['name'];
      exercice.repetitions = list[i]['repetitions'];
      exercice.series = list[i]['series'];
      exercice.actualSeries = list[i]['actualSeries'];
      exercice.weight = list[i]['weight'];
      exercices.add(exercice);
    }
    return exercices;
  }

//  CREATE
  void addNewExercice(ExerciceDB exercice) async {
    var concetionDB = await db;
    String query =
        'INSERT INTO $tableName(name,repetitions,series,actualSeries,weight) VALUES(\'${exercice.name}\',\'${exercice.repetitions}\',\'${exercice.series}\',\'${exercice.actualSeries}\',\'${exercice.weight}\');';
    await concetionDB.transaction((transaction) async {
      return await transaction.rawInsert(query);
    });
  }

//  UPDATE
  void updateExercice(ExerciceDB exercice) async {
    var concetionDB = await db;
    String query =
        'UPDATE $tableName SET name=\'${exercice.name}\',repetitions=\'${exercice.repetitions}\',series=\'${exercice.series}\',actualSeries=\'${exercice.actualSeries}\',weight=\'${exercice.weight}\' WHERE id=${exercice.id}';
    await concetionDB.transaction((transaction) async {
      return await transaction.rawQuery(query);
    });
  }

//  DELETE
  deleteExercice(ExerciceDB exercice) async {
    var concetionDB = await db;
    String query = 'DELETE FROM $tableName WHERE id=${exercice.id}';
    await concetionDB.transaction((transaction) async {
      return await transaction.rawQuery(query);
    });
  }
}
