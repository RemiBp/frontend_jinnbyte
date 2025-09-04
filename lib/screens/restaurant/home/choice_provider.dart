import 'package:choice_app/common/utils.dart';
import 'package:choice_app/network/API.dart';
import 'package:choice_app/network/api_url.dart';
import 'package:choice_app/res/loader.dart';
import 'package:choice_app/res/strings.dart';
import 'package:choice_app/res/toasts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class  ChoiceProvider  extends ChangeNotifier{

  final Loader _loader = Loader();



  BuildContext? context;

  init(context){
    this.context = context;
  }

Future<void> createChoiceApi({
    required String title,
    required String description,
    required String tags,
    required String location,
    required List<String> images,
}
    )async{
    try{
      _loader.showLoader(context: context);
      final body = {
        "placeId": 21,
        "title":title,
        "type": "wellness",
        "status": "public",
        "description": description,
        "link": "https://yourrestaurant.com/sunday-brunch",
        "tags": [tags
        ],
        "coverImage": images[0],
        "imageUrls":images,
        "publishDate":"2025-08-21T11:00:00.000Z",
        // DateTime.now().toIso8601String(),
        "createdBy": PreferenceUtils.getString(Strings.email),
        "location": location,
      };
      debugPrint("body for create posst is : $body");
      final response  = await MyApi.callPostApi(
        url:createUserPostApiUrl,
        body: body,
      );
      _loader.hideLoader(context!);
      debugPrint("response is : $response");
      if(response?["message"]!=null){
        Toasts.getSuccessToast(text: response?["message"]);
        // context!.pop();
      }
    }catch(err){
      _loader.hideLoader(context!);
      debugPrint("error while creating user post is : $err");
    }
}
 }