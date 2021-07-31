import 'package:flutter_sqflite_app/Models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper.internal();

  static late Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);

    return ourDb;
  }
  void _onCreate(Database db, int version) async{
    await db.execute("CREATE TABLE User(id INTEGER PRIMARY KEY, username TEXT, password TEXT)");
    print("Table is created!");
  }

  //insertion
  Future<int> saveUser(User user) async{
    var dbClient = await db; //db is a getter which will get the database _db.
    int res = await dbClient.insert("User", user.toMap());
    return res;
  }

  //deletion
  Future<int> deleteUser(User user) async{
    var dbClient = await db; //db is a getter which will get the database _db.
    int res = await dbClient.delete("User" );
    return res;
  }

}
