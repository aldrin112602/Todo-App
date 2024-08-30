import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/task_provider.dart';
import '../add_task/add_task_screen.dart';
import '../../widgets/search_box.dart';
import '../../widgets/task_item.dart';
import '../../widgets/shimmer_task_item.dart';
import '../../widgets/shimmer_search_box.dart';
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchText = _searchController.text;
    });
  }

  @override
Widget build(BuildContext context) {
  final taskList = ref.watch(taskProvider);

  // Display shimmer effect when tasks are loading
  final isLoading = taskList.isEmpty;

  final filteredTaskList = taskList.where((task) {
    return task.title.toLowerCase().contains(_searchText.toLowerCase());
  }).toList();

  return Scaffold(
    appBar: AppBar(
      title: const Text('Todo List'),
    ),
    body: Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          isLoading
              ? const ShimmerSearchBox() // Show shimmer while loading
              : SearchBox(
                  controller: _searchController,
                  onSearchChanged: _onSearchChanged,
                ),
          Expanded(
            child: isLoading
                ? ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) => const ShimmerTaskItem(),
                  )
                : ListView.builder(
                    itemCount: filteredTaskList.length,
                    itemBuilder: (context, index) {
                      final task = filteredTaskList[index];
                      return TaskItem(task: task);
                    },
                  ),
          ),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddTaskScreen(),
          ),
        );
      },
      child: const Icon(Icons.add),
    ),
  );
}

}
