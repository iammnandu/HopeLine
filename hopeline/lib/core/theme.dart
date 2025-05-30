import 'package:flutter/material.dart';

class FontSizes {
  static const extraSmall = 14.0;
  static const small = 16.0;
  static const standard = 18.0;
  static const large = 20.0;
  static const extraLarge = 24.0;
  static const doubleExtraLarge = 32.0;
}

class DefaultColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color pink = Color(0xFFEA2B83);
  static const Color lightpink = Color(0xFFFCDDEC);
  static const Color purple = Color(0xFF8E8FF8);
  static const Color orange = Color(0xFFF18F3B);
  static const Color lightteal = Color(0xFF58D5D4);

  static Color task1 = Colors.pink[100]!;
  static Color task2 = Colors.orange[100]!;
  static Color task3 = Colors.green[100]!;
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: const Color(0xFFAEAFF7),
      focusColor: const Color(0xFF371B34), 
      textTheme: TextTheme(
        bodySmall: TextStyle(
          fontFamily: 'AlegreyaSans',
          fontSize: FontSizes.small,
          color: Colors.white,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'AlegreyaSans',
          fontSize: FontSizes.standard,
          color: Colors.white,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'AlegreyaSans',
          fontSize: FontSizes.large,
          color: Colors.white,
        ),
        titleSmall: TextStyle(
          fontFamily: 'AlegreyaSans',
          fontSize: FontSizes.large,
          color: Colors.black,
        ),
        titleMedium: TextStyle(
          fontFamily: 'AlegreyaSans',
          fontSize: FontSizes.extraLarge,
          color: Colors.black,
        ),
        titleLarge: TextStyle(
          fontFamily: 'AlegreyaSans',
          fontSize: FontSizes.doubleExtraLarge,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        labelSmall: TextStyle(
          fontFamily: 'AlegreyaSans',
          fontSize: FontSizes.small,
          color: Colors.black,
        ),
        labelMedium: TextStyle(
          fontFamily: 'AlegreyaSans',
          fontSize: FontSizes.extraLarge,
          color: Colors.black,
        ),
        labelLarge: TextStyle(
          fontFamily: 'AlegreyaSans',
          fontSize: FontSizes.doubleExtraLarge,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
