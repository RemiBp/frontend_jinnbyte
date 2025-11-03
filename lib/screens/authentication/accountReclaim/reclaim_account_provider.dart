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

  double uploadProgress = 0.0;
  bool isUploading = false;
  PlatformFile? selectedFile; // to hold the picked file


  void setUploadProgress(double progress) {
    uploadProgress = progress;
    notifyListeners();
  }


  void setSelectedFile(PlatformFile file) {
    selectedFile = file;
    notifyListeners();
  }

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

      Toasts.getSuccessToast(text: al.documentSelectedSuccessfully);
    } catch (e) {
      _loader.hideLoader(context!);
      isLoading = false;
      notifyListeners();
      Toasts.getErrorToast(text: al.failedToUploadDocument);
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
        Toasts.getErrorToast(text: al.noPlacesFound);
      }
    } catch (e) {
      debugPrint("❌ Error fetching producer places: $e");
      Toasts.getErrorToast(text: al.failedToFetchPlaces);
      searchedPlaces = [];
    } finally {
      isSearching = false;
      notifyListeners();
    }
  }


  // Future<void> uploadBusinessDocument() async {
  //   try {
  //     // 1 Pick PDF file
  //     final result = await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       allowedExtensions: ['pdf'],
  //     );
  //
  //     if (result == null) {
  //       Toasts.getErrorToast(text: al.noFileSelected);
  //       return;
  //     }
  //
  //     final file = File(result.files.single.path!);
  //     selectedDoc = result.files.single;
  //     notifyListeners();
  //
  //     // Reset and start upload progress
  //     isUploading = true;
  //     setUploadProgress(0);
  //
  //     final networkProvider = context?.read<NetworkProvider>();
  //
  //     // If your `getUrlForDocumentUpload` supports Dio upload with progress, do this:
  //     final uploadedKey = await networkProvider?.getUrlForDocumentUpload(
  //       file,
  //       context!,
  //       onSendProgress: (sent, total) {
  //         if (total > 0) setUploadProgress(sent / total);
  //       },
  //     );
  //
  //     //  If it doesn't support progress, simulate a progress bar:
  //     if (uploadedKey == null) {
  //       for (int i = 1; i <= 10; i++) {
  //         await Future.delayed(const Duration(milliseconds: 150));
  //         setUploadProgress(i / 10);
  //       }
  //     }
  //
  //     if (uploadedKey == null) {
  //       Toasts.getErrorToast(text: al.failedToUploadDocument);
  //       isUploading = false;
  //       setUploadProgress(0);
  //       return;
  //     }
  //
  //     uploadedDocUrl = uploadedKey;
  //     setUploadProgress(1.0);
  //     isUploading = false;
  //     notifyListeners();
  //
  //     // 3 Save document details in backend
  //     final saveResponse = await MyApi.callPostApi(
  //       url: saveDocumentApiUrl,
  //       body: {
  //         "type": "business_registration",
  //         "fileUrl": uploadedKey,
  //       },
  //     );
  //
  //     if (saveResponse?["status"] == 200 || saveResponse?["status"] == 201) {
  //       Toasts.getSuccessToast(
  //         text: saveResponse?["message"] ?? al.documentSavedSuccessfully,
  //       );
  //     } else {
  //       Toasts.getErrorToast(
  //         text: saveResponse?["message"] ?? al.failedToSaveDocument,
  //       );
  //     }
  //   } catch (err) {
  //     debugPrint("❌ uploadBusinessDocument error: $err");
  //     Toasts.getErrorToast(text: al.unexpectedErrorWhileUploading);
  //   } finally {
  //     isUploading = false;
  //     notifyListeners();
  //   }
  // }

  Future<void> submitProducerDocuments({
    required Map<String, dynamic> documentsData,
  }) async {
    try {
      _loader.showLoader(context: context);


      final response = await MyApi.callPostApi(
        url: submitProducerDocumentApiUrl,
        body: documentsData,
      );

      _loader.hideLoader(context!);

      if (response?["message"] == "Documents submitted successfully") {
        Toasts.getSuccessToast(text: response?["message"]);
      } else {
        Toasts.getErrorToast(text: response?["message"] ?? "Failed to submit documents");
      }
    } catch (err) {
      _loader.hideLoader(context!);
      debugPrint("❌ Error submitting documents: $err");
      Toasts.getErrorToast(text: "Error submitting documents");
    }
  }
  Future<void> uploadAndSubmitDocuments() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result == null) {
        Toasts.getErrorToast(text: al.noFileSelected);
        return;
      }

      final file = File(result.files.single.path!);
      setSelectedFile(result.files.single);
      isUploading = true; // 👈 start progress
      setUploadProgress(0);
      notifyListeners();

      final networkProvider = context?.read<NetworkProvider>();

      final uploadedKey = await networkProvider?.getUrlForDocumentUpload(
        file,
        context!,
        onSendProgress: (sent, total) {
          if (total > 0) setUploadProgress(sent / total);
        },
      );

      if (uploadedKey == null) {
        isUploading = false;
        setUploadProgress(0);
        notifyListeners();
        Toasts.getErrorToast(text: al.failedToUploadDocument);
        return;
      }

      setUploadProgress(1);
      isUploading = false; // 👈 upload done
      notifyListeners();

      final documentData = {
        "document1": uploadedKey,
        "document1Expiry": "2025-11-01",
      };

      await submitProducerDocuments(documentsData: documentData);
    } catch (e) {
      isUploading = false;
      setUploadProgress(0);
      notifyListeners();
      debugPrint("❌ uploadAndSubmitDocuments error: $e");
      Toasts.getErrorToast(text: al.failedToUploadDocument);
    }
  }


}
