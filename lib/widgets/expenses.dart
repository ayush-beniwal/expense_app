//the file where we render the entire screen of expenses

import 'package:expense_app/widgets/expense_lists/expenses_list.dart';
import 'package:expense_app/widgets/modal.dart';
import 'package:flutter/material.dart';
import 'package:expense_app/models/expense.dart';

class Expenses extends StatefulWidget {
  Expenses({super.key}); //constructor for the stateful widget
  @override //overriding the default createState method
  State<Expenses> createState() {
    //making a method of return type State<Expense>, a generic type
    return _ExpensesState(); // returning a private class of same type
  }
}

class _ExpensesState extends State<Expenses> {
  //making the returned private class
// which extends the state of the main class

  final List<SingleExpense> _registeredExpenses = [
    //List of expenses
    SingleExpense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    SingleExpense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true, //makes the modal full screen
        context: context,
        builder: (ctx) => NewExpense(onAddExpense: _addExpense));
    //context is full of metadata info, for each widget, and it holds info about its
    //position in the widget tree
    //2nd argument is called builder. Whenever we see this, we must provide a function
    //that returns a widget, and recieves a BuildContext object to it. To avoid conflict,
    //we name that context as ctx, and make a anonymous arrow function inside it to
    //simply return a widget
  }

  void _addExpense(SingleExpense expense) {
    setState(() {
      _registeredExpenses
          .add(expense); //setting state whenever an expense is added
    });
  }

  void _removeExpense(SingleExpense expense) {
    final expenseIndex = _registeredExpenses
        .indexOf(expense); //getting the index of the expense to undo later
    setState(() {
      _registeredExpenses
          .remove(expense); //pass the expense which is to be removed as a value
      ScaffoldMessenger.of(context).clearSnackBars(); //clears all other info messages before it
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //using scaffold Messenger's showSnackBar to show a snackbar of 3 s duraction
        duration: const Duration(seconds: 3),
        content: const Text("Expense Deleted"),
        action: SnackBarAction(
            label:
                "Undo", //in action , we give a label with Undo , and a setState option which
            //inserts the deleted expense back into the list at a given position
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
              });
            }),
      ));
    });
  }

  @override
  Widget build(context) {
    Widget mainContent = const Center(
      child: Text("Add expenses from the + button"),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        removeExpense: _removeExpense,
      );
    }
    //Using a build method
    return Scaffold(
      //setting the appbar in scaffold
      appBar: AppBar(title: const Text("Ayush's expense tracker"), actions: [
        IconButton(
            onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        //using actions: argumemnt (taking a list of widgets) and adding a
        //icon button to it, which only has an icon
      ]),
      body: Column(
        children: [
          const Text('The chart'),
          Expanded(child: mainContent) //use expanded
          //whenever you use a column inside a column or a list
        ],
      ),
    );
  }
}
