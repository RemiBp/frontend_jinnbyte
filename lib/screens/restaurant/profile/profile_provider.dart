import 'dart:io';

import 'package:choice_app/network/models.dart';
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

  PhoneNumber? phoneNumber;
  XFile? profilePhoto;
  String businessName = "";

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
    profilePhoto = photo;
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

  bool _validateForm({
    required String address,
    required String password,
    required String website,
    required String instagram,
    required String twitter,
    required String facebook,
    required String description,
  }) {
    // Check if at least one field is filled
    bool hasAddress = address.trim().isNotEmpty;
    bool hasPassword = password.trim().isNotEmpty;
    bool hasPhone =
        phoneNumber != null &&
        phoneNumber!.international.length > 4; // More than just country code
    bool hasWebsite = website.trim().isNotEmpty;
    bool hasInstagram = instagram.trim().isNotEmpty;
    bool hasTwitter = twitter.trim().isNotEmpty;
    bool hasFacebook = facebook.trim().isNotEmpty;
    bool hasDescription = description.trim().isNotEmpty;
    bool hasBusinessName = businessName.trim().isNotEmpty;

    // Debug logging
    debugPrint("Validation check:");
    debugPrint("hasAddress: $hasAddress (${address.trim()})");
    debugPrint("hasPassword: $hasPassword (${password.trim()})");
    debugPrint("hasPhone: $hasPhone (${phoneNumber?.international})");
    debugPrint("hasWebsite: $hasWebsite (${website.trim()})");
    debugPrint("hasInstagram: $hasInstagram (${instagram.trim()})");
    debugPrint("hasTwitter: $hasTwitter (${twitter.trim()})");
    debugPrint("hasFacebook: $hasFacebook (${facebook.trim()})");
    debugPrint("hasDescription: $hasDescription (${description.trim()})");

    if (!hasAddress &&
        !hasPassword &&
        !hasPhone &&
        !hasWebsite &&
        !hasInstagram &&
        !hasTwitter &&
        !hasFacebook &&
        !hasDescription) {
      debugPrint("All fields are empty - validation failed");
      Toasts.getErrorToast(
        text: "Please fill at least one field to update your profile",
      );
      return false;
    }

    if (!hasBusinessName) {
      debugPrint(
        "Business name validation failed: too short (${businessName.trim().length} chars)",
      );
      Toasts.getErrorToast(
        text: "Please enter a valid business name",
      );
      return false;
    }

    // Validate address format if provided
    if (!hasAddress && address.trim().length < 5) {
      debugPrint(
        "Address validation failed: too short (${address.trim().length} chars)",
      );
      Toasts.getErrorToast(
        text: "Please enter a valid address (at least 5 characters)",
      );
      return false;
    }

    // Validate password format if provided
    // if (!hasPassword && password.trim().length < 6) {
    //   debugPrint(
    //     "Password validation failed: too short (${password.trim().length} chars)",
    //   );
    //   Toasts.getErrorToast(text: "Password must be at least 6 characters long");
    //   return false;
    // }

    // Validate phone number format if provided
    if (!hasPhone && phoneNumber!.international.length < 8) {
      debugPrint(
        "Phone validation failed: too short (${phoneNumber!.international.length} chars)",
      );
      Toasts.getErrorToast(text: "Please enter a valid phone number");
      return false;
    }

    // Validate description format if provided
    if (!hasDescription && description.trim().length < 10) {
      debugPrint(
        "Description validation failed: too short (${description.trim().length} chars)",
      );
      Toasts.getErrorToast(
        text: "Please enter a meaningful description (at least 10 characters)",
      );
      return false;
    }

    // Validate URL formats if provided
    if (!hasWebsite && !_isValidUrl(website.trim())) {
      debugPrint("Website URL validation failed: ${website.trim()}");
      Toasts.getErrorToast(text: "Please enter a valid website URL");
      return false;
    }

    if (!hasInstagram && !_isValidUrl(instagram.trim())) {
      debugPrint("Instagram URL validation failed: ${instagram.trim()}");
      Toasts.getErrorToast(text: "Please enter a valid Instagram URL");
      return false;
    }

    if (!hasTwitter && !_isValidUrl(twitter.trim())) {
      debugPrint("Twitter URL validation failed: ${twitter.trim()}");
      Toasts.getErrorToast(text: "Please enter a valid Twitter URL");
      return false;
    }

    if (!hasFacebook && !_isValidUrl(facebook.trim())) {
      debugPrint("Facebook URL validation failed: ${facebook.trim()}");
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

  Future<bool> updateProfile({
    required String address,
    required String password,
    required String website,
    required String instagram,
    required String twitter,
    required String facebook,
    required String description,
    required String profileImageUrl,
  }) async {
    try {
      // Validate form before making API call
      if (!_validateForm(
        address: address,
        password: password,
        website: website,
        instagram: instagram,
        twitter: twitter,
        facebook: facebook,
        description: description,
      )) {
        return false;
      }

      _loader.showLoader(context: context);

      Map<String, dynamic> body = {};

      // Only add fields that have values
      if (address.trim().isNotEmpty) {
        body["address"] = address.trim();
      }
      // if (password.trim().isNotEmpty) {
      //   body["password"] = password.trim();
      // }
      if (phoneNumber != null && phoneNumber!.international.length > 4) {
        body["phoneNumber"] = phoneNumber!.international;
      }
      if (website.trim().isNotEmpty) {
        body["website"] = website.trim();
      }
      if (instagram.trim().isNotEmpty) {
        body["instagram"] = instagram.trim();
      }
      if (twitter.trim().isNotEmpty) {
        body["twitter"] = twitter.trim();
      }
      if (facebook.trim().isNotEmpty) {
        body["facebook"] = facebook.trim();
      }
      if (description.trim().isNotEmpty) {
        body["description"] = description.trim();
      }

      body["businessName"] = businessName;
      body["profileImageUrl"] = profileImageUrl;
      body["latitude"] = 48.8566;
      body["longitude"] = 2.3522;

      debugPrint("Update profile body: $body");

      final response = await MyApi.callPutApi(
        url: updateProfileApiUrl,
        body: body,
        modelName: Models.restaurantUpdateProfileModel,
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

  Future<bool> setOperationalHours({
    required List<String> days,
    required Map<String, bool> isActive,
    required Map<String, TimeOfDay> startTimes,
    required Map<String, TimeOfDay> endTimes,
  }) async {
    try {
      _loader.showLoader(context: context);

      // Build the hours array
      List<Map<String, dynamic>> hours = [];
      for (String day in days) {
        hours.add({
          "day": day,
          "startTime": _formatTo24Hour(startTimes[day]!),
          "endTime": _formatTo24Hour(endTimes[day]!),
          "isClosed": !isActive[day]!,
        });
      }

      Map<String, dynamic> body = {
        "hours": hours,
      };

      debugPrint("Set operational hours body: $body");

      final response = await MyApi.callPostApi(
        url: setOperationalHoursApiUrl,
        body: body,
      );

      debugPrint("Set operational hours response: $response");

      if (response != null) {
        Toasts.getSuccessToast(text: "Operational hours saved successfully");
        _loader.hideLoader(context!);
        return true;
      } else {
        Toasts.getErrorToast(text: "Failed to save operational hours");
        _loader.hideLoader(context!);
        return false;
      }
    } catch (err) {
      debugPrint("Error setting operational hours: $err");
      _loader.hideLoader(context!);
      Toasts.getErrorToast(text: "Failed to save operational hours");
      return false;
    }
  }

  String _formatTo24Hour(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  void dispose() {
    super.dispose();
  }
}
