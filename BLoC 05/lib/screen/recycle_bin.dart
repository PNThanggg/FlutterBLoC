import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/task_bloc/task_bloc.dart';
import '../widgets/task_listview.dart';


class RecycleBinScreen extends StatelessWidget {
  const RecycleBinScreen({Key? key}) : super(key: key);

  static const id = "recycle_bin_screen";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Recycle bin"),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                  label: Text("Task: ${state.deletedTalks.length}"),
                ),
              ),
              TaskListView(
                listTask: state.deletedTalks,
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            tooltip: "Add Task",
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
