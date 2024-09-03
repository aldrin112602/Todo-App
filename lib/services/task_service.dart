import 'package:dio/dio.dart';
import '../models/task.dart';

class TaskService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.242.89:3000/api',
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  Future<List<Task>> fetchTasks() async {
    try {
      Response response = await _dio.get('/tasks');
      List<dynamic> data = response.data;
      return data.map((json) => Task.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<Task?> addTask(String title) async {
    try {
      Response response = await _dio.post('/tasks', data: {'title': title});
      return Task.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateTask(int id, Task task) async {
    try {
      await _dio.put('/tasks/$id', data: task.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteTask(int id) async {
    try {
      await _dio.delete('/tasks/$id');
      return true;
    } catch (e) {
      return false;
    }
  }
}
