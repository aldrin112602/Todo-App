import 'package:dio/dio.dart';
import '../models/task.dart';

class TaskService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://127.0.0.1:3000/api',
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  

  Future<void> initializeCsrfToken() async {
    try {
      Response response = await _dio
          .get('/getCsrftoken');
      final csrfToken = response.data['csrf_token'];
      _dio.options.headers['X-CSRF-TOKEN'] = csrfToken;
      _dio.options.headers['Cookie'] = 'XSRF-TOKEN=$csrfToken';
    } catch (e) {
      print('Error fetching CSRF token: $e');
    }
  }

  Future<List<Task>> fetchTasks() async {
    try {
      await initializeCsrfToken(); // Ensure CSRF token is initialized before making requests
      Response response = await _dio.get('/tasks');
      List<dynamic> data = response.data;
      return data.map((json) => Task.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching tasks: $e');
      return [];
    }
  }

  Future<Task?> addTask(String title) async {
    try {
      await initializeCsrfToken();
      Response response = await _dio.post('/tasks', data: {'title': title});
      return Task.fromJson(response.data);
    } catch (e) {
      print('Error adding task: $e');
      return null;
    }
  }

  Future<bool> updateTask(int id, Task task) async {
    try {
      await initializeCsrfToken();
      await _dio.put('/tasks/$id', data: task.toJson());
      return true;
    } catch (e) {
      print('Error updating task: $e');
      return false;
    }
  }

  Future<bool> deleteTask(int id) async {
    try {
      await initializeCsrfToken();
      await _dio.delete('/tasks/$id');
      return true;
    } catch (e) {
      print('Error deleting task: $e');
      return false;
    }
  }
}
