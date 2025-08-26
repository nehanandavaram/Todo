import 'package:flutter/material.dart';
import 'package:todoai/todos.dart';

class NewTodos extends StatefulWidget {
  const NewTodos({super.key, required this.onAddTodos});
  final void Function(Todos todo) onAddTodos;

  @override
  State<StatefulWidget> createState() {
    return _NewTodosState();
  }
}

class _NewTodosState extends State<NewTodos> {
  final _titleController = TextEditingController();
  final _timeController = TextEditingController();
  DateTime? _SelectedDate;
  TimeOfDay? _selectedTime;
  Category _SelectedCategory = Category.leisure;

  // Future<void> _selectTime(BuildContext context) async {
  //   final TimeOfDay? picked = await showTimePicker(
  //     context: context,
  //     initialTime: _selectedTime ?? TimeOfDay.now(),
  //   );

  //   if (picked != null) {
  //     _selectedTime = picked;
  //     _timeController.text = picked.format(context); // auto formats with AM/PM
  //   }
  // }

  void _presentDatePicker() async {
    final _pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    setState(() {
      _SelectedDate = _pickedDate;
    });
  }

  void _presentTimePicker() async {
    final now = TimeOfDay.now();
    final _pickedTime = await showTimePicker(
      context: context,
      initialTime: now,
    );
    setState(() {
      _selectedTime = _pickedTime;
      _timeController.text = _pickedTime!.format(context);
    });
  }

  //time validation

  bool isTimeInFuture(TimeOfDay selectedTime) {
    final now = DateTime.now();
    final selectedDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    return selectedDateTime.isAfter(now);
  }

  void submitTodos() {
    if (_selectedTime == null ||
        _SelectedDate == null ||
        _titleController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: Text("Invalid Input"),
              content: Text("Please check that your title,date,time entered"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: Text("Okay"),
                ),
              ],
            ),
      );
      return;
    }

    widget.onAddTodos(
      Todos(
        title: _titleController.text,
        date: _SelectedDate!,
        time: _selectedTime!,
        category: _SelectedCategory,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 100,
            decoration: InputDecoration(label: Text('Title')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _timeController,
                  readOnly: true,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    label: Text('Time'),
                    //suffixIcon: Icon(Icons.access_time),
                    suffixIcon: IconButton(
                      onPressed: _presentTimePicker,
                      icon: Icon(Icons.access_time),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _SelectedDate == null
                          ? 'No Date Selected'
                          : formatter.format(_SelectedDate!),
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              DropdownButton(
                value: _SelectedCategory,
                items:
                    Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toUpperCase()),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _SelectedCategory = value;
                  });
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('cancel'),
              ),
              ElevatedButton(onPressed: submitTodos, child: Text('Submit')),
            ],
          ),
        ],
      ),
    );
  }
}
