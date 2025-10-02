// lib/utilities/validators.dart

import 'package:choice_app/utilities/extensions.dart';

class Validators {
  static final _nameRegex = RegExp(r"^[a-zA-Z0-9\s\-,.&']+$");
  static final _passwordRegex = RegExp(r'^[a-zA-Z0-9!@#\$%^&*(),.?":{}|<>_\-]+$');

  static String? validateBusinessName(String? value, String missingMsg, String invalidMsg) {
    if (value == null || value.trim().isEmpty) {
      return missingMsg;
    } else if (!_nameRegex.hasMatch(value.trim())) {
      return invalidMsg;
    }
    return null;
  }

  static String? validateEmail(String? value, String missingMsg, String invalidMsg) {
    if (value == null || value.trim().isEmpty) {
      return missingMsg;
    } else if (!value.trim().validateEmail()) {
      return invalidMsg;
    }
    return null;
  }

  static String? validatePassword(String? value, String missingMsg, String invalidMsg) {
    if (value == null || value.trim().isEmpty) {
      return missingMsg;
    } else if (!_passwordRegex.hasMatch(value.trim())) {
      return invalidMsg;
    }
    return null;
  }
}
