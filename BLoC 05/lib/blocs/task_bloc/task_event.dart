part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class AddTask extends TaskEvent {
  final Task task;

  const AddTask({
    required this.task,
  });

  @override
  String toString() => 'AddTask { Task: ${task.toString()}';

  @override
  List<Object?> get props => [
        task,
      ];
}

class UpdateTask extends TaskEvent {
  final Task task;

  const UpdateTask({
    required this.task,
  });

  @override
  String toString() => 'UpdateTask { Task: ${task.toString()}';

  @override
  List<Object?> get props => [
        task,
      ];
}

class RemoveTask extends TaskEvent {
  final Task task;

  const RemoveTask({
    required this.task,
  });

  @override
  String toString() => 'Remove Task { Task: ${task.toString()}';

  @override
  List<Object?> get props => [
    task,
  ];
}

class DeleteTask extends TaskEvent {
  final Task task;

  const DeleteTask({
    required this.task,
  });

  @override
  String toString() => 'DeleteTask { Task: ${task.toString()}';

  @override
  List<Object?> get props => [
        task,
      ];
}
