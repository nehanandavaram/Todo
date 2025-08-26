// import 'package:flutter/material.dart';
// import 'package:todoai/todos.dart';

// class UpdatedTodo extends StatefulWidget {
//   const UpdatedTodo({
//     super.key,
//     required this.existingTodo, // 👈 add this
//   });

//   final Todos existingTodo; // 👈 todo being edited

//   @override
//   State<StatefulWidget> createState() {
//     return _UpdatedTodoState();
//   }
// }

// class _UpdatedTodoState extends State<UpdatedTodo> {
//   late TextEditingController _titleController;
//   late DateTime _dateController;
//   late TimeOfDay _selectedTime;
//   late Category _selectedCategory;

//   @override
//   void initState() {
//     super.initState();
//     // pre-fill with existing todo values
//     _titleController = TextEditingController(text: widget.existingTodo.title);
//     _dateController = widget.existingTodo.date;
//     _selectedTime = widget.existingTodo.time;
//     _selectedCategory = widget.existingTodo.category;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(30),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextField(
//             controller: _titleController,
//             decoration: const InputDecoration(label: Text("Title")),
//           ),
//           const SizedBox(height: 20),
//           TextField(
//             controller: _dateController,
//             decoration: const InputDecoration(label: Text("Date")),
//           ),

//           ElevatedButton(
//             onPressed: () {
//               final updatedTodo = Todos(
//                 title: _titleController.text,
//                 date: widget.existingTodo.date,
//                 time: widget.existingTodo.time,
//                 category: widget.existingTodo.category,
//               );
//               // widget.toUpdateTodos(updatedTodo);
//               Navigator.pop(context); // close after update
//             },
//             child: const Text("Update"),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:todoai/todos.dart';

class UpdatedTodo extends StatefulWidget {
  const UpdatedTodo({
    super.key,
    required this.existingTodo,
    required this.toUpdateTodos,
  });

  final Todos existingTodo;
  final void Function(Todos todo) toUpdateTodos;

  @override
  State<StatefulWidget> createState() {
    return _UpdatedTodoState();
  }
}

class _UpdatedTodoState extends State<UpdatedTodo> {
  late TextEditingController _titleController;
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  late Category _selectedCategory;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.existingTodo.title);
    _selectedDate = widget.existingTodo.date;
    _selectedTime = widget.existingTodo.time;
    _selectedCategory = widget.existingTodo.category;
  }

  // Future<void> _pickDate() async {
  //   final pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: _selectedDate,
  //     firstDate: DateTime(2020),
  //     lastDate: DateTime(2100),
  //   );
  //   if (pickedDate != null) {
  //     setState(() {
  //       _selectedDate = pickedDate;
  //     });
  //   }
  // }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _pickTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title field
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(label: Text("Title")),
            ),
            const SizedBox(height: 20),

            // Date picker
            Row(
              children: [
                Text(
                  "Date: ${_selectedDate.toLocal().toString().split(' ')[0]}",
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: _pickDate,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Time picker
            Row(
              children: [
                Text("Time: ${_selectedTime.format(context)}"),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.access_time),
                  onPressed: _pickTime,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Category dropdown
            DropdownButton<Category>(
              value: _selectedCategory,
              items:
                  Category.values.map((cat) {
                    return DropdownMenuItem(
                      value: cat,
                      child: Text(cat.name.toUpperCase()),
                    );
                  }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedCategory = value;
                  });
                }
              },
            ),
            const SizedBox(height: 30),

            // Update button
            ElevatedButton(
              onPressed: () {
                final updatedTodo = Todos(
                  title: _titleController.text,
                  date: _selectedDate,
                  time: _selectedTime,
                  category: _selectedCategory,
                );
                widget.toUpdateTodos(updatedTodo);
                Navigator.pop(context);
              },
              child: const Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}
