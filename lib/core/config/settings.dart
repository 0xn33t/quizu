import 'package:flutter/material.dart';

abstract class Settings {
  static const bool sandbox = false;
  static const String appName = 'QuizU';
  static const Locale appLocale = Locale('en', 'US');
  static const List<Locale> supportedLocales = [
    Locale('ar', 'SA'),
    Locale('en', 'US'),
  ];
  static const String tokenScheme = 'bearer';
}
