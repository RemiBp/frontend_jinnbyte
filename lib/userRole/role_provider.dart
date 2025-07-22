import 'package:choice_app/userRole/user_role.dart';
import 'package:flutter/cupertino.dart';

class RoleProvider with ChangeNotifier {
  UserRole _role = UserRole.user;

  UserRole get role => _role;

  void setRole(UserRole newRole) {
    _role = newRole;
    notifyListeners();
  }
}