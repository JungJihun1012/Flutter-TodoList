import 'package:flutter/material.dart';
import 'package:flutter_todolist/model/user.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FLutter Demo",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const todoApp(),
    );
  }
}

class todoApp extends StatefulWidget {
  const todoApp({Key? key}) : super(key: key);

  @override
  State<todoApp> createState() => _todoApp();
}

class _todoApp extends State<todoApp> {
  String title = "";
  String description = "";

  List<Todo> todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("todo - list"),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: const Text('나의 할일'),
                    actions: [
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            title = value;
                          });
                        },
                        decoration: InputDecoration(hintText: "글 제목"),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            description = value;
                          });
                        },
                        decoration: InputDecoration(hintText: "글 내용"),
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            setState(() {
                              todos.add(Todo(
                                title: title,
                                description: description,
                              ));
                            });
                          }, child: Text("글 추가 하기"),
                        ),
                      ),
                    ],
                  );
                }
              );
            },
              icon: Icon(Icons.add),
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (_, index) {
          return InkWell(
            child: ListTile(
              title: Text(todos[index].title),
              subtitle: Text(todos[index].description),
            ),
          );
        },
        itemCount: todos.length,
      ),
    );
  }
}