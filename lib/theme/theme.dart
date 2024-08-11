import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade200, // Light grey for surfaces
    primary: Color(0xFF7C4DFF), // Purple
    secondary: Color(0xFF448AFF), // Blue
    inversePrimary: Colors.white, // White for inverse primary
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: Color(0xFF7C4DFF)),
    bodyLarge: TextStyle(fontSize: 16.0, color: Colors.grey.shade800),
    bodyMedium: TextStyle(fontSize: 14.0, color: Colors.grey.shade600),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF7C4DFF), // Purple for buttons
      foregroundColor: Colors.white, // White text on buttons
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade800, // Dark grey for surfaces
    primary: Color(0xFF9C27B0), // Lighter Purple for contrast in dark mode
    secondary: Color(0xFF82B1FF), // Light blue for secondary elements
    inversePrimary: Colors.grey.shade300, // Light grey for inverse primary
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
    bodyLarge: TextStyle(fontSize: 16.0, color: Colors.grey.shade300),
    bodyMedium: TextStyle(fontSize: 14.0, color: Colors.grey.shade500),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF9C27B0), // Lighter purple for buttons
      foregroundColor: Colors.white, // White text on buttons
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  ),
);
