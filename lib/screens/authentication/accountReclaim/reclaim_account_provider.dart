import 'package:flutter/material.dart';

class ReclaimAccountProvider extends ChangeNotifier {
  int step = 0;
  final docs = [
    "Buisness  Registration Documents",
    "Commercial Lease Contract",
    "Utility Bill",
    "Supplier Invoice",
    "Professional Insurance Certificate",
    "Tax Document",
    "Signed Authorization Letter",
  ];

  set updatedStep(int value) {
    step = value;
    debugPrint("step : $step");
    notifyListeners();
  }
}
