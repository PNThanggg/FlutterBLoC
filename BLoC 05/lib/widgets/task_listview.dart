import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/task_bloc/task_bloc.dart';
import '../model/task.dart';

class TaskListView extends StatelessWidget {
  final List<Task> listTask;

  const TaskListView({
    Key? key,
    required this.listTask,
  }) : super(key: key);

  void _removeOrDeleteTask(BuildContext context, Task task) {
    task.isDeleted == true
        ? context.read<TaskBloc>().add(DeleteTask(task: task))
        : context.read<TaskBloc>().add(RemoveTask(task: task));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 12),
      itemCount: listTask.length,
      itemBuilder: (context, index) {
        Task task = listTask[index];

        return ListTile(
          title: Text(
            task.title,
            style: TextStyle(
              decoration: task.isDone! ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
          trailing: Checkbox(
            onChanged: (value) {
              context.read<TaskBloc>().add(UpdateTask(task: task));
            },
            value: task.isDone,
          ),
          onLongPress: () => _removeOrDeleteTask(context, task),
        );
      },
    );
  }
}
