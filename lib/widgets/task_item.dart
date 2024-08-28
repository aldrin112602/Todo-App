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
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Delete button
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              ref.read(taskProvider.notifier).deleteTask(task.id);
            },
          ),
          
          // Edit button
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              _showEditDialog(context, ref);
            },
          ),
          
        ],
      ),
    );
  }

  // Function to show a dialog for editing the task
  void _showEditDialog(BuildContext context, WidgetRef ref) {
    final editController = TextEditingController(text: task.title); // Changed variable name

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Task'),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(
              hintText: 'Enter new task title',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final newTitle = editController.text.trim(); // Use editController here
                if (newTitle.isNotEmpty) {
                  ref.read(taskProvider.notifier).editTask(task.id, newTitle);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
