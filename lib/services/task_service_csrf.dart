import 'package:dio/dio.dart';
import '../models/task.dart';

class TaskService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.1.89:3000/api',
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  String? _csrfToken; // To store the CSRF token

  Future<void> _fetchCsrfToken() async {
    try {
      Response response = await _dio.get('/getCsrftoken');
      _csrfToken = response.data['csrf_token'];
      _dio.options.headers['X-CSRF-TOKEN'] = _csrfToken;
    } catch (e) {
      print('Error fetching CSRF token: $e');
    }
  }

  Future<List<Task>> fetchTasks() async {
    try {
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
      if (_csrfToken == null) {
        await _fetchCsrfToken();
      }

      Response response = await _dio.post(
        '/tasks',
        data: {'title': title},
        options: Options(headers: {'X-CSRF-TOKEN': _csrfToken}),
      );
      return Task.fromJson(response.data);
    } catch (e) {
      print('Error adding task: $e');
      return null;
    }
  }

  Future<bool> updateTask(int id, Task task) async {
    try {
      if (_csrfToken == null) {
        await _fetchCsrfToken();
      }

      await _dio.put('/tasks/$id',
          data: task.toJson(),
          options: Options(headers: {'X-CSRF-TOKEN': _csrfToken}));
      return true;
    } catch (e) {
      print('Error updating task: $e');
      return false;
    }
  }

  Future<bool> deleteTask(int id) async {
    try {
      if (_csrfToken == null) {
        await _fetchCsrfToken();
      }

      await _dio.delete(
        '/tasks/$id',
        options: Options(headers: {'X-CSRF-TOKEN': _csrfToken}),
      );
      return true;
    } catch (e) {
      print('Error deleting task: $e');
      return false;
    }
  }
}
