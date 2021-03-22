import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_nato/taskmodel.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider{
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TasksDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute(
            "CREATE TABLE tasks(id INTEGER PRIMARY KEY, subjectName TEXT, taskName TEXT, priorityLevel TEXT)",
          );
        });
  }

  newTask(Task task) async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the Task into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same task is inserted
    // multiple times, it replaces the previous data.
    var res = await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return res;
  }

  Future<List<Task>> tasks() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Tasks.
    final List<Map<String, dynamic>> maps = await db.query('tasks');

    // Convert the List<Map<String, dynamic> into a List<Task>.
    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['id'],
        subjectName: maps[i]['subjectName'],
        taskName: maps[i]['taskName'],
        priorityLevel: maps[i]['priorityLevel'],
      );
    });
  }

  updateTask(Task task) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Task.
    var res = await db.update(
      'tasks',
      task.toMap(),
      // Ensure that the Task has a matching id.
      where: "id = ?",
      // Pass the Task's id as a whereArg to prevent SQL injection.
      whereArgs: [task.id],
    );
    return res;
  }

  deleteTask(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Task from the database.
    var res = await db.delete(
      'tasks',
      // Use a `where` clause to delete a specific task.
      where: "id = ?",
      // Pass the Task's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
    return res;
  }
}
