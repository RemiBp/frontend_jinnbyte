import 'package:choice_app/models/get_all_events_response.dart';
import 'package:flutter/material.dart';

import '../../../network/API.dart';
import '../../../network/api_url.dart';
import '../../../network/models.dart';
import '../../../res/loader.dart';
import '../../../res/toasts.dart';

class EventProvider extends ChangeNotifier{
  GetAllEventsResponse getAllEventsResponse = GetAllEventsResponse();

  final Loader _loader = Loader();

  BuildContext? context;

  init(context) {
    this.context = context;
  getAllEvents();
  }

  Future<void> createEventApi({
    required String eventName,
    required String description,
    required String venue,
    required String address,
    required String capacity,
    required String price,
    required String date,
    required String startTime,
    required String endTime,
    required List<String> images,
  }) async {
    try {
      _loader.showLoader(context: context);

      final body = {
        "eventTypeId": 1,
        "title": eventName,
        "description": description,
        "serviceType": venue,
        "location": address,
        "pricePerGuest": double.tryParse(price) ?? 0,
        "maxCapacity": int.tryParse(capacity) ?? 0,
        "status": "Active",
        "date": date,
        "startTime": startTime,
        "endTime": endTime,
        "eventImages": images,
      };

      debugPrint("body for create post is : $body");

      final response = await MyApi.callPostApi(
        url: createEventPostApiUrl,
        body: body,
      );

      _loader.hideLoader(context!);

      debugPrint("response is : $response");
      if (response?["message"] != null) {
        Toasts.getSuccessToast(text: response?["message"]);
        // context!.pop();
      }
    } catch (err) {
      _loader.hideLoader(context!);
      debugPrint("error while creating event is : $err");
    }
  }

  Future<void> getAllEvents() async {
    try {
      _loader.showLoader(context: context);
      getAllEventsResponse = await MyApi.callGetApi(
        url: getAllEventsApiUrl,
        parameters:{
          "status":"Active"
        },
        modelName: Models.eventsModel,
      );
      debugPrint("response is : ${getAllEventsResponse.data?.length}");
      _loader.hideLoader(context!);
    } catch (err) {
      debugPrint("error while getting all events : $err");
      _loader.hideLoader(context!);
    }

  }
}