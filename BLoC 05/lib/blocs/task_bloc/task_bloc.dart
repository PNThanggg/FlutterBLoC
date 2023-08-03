import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../model/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends HydratedBloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState()) {
    on<TaskEvent>((event, emit) {});

    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
  }

  void _onAddTask(AddTask even, Emitter<TaskState> emit) {
    final state = this.state;

    emit(
      TaskState(
        allTasks: List.from(state.allTasks)..add(even.task),
        deletedTalks: state.deletedTalks,
      ),
    );
  }

  void _onUpdateTask(UpdateTask even, Emitter<TaskState> emit) {
    final state = this.state;
    final task = even.task;
    final int index = state.allTasks.indexOf(task);

    List<Task> allTasks = List.from(state.allTasks)..remove(task);
    task.isDone == false
        ? allTasks.insert(index, task.copyWith(isDone: true))
        : allTasks.insert(index, task.copyWith(isDone: false));

    emit(
      TaskState(
        allTasks: allTasks,
        deletedTalks: state.deletedTalks,
      ),
    );
  }

  void _onDeleteTask(DeleteTask even, Emitter<TaskState> emit) {
    final state = this.state;
    emit(
      TaskState(
        allTasks: List.from(state.allTasks)..remove(even.task),
        deletedTalks: List.from(state.deletedTalks)..add(even.task),
      ),
    );
  }

  void _onRemoveTask(RemoveTask even, Emitter<TaskState> emit) {
    final state = this.state;
    emit(
      TaskState(
        allTasks: List.from(state.allTasks)..remove(even.task),
        deletedTalks: List.from(state.deletedTalks)
          ..add(
            even.task.copyWith(isDeleted: true),
          ),
      ),
    );
  }

  @override
  TaskState? fromJson(Map<String, dynamic> json) {
    return TaskState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TaskState state) {
    return state.toMap();
  }
}
