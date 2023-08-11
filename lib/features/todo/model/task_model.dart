class TaskModel {
  int? id;
  String? title;
  String? description;
  bool isCompleted;
  DateTime? date;
  DateTime? startTime;
  DateTime? endTime;
  bool remind;
  bool repeat;

  TaskModel(
      {this.id,
      this.title,
      this.description,
      this.isCompleted = false,
      this.date,
      this.startTime,
      this.endTime,
      this.remind = false,
      this.repeat = true});

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
        id: map["id"] as int?,
        title: map["title"] as String?,
        date: DateTime.parse(map["date"] as String),
        description: map['description'] as String?,
        endTime: DateTime.parse(map["endTime"] as String),
        startTime: DateTime.parse(map["startTime"] as String),
        isCompleted: (map['isComplete'] as num) == 1,
        remind: (map['remind'] as num) == 1,
        repeat: (map['repeat'] as num) == 1);
  }
  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "date": date.toString(),
        "description": description,
        "endTime": endTime.toString(),
        "startTime": startTime.toString(),
        "isComplete": isCompleted ? 1 : 0,
        "remind": remind ? 1 : 0,
        "repeat": repeat ? 1 : 0
      };
}
