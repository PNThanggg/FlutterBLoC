import 'dart:convert';

import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String title;
  final String id;
  final bool? isDone;
  final bool? isDeleted;

  const Task({
    required this.title,
    required this.id,
    this.isDone = false,
    this.isDeleted = false,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
        title: map['title'] ?? '',
        id: map['id'] ?? '',
        isDone: map['isDone'] as bool,
        isDeleted: map['isDeleted'] as bool);
  }

  Task copyWith({String? title, String? id, bool? isDone, bool? isDeleted}) {
    return Task(
      title: title ?? this.title,
      id: id ?? this.id,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
      'isDone': isDone,
      'isDeleted': isDeleted,
    };
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));

  @override
  List<Object?> get props => [
        title,
        id,
        isDone,
        isDeleted,
      ];
}
