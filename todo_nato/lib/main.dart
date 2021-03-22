import 'package:flutter/widgets.dart';

import 'package:todo_nato/taskmodel.dart';
import 'package:todo_nato/taskdb.dart';

void main() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.

  var fido = Task(
    id: 0,
    subjectName: 'cmsc 129',
    taskName: 'develop app',
    priorityLevel: 'low',
  );

  // Insert a dog into the database.
  await DBProvider.db.newTask(fido);

  // Print the list of dogs (only Fido for now).
  print(await DBProvider.db.tasks());

  // Update Fido's age and save it to the database.
  fido = Task(
    id: fido.id,
    subjectName: fido.subjectName,
    taskName: 'set up db',
    priorityLevel: 'high',
  );
  await DBProvider.db.updateTask(fido);

  // Print Fido's updated information.
  print(await DBProvider.db.tasks());

  // Delete Fido from the database.
  await DBProvider.db.deleteTask(fido.id);

  // Print the list of dogs (empty).
  print(await DBProvider.db.tasks());
}
