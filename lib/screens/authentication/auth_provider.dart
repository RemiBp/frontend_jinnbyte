import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier{
  bool loginPassVisibility = false;
  bool signupPassVisibility = false;

  toggleLoginPassVisibility(){
    loginPassVisibility = !loginPassVisibility;
    notifyListeners();
  }
  toggleSignupPassVisibility(){
    signupPassVisibility = !signupPassVisibility;
    notifyListeners();
  }

}