import 'package:choice_app/network/api_url.dart';
import 'package:flutter/material.dart';

import '../../../../common/utils.dart';
import '../../../../models/get_all_events_near_me_response.dart';
import '../../../../network/API.dart';
import '../../../../network/models.dart';


class ExploreViewProvider extends ChangeNotifier {
  final BuildContext context;

  ExploreViewProvider({required this.context});

  bool isLoading = false;
  List<EventData> events = [];

  Future<void> getEventsNearMe() async {
    try {
      isLoading = true;
      notifyListeners();

      //  Read lat/lng saved from profile
      final latString = PreferenceUtils.getString("latitude");
      final lngString = PreferenceUtils.getString("longitude");

      double lat = double.tryParse(latString ?? "") ?? 38.716900;
      double lng = double.tryParse(lngString ?? "") ?? -9.139000;

      final url = "$getEventsNearMeApiUrl?lat=$lat&lng=$lng&radius=5";

      debugPrint("📍 Calling GET: $url");

      final response = await MyApi.callGetApi(
        url: url,
        modelName: Models.getEventsNearMeModel,
      );

      if (response != null && response.data != null) {
        events = response.data!
            .where((e) =>
        e.serviceType?.toLowerCase() == 'restaurant' ||
            e.serviceType?.toLowerCase() == 'leisure')
            .toList();
      }

      isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint("❌ Error fetching events near me: $e");
      isLoading = false;
      notifyListeners();
    }
  }

}
