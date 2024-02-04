import 'package:flutter/material.dart';
import 'package:expense_app/widgets/expenses.dart';

var kColorScheme = //convention to define global variables starting with k
    ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(
            255, 96, 59, 181)); //allows us to make a color scheme
//via simply supplying a seed color

var kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark, //tells flutter we are building for dark theme
    seedColor: const Color.fromARGB(255, 5, 99, 125));
void main() {
  runApp(MaterialApp(
    darkTheme: ThemeData.dark().copyWith(
      colorScheme: kDarkColorScheme,
    ),
    themeMode: ThemeMode.system,
    home: Expenses(),
    theme: ThemeData().copyWith(
        colorScheme:
            kColorScheme, //using the colorscheme defined above  (wille be used with various widgetks)
        //instead of copying an entire theme by scratch, its better to use copyWith, and just modify
        //individual aspects of that theme
        appBarTheme: const AppBarTheme().copyWith(
          //using color scheme to set various styling options
          centerTitle: true,
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
            color: kColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: kColorScheme.onSecondaryContainer,
                  fontSize: 16),
            )),
  ));
}
