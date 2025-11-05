import 'package:flutter/services.dart';

// 1. Allows only alphabets, numbers, and underscore (for names, usernames, etc.)
class AllowOnlyAlphanumericUnderscore extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final regex = RegExp(r'^[a-zA-Z0-9_]*$');
    if (regex.hasMatch(newValue.text)) {
      return newValue;
    }
    return oldValue;
  }
}

//  2. Allows only alphabets and underscore (for simple email name part)
class AllowOnlyAlphabetUnderscore extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final regex = RegExp(r'^[a-zA-Z0-9@._-]*$');
    if (regex.hasMatch(newValue.text)) {
      return newValue;
    }
    return oldValue;
  }
}

// 3. Allows only visible ASCII characters (no emojis, Urdu, or special Unicode)
class AllowOnlyAsciiCharacters extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final regex = RegExp(r'^[\x21-\x7E]*$', unicode: false);
    if (regex.hasMatch(newValue.text)) {
      return newValue;
    }
    return oldValue;
  }
}
