import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

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

  Future addMovement(ContactModel contactModel) async {
    Database db = await getDb();
    var id = await db.insert(tableName, contactModel.toJson());
    print("mana id $id");
    return contactModel.copyWith(id: id);

  }

  Future<List> getContact() async {
    Database db = await getDb();

    var result = await db.query(tableName, columns: ["id", "name", "number", "createdAt"]);

    return result.toList();
  }

  Future updateContact(ContactModel contactModel) async {
    Database db = await getDb();
    print("Mana id ${contactModel.id}");
    var id=  await db.update(tableName, contactModel.toJson(), where: "id = ?", whereArgs: [contactModel.id]);
    return contactModel.copyWith(id: id);

  }

  Future<int> deleteContact(int id) async {
    print("$id dagi contact o'chdi");
    Database db = await getDb();

    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}