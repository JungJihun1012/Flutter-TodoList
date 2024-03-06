import "package:flutter/material.dart";
import "package:flutter_todolist/provider/provider.dart";
import "package:provider/provider.dart";
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import "screens/todos_screen.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StateNotifierProvider<TodoList, TodoListState>(
            create: (context) => TodoList()),
        StateNotifierProvider<TodoFilter, TodoFilterState>(
            create: (context) => TodoFilter()),
        StateNotifierProvider<TodoSearch, TodoSearchState>(
            create: (context) => TodoSearch()),
        StateNotifierProvider<TodoActiveCount, TodoActiveCountState>(
            create: (context) => TodoActiveCount()),
        StateNotifierProvider<FilteredTodos, FilteredTodosState>(
            create: (context) => FilteredTodos()),
      ],
      child: MaterialApp(
        title: 'TODOS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TodosScreen(),
      ),
    );
  }
}