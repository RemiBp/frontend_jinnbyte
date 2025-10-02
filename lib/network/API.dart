import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../common/utils.dart';
import '../models/error_model.dart';
import '../res/refresh_token.dart';
import '../res/strings.dart';
import '../res/toasts.dart';
import 'models.dart';

class MyApi {
  static Future<dynamic> callGetPostApi({
    String? url,
    dynamic body,
    Map<String, dynamic>? parameters,
    Map<String, dynamic>? myHeaders,
    dynamic modelName,
    final provider,
    bool? hideBadRequestToast,
  }) async {
    try {
      var dio = Dio();
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (!connectivityResult.contains( ConnectivityResult.none)) {
        Map<String, dynamic> header = {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${PreferenceUtils.getString(Strings.token)}'
        };
        Response response = await dio.get(url!,
            options: Options(headers: header), queryParameters: parameters);
        switch (response.statusCode) {
          case 200:
            debugPrint('Case 200 Come');
            dynamic getModelObj =
                await Models.getModelObject(modelName, response.data);
            // if (getModelObj.code == 1) {
            //   return getModelObj;
            // } else {
            //   Toasts.getErrorToast(text: getModelObj.message);
            // }
            // return null;
            return getModelObj;

          default:
            Toasts.getErrorToast(text: Strings.badHappenedError);
            return null;
        }
      } else {
        Toasts.getErrorToast(text: "No internet");
        return null;
      }
    } on DioException catch (ex) {
      if (ex.response != null) {
        ErrorResponse errorResponse =
            await Models.getModelObject(Models.errorModel, ex.response?.data);
        switch (ex.response!.statusCode) {
          case 400:
            if (hideBadRequestToast != true) {
              Toasts.getErrorToast(text: errorResponse.data?.message);
            } else {
              provider?.handleBadRequest();
            }

            return;
          case 401:
            if (errorResponse.message ==
                "Authorization has been denied for this request.") {
              dynamic modelobj;
              await RefreshToken().onRefreshTokenApi().then((value) async {
                if (value) {
                  Map<String, dynamic> header = {
                    "Content-Type": "application/json",
                    'Authorization': PreferenceUtils.getString(Strings.token)
                  };
                  modelobj = await callGetApi(
                      parameters: parameters,
                      modelName: modelName,
                      url: url,
                      myHeaders: header);
                  return modelobj;
                }
              });
              return modelobj;
            } else {
              Toasts.getErrorToast(text: errorResponse.data?.message);
              return;
            }
          default:
            Toasts.getErrorToast(text: Strings.badHappenedError);
            return;
        }
      } else {
        Toasts.getErrorToast(text: Strings.badHappenedError);
      }
    } on Exception catch (ex) {
      debugPrint("ex is : $ex");
      Toasts.getErrorToast(text: Strings.badHappenedError);
      return;
    }
  }

  static Future<dynamic> callPostApi(
      {String? url,
      dynamic body,
      Map<String, dynamic>? parameters,
      Map<String, dynamic>? myHeaders,
      dynamic modelName}) async {
    try {
      var dio = Dio();
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (!connectivityResult.contains( ConnectivityResult.none)) {
        Map<String, dynamic> header = {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${PreferenceUtils.getString(Strings.token)}'
        };
        debugPrint("headers are : $header");
        Response response = await dio.post(url!,
            options: Options(headers: header),
            data: body,
            queryParameters: parameters);
        switch (response.statusCode) {
          case 200||201:
            if(modelName!=null){
             return await Models.getModelObject(modelName, response.data);
            }else{
              return response.data;
            }


          default:
            Toasts.getErrorToast(text: Strings.badHappenedError);
            return null;
        }
      } else {
        Toasts.getErrorToast(text: Strings.noInternetError);
        return null;
      }
    } on DioException catch (ex) {
      debugPrint("Error in post api is : $ex");
      if (ex.response != null) {
        ErrorResponse errorResponse =
            await Models.getModelObject(Models.errorModel, ex.response?.data);
        switch (ex.response!.statusCode) {
          case 401:
            Toasts.getErrorToast(text: errorResponse.message);
            return null;

          case 404:
            Toasts.getErrorToast(text: errorResponse.message??Strings.badHappenedError);
            return null;
          case 400:
            if (errorResponse.message ==
                "Authorization has been denied for this request.") {
              dynamic modelobj;
              await RefreshToken().onRefreshTokenApi().then((value) async {
                if (value) {
                  Map<String, dynamic> header = {
                    "Content-Type": "application/json",
                    'Authorization': PreferenceUtils.getString(Strings.token)
                  };
                  modelobj = await callPostApi(
                      parameters: parameters,
                      modelName: modelName,
                      body: body,
                      url: url,
                      myHeaders: header);
                  return modelobj;
                }
              });
              return modelobj;
            } else {
              Toasts.getErrorToast(text: errorResponse.message??Strings.badHappenedError);
              return null;
            }
          default:
            Toasts.getErrorToast(text: Strings.badHappenedError);
            return null;
        }
      } else {
        Toasts.getErrorToast(text: Strings.badHappenedError);
      }
    } on Exception catch (ex) {
      debugPrint("ex is : $ex");
      Toasts.getErrorToast(text: Strings.badHappenedError);
      return null;
    }
  }

  static Future<dynamic> callPatchApi(
      {String? url,
      dynamic body,
      Map<String, dynamic>? parameters,
      Map<String, dynamic>? myHeaders,
      dynamic modelName}) async {
    try {
      var dio = Dio();
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (!connectivityResult.contains(ConnectivityResult.none) ) {
        Map<String, dynamic> header = {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${PreferenceUtils.getString(Strings.token)}'
        };
        Response response = await dio.patch(url!,
            options: Options(headers: header),
            data: body,
            queryParameters: parameters);
        switch (response.statusCode) {
          case 200:
            dynamic modelObj =
                await Models.getModelObject(modelName, response.data);
            // if (modelObj.code == 1) {
            //   return modelObj;
            // } else {
            //   Toasts.getErrorToast(text: modelObj.message);
            // }
            // return null;
            return modelObj;

          default:
            Toasts.getErrorToast(text: Strings.badHappenedError);
            return null;
        }
      } else {
        Toasts.getErrorToast(text: Strings.noInternetError);
        return null;
      }
    } on DioException catch (ex) {
      if (ex.response != null) {
        ErrorResponse errorResponse =
            await Models.getModelObject(Models.errorModel, ex.response?.data);
        switch (ex.response!.statusCode) {
          case 400:
            Toasts.getErrorToast(text: errorResponse.data?.message);
            return null;
          case 401:
            if (errorResponse.message ==
                "Authorization has been denied for this request.") {
              dynamic modelobj;
              await RefreshToken().onRefreshTokenApi().then((value) async {
                if (value) {
                  Map<String, dynamic> header = {
                    "Content-Type": "application/json",
                    'Authorization': PreferenceUtils.getString(Strings.token)
                  };
                  modelobj = await callPatchApi(
                      parameters: parameters,
                      modelName: modelName,
                      url: url,
                      myHeaders: header);
                  return modelobj;
                }
              });
              return modelobj;
            } else {
              Toasts.getErrorToast(text: errorResponse.data?.message);
              return;
            }
          default:
            Toasts.getErrorToast(text: Strings.badHappenedError);
            return null;
        }
      } else {
        Toasts.getErrorToast(text: Strings.badHappenedError);
      }
    } on Exception catch (ex) {
      debugPrint("ex is : $ex");
      Toasts.getErrorToast(text: Strings.badHappenedError);
      return null;
    }
  }

  static Future<dynamic> callGetApi({
    String? url,
    dynamic body,
    Map<String, dynamic>? parameters,
    Map<String, dynamic>? myHeaders,
    dynamic modelName,
    bool? showToast,
  }) async {
    try {
      var dio = Dio();
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (!connectivityResult.contains(ConnectivityResult.none)) {
        Map<String, dynamic> header = {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${PreferenceUtils.getString(Strings.token)}'
        };
        Response response = await dio.get(url!,
            data: body,
            options: Options(headers: header),
            queryParameters: parameters);
        switch (response.statusCode) {
          case 200||201:
            if(modelName!=null){
              return await Models.getModelObject(modelName, response.data);
            }else{
              return response.data;
            }
            // if (getModelObj.code == 1) {
            //   return getModelObj;
            // } else {
            //   Toasts.getErrorToast(text: getModelObj.message);
            // }
            // return null;

          default:
            Toasts.getErrorToast(text: Strings.badHappenedError);
            return null;
        }
      } else {
        Toasts.getErrorToast(text: "No internet");
        return null;
      }
    } on DioException catch (ex) {
      debugPrint(
          "error in get api is : ${ex.response?.data}, with status code : ${ex.response?.statusCode}");

      if (ex.response != null) {
        ErrorResponse errorResponse = ex.response?.data is! String
            ? await Models.getModelObject(Models.errorModel, ex.response?.data)
            : ErrorResponse();
        switch (ex.response!.statusCode) {
          case 400:
            if (showToast == null) {
              Toasts.getErrorToast(text: errorResponse.message);
            }
            return;
          case 401:
            dynamic modelobj;
            await RefreshToken().onRefreshTokenApi().then((value) async {
              if (value) {
                Map<String, dynamic> header = {
                  "Content-Type": "application/json",
                  'Authorization': PreferenceUtils.getString(Strings.token)
                };
                modelobj = await callGetApi(
                    parameters: parameters,
                    modelName: modelName,
                    url: url,
                    myHeaders: header);
                return modelobj;
              }
            });
            return modelobj;

          default:
            Toasts.getErrorToast(text: Strings.badHappenedError);
            return;
        }
      } else {
        Toasts.getErrorToast(text: Strings.badHappenedError);
        return null;
      }
    } on Exception catch (ex) {
      debugPrint("ex is : $ex");
      Toasts.getErrorToast(text: Strings.badHappenedError);
      return;
    }
  }

  static Future<dynamic> callPutApi(
      {String? url,
      dynamic body,
      Map<String, dynamic>? parameters,
      Map<String, dynamic>? myHeaders,
      dynamic modelName}) async {
    try {
      var dio = Dio();
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (!connectivityResult.contains( ConnectivityResult.none)) {
        Map<String, dynamic> header = {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${PreferenceUtils.getString(Strings.token)}'
        };
        Response response = await dio.put(url!,
            options: Options(headers: header),
            data: body,
            queryParameters: parameters);
        switch (response.statusCode) {
          case 200:
            dynamic modelObj =
                await Models.getModelObject(modelName, response.data);
            // if (modelObj.code == 1) {
            //   return modelObj;
            // } else {
            //   Toasts.getErrorToast(text: modelObj.message);
            // }
            // return null;
            return modelObj;

          default:
            Toasts.getErrorToast(text: Strings.badHappenedError);
            return null;
        }
      } else {
        Toasts.getErrorToast(text: Strings.noInternetError);
        return null;
      }
    } on DioException catch (ex) {
      if (ex.response != null) {
        ErrorResponse errorResponse =
            await Models.getModelObject(Models.errorModel, ex.response?.data);
        switch (ex.response!.statusCode) {
          case 400:
            Toasts.getErrorToast(text: errorResponse.data?.message);
            return null;
          case 401:
            if (errorResponse.message ==
                "Authorization has been denied for this request.") {
              dynamic modelobj;
              await RefreshToken().onRefreshTokenApi().then((value) async {
                if (value) {
                  Map<String, dynamic> header = {
                    "Content-Type": "application/json",
                    'Authorization': PreferenceUtils.getString(Strings.token)
                  };
                  modelobj = await callPutApi(
                      parameters: parameters,
                      modelName: modelName,
                      body: body,
                      url: url,
                      myHeaders: header);
                  return modelobj;
                }
              });
              return modelobj;
            } else {
              Toasts.getErrorToast(text: errorResponse.data?.message);
              return null;
            }
          default:
            Toasts.getErrorToast(text: Strings.badHappenedError);
            return null;
        }
      } else {
        Toasts.getErrorToast(text: Strings.badHappenedError);
      }
    } on Exception catch (ex) {
      debugPrint("ex is : $ex");
      Toasts.getErrorToast(text: Strings.badHappenedError);
      return null;
    }
  }

  static Future<dynamic> callDeleteApi(
      {String? url,
      dynamic body,
      Map<String, dynamic>? parameters,
      Map<String, dynamic>? myHeaders,
      dynamic modelName}) async {
    try {
      var dio = Dio();
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (!connectivityResult.contains( ConnectivityResult.none)) {
        Map<String, dynamic> header = {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${PreferenceUtils.getString(Strings.token)}'
        };
        Response response = await dio.delete(url!,
            options: Options(headers: header),
            data: body,
            queryParameters: parameters);
        switch (response.statusCode) {
          case 200:
            dynamic modelObj =
                await Models.getModelObject(modelName, response.data);
            // if (modelObj.code == 1) {
            //   return modelObj;
            // } else {
            //   Toasts.getErrorToast(text: modelObj.message);
            // }
            // return null;
            return modelObj;

          default:
            Toasts.getErrorToast(text: Strings.badHappenedError);
            return null;
        }
      } else {
        Toasts.getErrorToast(text: Strings.noInternetError);
        return null;
      }
    } on DioException catch (ex) {
      if (ex.response != null) {
        ErrorResponse errorResponse =
            await Models.getModelObject(Models.errorModel, ex.response?.data);
        switch (ex.response!.statusCode) {
          case 400:
            Toasts.getErrorToast(text: errorResponse.data?.message);
            return null;
          case 401:
            if (errorResponse.message ==
                "Authorization has been denied for this request.") {
              dynamic modelobj;
              await RefreshToken().onRefreshTokenApi().then((value) async {
                if (value) {
                  Map<String, dynamic> header = {
                    "Content-Type": "application/json",
                    'Authorization': PreferenceUtils.getString(Strings.token)
                  };
                  modelobj = await callPutApi(
                      parameters: parameters,
                      modelName: modelName,
                      body: body,
                      url: url,
                      myHeaders: header);
                  return modelobj;
                }
              });
              return modelobj;
            } else {
              Toasts.getErrorToast(text: errorResponse.data?.message);
              return null;
            }
          default:
            Toasts.getErrorToast(text: Strings.badHappenedError);
            return null;
        }
      } else {
        Toasts.getErrorToast(text: Strings.badHappenedError);
      }
    } on Exception catch (ex) {
      debugPrint("ex is : $ex");
      Toasts.getErrorToast(text: Strings.badHappenedError);
      return null;
    }
  }
}
