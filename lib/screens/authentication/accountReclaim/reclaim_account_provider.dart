import 'package:flutter/material.dart';
import '../../../res/loader.dart';

import '../../../l18n.dart';
import '../../../res/toasts.dart';

class ReclaimAccountProvider extends ChangeNotifier {

  BuildContext? context;
  int step = 0;
  bool isLoading = false;

  final docs = [al.businessRegistrationDocument,
    al.documentLeaseContract,
    al.documentUtilityBill,
    al.documentSupplierInvoice,
    al.documentInsuranceCertificate,
    al.documentTax,
    al.documentAuthorizationLetter,
  ];

  final Loader _loader = Loader();

  void init(BuildContext ctx) {
    context = ctx;
  }


  set updatedStep(int value) {
    step = value;
    debugPrint("step : $step");
    notifyListeners();
  }

  Future<void> uploadDocument(Future<void> Function() onUploadAction) async {
    try {
      isLoading = true;
      notifyListeners();
      _loader.showLoader(context: context);

      await onUploadAction();

      _loader.hideLoader(context!);
      isLoading = false;
      notifyListeners();

      Toasts.getSuccessToast(text: "Document selected successfully");
    } catch (e) {
      _loader.hideLoader(context!);
      isLoading = false;
      notifyListeners();
      Toasts.getErrorToast(text: "Failed to upload document");
      debugPrint("Error in uploadDocument: $e");
    }
  }
}
