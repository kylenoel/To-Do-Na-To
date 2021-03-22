class Task {
  final int id;
  String subjectName;
  String taskName;
  String priorityLevel;

  Task({
    this.id,
    this.subjectName,
    this.taskName,
    this.priorityLevel,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subjectName': subjectName,
      'taskName': taskName,
      'priorityLevel': priorityLevel
    };
  }

  // Implement toString to make it easier to see information about
  // each task when using the print statement.
  @override
  String toString() {
    return 'Task{id: $id, subject name: $subjectName, task name: $taskName, priority level: $priorityLevel}';
  }
}
