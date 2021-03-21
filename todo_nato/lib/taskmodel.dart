//defining Task model
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