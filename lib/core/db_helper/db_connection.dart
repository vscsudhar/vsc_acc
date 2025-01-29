import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_crud.db');
    var database =
        await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    String donation =
        "CREATE TABLE donation (id INTEGER PRIMARY KEY, serialNo Text, name TEXT,amount REAL, area TEXT, dateTime TEXT)";
    await database.execute(donation);

    String fund =
        "CREATE TABLE funds (id INTEGER PRIMARY KEY, name TEXT,area TEXT, amount TEXT, dateTime TEXT)";
    await database.execute(fund);

    String expenses =
        "CREATE TABLE expenses (id INTEGER PRIMARY KEY,  purpose TEXT,item TEXT, amount TEXT,dateTime TEXT)";
    await database.execute(expenses);

    String rice =
        "CREATE TABLE rice (id INTEGER PRIMARY KEY,  name TEXT,area TEXT, kg TEXT, dateTime TEXT)";
    await database.execute(rice);

    String sponsors =
        "CREATE TABLE sponsors (id INTEGER PRIMARY KEY, name TEXT,area TEXT, sponsorType TEXT,  sponsorItem TEXT,dateTime TEXT)";
    await database.execute(sponsors);
  }
}
