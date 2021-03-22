import 'package:flutter/widgets.dart';

import 'package:todo_nato/taskmodel.dart';
import 'package:todo_nato/taskdb.dart';

void main() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.

  var cmsc = Task(
    id: 0,
    subjectName: 'cmsc 129',
    taskName: 'develop app',
    priorityLevel: 'low',
  );

  // Insert a task into the database.
  await DBProvider.db.newTask(cmsc);

  // Print the list of tasks (only cmsc for now).
  print(await DBProvider.db.tasks());

  // Update cmsc's taskName and priorityLevel, and save it to the database.
  cmsc = Task(
    id: cmsc.id,
    subjectName: cmsc.subjectName,
    taskName: 'set up db',
    priorityLevel: 'high',
  );
  await DBProvider.db.updateTask(cmsc);

  // Print cmsc's updated information.
  print(await DBProvider.db.tasks());

  // Delete cmsc from the database.
  await DBProvider.db.deleteTask(cmsc.id);

  // Print the list of tasks (empty).
  print(await DBProvider.db.tasks());
}
