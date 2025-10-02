import 'package:choice_app/common/utils.dart';
import 'package:choice_app/models/auth_ressponse.dart';
import 'package:choice_app/screens/restaurant/profile/profile_provider.dart';
import 'package:choice_app/userRole/role_provider.dart';
import 'package:choice_app/userRole/user_role.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../l18n.dart';
import '../../network/API.dart';
import '../../network/api_url.dart';
import '../../network/models.dart';
import '../../res/loader.dart';
import '../../res/toasts.dart';
import '../../routes/routes.dart';

class AuthProvider extends ChangeNotifier{
  AuthResponse authResponse = AuthResponse();
  bool loginPassVisibility = false;
  bool signupPassVisibility = false;
  BuildContext? context;
  bool isDataFetch = false;
  bool _agreed = false;
  bool _rememberMe = false;



  bool get agreed => _agreed;
  bool get rememberMe => _rememberMe;


  final Loader _loader = Loader();
  PlatformFile? selectedDoc1;
  PlatformFile? selectedDoc2;
  DateTime? expiryDate1;
  DateTime? expiryDate2;

  Future<void> selectDate(BuildContext context, int dateNumber) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      if (dateNumber == 1) {
        expiryDate1 = picked;
      } else {
        expiryDate2 = picked;
      }
      notifyListeners();
    }
  }


  Future<void> pickFile(int docNumber) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null && result.files.isNotEmpty) {
      if (docNumber == 1) {
        selectedDoc1 = result.files.first;
      } else {
        selectedDoc2 = result.files.first;
      }
      notifyListeners();
    }
  }

  init(context) {
    this.context = context;
  }

  toggleLoginPassVisibility(){
    loginPassVisibility = !loginPassVisibility;
    notifyListeners();
  }
  toggleSignupPassVisibility(){
    signupPassVisibility = !signupPassVisibility;
    notifyListeners();
  }

  void toggleAgreement(bool value) {
    _agreed = value;
    notifyListeners();
  }
  void toggleRememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }

  Future<void> registerUser({
    required String businessName,
    required String email,
    required String role,
    required String password,
  }) async {
    try {
      _loader.showLoader(context: context);
      Map<String, dynamic> headers = {"Content-Type": "application/json"};
      Map<String, dynamic> body = {
        "email": email,
        "password": password,
        "businessName": businessName,
        "role": role
      };
      debugPrint("body is : ---------->$body");
      final signupResponse = await MyApi.callPostApi(
        url: signUpApiUrl,
        myHeaders: headers,
        body: body,
        // modelName: Models.loginModel,
      );
      debugPrint("register response : $signupResponse");
      if (signupResponse?["message"] != null) {
        debugPrint("register response : ${signupResponse?["message"]}");
        Toasts.getSuccessToast(text: al.registrationSuccessful);
        context?.push(Routes.otpVerificationRoute, extra: {
          "email": email,
          "isResetPassFlow": false,
        });
        globalBusinessName = businessName;
      }
      _loader.hideLoader(context!);
    } catch (err) {
      debugPrint("error during registering new user : $err");
      _loader.hideLoader(context!);
    }
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      _loader.showLoader(context: context);
      final roleProvider = context?.read<RoleProvider>();
      Map<String, dynamic> headers = {"Content-Type": "application/json"};
      Map<String, dynamic> body = {
        "email": email,
        "password": password,
        "deviceId": ""
      };
      debugPrint("body is : ---------->$body");
      authResponse = await MyApi.callPostApi(
        url:roleProvider?.role == UserRole.user?userLoginApiUrl: loginApiUrl,
        myHeaders: headers,
        body: body,
        modelName: Models.authModel,
      );
      debugPrint("login response : ${authResponse.toJson()}");
      if (authResponse.user != null) {
        await PreferenceUtils.setAuthResponse(authResponse);
        _loader.hideLoader(context!);
        // if(roleProvider?.role == UserRole.user){
        //   context?.push(Routes.customerHomeRoute);
        // }else
        // {
          context?.go(Routes.restaurantBottomTabRoute);
        // }

        return;
      }
      _loader.hideLoader(context!);
    } catch (err) {
      debugPrint("error during login : $err");
      _loader.hideLoader(context!);
    }
  }

  Future<void> submitDocs() async {
    try {
      if(expiryDate1 == null){
        Toasts.getErrorToast(text: al.expiryDate1Placeholder);
      }else if(selectedDoc1 == null){
        Toasts.getErrorToast(text: al.businessRegistrationPlaceholder);
      }else  if(expiryDate2 == null){
        Toasts.getErrorToast(text: al.expiryDate2Placeholder);
      }else if(selectedDoc2 == null){
        Toasts.getErrorToast(text: al.utilityBillPlaceholder);
      }else{ _loader.showLoader(context: context);
      Map<String, dynamic> body = {
        "document1": selectedDoc1?.path,
        "document1Expiry": DateFormat("yyyy-MM-dd").format(expiryDate1!),
        "document2": selectedDoc2?.path,
        "document2Expiry": DateFormat("yyyy-MM-dd").format(expiryDate2!)
      };
      debugPrint("body is : ---------->$body");
      final response = await MyApi.callPostApi(
        url: submitDocsApiUrl,
        body: body,
      );
      debugPrint("upload docs response : $response");
      if (response?["message"] != null) {
        Toasts.getSuccessToast(text: response?["message"]);
        _loader.hideLoader(context!);
        context?.push(Routes.restaurantProfileRoute);
        return;
      }
      _loader.hideLoader(context!);

      }

    } catch (err) {
      debugPrint("error during upload docs : $err");
      _loader.hideLoader(context!);
    }
  }



}