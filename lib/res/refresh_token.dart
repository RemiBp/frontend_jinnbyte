// import 'package:stop_n_go/common/utils.dart';
// import 'package:stop_n_go/models/login_model.dart';
// import 'package:stop_n_go/models/refresh_token_model.dart';
// import 'package:stop_n_go/network/API.dart';
// import 'package:stop_n_go/network/api_url.dart';
// import 'package:stop_n_go/network/models.dart';
// import 'package:stop_n_go/res/strings.dart';

class RefreshToken {
  // RefreshTokenResponse tokenResponse = RefreshTokenResponse();

  Future<bool> onRefreshTokenApi() async {
    return true;
    // try {
    //   Map<String, dynamic> header = {"Content-Type": "application/json"};
    //   Map<String, dynamic> body = {
    //     "refreshToken": PreferenceUtils.getString(Strings.refreshToken)
    //   };
    //   tokenResponse = await MyApi.callPostApi(
    //     url: refreshTokenApiUrl,
    //     body: body,
    //     myHeaders: header,
    //     modelName: Models.refreshTokenModel,
    //   );
    //   if (tokenResponse.data != null) {
    //     PreferenceUtils.setString(
    //         Strings.token, tokenResponse.data?.accessToken?.token ?? "");
    //     PreferenceUtils.setString(
    //         Strings.refreshToken, tokenResponse.data?.refreshToken ?? "");
    //     return true;
    //   }
    //   return false;
    // } catch (e) {
    //   return false;
    // }
  }
}
