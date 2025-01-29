import 'package:sqflite/sqflite.dart';
import 'package:vsc_acc/core/db_helper/db_connection.dart';
import 'package:path_provider/path_provider.dart';

class Repository {
  late DatabaseConnection _databaseConnection;
  Repository() {
    _databaseConnection = DatabaseConnection();
  }
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }

  //insert User

  Future<int?> insertData(String table, Map<String, dynamic> data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  insertUserData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  //login Check
  checkUserData(table, userName, userPass) async {
    var db = await database;
    return await db?.query('user',
        where: "userName = ? AND password = ?",
        whereArgs: [userName, userPass]);
  }

  // read User

  readData(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  // read single record by id
  readById(table, itemId) async {
    var connection = await database;
    return await connection?.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  // delete DataBy Id
  deleteDataById(table, itemId) async {
    var connection = await database;
    return await connection?.rawDelete("delete from $table where id=$itemId");
  }

  deleteDatas() async {
    var db = await database;
    return await db?.delete('users', where: '1');
  }

  readByDateAndyear(table, dateTime, session) async {
    var connection = await database;
    return await connection?.query(table,
        where: "session = '$session' AND dateTime = ?", whereArgs: [dateTime]);
  }

  readByDate(table, dateTime) async {
    var connection = await database;
    return await connection?.query(table, where: "dateTime = '$dateTime'");
  }

  readByYear(String table, int year) async {
    var connection = await database;
    if (connection == null) {
      throw Exception("Database connection is null");
    }

    return await connection.query(
      table,
      where: "strftime('%Y', dateTime) = ?",
      whereArgs: [year.toString()],
    );
  }

  exportTableToCSV(tableName) async {
    var db = await database;
    return await db?.query(tableName);
  }

  // Future<List<Map<String, dynamic>>> exportTableToCSV(String tableName) async {
  //   var db = await database;
  //   return await db?.query(tableName) ?? [];
  // }

  // Search Data
  Future<List<Map<String, dynamic>>> searchData(
      String table, String query, List<String> columns) async {
    var connection = await database;
    if (connection == null) return [];
    String whereClause = columns.map((column) => "$column LIKE ?").join(" OR ");
    List<String> whereArgs = List.generate(columns.length, (_) => '%$query%');

    return await connection.query(
      table,
      where: whereClause,
      whereArgs: whereArgs,
    );
  }

  Future<List<Map<String, dynamic>>?> getAllData(String table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  Future<Set<String>> getExistingSerialNumbers(String tableName) async {
    var connection = await database;

    List<Map<String, dynamic>> results =
        await connection!.query(tableName, columns: ['serialNo']);

    return results.map((row) => row['serialNo'].toString()).toSet();
  }
}
