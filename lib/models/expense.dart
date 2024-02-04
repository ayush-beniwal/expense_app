import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter =
    DateFormat.yMd(); //using the imported intl package to define a
// date format object
const uuid = Uuid(); //defiing a uuid object for ID creation

enum Category { food, travel, leisure, work } //making an enum for category

const categoryIcons = {
  //making a map of icons and enum catergory
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class SingleExpense {
  SingleExpense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid
            .v4(); //initializing a default id using uuid package, done in this way
// writing the same code without using the this keyword
//   Expenses({
//     required String title,
//     required double amount,
//     required DateTime date,
//     required Category category,
//   }) : id = Uuid().v4(),
//        title = title,
//        amount = amount,
//        date = date,
//        category = category;
// }

  final String title;
  final double amount;
  final String id;
  final DateTime date;
  final Category category;

  String get formattedDate {
    //just defined a getter.
    return formatter.format(date);
    //using the format method on date, via the formatter obj
  }
}

class ExpenseBucket {
  //making a model for our chart
  ExpenseBucket(
      {required this.category,
      required this.expenses}); //base constructor function
  ExpenseBucket.forCategory(List<SingleExpense> allExpenses,
      this.category) //another constructor function, when we
      //wish to return expenses for a specififc catergorry
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();
  //using an initializer list to set expenses variable equal to allExpenses, but using where to filter
  //the list for items whose category matches the given category, finally converting it to list;
  final Category category;
  final List<SingleExpense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
