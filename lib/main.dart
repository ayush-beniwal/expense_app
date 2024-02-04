import 'package:flutter/material.dart';
import 'package:expense_app/widgets/expenses.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(scaffoldBackgroundColor: const Color.fromARGB(255, 207, 184, 245)),
      //instead of copying an entire theme by scratch, its better to use copyWith, and just modify
      //individual aspects of that theme
      home: Expenses(),
    ),
  );
}
