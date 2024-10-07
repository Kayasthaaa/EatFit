import 'package:dio/dio.dart';
import 'package:eat_fit/src/instructor/constant/app_url.dart';
import 'package:eat_fit/src/instructor/constant/retry_refresh_tokens/retry_refresh_tokens.dart';
import 'package:eat_fit/src/instructor/constant/storage.dart';
import 'package:eat_fit/src/instructor/feature/screens/generate_code/models/generate_code_models.dart';

class GenerateApiClass {
  static final Dio _dio = Dio(BaseOptions(baseUrl: ApiUrl.kApiBaseUrl));

  static Future<GenerateCodeModels> postCode(String meal, String phone) async {
    final RequestOptions requestOptions =
        RequestOptions(path: ApiUrl.kApiGenerateCode);
    final String? accessToken = await SecureStorage.getAccessToken();

    if (accessToken != null) {
      requestOptions.headers['Authorization'] = 'Bearer $accessToken';
    }

    try {
      final response = await _dio.request(
        ApiUrl.kApiGenerateCode,
        options: Options(
          method: 'POST', // Change method to POST
          headers: requestOptions.headers,
          responseType: ResponseType.json, // Set responseType to JSON
          contentType: Headers.jsonContentType, // Set contentType to JSON
          validateStatus: (status) =>
              status! <
              500, // Only consider HTTP status codes less than 500 as valid
        ),
        data: {'meal_plan': meal, 'phone_number': phone},
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData != null && responseData is Map<String, dynamic>) {
          final body = GenerateCodeModels.fromJson(responseData);
          return body;
        } else {
          throw Exception('Invalid response data format');
        }
      } else if (response.statusCode == 401) {
        await RefreshTokenService.refreshAccessToken();
        return await postCode(meal, phone);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
    } on DioException catch (error) {
      if (error.response != null) {
        final responseData = error.response!.data;
        if (responseData != null && responseData is Map<String, dynamic>) {
          final errorMessage =
              responseData['error'] ?? 'Error, Please try again';
          throw errorMessage; // Throw the error message directly
        } else {
          throw 'Invalid error response format';
        }
      } else {
        throw 'Network error: ${error.message}';
      }
    } catch (error) {
      // Other exceptions
      throw error.toString(); // Throw the error message directly
    }
  }
}
