// Example: lib/widgets/task_item.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/task_provider.dart';
import '../models/task.dart';

class TaskItem extends ConsumerWidget {
  final Task task;

  TaskItem({required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(task.title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(task.isCompleted ? Icons.check_box : Icons.check_box_outline_blank),
            onPressed: () => ref.read(taskProvider.notifier).toggleTaskCompletion(task.id),
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final newTitle = await _showEditDialog(context, task.title);
              if (newTitle != null) {
                ref.read(taskProvider.notifier).editTask(task.id, newTitle);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => ref.read(taskProvider.notifier).deleteTask(task.id),
          ),
        ],
      ),
    );
  }

  Future<String?> _showEditDialog(BuildContext context, String currentTitle) async {
    TextEditingController controller = TextEditingController(text: currentTitle);
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Task'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'Task Title'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
            ),
          ],
        );
      },
    );
  }
}
