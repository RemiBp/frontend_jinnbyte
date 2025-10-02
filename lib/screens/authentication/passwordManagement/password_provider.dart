import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../network/API.dart';
import '../../../network/api_url.dart';
import '../../../res/loader.dart';
import '../../../res/toasts.dart';
import '../../../routes/routes.dart';

class PasswordProvider extends ChangeNotifier{
  bool newPassVisibility = false;
  bool currentPassVisibility = true;
  bool confirmPassVisibility = false;
  BuildContext? context;
  bool isDataFetch = false;

  final Loader _loader=Loader();
  //  context.go(Routes.loginRoute);

  init(context){
    this.context=context;
  }

  toggleNewPassVisibility(){
    newPassVisibility = !newPassVisibility;
    notifyListeners();
  }

  void toggleCurrentPassVisibility() {
    currentPassVisibility = !currentPassVisibility;
    notifyListeners();
  }

  toggleConfirmPassVisibility(){
    confirmPassVisibility = !confirmPassVisibility;
    notifyListeners();
  }

  Future<void> forgotPasswordApi({
    required String email,
    required bool isResetPassFlow,
  }) async {
    try {
      _loader.showLoader(context: context);
      Map<String, dynamic> headers = {"Content-Type": "application/json"};
      Map<String, dynamic> body = {
        "email": email
      };
      debugPrint("body is : ---------->$body");
      final response  = await MyApi.callPostApi(
        url: forgotPasswordApiUrl,
        myHeaders: headers,
        body: body,
        // modelName: Models.loginModel,
      );
      debugPrint("register response : $response");
      if(response?["message"]!=null){
        debugPrint("register response : ${response?["message"]}");
        Toasts.getSuccessToast(text: response?["message"]);
        context?.push(Routes.otpVerificationRoute, extra: {
          "email":email,
          "isResetPassFlow":true,
        });
      }
      _loader.hideLoader(context!);
    } catch (err) {
      debugPrint("error during registering new user : $err");
      _loader.hideLoader(context!);
    }
  }

  Future<void> resetPasswordApi({
    required String email,
    required String otp,
    required String password,
  }) async {
    try {
      _loader.showLoader(context: context);
      Map<String, dynamic> headers = {"Content-Type": "application/json"};
      Map<String, dynamic> body = {
        "email":email,
        "otp": otp,
        "password": password
      };
      debugPrint("body is : ---------->$body");
      final response  = await MyApi.callPostApi(
        url: resetPasswordApiUrl,
        myHeaders: headers,
        body: body,
      );
      debugPrint("reset password response : $response");
      if(response?["message"]!=null){
        debugPrint("reset password response : ${response?["message"]}");
        Toasts.getSuccessToast(text: response?["message"]);
        context?.go(Routes.loginRoute);
      }
      _loader.hideLoader(context!);
    } catch (err) {
      debugPrint("error during reset password : $err");
      _loader.hideLoader(context!);
    }
  }

}