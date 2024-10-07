import 'dart:convert';
import 'package:eat_fit/src/instructor/constant/app_url.dart';
import 'package:eat_fit/src/instructor/constant/retry_refresh_tokens/retry_refresh_tokens.dart';
import 'package:eat_fit/src/instructor/constant/storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static Future<Map<String, dynamic>> accessCode(
      String email, String password) async {
    final String url = ApiUrl.kApiBaseUrl + ApiUrl.kApiAccessPath;
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({'phone_number': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final SharedPreferences userType = await SharedPreferences.getInstance();
      final SharedPreferences userId = await SharedPreferences.getInstance();
      userType.setString('userType', responseData['user']['role_type']);
      userId.setInt('id', responseData['user']['id']);
      final String accessToken = responseData['access'];
      final String refreshToken = responseData['refresh'];
      await SecureStorage.saveTokens(accessToken, refreshToken);
      return responseData;
    } else {
      throw Exception('Failed to login');
    }
  }

  static Future<Map<String, dynamic>> refreshToken() async {
    final String? refreshToken = await SecureStorage.getRefreshToken();
    if (refreshToken != null) {
      final String url = ApiUrl.kApiBaseUrl + ApiUrl.kApiRefreshTokenPath;
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode({'refresh': refreshToken}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String newAccessToken = responseData['access'];
        await SecureStorage.updateAccessToken(newAccessToken);
        return responseData;
      } else {
        RefreshTokenService.refreshAccessToken();
        throw Exception('Failed to refresh token');
      }
    } else {
      RefreshTokenService.refreshAccessToken();
      throw Exception('Refresh token is null');
    }
  }
}
