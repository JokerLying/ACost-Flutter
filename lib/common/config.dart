import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Config {
  static bool darkMode;
  static bool chineseMode;
  static ThemeData themeData;

  static Future<bool> loadConfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    darkMode = prefs.getBool("dark_mode") ?? false;
    chineseMode = prefs.getBool("chinese_mode") ?? false;
    return true;
  }

  static _saveDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("dark_mode", darkMode);
  }

  static _saveChineseMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("chinese_mode", chineseMode);
  }

  static changeThemeMode() {
    darkMode = !darkMode;
    setTheme();
    _saveDarkMode();
  }

  static changeChineseMode() {
    chineseMode = !chineseMode;
    _saveChineseMode();
  }

  static setTheme() {
    if (darkMode) {
      themeData = _nightTheme;
    } else {
      themeData = _dayTheme;
    }
  }

  static ThemeData get _dayTheme {
    return new ThemeData(
      primarySwatch: Colors.teal,
      backgroundColor: Colors.teal[50],
      scaffoldBackgroundColor: Colors.teal[50],
      iconTheme: IconThemeData(color: Colors.teal[50]),
      bottomAppBarColor: Colors.teal[300],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.teal[400],
        foregroundColor: Colors.teal[50],
      ),
      primaryIconTheme: IconThemeData(color: Colors.teal[50]),
      primaryTextTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.teal[600],
        ),
        bodyText2: TextStyle(
          color: Colors.teal[700],
        ),
      ),
      accentTextTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.teal[300],
        ),
        bodyText2: TextStyle(
          color: Colors.teal[400],
        ),
      ),
    );
  }

  static ThemeData get _nightTheme {
    return new ThemeData(
      primarySwatch: Colors.blueGrey,
      backgroundColor: Colors.blueGrey[900],
      scaffoldBackgroundColor: Colors.blueGrey[900],
      iconTheme: IconThemeData(color: Colors.blueGrey[900]),
      bottomAppBarColor: Colors.blueGrey[500],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.blueGrey[600],
        foregroundColor: Colors.blueGrey[900],
      ),
      primaryTextTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.blueGrey[400],
        ),
        bodyText2: TextStyle(
          color: Colors.blueGrey[300],
        ),
      ),
      accentTextTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.blueGrey[700],
        ),
        bodyText2: TextStyle(
          color: Colors.blueGrey[600],
        ),
      ),
    );
  }
}
