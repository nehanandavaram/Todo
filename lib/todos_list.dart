import 'package:flutter/material.dart';
import 'package:todoai/todo_items.dart';
import 'package:todoai/todos.dart';

class TodosList extends StatelessWidget {
  const TodosList({super.key, required this.todo, required this.onRemoveTodos});
  final List<Todos> todo;
  final void Function(Todos todo) onRemoveTodos;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todo.length,
      itemBuilder:
          (ctx, index) => Dismissible(
            key: ValueKey(todo[index]),
            background: Container(
              color: Theme.of(context).colorScheme.error,
              margin: EdgeInsets.symmetric(
                horizontal: Theme.of(context).cardTheme.margin!.horizontal,
              ),
            ),
            onDismissed: (direction) {
              onRemoveTodos(todo[index]);
            },
            child: TodoItems(todo[index]),
          ),
    );
  }
}
