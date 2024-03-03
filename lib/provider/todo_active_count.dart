import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_todolist/provider/todo_list.dart';

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

class TodoActiveCount with ChangeNotifier {
  // TodoActiveCountState _state = TodoActiveCountState.init();
  late TodoActiveCountState _state;
  final int initTodoActiveCount;

  TodoActiveCount({
    required this.initTodoActiveCount,
  }) {
    debugPrint('initTodoActiveCount :' +  initTodoActiveCount.toString());
    _state = TodoActiveCountState(todoActiveCount: initTodoActiveCount);
  }

  TodoActiveCountState get state => _state;


  void update(TodoList todoList) {
    final int newTodoActiveCount =
        todoList.state.todos.where((todo) => !todo.completed).toList().length;
    _state = _state.copyWith(todoActiveCount: newTodoActiveCount);
    debugPrint('update - active count: ' + _state.toString());
    notifyListeners();
  }
}