import 'package:flutter/material.dart';

import '../../../l18n.dart';

class ReclaimAccountProvider extends ChangeNotifier {
  int step = 0;
  final docs = [al.businessRegistrationDocument,
    al.documentLeaseContract,
    al.documentUtilityBill,
    al.documentSupplierInvoice,
    al.documentInsuranceCertificate,
    al.documentTax,
    al.documentAuthorizationLetter,
  ];

  set updatedStep(int value) {
    step = value;
    debugPrint("step : $step");
    notifyListeners();
  }
}
