import 'dart:io';

import 'package:flutter/material.dart';

import '../res/toasts.dart';

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final result = hexString.replaceFirst('#', '0xff');
    return Color(int.parse(result));
  }
}

extension StringExtensions on String {
  bool validateEmail() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }

  bool validatePassword() {
    return RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9!@#$%^&*]).{8,}$').hasMatch(this);
  }

  bool validatePhoneNumber() {
    return
        //RegExp(r"/^((\+|00)32\s?|0)4(60|[789]\d)(\s?\d{2}){3}$/").hasMatch(this);
        RegExp(r"^(\+\d{12})?$").hasMatch(this);
  }
}

bool validatePassword(String? value) {
  if (value != null && value.isNotEmpty) {
    if (!value.validatePassword()) {
      if (value.length < 8) {
        Toasts.getErrorToast(text: "Password must Contain 8 characters");
        return false;
      }
      Toasts.getErrorToast(
          text:
              "Password must contain Numbers,Capital letters and special characters");
      return false;
    }
    return true;
  } else {
    Toasts.getErrorToast(text: "Enter a valid Password");
    return false;
  }
}

bool validEmail(String value) {
  if (value.isEmpty) {
    Toasts.getErrorToast(text: "Please enter your email");
    return false;
  }
  if (value.toString().validateEmail() == false) {
    Toasts.getErrorToast(text: "Enter a valid Email");
    return false;
  } else {
    return true;
  }
}

bool validName(String? value) {
  if (value != null && value.length < 5) {
    Toasts.getErrorToast(text: "Name Must have 5 characters");
    return false;
  } else {
    return true;
  }
}

extension FileExtension on File {
  String get fileName {
    return path.split('/').last;
  }
}
