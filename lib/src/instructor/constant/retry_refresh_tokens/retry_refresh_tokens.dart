import 'package:dio/dio.dart';
import 'package:eat_fit/src/instructor/constant/app_url.dart';
import 'package:eat_fit/src/instructor/constant/storage.dart';

class RefreshTokenService {
  static final Dio _dio = Dio(BaseOptions(baseUrl: ApiUrl.kApiBaseUrl));

  static Future<void> refreshAccessToken() async {
    try {
      final String? refreshToken = await SecureStorage.getRefreshToken();

      if (refreshToken != null) {
        final response = await _dio.post(
          ApiUrl.kApiRefreshTokenPath,
          data: {'refresh': refreshToken},
        );

        if (response.statusCode == 200) {
          final String newAccessToken = response.data['access'];
          await SecureStorage.updateAccessToken(newAccessToken);
        } else {
          throw Exception('Failed to refresh access token');
        }
      } else {
        throw Exception('Refresh token not found');
      }
    } catch (e) {
      throw Exception('Failed to refresh access token: $e');
    }
  }
}
