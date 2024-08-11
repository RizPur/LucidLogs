import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    primary: Colors.blue.shade700, // Adjusted for better contrast
    secondary: Colors.blue.shade400,
    inversePrimary: Colors.grey.shade800,
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.blue.shade700),
    bodyLarge: TextStyle(fontSize: 16.0, color: Colors.grey.shade800),
    bodyMedium: TextStyle(fontSize: 14.0, color: Colors.grey.shade600),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue.shade700, // Background color of the button
      foregroundColor: Colors.white, // Text and icon color of the button
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: Colors.blueGrey.shade800, // Adjusted for better contrast
    secondary: Colors.blueGrey.shade600,
    inversePrimary: Colors.grey.shade300,
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.blueGrey.shade100),
    bodyLarge: TextStyle(fontSize: 16.0, color: Colors.grey.shade300),
    bodyMedium: TextStyle(fontSize: 14.0, color: Colors.grey.shade500),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blueGrey.shade700, // Background color of the button
      foregroundColor: Colors.white, // Text and icon color of the button
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  ),
);
