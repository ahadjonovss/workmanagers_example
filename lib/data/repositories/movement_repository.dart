import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:workmanagers_example/data/model/movement_model.dart';
import 'package:workmanagers_example/data/model/route_model.dart';

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

  Future<List<MovementModel>> getMovements() async {
    Database db = await getDb();

    var result = await db.query(tableName, columns: ["lat", "long", "time"]);

    List<MovementModel> movements = result.map((e) => MovementModel.fromJson(e)).toList();

    return movements;
  }

}