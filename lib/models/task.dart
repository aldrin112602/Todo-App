
class Task {
  final int id;
  final String title;
  final int isCompleted; // 0 or 1

  // constructor
  Task({
    required this.id,
    required this.title,
    this.isCompleted = 0, // default 0
  });


  // JSON to Object
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as int,
      title: json['title'] as String,
      isCompleted: json['is_completed'] ?? 0,
    );
  }

  // Object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }
}
