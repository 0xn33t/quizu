import 'package:flutter/material.dart';

class AppColors {
  static const int _primaryValue = 0xFF1D4ED8;
  static const int _secondaryValue = 0xFFF97418;

  static const Color primary = Color(_primaryValue);
  static const Color secondary = Color(_secondaryValue);
  static const Color shadowColor = Color(0xFFF6F6F7);
  static const Color textColor = Colors.black;

  static const MaterialColor primarySwatch =
      MaterialColor(_primaryValue, <int, Color>{
    50: Color(0xFFE4EAFA),
    100: Color(0xFFBBCAF3),
    200: Color(0xFF8EA7EC),
    300: Color(0xFF6183E4),
    400: Color(0xFF3F69DE),
    500: Color(_primaryValue),
    600: Color(0xFF1A47D4),
    700: Color(0xFF153DCE),
    800: Color(0xFF1135C8),
    900: Color(0xFF0A25BF),
  });

  static const MaterialColor secondarySwatch =
      MaterialColor(_secondaryValue, <int, Color>{
    50: Color(0xFFFEEEE3),
    100: Color(0xFFFDD5BA),
    200: Color(0xFFFCBA8C),
    300: Color(0xFFFB9E5D),
    400: Color(0xFFFA893B),
    500: Color(_secondaryValue),
    600: Color(0xFFF86C15),
    700: Color(0xFFF76111),
    800: Color(0xFFF6570E),
    900: Color(0xFFF54408),
  });
}

class AppFonts {
  static const tajawal = 'Montserrat';
}

class AppEdges {
  static const double content = 15.0;
  static const double box = 20.0;
  static const double extraSmall = 4;
  static const double small = 6;
  static const double medium = 10;
  static const double large = 16;
  static const double extraLarge = 24;
  static const double extraExtraLarge = 34;
}

class AppCorners {
  static const double small = 12.0;
  static const double large = 30.0;

  static const Radius smallRadius = Radius.circular(small);
  static const Radius largeRadius = Radius.circular(large);

  static const BorderRadius smallBorderRadius = BorderRadius.all(smallRadius);
  static const BorderRadius largeBorderRadius = BorderRadius.all(largeRadius);
}

class AppSpacers {
  // Horizontals Spacers
  static const SizedBox horizontalContent = SizedBox(width: AppEdges.content);
  static const SizedBox horizontalExtraSmall =
      SizedBox(width: AppEdges.extraSmall);
  static const SizedBox horizontalSmall = SizedBox(width: AppEdges.small);
  static const SizedBox horizontalMedium = SizedBox(width: AppEdges.medium);
  static const SizedBox horizontalLarge = SizedBox(width: AppEdges.large);
  static const SizedBox horizontalExtraLarge =
      SizedBox(width: AppEdges.extraLarge);
  static const SizedBox horizontalExtraExtraLarge =
      SizedBox(width: AppEdges.extraExtraLarge);

  // Verticals Spacers
  static const SizedBox verticalContent = SizedBox(height: AppEdges.content);
  static const SizedBox verticalExtraSmall =
      SizedBox(height: AppEdges.extraSmall);
  static const SizedBox verticalSmall = SizedBox(height: AppEdges.small);
  static const SizedBox verticalMedium = SizedBox(height: AppEdges.medium);
  static const SizedBox verticalLarge = SizedBox(height: AppEdges.large);
  static const SizedBox verticalExtraLarge =
      SizedBox(height: AppEdges.extraLarge);
  static const SizedBox verticalExtraExtraLarge =
      SizedBox(height: AppEdges.extraExtraLarge);
}

extension CustomColorScheme on ColorScheme {
  MaterialColor get primarySwatch => AppColors.primarySwatch;
  MaterialColor get secondarySwatch => AppColors.secondarySwatch;
}

extension CustomThemeData on ThemeData {
  ShapeBorder get modalSheetShape {
    return const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: AppCorners.smallRadius,
        topRight: AppCorners.smallRadius,
      ),
    );
  }
}
