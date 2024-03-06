import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:state_notifier/state_notifier.dart';
import '../model/todo_model.dart';

class TodoListState extends Equatable {
  final List<Todo> todos;
  const TodoListState({
    required this.todos,
  });

  factory TodoListState.init() {
    return TodoListState(todos: [
      Todo(id: '1', desc: 'Clean the room'),
      Todo(id: '2', desc: 'Wash the dish'),
      Todo(id: '3', desc: 'Do homework')
    ]);
  }

  @override
  List<Object> get props => [todos];

  @override
  String toString() {
    return 'TodoListState{todos": $todos}';
  }

  TodoListState copyWith({
    List<Todo>? todos,
  }) {
    return TodoListState(todos: todos ?? this.todos);
  }
}

class TodoList extends StateNotifier<TodoListState> {
  TodoList() : super(TodoListState.init());

  void addTodo(String todoDesc) {
    int? newNum;
    if (state.todos.isEmpty) {
      newNum = 1;
    } else {
      newNum = int.parse(state.todos.last.id) + 1;
    }
    final newTodo = Todo(id: newNum.toString(), desc: todoDesc);
    final newTodos = [...state.todos, newTodo];

    state = state.copyWith(todos: newTodos);
    debugPrint('addTodo: ' + state.toString());
  }

  void editTodo(String id, String desc) {
    final newTodos = state.todos.map((Todo todo) {
      if (todo.id == id) {
        return Todo(
          id: id,
          desc: desc,
          completed: todo.completed,
        );
      }
      return todo;
    }).toList();

    state = state.copyWith(todos: newTodos);
  }

  void removeTodo(String id) {
    final newTodos = state.todos.where((Todo todo) => todo.id != id).toList();
    state = state.copyWith(todos: newTodos);
    debugPrint('remove Todos: ' + state.toString());
  }

  void toggleTodo(String id) {
    final newTodos = state.todos.map((Todo todo) {
      if (todo.id == id) {
        return Todo(
          id: id,
          desc: todo.desc,
          completed: !todo.completed,
        );
      }
      return todo;
    }).toList();
    state = state.copyWith(todos: newTodos);
  }
}