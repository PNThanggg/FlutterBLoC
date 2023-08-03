part of 'task_bloc.dart';

class TaskState extends Equatable {
  final List<Task> allTasks;
  final List<Task> deletedTalks;

  const TaskState({
    this.allTasks = const <Task>[],
    this.deletedTalks = const <Task>[],
  });

  @override
  String toString() => 'TaskState { allTasks: [] }';

  @override
  List<Object?> get props => [
        allTasks,
        deletedTalks,
      ];

  factory TaskState.fromMap(Map map) {
    return TaskState(
      allTasks: List<Task>.from(
        map['allTasks']?.map(
          (x) => Task.fromMap(x),
        ),
      ),
      deletedTalks: List<Task>.from(
        map['deletedTasks']?.map(
          (x) => Task.fromMap(x),
        ),
      ),
    );
  }

  factory TaskState.fromJson(String source) => TaskState.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      "allTasks": allTasks.map((e) => e.toMap()).toList(),
      "deletedTalks": deletedTalks.map((e) => e.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());
}
