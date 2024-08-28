import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/task_provider.dart';

class AddTaskScreen extends ConsumerWidget {
  AddTaskScreen({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              
              controller: _controller,
              decoration: const InputDecoration(
                  
                  contentPadding: EdgeInsets.all(0),
                  prefixIcon: Icon(
                    Icons.add_to_queue, 
                    color: Color.fromARGB(31, 17, 17, 17), size: 20,
                  ),
                  prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
                  border: InputBorder.none,
                  hintText: '  Enter new task..',
                  hintStyle: TextStyle(color: Color.fromARGB(31, 58, 57, 57)),
                ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final title = _controller.text;
                if (title.isNotEmpty) {
                  ref.read(taskProvider.notifier).addTask(title);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}
