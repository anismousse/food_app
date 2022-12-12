import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTheme extends ChangeNotifier {
  bool _isDaskTheme = true;

  currentTheme() {
    if (_isDaskTheme) {
      return ThemeMode.dark;
    }
    return ThemeMode.light;
  }

  void toggleTheme() {
    _isDaskTheme = !_isDaskTheme;
    notifyListeners();
  }

  ThemeData darkTheme = ThemeData(
      // iconTheme: IconThemeData(color: Colors.white),
      scaffoldBackgroundColor: Colors.black,
      // colorScheme: ColorScheme.fromSwatch(accentColor: Colors.white),
      appBarTheme: AppBarTheme(color: Colors.black),
      brightness: Brightness.dark,
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: Colors.blueAccent,
              textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(shape: StadiumBorder())),
      cardColor: Color(0xFF1A191D),
      dividerColor: Colors.grey[600]);

  ThemeData lightTheme = ThemeData(
    // iconTheme: IconThemeData(color: Colors.white),
    scaffoldBackgroundColor: Color(0xFFeeeeee),
    primaryColor: Color(0xFFeeeeee),
    // colorScheme: ColorScheme.fromSwatch(accentColor: Colors.white),
    appBarTheme: AppBarTheme(backgroundColor: Color(0xFFeeeeee), elevation: 0),
    brightness: Brightness.light,
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            foregroundColor: Colors.blueAccent,
            textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(shape: StadiumBorder())),
    // accentColor: Colors.black,
  );
}
