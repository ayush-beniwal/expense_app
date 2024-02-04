//this file is for making a widget for the appearnce of 1 expense item
import 'package:flutter/material.dart';
import 'package:expense_app/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.singleExpense, {super.key});

  final SingleExpense singleExpense; //recieving a single expense as parameter

  @override
  Widget build(context) {
    return Card(
      //using the card widget to get a card like feel for our expense item
      child: Padding(
        //wrapping our column with a padding widget
        padding:
            const EdgeInsets.fromLTRB(16, 60, 16, 16), //left top right bottom
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          //column with children as title, and then a size box, then a row of info
          children: [
            Text(
              singleExpense.title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge, //applies our default theme to this widget
              //basically reaches out to main class via context, then access the titleLarge texttheme
            ),
            const SizedBox(height: 7),
            Row(
              //row which will have title, sizedbox, and then a row of rest items
              children: [
                Text('\$${singleExpense.amount.toStringAsFixed(2)}'),
                //converting amount to 2 decimal places string
                //we inject the value in a string using ${} syntax. we also escape the first $
                const Spacer(),
                //spacer widget, used in any column or row, and it gets all the space it
                //can take in the entire column or the row.
                Row(children: [
                  Icon(categoryIcons[
                      singleExpense.category]), //using the map for icons
                  const SizedBox(width: 8),
                  Text(singleExpense
                      .formattedDate) //using our getter {notice no ()}
                ]),
              ],
            )
          ],
        ),
      ),
    );
  }
}
