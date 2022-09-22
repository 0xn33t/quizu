import 'package:flutter/material.dart' show BuildContext, Locale, Localizations;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension L10nBuildContext on BuildContext {
  AppL10n get l10n => AppL10n.of(this)!;

  Locale get locale => Localizations.localeOf(this);
  String get languageCode => locale.languageCode;
  String? get countryCode => locale.countryCode;
  
}