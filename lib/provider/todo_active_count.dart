import 'package:equatable/equatable.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

class TodoActiveCount extends StateNotifier<TodoActiveCountState>
    with LocatorMixin {
  TodoActiveCount() : super(TodoActiveCountState.init());

  @override
  void update(Locator watch) {
    final List<Todo> todos = watch<TodoListState>().todos;
    state = state.copyWith(
        todoActiveCount:
            todos.where((Todo todo) => !todo.completed).toList().length);
    super.update(watch);
  }
}