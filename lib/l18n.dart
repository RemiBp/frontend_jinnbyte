import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';

AppLocalizations get al => _al!; // helper function to avoid typing '!' all the time
AppLocalizations? _al; // global variable
bool get rtlDirection =>_currentDirection!.name == "rtl";
TextDirection? _currentDirection;

class AppTranslations {
  static init(BuildContext context) {
    _al = AppLocalizations.of(context);
    _currentDirection = Directionality.of(context);
  }
}