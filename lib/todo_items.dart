import 'package:flutter/material.dart';
import 'package:todoai/todos.dart';

class TodoItems extends StatelessWidget {
  const TodoItems(this.todos, {super.key});
  final Todos todos;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                  Row(
                    children: [
                      const SizedBox(width: 20),
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
