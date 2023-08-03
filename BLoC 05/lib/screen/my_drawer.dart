import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/switch_bloc/switch_bloc.dart';
import '../blocs/task_bloc/task_bloc.dart';
import 'recycle_bin.dart';
import 'task_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.grey,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 12,
              bottom: 12,
              left: 12,
            ),
            child: Text(
              "Task Drawer",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) => GestureDetector(
              onTap: () => Navigator.of(context).pushReplacementNamed(TaskScreen.id),
              child: ListTile(
                leading: const Icon(Icons.folder_special),
                title: const Text("My Tasks"),
                trailing: Text("${state.allTasks.length}"),
              ),
            ),
          ),
          const Divider(),
          BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () => Navigator.of(context).pushReplacementNamed(RecycleBinScreen.id),
                child: ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text("Bin"),
                  trailing: Text(
                    "${state.deletedTalks.length}",
                  ),
                ),
              );
            },
          ),
          BlocBuilder<SwitchBloc, SwitchState>(
            builder: (context, state) {
              return Switch(
                value: state.switchValue,
                onChanged: (value) {
                  value
                      ? context.read<SwitchBloc>().add(SwitchOnEvent())
                      : context.read<SwitchBloc>().add(SwitchOffEvent());
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
