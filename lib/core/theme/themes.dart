import 'package:flutter/material.dart';
import 'package:quiz_u/core/index.dart' show AppColors, AppFonts;

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
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.black,
      showUnselectedLabels: true,
      elevation: 0,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      enabledBorder: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(),
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.bold,
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
      subtitle1: TextStyle(color: Colors.black45, fontSize: 14),
      subtitle2: TextStyle(color: Colors.black45, fontSize: 13),
      button: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      bodyText1: TextStyle(color: AppColors.textColor),
      bodyText2: TextStyle(color: AppColors.textColor),
    ).apply(fontFamily: AppFonts.tajawal),
  );
}

extension AppDirectionality on BuildContext {
  bool get isRTL {
    final TextDirection currentDirection = Directionality.of(this);
    return currentDirection == TextDirection.rtl;
  }
}
