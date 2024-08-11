import 'package:flutter/material.dart';
import 'package:lucidlogs/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
    _saveThemeToPreferences();
  }

  void setAccentColor(Color color) {
    if (isDarkMode) {
      _themeData = darkMode.copyWith(
        colorScheme: _themeData.colorScheme.copyWith(primary: color),
      );
    } else {
      _themeData = lightMode.copyWith(
        colorScheme: _themeData.colorScheme.copyWith(primary: color),
      );
    }
    notifyListeners();
    _saveAccentColorToPreferences(color);
  }

  Future<void> _saveThemeToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode);
  }

  Future<void> _saveAccentColorToPreferences(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('accentColor', color.value);
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    bool isDarkModePref = prefs.getBool('isDarkMode') ?? false;
    int? accentColorValue = prefs.getInt('accentColor');
    Color accentColor = accentColorValue != null
        ? Color(accentColorValue)
        : (isDarkModePref
            ? darkMode.colorScheme.primary
            : lightMode.colorScheme.primary);

    _themeData = (isDarkModePref ? darkMode : lightMode).copyWith(
      colorScheme: _themeData.colorScheme.copyWith(primary: accentColor),
    );

    notifyListeners();
  }
}
