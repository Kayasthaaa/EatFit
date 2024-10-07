import 'dart:convert';
import 'package:eat_fit/src/instructor/constant/app_url.dart';
import 'package:eat_fit/src/instructor/feature/screens/register/models/register_models.dart';
import 'package:http/http.dart' as http;

class RegisterUserApi {
  Future<RegisterModels?> registerUser(
      String phone, String password, String confirmPassword) async {
    var registerResponse = await http.post(
      Uri.parse(ApiUrl.kApiBaseUrl + ApiUrl.kRegister),
      body: {
        "phone_number": phone,
        "password1": password,
        "password2": confirmPassword,
      },
    );
    if (registerResponse.statusCode == 201) {
      RegisterModels registerModels = RegisterModels.fromJson(
        json.decode(registerResponse.body),
      );

      return registerModels;
    } else {}

    return null;
  }
}
