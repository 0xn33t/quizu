import 'package:flutter/material.dart';
import 'package:quiz_u/core/theme/styles.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 5,
      shadowColor: Colors.black26,
      titleTextStyle: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppColors.textColor,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.all(12),
        ),
        elevation: MaterialStateProperty.all(0),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.black,
      showUnselectedLabels: true,
      elevation: 0,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.black12),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.black12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: AppColors.primary),
      ),
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.w900,
        color: AppColors.textColor,
      ),
      headline2: TextStyle(
        fontSize: 31,
        fontWeight: FontWeight.bold,
        color: AppColors.textColor,
      ),
      headline3: TextStyle(
        fontSize: 27,
        fontWeight: FontWeight.w600,
        color: AppColors.textColor,
      ),
      headline4: TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.w600,
        color: AppColors.textColor,
      ),
      headline5: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: AppColors.textColor,
      ),
      headline6: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppColors.textColor,
      ),
      subtitle1: TextStyle(color: Colors.black, fontSize: 13),
      subtitle2: TextStyle(color: Colors.black45, fontSize: 12),
      button: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      bodyText1: TextStyle(color: AppColors.textColor, fontSize: 15),
      bodyText2: TextStyle(color: AppColors.textColor, fontSize: 14),
    ).apply(fontFamily: AppFonts.tajawal),
  );
}
