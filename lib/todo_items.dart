import 'package:flutter/material.dart';
import 'package:todoai/todos.dart';
import 'package:todoai/updated_todo.dart';

class TodoItems extends StatelessWidget {
  const TodoItems(this.todos, this.toUpdateTodos, {super.key});
  final Todos todos;
  final void Function(Todos oldTodos, Todos newTodos) toUpdateTodos;

  void _updateTodos(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder:
          (ctx) => UpdatedTodo(
            existingTodo: todos,
            toUpdateTodos: (updatedTodo) {
              toUpdateTodos(todos, updatedTodo);
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(todos.title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 20),
              Row(
                children: [
                  Icon(categoryIcons[todos.category]),
                  SizedBox(width: 10),
                  Text(todos.formattedTime(context)),
                  const Spacer(),
                  Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => _updateTodos(context),
                            icon: Icon(Icons.edit),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20, height: 20),
                      Text(todos.formattedDate),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
