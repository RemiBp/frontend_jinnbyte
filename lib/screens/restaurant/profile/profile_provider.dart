import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../../../appColors/colors.dart';
import '../../../network/API.dart';
import '../../../network/api_url.dart';
import '../../../res/loader.dart';
import '../../../res/toasts.dart';

class ProfileProvider extends ChangeNotifier {
  BuildContext? context;

  File? profileImage;
  
  // Form controllers
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();
  final TextEditingController twitterController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  
  PhoneNumber? phoneNumber;
  
  final Loader _loader = Loader();

  init(context) {
    this.context = context;
    profileImage = null;
    phoneNumber = PhoneNumber.parse('+33');
  }

  getImage({required bool isCamera}) async {
    final photo = await ImagePicker().pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
      maxHeight: 480,
      maxWidth: 640,
      imageQuality: 50,
    );
    if (photo != null) {
      profileImage = File(photo.path);
      // final croppedFile = await ImageCropper().cropImage(
      //   sourcePath: photo.path,
      //   aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      //   // cropStyle: CropStyle.circle,
      //   compressQuality: 100,
      //   uiSettings: [
      //     AndroidUiSettings(
      //       toolbarTitle: 'Crop Image',
      //       toolbarColor: AppColors.primaryColor,
      //       toolbarWidgetColor: Colors.white,
      //       initAspectRatio: CropAspectRatioPreset.ratio16x9,
      //       lockAspectRatio: true,
      //     ),
      //     IOSUiSettings(title: 'Set Image Size'),
      //   ],
      // );
      // if (croppedFile != null) {
      //   profileImage = File(croppedFile.path);
      //   debugPrint("after crop.......->$profileImage");
      // }
      Navigator.pop(context!);
      notifyListeners();
    }
  }

  void setPhoneNumber(PhoneNumber? phone) {
    phoneNumber = phone;
    notifyListeners();
  }

  bool _validateForm() {
    // Check if at least one field is filled
    bool hasAddress = addressController.text.trim().isNotEmpty;
    bool hasPassword = passwordController.text.trim().isNotEmpty;
    bool hasPhone = phoneNumber != null && phoneNumber!.international.length > 4; // More than just country code
    bool hasWebsite = websiteController.text.trim().isNotEmpty;
    bool hasInstagram = instagramController.text.trim().isNotEmpty;
    bool hasTwitter = twitterController.text.trim().isNotEmpty;
    bool hasFacebook = facebookController.text.trim().isNotEmpty;
    bool hasDescription = descriptionController.text.trim().isNotEmpty;

    // Debug logging
    debugPrint("Validation check:");
    debugPrint("hasAddress: $hasAddress (${addressController.text.trim()})");
    debugPrint("hasPassword: $hasPassword (${passwordController.text.trim()})");
    debugPrint("hasPhone: $hasPhone (${phoneNumber?.international})");
    debugPrint("hasWebsite: $hasWebsite (${websiteController.text.trim()})");
    debugPrint("hasInstagram: $hasInstagram (${instagramController.text.trim()})");
    debugPrint("hasTwitter: $hasTwitter (${twitterController.text.trim()})");
    debugPrint("hasFacebook: $hasFacebook (${facebookController.text.trim()})");
    debugPrint("hasDescription: $hasDescription (${descriptionController.text.trim()})");

    if (!hasAddress && !hasPassword && !hasPhone && !hasWebsite && 
        !hasInstagram && !hasTwitter && !hasFacebook && !hasDescription) {
      debugPrint("All fields are empty - validation failed");
      Toasts.getErrorToast(text: "Please fill at least one field to update your profile");
      return false;
    }

    // Validate address format if provided
    if (!hasAddress && addressController.text.trim().length < 5) {
      debugPrint("Address validation failed: too short (${addressController.text.trim().length} chars)");
      Toasts.getErrorToast(text: "Please enter a valid address (at least 5 characters)");
      return false;
    }

    // Validate password format if provided
    if (!hasPassword && passwordController.text.trim().length < 6) {
      debugPrint("Password validation failed: too short (${passwordController.text.trim().length} chars)");
      Toasts.getErrorToast(text: "Password must be at least 6 characters long");
      return false;
    }

    // Validate phone number format if provided
    if (!hasPhone && phoneNumber!.international.length < 8) {
      debugPrint("Phone validation failed: too short (${phoneNumber!.international.length} chars)");
      Toasts.getErrorToast(text: "Please enter a valid phone number");
      return false;
    }

    // Validate description format if provided
    if (!hasDescription && descriptionController.text.trim().length < 10) {
      debugPrint("Description validation failed: too short (${descriptionController.text.trim().length} chars)");
      Toasts.getErrorToast(text: "Please enter a meaningful description (at least 10 characters)");
      return false;
    }

    // Validate URL formats if provided
    if (websiteController.text.trim().isEmpty && !_isValidUrl(websiteController.text.trim())) {
      debugPrint("Website URL validation failed: ${websiteController.text.trim()}");
      Toasts.getErrorToast(text: "Please enter a valid website URL");
      return false;
    }

    if (instagramController.text.trim().isEmpty && !_isValidUrl(instagramController.text.trim())) {
      debugPrint("Instagram URL validation failed: ${instagramController.text.trim()}");
      Toasts.getErrorToast(text: "Please enter a valid Instagram URL");
      return false;
    }

    if (twitterController.text.trim().isEmpty && !_isValidUrl(twitterController.text.trim())) {
      debugPrint("Twitter URL validation failed: ${twitterController.text.trim()}");
      Toasts.getErrorToast(text: "Please enter a valid Twitter URL");
      return false;
    }

    if (facebookController.text.trim().isEmpty && !_isValidUrl(facebookController.text.trim())) {
      debugPrint("Facebook URL validation failed: ${facebookController.text.trim()}");
      Toasts.getErrorToast(text: "Please enter a valid Facebook URL");
      return false;
    }

    return true;
  }

  bool _isValidUrl(String url) {
    try {
      // If URL doesn't start with http/https, add https://
      // String urlToCheck = url.trim();
      // if (!urlToCheck.startsWith('http://') && !urlToCheck.startsWith('https://')) {
      //   urlToCheck = 'https://$urlToCheck';
      // }
      //
      // final uri = Uri.parse(urlToCheck);
      // bool isValid = uri.hasScheme &&
      //               (uri.scheme == 'http' || uri.scheme == 'https') &&
      //               uri.host.isNotEmpty;
      //
      // debugPrint("URL validation for '$url' -> '$urlToCheck': $isValid (scheme: ${uri.scheme}, host: ${uri.host})");
      final isValid = url.contains('http') || url.contains('https');
      return isValid;
    } catch (e) {
      debugPrint("URL validation failed for '$url': $e");
      return false;
    }
  }

  Future<bool> updateProfile() async {
    try {
      // Validate form before making API call
      if (!_validateForm()) {
        return false;
      }

      _loader.showLoader(context: context);
      
      Map<String, dynamic> body = {};

      // Only add fields that have values
      if (addressController.text.trim().isNotEmpty) {
        body["address"] = addressController.text.trim();
      }
      if (passwordController.text.trim().isNotEmpty) {
        body["password"] = passwordController.text.trim();
      }
      if (phoneNumber != null && phoneNumber!.international.length > 4) {
        body["phoneNumber"] = phoneNumber!.international;
      }
      if (websiteController.text.trim().isNotEmpty) {
        body["website"] = websiteController.text.trim();
      }
      if (instagramController.text.trim().isNotEmpty) {
        body["instagram"] = instagramController.text.trim();
      }
      if (twitterController.text.trim().isNotEmpty) {
        body["twitter"] = twitterController.text.trim();
      }
      if (facebookController.text.trim().isNotEmpty) {
        body["facebook"] = facebookController.text.trim();
      }
      if (descriptionController.text.trim().isNotEmpty) {
        body["description"] = descriptionController.text.trim();
      }

      debugPrint("Update profile body: $body");
      
      final response = await MyApi.callPatchApi(
        url: updateProfileApiUrl,
        body: body,
      );
      
      debugPrint("Update profile response: $response");
      
      if (response != null) {
        Toasts.getSuccessToast(text: "Profile updated successfully");
        _loader.hideLoader(context!);
        return true;
      } else {
        Toasts.getErrorToast(text: "Failed to update profile");
        _loader.hideLoader(context!);
        return false;
      }
    } catch (err) {
      debugPrint("Error updating profile: $err");
      _loader.hideLoader(context!);
      Toasts.getErrorToast(text: "Failed to update profile");
      return false;
    }
  }

  @override
  void dispose() {
    addressController.dispose();
    passwordController.dispose();
    websiteController.dispose();
    instagramController.dispose();
    twitterController.dispose();
    facebookController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
