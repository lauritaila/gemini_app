import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  final bool isDarkMode;
  AppTheme({required this.isDarkMode});

  ThemeData getTheme() => ThemeData(
    colorSchemeSeed: Color(0xFF1E1C36),
    brightness: isDarkMode ? Brightness.dark : Brightness.light,
    useMaterial3: true,
    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor:  Color(0xFF1E1C36),
      surfaceTintColor: Colors.transparent,
      elevation: 0,
    ),
  );

  static setSystemUIOverlayStyle({required bool isDarkMode}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
      systemNavigationBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: Colors.transparent
    ));
  }
}
