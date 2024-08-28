import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]);

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
}

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier();
});
