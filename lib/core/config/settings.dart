import 'package:flutter/material.dart';

abstract class Settings {
  static const bool sandbox = false;
  static const String appName = 'QuizU';
  static const Locale appLocale = Locale('en', 'US');
  static const List<Locale> supportedLocales = [
    Locale('ar', 'SA'),
    Locale('en', 'US'),
  ];
  static const String tokenScheme = 'Bearer';
  static const String authStorageKey = 'authorized_v1';
  static const String scoresStorageKey = 'scores_v1';
  static const Duration quizDuration = Duration(minutes: 2);
  static const String fallbackCarrierRegionCode = 'SA';
}
