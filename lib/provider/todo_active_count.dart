import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_todolist/model/todo_model.dart';
import 'package:flutter_todolist/provider/todo_list.dart';
import 'package:flutter_todolist/provider/provider.dart';

class TodoActiveCountState extends Equatable {
  final int todoActiveCount;

  const TodoActiveCountState({
    required this.todoActiveCount,
  });

  factory TodoActiveCountState.init() {
    return const TodoActiveCountState(todoActiveCount: 0);
  }

  @override
  List<Object> get props => [todoActiveCount];

  @override
  String toString() =>
      'TodoActiveCountState(todoActiveCount: $todoActiveCount)';

  TodoActiveCountState copyWith({
    int? todoActiveCount,
  }) {
    return TodoActiveCountState(
      todoActiveCount: todoActiveCount ?? this.todoActiveCount,
    );
  }
}

class TodoActiveCount{
  final TodoList todoList;
  TodoActiveCount({required this.todoList});

  TodoActiveCountState  get state => TodoActiveCountState(
    todoActiveCount: todoList.state.todos
            .where((Todo todo) => !todo.completed)
            .toList()
            .length,
  );
}