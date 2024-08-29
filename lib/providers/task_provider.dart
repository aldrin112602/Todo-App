
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';
import '../services/task_service.dart';

class TaskNotifier extends StateNotifier<List<Task>> {
  final TaskService _taskService;

  TaskNotifier(this._taskService) : super([]) {
    _fetchTasks();

  }

  

  Future<void> _fetchTasks() async {
    state = await _taskService.fetchTasks();
  }

  Future<void> addTask(String title) async {
    final newTask = await _taskService.addTask(title);
    if (newTask != null) {
      state = [...state, newTask];
    }
  }

  Future<void> toggleTaskCompletion(int id) async {
    final task = state.firstWhere((task) => task.id == id);
    final updatedTask = Task(
      id: task.id,
      title: task.title,
      isCompleted: !task.isCompleted,
    );

    final success = await _taskService.updateTask(id, updatedTask);
    if (success) {
      state = [
        for (final task in state)
          if (task.id == id) updatedTask else task,
      ];
    }
  }

  Future<void> editTask(int id, String newTitle) async {
    final task = state.firstWhere((task) => task.id == id);
    final updatedTask = Task(
      id: task.id,
      title: newTitle,
      isCompleted: task.isCompleted,
    );

    final success = await _taskService.updateTask(id, updatedTask);
    if (success) {
      state = [
        for (final task in state)
          if (task.id == id) updatedTask else task,
      ];
    }
  }

  Future<void> deleteTask(int id) async {
    final success = await _taskService.deleteTask(id);
    if (success) {
      state = state.where((task) => task.id != id).toList();
    }
  }
}

// Provider for TaskNotifier
final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  final taskService = TaskService();
  return TaskNotifier(taskService);
});
