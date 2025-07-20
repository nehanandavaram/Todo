import 'package:flutter/material.dart';
import 'package:todoai/todo_screen.dart';

final kColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 96, 58, 181),
);
final kDarkScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Color.fromARGB(255, 5, 98, 125),
);
void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: kDarkScheme,
        cardTheme: CardThemeData(
          color: kDarkScheme.primaryContainer,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkScheme.primaryContainer,
            foregroundColor: kDarkScheme.onPrimaryContainer,
          ),
        ),
      ),
      theme: ThemeData(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: kColorScheme,
        appBarTheme: AppBarTheme(
          backgroundColor: kColorScheme.primaryContainer,
          foregroundColor: kColorScheme.onPrimaryContainer,
        ),
        cardTheme: CardThemeData(
          color: kColorScheme.primaryContainer,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
            foregroundColor: kColorScheme.onPrimaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            color: kColorScheme.onSecondaryContainer,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),

      home: TodoScreen(),
    ),
  );
}
