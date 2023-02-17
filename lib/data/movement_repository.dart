import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:workmanagers_example/data/model/movement_model.dart';

class MovementRepository{
  Database? database;
  String tableName="movements";

  MovementRepository();

  Future<Database> getDb() async {
    if (database == null) {
      database = await createDatabase();
      return database!;
    }
    return database!;
  }


  createDatabase() async {

    String databasesPath = await getDatabasesPath();
    String dbPath = '${databasesPath}movement.db';

    var database = await openDatabase(dbPath, version: 1, onCreate: populateDb);
    return database;
  }

  void populateDb(Database database, int version) async {
    await database.execute("CREATE TABLE $tableName ("
        "lat REAL,"
        "long REAL,"
        "time TEXT"
        ")");
  }

  Future addMovement(MovementModel movementModel) async {
    Database db = await getDb();
    await db.insert(tableName, movementModel.toJson());
    debugPrint("Movement added to Db");
  }

  Future<List> getMovements() async {
    Database db = await getDb();

    var result = await db.query(tableName, columns: ["lat", "long", "time"]);

    return result.toList();
  }

}