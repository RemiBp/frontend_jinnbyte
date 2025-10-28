import 'dart:io';

import 'package:choice_app/network/API.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../l18n.dart';
import '../res/loader.dart';
import '../res/toasts.dart';
import 'api_url.dart';
import 'package:path/path.dart';

class  NetworkProvider extends ChangeNotifier{


  String case400Error = "";
  bool isSubscriber = false;
  BuildContext? context;
  File? image;
  String? imageUrl;

  final Loader _loader = Loader();


  Future<File?> getImage({required bool isCamera}) async {
    final photo = await ImagePicker().pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
      maxHeight: 480,
      maxWidth: 640,
      imageQuality: 50,
    );
    if (photo != null) {
      final image  = File(photo.path);
      notifyListeners();
      return image;
    }
    return null;
  }


  Future<String?> getUrlForFileUpload(Uint8List? imageBytes,{
    bool? hideLoader,
    bool? startLoader,
  }) async {
    try {
      if (startLoader != false) {
        _loader.showLoader(context: context);
      }
      Map<String, dynamic> header = {"Content-Type": "application/json"};
      Map<String, dynamic> body = {
        "fileName": "image${DateTime.now().millisecondsSinceEpoch}.${getImageType(imageBytes!)}",
        "contentType": "image/${getImageType(imageBytes)}",
        "folderName": "GalleryImage"
      };
      debugPrint("body is ...............>$body");
      final response = await MyApi.callPostApi(
        url: preSignedFileUploadApiUrl,
        myHeaders: header,
        body: body,
      );
      if (response?["url"] != null) {
        debugPrint("url for file upload is : ${response?["url"]}");
        imageUrl = response?["keyName"] ;
        await uploadImageByUrl(response?["url"], imageBytes);

        if (hideLoader != false) {
          _loader.hideLoader(context!);
        }
        notifyListeners();
        return imageUrl;
      } else {
        _loader.hideLoader(context!);
        notifyListeners();
        return null;
      }
    } catch (err) {
      debugPrint("error while getting url for file is : $err");
      _loader.hideLoader(context!);
      return null;
    }
  }

  Future<bool> uploadImageByUrl(String apiUrl, Uint8List imageBytes) async {
    try {
      final Dio dio = Dio();
      final response = await dio.put(apiUrl,
          data: imageBytes,
          options: Options(contentType: Headers.formUrlEncodedContentType));
      if (response.statusCode == 200) {
        debugPrint(
            "--------------------------it is success--------------------------");
        return true;
      } else {
        debugPrint(
            "--------------------------it is failure with status code : ${response.statusCode}--------------------------");
        return false;
      }
    } catch (err) {
      debugPrint("error while uploading file : $err");
      return false;
    }
  }

  String? getImageType(Uint8List bytes) {
    // PNG signature: 89 50 4E 47 0D 0A 1A 0A
    if (bytes.length > 4 &&
        bytes[0] == 0x89 &&
        bytes[1] == 0x50 &&
        bytes[2] == 0x4E &&
        bytes[3] == 0x47) {
      return 'png';
    }

    // JPEG signature: FF D8 FF
    if (bytes.length > 2 && bytes[0] == 0xFF && bytes[1] == 0xD8) {
      return 'jpeg';
    }

    // GIF signature: 47 49 46 38 (GIF89a) or 47 49 46 37 (GIF87a)
    if (bytes.length > 6 &&
        bytes[0] == 0x47 &&
        bytes[1] == 0x49 &&
        bytes[2] == 0x46 &&
        (bytes[4] == 0x38 || bytes[4] == 0x37)) {
      return 'gif';
    }

    // BMP signature: 42 4D
    if (bytes.length > 2 && bytes[0] == 0x42 && bytes[1] == 0x4D) {
      return 'bmp';
    }

    // WebP signature: 52 49 46 46 (RIFF) + 87 65 62 50 (WEBP)
    if (bytes.length > 12 &&
        bytes[0] == 0x52 &&
        bytes[1] == 0x49 &&
        bytes[2] == 0x46 &&
        bytes[3] == 0x46 &&
        bytes[8] == 0x57 &&
        bytes[9] == 0x45 &&
        bytes[10] == 0x42 &&
        bytes[11] == 0x50) {
      return 'webp';
    }

    return null; // Unknown format
  }


  Future<String?> getUrlForDocumentUpload(File file,BuildContext context) async {
    try {
      _loader.showLoader(context: context);

      final Uint8List fileBytes = await file.readAsBytes();
      final String fileName = basename(file.path);

      Map<String, dynamic> header = {"Content-Type": "application/json"};
      Map<String, dynamic> body = {
        "fileName": fileName,
        "contentType": "application/pdf", // only pdfs allowed
        "folderName": "BusinessDocuments"
      };

      debugPrint("📄 PreSigned Document Upload Body: $body");

      final response = await MyApi.callPostApi(
        url: preSignedFileUploadApiUrl,
        myHeaders: header,
        body: body,
      );

      if (response?["url"] != null) {
        debugPrint("✅ PreSigned Document URL: ${response?["url"]}");

        // upload file to the S3 pre-signed URL
        final success = await uploadImageByUrl(response?["url"], fileBytes);

        _loader.hideLoader(context!);

        if (success) {
          debugPrint("📦 Document uploaded successfully to S3");
          return response?["keyName"]; // this is your permanent S3 file URL
        } else {
          Toasts.getErrorToast(text: al.failedToUploadDocument);
          return null;
        }
      } else {
        _loader.hideLoader(context!);
        Toasts.getErrorToast(text: al.failedToGetUploadUrl);
        return null;
      }
    } catch (err) {
      debugPrint("❌ Error in getUrlForDocumentUpload: $err");
      _loader.hideLoader(context!);
      Toasts.getErrorToast(text: al.failedToUploadDocument);
      return null;
    }
  }


}