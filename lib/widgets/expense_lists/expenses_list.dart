//this file is for the appearance of the entire list of expenses
import 'package:expense_app/widgets/expense_lists/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_app/models/expense.dart';

class ExpensesList extends StatelessWidget {
  //stateless widget defination
  const ExpensesList({super.key, required this.expenses}); //constructor for the class
  final List<SingleExpense> expenses; //list of expenses

  @override
  Widget build(context) {
    return ListView.builder(
      //using listview builder, a special constructor for when
      // we dont know the number of items and only wish to display visible items
      // it takes itembuilder named parameter, which needs a function of return type
      // widget, the function gets 2 args, builcontext and an index for each item
      // we also define a itemcount argument to tell how many items does it need to build
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => ExpenseItem(expenses[index]), 
      //we basically pass the ExpenseItem widget using index to pass a single expense
      //to it
    );
  }
}
