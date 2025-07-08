import 'package:flutter/material.dart';
import 'package:todoai/new_todos.dart';
import 'package:todoai/todos.dart';
import 'package:todoai/todos_list.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() {
    return _TodoScreenState();
  }
}

class _TodoScreenState extends State<TodoScreen> {
  final List<Todos> _ListOfTodos = [
    Todos(
      title: 'Meeting',
      date: DateTime.now(),
      time: TimeOfDay.now(),
      category: Category.meetings,
    ),
    Todos(
      title: 'Learning',
      date: DateTime.now(),
      time: TimeOfDay.now(),
      category: Category.learning,
    ),
  ];

  void _addExpensesToScreen() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewTodos(onAddTodos: _addTodos),
    );
  }

  void _addTodos(Todos todo) {
    setState(() {
      _ListOfTodos.add(todo);
    });
  }

  void _removedExpenses(Todos todo) {
    final todoIndex = _ListOfTodos.indexOf(todo);
    setState(() {
      _ListOfTodos.remove(todo);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text("Removed Todo"),
        action: SnackBarAction(
          label: 'undo',
          onPressed: () {
            setState(() {
              _ListOfTodos.insert(todoIndex, todo);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text("Todo-AI"),
            SizedBox(height: 5),
            Text(
              "${DateTime.now().toLocal().toString().split(' ')[0]}",
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: _addExpensesToScreen, icon: Icon(Icons.add)),
        ],
      ),

      body: Column(
        children: [
          Expanded(
            child: TodosList(
              todo: _ListOfTodos,
              onRemoveTodos: _removedExpenses,
            ),
          ),
        ],
      ),
    );
  }
}
