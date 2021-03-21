import 'package:sqflite/sqflite.dart';

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

class Task {
  int id;
  String subjectName;
  String taskName;
  String priorityLevel;

  Task({
    this.id,
    this.subjectName,
    this.taskName,
    this.priorityLevel,
  });

  int get id => id;
  String get subjectName => subjectName;
  String get taskName => taskName;
  String get priorityLevel => priorityLevel;


  factory Task.fromJson(Map<String, dynamic> data) => new Task(
    id: data["id"],
    subjectName: data["subject_name"],
    taskName: data["task_name"],
    priorityLevel: data["priority_level"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subject_name": subjectName,
    "task_name": taskName,
    "priority_level": priorityLevel,
  };
}

Future<int> createTask(Task task) async {
  var result = await database.insert("Task", task.toMap());
  return result;
}



