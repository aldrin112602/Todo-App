import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier()
      : super([
          Task(id: '1', title: 'Buy groceries'),
          Task(id: '2', title: 'Walk the dog'),
          Task(id: '3', title: 'Read a book'),
        ]);

  void addTask(String title) {
    state = [
      ...state,
      Task(id: DateTime.now().toString(), title: title),
    ];
  }

  void toggleTaskCompletion(String id) {
    state = [
      for (final task in state)
        if (task.id == id)
          Task(id: task.id, title: task.title, isCompleted: !task.isCompleted)
        else
          task,
    ];
  }

  void deleteTask(String id) {
    state = state.where((task) => task.id != id).toList();
  }


  void editTask(String id, String newTitle) {
    state = [
      for (final task in state)
        if (task.id == id)
          Task(id: task.id, title: newTitle, isCompleted: task.isCompleted)
        else
          task,
    ];
  }
}

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier();
});
