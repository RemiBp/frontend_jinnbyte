import 'package:choice_app/models/auth_ressponse.dart';
import 'package:choice_app/models/customer_all_posts_response.dart';
import 'package:choice_app/models/customer_profile_response.dart';
import 'package:choice_app/models/get_all_events_response.dart';
import 'package:choice_app/models/get_all_service_types_response.dart';
import 'package:choice_app/models/get_cuisine_types_response.dart';
import 'package:choice_app/models/get_menu_categories_response.dart';
import 'package:choice_app/models/get_producer_slots_response.dart';
import 'package:choice_app/models/restaurant_update_profile_response.dart';

import '../models/error_model.dart';

class Models {
  static const String errorModel = "ERROR_MODEL";
  static const String authModel = "REGISTRATION_MODEL";
  static const String eventsModel = "Events_MODEL";
  static const String restaurantUpdateProfileModel =
      "RESTAURANT_UPDATE_PROFILE_MODEL";
  static const String restaurantGetCuisineTypesModel =
      "RESTAURANT_GET_CUISINE_TYPES_MODEL";
  static const String restaurantGetMenuCategoriesModel =
      "RESTAURANT_GET_MENU_CATEGORIES_MODEL";
  static const String customerProfileModel = "CUSTOMER_PROFILE_MODEL";
  static const String customerAllPostsModel = "CUSTOMER_ALL_POSTS_MODEL";
  static const String getProducerSlotsModel = "GET_PRODUCER_SLOTS_MODEL";
  static const String getAllServiceTypesModel = "GET_ALL_SERVICE_TYPES_MODEL";

  static Future<dynamic> getModelObject(
    String modelName,
    Map<String, dynamic> json,
  ) async {
    switch (modelName) {
      case errorModel:
        return ErrorResponse.fromJson(json);
      case authModel:
        return AuthResponse.fromJson(json);
      case eventsModel:
        return GetAllEventsResponse.fromJson(json);
      case restaurantUpdateProfileModel:
        return RestaurantUpdateProfileResponse.fromJson(json);
      case customerProfileModel:
        return CustomerProfileResponse.fromJson(json);
      case customerAllPostsModel:
        return CustomerAllPostsResponse.fromJson(json);
      case restaurantGetCuisineTypesModel:
        return GetCuisineTypesResponse.fromJson(json);
      case restaurantGetMenuCategoriesModel:
        return GetMenuCategoriesResponse.fromJson(json);
      case getProducerSlotsModel:
        return GetProducerSlotsResponse.fromJson(json);
      case getAllServiceTypesModel:
        return GetAllServiceTypesResponse.fromJson(json);
    }
  }
}
