import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../utils/UserSession.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE UserSession(id INTEGER PRIMARY KEY, username TEXT, token TEXT)");
  }

  Future<int> saveUser(UserSession user) async {
    var dbClient = await db;
    int res = await dbClient.insert("UserSession", user.toMap());
    return res;
  }

  Future<int> deleteUsers() async {
    var dbClient = await db;
    int res = await dbClient.delete("UserSession");
    return res;
  }

  Future<String> isLoggedIn() async {
    var dbClient = await db;
    var res = await dbClient.query("UserSession");
    return res.length > 0 ? res[0]["token"] : null;
  }

  Future<UserSession> isLoggedInSession() async {
    var dbClient = await db;
    var res = await dbClient.query("UserSession");
    return res.length > 0
        ? new UserSession(res[0]["username"], res[0]["token"])
        : null;
  }
}
