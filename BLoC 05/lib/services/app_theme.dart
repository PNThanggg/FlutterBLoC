import 'package:flutter/material.dart';

enum AppTheme {
  lightTheme,
  darkTheme,
}

class AppThemes {
  static final appThemeData = {
    AppTheme.darkTheme: ThemeData(
      useMaterial3: true,
      primaryColor: Colors.black,
      brightness: Brightness.dark,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      dividerColor: Colors.black54,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        color: Colors.black12,
        // backgroundColor: Colors.black12,
        actionsIconTheme: IconThemeData(
          color: Colors.white,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),

        titleTextStyle: TextStyle(
          color: Colors.white,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
      ),
      textTheme: const TextTheme(
        titleMedium: TextStyle(color: Colors.white),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.grey,
        unselectedItemColor: Colors.white,
      ),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.grey,
      ).copyWith(
        background: const Color(0xFF212121),
        brightness: Brightness.dark,
      ),
    ),
    AppTheme.lightTheme: ThemeData(
      useMaterial3: true,
      primaryColor: Colors.white,
      brightness: Brightness.light,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      dividerColor: const Color(0xff757575),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.black),
        ),
      ),
      textTheme: const TextTheme(
        titleMedium: TextStyle(
          color: Colors.black,
        ),
      ),
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        // backgroundColor: Colors.black12,
        actionsIconTheme: IconThemeData(
          color: Colors.black,
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),

        titleTextStyle: TextStyle(
          color: Colors.black,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.grey,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
      ),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey).copyWith(
        background: const Color(0xFFE5E5E5),
      ),
    ),
  };
}
