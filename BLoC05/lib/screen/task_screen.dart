import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/task_bloc/task_bloc.dart';
import '../model/task.dart';
import '../widgets/task_listview.dart';
import 'add_task_screen.dart';
import 'my_drawer.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  static const id = "task_screen";

  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const AddTaskScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        List<Task> listTask = state.allTasks;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Tasks app"),
            actions: [
              IconButton(
                onPressed: () => _addTask(context),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          drawer: const MyDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                  label: Text("Task: ${state.allTasks.length}"),
                ),
              ),
              TaskListView(listTask: listTask),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _addTask(context),
            tooltip: "Add Task",
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
