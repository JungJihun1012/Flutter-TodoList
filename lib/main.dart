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
        ChangeNotifierProxyProvider3<TodoFilter, TodoSearch, TodoList,
            FilteredTodos>(
          create: (context) => FilteredTodos(
            initFilteredTodos: context.read<TodoList>().state.todos,
          ),
          update: (
            BuildContext context,
            TodoFilter todoFilter,
            TodoSearch todoSearch,
            TodoList todoList,
            FilteredTodos? filteredTodos,
          ) =>
              filteredTodos!..update(todoFilter, todoSearch, todoList),
        ),
        ChangeNotifierProxyProvider<TodoList, TodoActiveCount>(
          create: (context) => TodoActiveCount(
            initTodoActiveCount: context.read<TodoList>().state.todos.length,
          ),
          update: (
            BuildContext context,
            TodoList todoList,
            TodoActiveCount? todoActiveCount,
          ) =>
              todoActiveCount!..update(todoList),
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