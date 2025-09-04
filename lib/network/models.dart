
import 'package:choice_app/models/auth_ressponse.dart';
import 'package:choice_app/models/get_all_events_response.dart';

import '../models/error_model.dart';

class Models {
  static const String errorModel = "ERROR_MODEL";
  static const String authModel = "REGISTRATION_MODEL";
  static const String eventsModel = "Events_MODEL";



  static Future<dynamic> getModelObject(
      String modelName, Map<String, dynamic> json) async {
    switch (modelName) {
      case errorModel:
        return ErrorResponse.fromJson(json);
      case authModel:
        return AuthResponse.fromJson(json);
      case eventsModel:
        return GetAllEventsResponse.fromJson(json);
    }
  }
}
