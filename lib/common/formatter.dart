import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Formatter {
  static String formatDate(DateTime? date, {String? newPattern}) {
    date ??= DateTime.now();
    return DateFormat(newPattern ?? 'MMMM d, y').format(date);
  }

  static String formatDateFromString(String? dateString,
      {String newPattern = 'MM/dd/yyyy', bool? isChat}) {
    if (dateString == null || dateString.isEmpty) {
      return "2024-01-01T12:00:00.000Z";
    }
    try {
      DateTime parsedDate = isChat??false?DateTime.parse(dateString).toLocal():DateTime.parse(dateString);
      return formatDate(parsedDate, newPattern: newPattern);
    } catch (e) {
      return dateString;
    }
  }
}

class CreditCardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(' ', '');

    if (newText.length > 16) {
      newText = newText.substring(0, 16);
    }

    String formattedText = '';
    for (int i = 0; i < newText.length; i++) {
      if (i % 4 == 0 && i != 0) {
        formattedText += ' ';
      }
      formattedText += newText[i];
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

class ExpirationDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (newText.length > 4) newText = newText.substring(0, 4);

    String formattedText = '';
    for (int i = 0; i < newText.length; i++) {
      if (i == 2) formattedText += ' / ';
      formattedText += newText[i];
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
