import "package:flutter/material.dart";
import "package:flutter_todolist/provider/filtered_todos.dart";
import "package:flutter_todolist/provider/provider.dart";
import "package:flutter_todolist/provider/todo_filter.dart";
import "package:flutter_todolist/provider/todo_list.dart";
import "package:provider/provider.dart";

import "screens/todos_screen.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //MultiProvider 추가
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TodoList>(create: (context) => TodoList()),
        ChangeNotifierProvider<TodoFilter>(create: (context) => TodoFilter()),
        ChangeNotifierProvider<TodoSearch>(create: (context) => TodoSearch()),
        ProxyProvider3<TodoFilter, TodoSearch, TodoList, FilteredTodos>(
          update: (
            BuildContext context,
            TodoFilter todoFilter,
            TodoSearch todoSearch,
            TodoList todoList,
            FilteredTodos? _,
          ) =>
              FilteredTodos(
                todoList: todoList,
                todoFilter: todoFilter,
                todoSearch: todoSearch,
              ),
        ),
        ProxyProvider<TodoList, TodoActiveCount>(
          update: (
            BuildContext context,
            TodoList todoList,
            TodoActiveCount? _,
          ) =>
              TodoActiveCount(todoList: todoList),
        )
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