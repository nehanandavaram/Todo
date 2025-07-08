import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category { meetings, learning, leisure, shop, health }

const categoryIcons = {
  Category.health: Icons.health_and_safety_outlined,
  Category.learning: Icons.laptop_rounded,
  Category.leisure: Icons.movie,
  Category.shop: Icons.shop_two_outlined,
  Category.meetings: Icons.meeting_room_outlined,
};

class Todos {
  Todos({
    required this.title,
    required this.date,
    required this.time,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final DateTime date;
  final TimeOfDay time;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }

  String formattedTime(BuildContext context) {
    return time.format(context);
  }
}

// class ExpenseBucket {
//   ExpenseBucket({required this.category, required this.expenses});
//   ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
//     : expenses =
//           allExpenses.where((expense) => expense.category == category).toList();
//   final Category category;
//   final List<Expense> expenses;
//   double get totalExpense {
//     double sum = 0;
//     for (final expense in expenses) {
//       sum += expense.price;
//     }
//     return sum;
//   }
// }
