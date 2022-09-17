import 'package:flutter/material.dart';
 
class AppTheme {
  //
  AppTheme._();
 
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.green,
      ),
    ),
    colorScheme:  ColorScheme.light(
      primary: Colors.black,
      onPrimary: Colors.black.withOpacity(0.7),
      secondary: Colors.green,
    ),
    cardTheme: const CardTheme(
      color: Colors.teal,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white54,
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
      ),
      subtitle1: TextStyle(
        color: Colors.black,
        fontSize: 18.0,
      ),
    ),
  );
 
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.green,
      ),
    ),
    colorScheme: const ColorScheme.dark(
      primary: Colors.black,
      onPrimary: Colors.white,
      secondary: Colors.green,
      onSecondary: Colors.white
    ),
    cardTheme: const CardTheme(
      color: Colors.black,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white54,
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      subtitle1: TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
    ),
  );
}