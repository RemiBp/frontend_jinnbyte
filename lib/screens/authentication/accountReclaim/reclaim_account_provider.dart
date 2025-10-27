import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/get_producers_places_claim_response.dart';
import '../../../network/API.dart';
import '../../../network/api_url.dart';
import '../../../network/models.dart';
import '../../../network/network_provider.dart';
import '../../../res/loader.dart';
import '../../../l18n.dart';
import '../../../res/toasts.dart';

class ReclaimAccountProvider extends ChangeNotifier {

  PlatformFile? selectedDoc;
  String? uploadedDocUrl;
  BuildContext? context;
  int step = 0;
  bool isLoading = false;

  //  CLAIM FLOW FIELDS
  List<PlaceData> searchedPlaces = [];
  bool isSearching = false;
  String selectedType = "";
  PlaceData? selectedPlace;

  int? get claimProducerId => selectedPlace?.id;



  // Update the selected type (restaurant, wellness, leisure)
  void setType(String type) {
    selectedType = type;
    searchedPlaces.clear();
    notifyListeners();
  }

  void selectPlace(PlaceData place) {
    selectedPlace = place;
    notifyListeners();
  }

  final docs = [
    al.businessRegistrationDocument,
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

  // FETCH PRODUCER PLACES
  Future<void> getProducerPlaces({
    required String query,
  }) async {
    if (query.isEmpty || selectedType.isEmpty) {
      searchedPlaces.clear();
      notifyListeners();
      return;
    }

    try {
      isSearching = true;
      notifyListeners();

      final ClaimProducerPlacesResponse response = await MyApi.callGetApi(
        url: getProducerPlacesApiUrl,
        modelName: Models.claimProducerPlacesModel,
        parameters: {
          "query": query,
          "type": selectedType,
        },
      );

      debugPrint("✅ API response: ${response.toJson()}");

      if (response.status == 200 && response.data != null) {
        searchedPlaces = response.data!;
        debugPrint("✅ Parsed ${searchedPlaces.length} places");
      } else {
        searchedPlaces = [];
        Toasts.getErrorToast(text: "No places found");
      }
    } catch (e) {
      debugPrint("❌ Error fetching producer places: $e");
      Toasts.getErrorToast(text: "Failed to fetch places");
      searchedPlaces = [];
    } finally {
      isSearching = false;
      notifyListeners();
    }
  }


  Future<void> uploadBusinessDocument() async {
    try {
      // 1️⃣ Pick only PDF files
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result == null) {
        Toasts.getErrorToast(text: "No file selected");
        return;
      }

      final file = File(result.files.single.path!);
      selectedDoc = result.files.single; // ✅ store locally for UI
      notifyListeners();

      final networkProvider = context?.read<NetworkProvider>();

      // 2️⃣ Upload to S3 via presigned URL
      final uploadedKey =
      await networkProvider?.getUrlForDocumentUpload(file, context!);

      if (uploadedKey == null) {
        Toasts.getErrorToast(text: "Failed to upload document");
        return;
      }

      uploadedDocUrl = uploadedKey; // ✅ store uploaded URL
      notifyListeners();

      debugPrint("✅ Uploaded S3 Key: $uploadedKey");

      // 3️⃣ Save document details in backend
      final saveResponse = await MyApi.callPostApi(
        url: saveDocumentApiUrl,
        body: {
          "type": "business_registration",
          "fileUrl": uploadedKey,
        },
      );

      debugPrint("📨 Save Document Response: $saveResponse");

      if (saveResponse?["status"] == 200 || saveResponse?["status"] == 201) {
        Toasts.getSuccessToast(
          text: saveResponse?["message"] ?? "Document saved successfully",
        );
      } else {
        Toasts.getErrorToast(
          text: saveResponse?["message"] ?? "Failed to save document",
        );
      }
    } catch (err) {
      debugPrint("❌ uploadBusinessDocument error: $err");
      Toasts.getErrorToast(
        text: "Unexpected error occurred while uploading",
      );
    }
  }

}
