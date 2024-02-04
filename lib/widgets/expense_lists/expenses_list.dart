//this file is for the appearance of the entire list of expenses
import 'package:expense_app/widgets/expense_lists/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_app/models/expense.dart';

class ExpensesList extends StatelessWidget {
  //stateless widget defination
  ExpensesList(
      {super.key,
      required this.expenses,
      required this.removeExpense}); //constructor for the class
  final List<SingleExpense> expenses; //list of expenses
  final void Function(SingleExpense expense)
      removeExpense; //syntax for declaring function as a property
  @override
  Widget build(context) {
    return ListView.builder(
      //using listview builder, a special constructor for when
      // we dont know the number of items and only wish to display visible items
      // it takes itembuilder named argument, which needs a function of return type
      // widget, the function gets 2 args, builcontext and an index for each item
      // we also define a itemcount argument to tell how many items does it need to build
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.2),
            margin: const EdgeInsets.symmetric(horizontal: 16),
          ),
          key: ValueKey(expenses[index]),
          onDismissed: (direction) {
            //cant point at it directly, as onDissmised passes a direction as well
            removeExpense(expenses[index]);
          },
          child: ExpenseItem(
            expenses[index],
          )),
      //we basically pass the ExpenseItem widget using index to pass a single expense
      //to it
    );
  }
} //Dismissable makes each expense item swipable to delete it. We need to pass a key to it, which basically 
//is a unique identifier to tell flutter which widget it is accociated with the key
// for dismissable, we can generate a key via ValueKey() method. We can just pass expense item to genereate
//a unique key for each expense item
