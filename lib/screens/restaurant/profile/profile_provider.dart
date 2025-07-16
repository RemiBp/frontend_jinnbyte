import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../appColors/colors.dart';

class ProfileProvider extends ChangeNotifier {
  BuildContext? context;

  File? profileImage;

  init(context) {
    this.context = context;
    profileImage = null;
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
}
