
import 'package:choice_app/models/auth_ressponse.dart';

import '../models/error_model.dart';

class Models {
  static const String errorModel = "ERROR_MODEL";
  static const String AuthModel = "REGISTRATION_MODEL";



  static Future<dynamic> getModelObject(
      String modelName, Map<String, dynamic> json) async {
    switch (modelName) {
      case errorModel:
        return ErrorResponse.fromJson(json);
      case AuthModel:
        return AuthResponse.fromJson(json);
    }
  }
}
