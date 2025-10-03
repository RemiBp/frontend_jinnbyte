import 'package:choice_app/common/utils.dart';
import 'package:choice_app/models/auth_ressponse.dart';
import 'package:choice_app/userRole/user_role.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../network/API.dart';
import '../../../network/api_url.dart';
import '../../../network/models.dart';
import '../../../res/loader.dart';
import '../../../res/toasts.dart';
import '../../../routes/routes.dart';
import '../../../userRole/role_provider.dart';

class OtpProvider extends ChangeNotifier {
  AuthResponse registrationResponse = AuthResponse();
  bool loginPassVisibility = false;
  bool signupPassVisibility = false;
  BuildContext? context;
  bool isDataFetch = false;

  final Loader _loader = Loader();

  init(context) {
    this.context = context;
  }

  toggleLoginPassVisibility() {
    loginPassVisibility = !loginPassVisibility;
    notifyListeners();
  }

  toggleSignupPassVisibility() {
    signupPassVisibility = !signupPassVisibility;
    notifyListeners();
  }



  Future<void> verifyOtp({
    required String email,
    required String otp,
    required bool isResetPassFlow,
  }) async {
    try {
      _loader.showLoader(context: context);
      Map<String, dynamic> headers = {"Content-Type": "application/json"};
      Map<String, dynamic> body = {"email": email, "otp": otp};
      debugPrint("body is : ---------->$body");
      final roleProvider = context?.read<RoleProvider>();
      final verifyFgOtpApi = roleProvider?.role == UserRole.user
          ? verifyUserFgOtpApiUrl
          : verifyFgOtpApiUrl;
      final verifySignupOtpApi = roleProvider?.role == UserRole.user
          ? verifyUserSignupOtpApiUrl
          : verifySignupOtpApiUrl;
      registrationResponse = await MyApi.callPostApi(
        url: isResetPassFlow ? verifyFgOtpApi : verifySignupOtpApi,
        myHeaders: headers,
        body: body,
        modelName:isResetPassFlow?null: Models.authModel,
      );
      if (registrationResponse.user != null) {
        debugPrint("register response : ${registrationResponse.toJson()}");
        Toasts.getSuccessToast(text: "Otp Verified Successful");
        await PreferenceUtils.setAuthResponse(registrationResponse);
        _loader.hideLoader(context!);
        if (isResetPassFlow) {
          context?.push(Routes.resetPasswordRoute, extra: {"email": email});
          return;
        }
        //final roleProvider = context?.read<RoleProvider>();
        if (roleProvider?.role == UserRole.user) {
          context?.push(Routes.loginRoute); // go to login if role is user
        } else {
          context?.push(Routes.uploadDocsRoute); // otherwise go to upload docs
        }
        return;        return;
      }
      _loader.hideLoader(context!);
    } catch (err) {
      debugPrint("error during registering new user : $err");
      _loader.hideLoader(context!);
    }
  }

  Future<void> verifyFgOtp({
    required String email,
    required String otp,
    required bool isResetPassFlow,
  }) async {
    try {
      _loader.showLoader(context: context);
      Map<String, dynamic> headers = {"Content-Type": "application/json"};
      Map<String, dynamic> body = {"email": email, "otp": otp};
      debugPrint("body is : ---------->$body");
      final roleProvider = context?.read<RoleProvider>();
      final verifyFgOtpApi = roleProvider?.role == UserRole.user
          ? verifyUserFgOtpApiUrl
          : verifyFgOtpApiUrl;
      final response = await MyApi.callPostApi(
        url: verifyFgOtpApi ,
        myHeaders: headers,
        body: body,
      );
      if (response?["message"] != null) {
        debugPrint("register response : ${response?["message"]}");
        Toasts.getSuccessToast(text: "Otp Verified Successful");
        _loader.hideLoader(context!);
          context?.push(Routes.resetPasswordRoute, extra: {"email": email, "otp":otp});
          return;

      }
      _loader.hideLoader(context!);
    } catch (err) {
      debugPrint("error during verify otp : $err");
      _loader.hideLoader(context!);
    }
  }

  Future<void> resendOtp({
    required String email,
    required bool isResetPassFlow,
  }) async {
    try {
      _loader.showLoader(context: context);
      Map<String, dynamic> headers = {"Content-Type": "application/json"};
      Map<String, dynamic> body = {"email": email};
      debugPrint("body is : ---------->$body");
      final roleProvider = context?.read<RoleProvider>();
      final resendFgOtpApi = roleProvider?.role == UserRole.user
          ? resendUserFgOtpApiUrl
          : resendFgOtpApiUrl;
      final resendSignupOtpApi = roleProvider?.role == UserRole.user
          ? resendUserSignupOtpApiUrl
          : resendSignupOtpApiUrl;
      final response = await MyApi.callPostApi(
        url: isResetPassFlow ? resendFgOtpApi : resendSignupOtpApi,
        myHeaders: headers,
        body: body,
      );
      if (response?["message"] != null) {
        debugPrint("register response : ${response?["message"]}");
        Toasts.getSuccessToast(text: response?["message"]);
        await PreferenceUtils.setAuthResponse(registrationResponse);
        _loader.hideLoader(context!);
        return;
      }
      _loader.hideLoader(context!);
    } catch (err) {
      debugPrint("error during registering new user : $err");
      _loader.hideLoader(context!);
    }
  }
}
