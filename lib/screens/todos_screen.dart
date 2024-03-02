import 'package:flutter/material.dart';
import 'package:flutter_todolist/provider/todo_list.dart';
import 'package:provider/provider.dart';

import '../model/todo_model.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({Key? key}) : super(key: key);

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
            child: Column(
              children: const [
                TodoHeader(),
                CreateTodo(),
                SizedBox(height: 20.0),
                SearchAndFilterTodo(),
                ShowTodos(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TodoHeader extends StatelessWidget {
  const TodoHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          'TODO',
          style: TextStyle(fontSize: 40.0),
        ),
        Text(
          '0 items left',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.redAccent,
          ),
        ),
      ],
    );
  }
}

class CreateTodo extends StatefulWidget {
  const CreateTodo({Key? key}) : super(key: key);

  @override
  _CreateTodoState createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  final newTodoController = TextEditingController();

  @override
  void dispose() {
    newTodoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: newTodoController,
      decoration: const InputDecoration(labelText: 'What to do?'),
      onFieldSubmitted: (String? todoDesc) {
        if (todoDesc != null && todoDesc.trim().isNotEmpty) {
          debugPrint('CreateTodo Clicked: ${todoDesc.toString()}');
          context.read<TodoList>().addTodo(todoDesc);
          newTodoController.clear();
        }
      },
    );
  }
}

class SearchAndFilterTodo extends StatefulWidget {
  //StatelessWidget
  const SearchAndFilterTodo({Key? key}) : super(key: key);

  @override
  State<SearchAndFilterTodo> createState() => _SearchAndFilterTodoState();
}

class _SearchAndFilterTodoState extends State<SearchAndFilterTodo> {
  String clickedType = 'all';

  // final debounce = Debounce(milliseconds: 1000);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Search todos',
            border: InputBorder.none,
            filled: true,
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (String? newSearchTerm) {
            debugPrint('Search todos: $newSearchTerm');
            // if (newSearchTerm != null) {
            //   debounce.run(() {
            //     context.read<TodoSearch>().setSearchTerm(newSearchTerm);
            //   });
            // }
          },
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            filterButton(context, 'all'),
            filterButton(context, 'active'),
            filterButton(context, 'completed'),
          ],
        ),
      ],
    );
  }

  Widget filterButton(BuildContext context, String filter) {
    //, Filter filter
    return TextButton(
      onPressed: () {
        // context.read<TodoFilter>().changeFilter(filter);
        clickedType = filter;
        debugPrint('Clicked button $clickedType');
        setState(() {});
      },
      child: Text(
        filter == 'all'
            ? 'All'
            : filter == 'active'
                ? 'Active'
                : 'Completed',
        style: TextStyle(
          fontSize: 18.0,
          color: textColor(context, filter),
        ),
      ),
    );
  }

  Color textColor(BuildContext context, String filter) {
    //Filter filter
    var currentFilter = clickedType; //context.watch<TodoFilter>().state.filter
    return currentFilter == filter ? Colors.blue : Colors.grey;
  }
}

// => todo_model.dart
// class Todo {
//   String id;
//   String desc;
//   bool completed;
//
//   Todo({
//     required this.id,
//     required this.desc,
//     this.completed = false,
//   });
//
// }
//
// List<Todo> todos = [
//   Todo(id: '1', desc: 'Clean the room'),
//   Todo(id: '2', desc: 'Wash the dish'),
//   Todo(id: '3', desc: 'Do homework'),
// ];

class ShowTodos extends StatelessWidget {
  const ShowTodos({Key? key}) : super(key: key);

  Widget showBackground(int direction) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      color: Colors.red,
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        size: 30.0,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 현재는 초기화 되는 부분에서 가져오지만 차후에는 필더리스트 가져오기.
    final todos = context.watch<TodoList>().state.todos;

    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemCount: todos.length,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(color: Colors.grey);
      },
      itemBuilder: (BuildContext context, int index) {
        return TodoItem(todo: todos[index]);
      },
    );
  }
}

class TodoItem extends StatefulWidget {
  final Todo todo;
  const TodoItem({Key? key, required this.todo}) : super(key: key);

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    debugPrint('todo list : ${widget.todo}');

    return ListTile(
      leading: Checkbox(
        value: widget.todo.completed,
        onChanged: (bool? checked) {
          // 토글함수
          context.read<TodoList>().toggleTodo(widget.todo.id);
          debugPrint(
              'value(${widget.todo.desc}): ${widget.todo.completed.toString()}');
          // provider 처리해서 필요없음
          // setState(() {});
        },
      ),
      title: Text(widget.todo.desc),
    );
  }
}