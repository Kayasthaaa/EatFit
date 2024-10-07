import 'dart:convert';
import 'package:eat_fit/src/instructor/constant/app_url.dart';
import 'package:eat_fit/src/instructor/feature/screens/login/models/login_models.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  Future<LoginModels?> userLogin(String phone) async {
    var loginResponse = await http.post(
      Uri.parse(ApiUrl.kApiBaseUrl + ApiUrl.kApiVerifyPath),
      body: {
        "phone_number": phone,
      },
    );
    if (loginResponse.statusCode == 200) {
      LoginModels loginModels = LoginModels.fromJson(
        json.decode(loginResponse.body),
      );

      return loginModels;
    }
    return null;
  }
}
