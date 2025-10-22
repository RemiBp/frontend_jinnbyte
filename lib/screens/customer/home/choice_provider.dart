import 'package:choice_app/models/get_producer_places.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../network/API.dart';
import '../../../network/api_url.dart';
import '../../../network/models.dart';
import '../../../res/loader.dart';
import '../../../res/toasts.dart';

class CustomerChoiceProvider extends ChangeNotifier {
  ProducerPlacesResponse placesResponse = ProducerPlacesResponse();
  BuildContext? context;

  final Loader _loader = Loader();

  init(context) {
    this.context = context;
  }

  Future<void> getProducerPlaces() async {
    try {
      _loader.showLoader(context: context);

      placesResponse = await MyApi.callGetApi(
        url: getProducerPlacesApiUrl,
        modelName: Models.  producerPlacesModel,
        parameters: {"query": " ", "type": "restaurant"},
      );

      debugPrint("Get cuisine types response: ${placesResponse.status}");

      _loader.hideLoader(context!);

      if (placesResponse.data == null) {
        Toasts.getErrorToast(text: "Failed to fetch places");
      }
      notifyListeners();
    } catch (err) {
      debugPrint("Error getting cuisine types: $err");
      _loader.hideLoader(context!);
      Toasts.getErrorToast(text: "Failed to fetch places");
    }
  }

  Future<void> createChoice({
    required int placeId,
    required String status,
    required String description,
    required List<String> tags,
    required List<String> imageUrls,
    required Map<String, dynamic> rating,
  }) async {
    try {
      _loader.showLoader(context: context);
      Map<String, dynamic> headers = {"Content-Type": "application/json"};
      Map<String, dynamic> body = {
        "placeId": placeId,
        "type": "restaurant",
        "status": status,
        "title": "Sample",
        "description": description,
        "link": "https://yourrestaurant.com/sunday-brunch",
        "tags": tags,
        "imageUrls": imageUrls,
        "coverImage": imageUrls[0],
        "publishDate": DateTime.now().toUtc().toIso8601String(),
        "createdBy": "api-user-123",
        "location": "abc, xyz",
      };
      debugPrint("body is : ---------->$body");
      final response = await MyApi.callPostApi(
        url: createUserPostApiUrl,
        myHeaders: headers,
        body: body,
      );
      debugPrint("choice response : $response");
      _loader.hideLoader(context!);
      if (response != null) {
        Toasts.getSuccessToast(text: response?["message"]);
        await saveRating(choiceId: response["data"]["id"], rating: rating);
      }
    } catch (err) {
      debugPrint("error during saving  rating : $err");
      _loader.hideLoader(context!);
    }
  }

  Future<void> saveRating({
    required int choiceId,
    required Map<String, dynamic> rating,
  }) async {
    try {
      _loader.showLoader(context: context);
      Map<String, dynamic> headers = {"Content-Type": "application/json"};
      Map<String, dynamic> body = {
        "producerType": "restaurant",
        "ratings": {
          "service": rating["Service"],
          "place": rating["Place"],
          "portions": rating["Portions"],
          "ambiance": rating["Ambiance"],
        },
        "comment": "test sample comment",
      };
      debugPrint("body is : ---------->$body");
      final response = await MyApi.callPostApi(
        url: "$saveResRatingApiUrl/$choiceId",
        myHeaders: headers,
        body: body,
      );
      debugPrint("save rating response : $response");
      _loader.hideLoader(context!);
      if (response != null) {
        Toasts.getSuccessToast(text: response?["message"]);
        context?.pop();
      }

    } catch (err) {
      debugPrint("error during saving  rating : $err");
      _loader.hideLoader(context!);
    }
  }
}
