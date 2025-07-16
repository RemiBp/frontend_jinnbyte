import 'package:flutter/material.dart';

class PasswordProvider extends ChangeNotifier{
  bool newPassVisibility = false;
  bool confirmPassVisibility = false;

  toggleNewPassVisibility(){
    newPassVisibility = !newPassVisibility;
    notifyListeners();
  }
  toggleConfirmPassVisibility(){
    confirmPassVisibility = !confirmPassVisibility;
    notifyListeners();
  }

}