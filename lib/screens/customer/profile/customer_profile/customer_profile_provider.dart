import 'package:choice_app/models/customer_all_posts_response.dart';
import 'package:choice_app/models/customer_profile_response.dart';
import 'package:choice_app/network/API.dart';
import 'package:choice_app/network/api_url.dart';
import 'package:choice_app/network/models.dart';
import 'package:choice_app/res/loader.dart';
import 'package:flutter/material.dart';

class CustomerProfileProvider extends ChangeNotifier{
  CustomerProfileResponse customerProfileResponse = CustomerProfileResponse();
  CustomerAllPostsResponse postsResponse = CustomerAllPostsResponse();
  BuildContext? context;
  final Loader _loader = Loader();

  init(context){
    this.context = context;
  }

  User? get user=>{
     customerProfileResponse.user
  }.firstOrNull;

  List<Data>? get  userPosts=>{
    postsResponse.data
  }.firstOrNull;

  Future<void> getProfile()async{
    try{
      _loader.showLoader(context: context);
      customerProfileResponse =await MyApi.callGetApi(
        url: userProfileApiUrl,
        modelName: Models.customerProfileModel
      );
      debugPrint("profile response is : ${customerProfileResponse.toJson()
      }");
      _loader.hideLoader(context!);

    }catch(err){
      debugPrint("error while getting profile is : $err");
      _loader.hideLoader(context!);
    }
    notifyListeners();
  }


  Future<void> getCustomerPosts()async{
    try{
      _loader.showLoader(context: context);
      postsResponse =await MyApi.callGetApi(
          url: userPostsApiUrl,
          modelName: Models.customerAllPostsModel
      );
      debugPrint("user posts response is : ${postsResponse.status
      }");
      _loader.hideLoader(context!);
    }catch(err){
      debugPrint("error while getting user posts is : $err");
      _loader.hideLoader(context!);
    }
    notifyListeners();
  }
}