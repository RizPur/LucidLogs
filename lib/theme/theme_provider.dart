import 'package:flutter/material.dart';
import 'package:lucidlogs/theme/theme.dart';

class ThemeProvider with ChangeNotifier {

  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;
  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if(_themeData == lightMode){
      themeData = darkMode;
    }

    else {
      themeData = lightMode;
    }
  }

}