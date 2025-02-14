import 'package:flutter/material.dart';

class AppTheme {
  // Define Colors
  static const Color darkGray = Color(0xFF171717);
  static const Color offWhite =
      Color(0xFFF0FCF0); // This seems incorrect, check the hex code
  static const Color paleYellow = Color(0xFFD9DBA4);
  static const Color lightBeige = Color(0xFFDCE0CE);
  static const Color lavender = Color(0xFFC6C3FA);
  static const Color gold = Color(0xFFF5D525);
  static const Color softPink =
      Color(0xFFFDC1C1); // This hex code seems incorrect, check it

  // Define Text Styles
  static TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(
        fontFamily: 'Lexend',
        fontWeight: FontWeight.w200,
        fontSize: 32,
        color: darkGray), // Light
    displayMedium: TextStyle(
        fontFamily: 'Lexend',
        fontWeight: FontWeight.w400,
        fontSize: 28,
        color: darkGray), // Regular
    displaySmall: TextStyle(
        fontFamily: 'Lexend',
        fontWeight: FontWeight.w500,
        fontSize: 24,
        color: darkGray), // Medium
    headlineMedium: TextStyle(
        fontFamily: 'Lexend',
        fontWeight: FontWeight.w600,
        fontSize: 20,
        color: darkGray), // SemiBold
    bodyLarge: TextStyle(
        fontFamily: 'Lexend',
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: darkGray),
    bodyMedium: TextStyle(
        fontFamily: 'Lexend',
        fontWeight: FontWeight.w200,
        fontSize: 14,
        color: darkGray),
  );

  // Define Light Theme
  static ThemeData lightTheme = ThemeData(
    primaryColor: gold,
    scaffoldBackgroundColor: offWhite,
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: gold,
      titleTextStyle: TextStyle(
          fontFamily: 'Lexend',
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: darkGray),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lavender,
        foregroundColor: darkGray,
        textStyle: TextStyle(
            fontFamily: 'Lexend', fontWeight: FontWeight.w500, fontSize: 18),
      ),
    ),
  );
}
