import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/task_provider.dart';
import '../models/task.dart';

class TaskItem extends ConsumerWidget {
  final Task task;

  const TaskItem({super.key, required this.task});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(task.title),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          ref.read(taskProvider.notifier).deleteTask(task.id);
        },
      ),
      
    );
  }
}
