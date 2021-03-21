import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:todo_nato/taskmodel.dart';

createDatabase() async {
  String databasesPath = await getDatabasesPath();
  String dbPath = join(databasesPath, 'task.db');

  var database = await openDatabase(dbPath, version: 1, onCreate: populateDb);
  return database;
}

void populateDb(Database database, int version) async {
  await database.execute("CREATE TABLE Task ("
      "id INTEGER PRIMARY KEY,"
      "subject_name TEXT,"
      "task_name TEXT,"
      "priority_level TEXT"
      ")");
}

Future<int> createTask(Task task) async {
  var result = await database.insert("Task", task.toMap());
  return result;
}
