import 'package:dio/dio.dart';
import 'package:eat_fit/src/instructor/constant/app_url.dart';
import 'package:eat_fit/src/instructor/constant/retry_refresh_tokens/retry_refresh_tokens.dart';
import 'package:eat_fit/src/instructor/constant/storage.dart';
import 'package:eat_fit/src/instructor/feature/screens/update_meal_plans/models/update_meal_plans_models.dart';

class UpdateMealDetailsApiClass {
  static final Dio _dio = Dio(BaseOptions(baseUrl: ApiUrl.kApiBaseUrl));

  static Future<UpdateMealPlans> updateMealDetails(
      {required String name, required int id}) async {
    String endpoint = '/meals/$id/';
    final RequestOptions requestOptions = RequestOptions(path: endpoint);
    final String? accessToken = await SecureStorage.getAccessToken();

    if (accessToken != null) {
      requestOptions.headers['Authorization'] = 'Bearer $accessToken';
    }

    try {
      final response = await _dio.request(
        endpoint,
        options: Options(
          method: 'PATCH', // Change method to POST
          headers: requestOptions.headers,
          responseType: ResponseType.json, // Set responseType to JSON
          contentType: Headers.jsonContentType, // Set contentType to JSON
          validateStatus: (status) =>
              status! <
              500, // Only consider HTTP status codes less than 500 as valid
        ),
        data: {
          'plan_name': name,
        },
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData != null && responseData is Map<String, dynamic>) {
          final body = UpdateMealPlans.fromJson(responseData);
          return body;
        } else {
          throw Exception('Invalid response data format');
        }
      } else if (response.statusCode == 401) {
        await RefreshTokenService.refreshAccessToken();
        return await updateMealDetails(name: name, id: id);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
    } on DioException catch (error) {
      // Handle DioException specifically
      if (error.response != null) {
        final responseData = error.response!.data;
        if (responseData != null && responseData is Map<String, dynamic>) {
          final errorMessage =
              responseData['error'] ?? 'Error, Please try again';
          throw Exception(errorMessage);
        } else {
          throw Exception('Invalid error response format');
        }
      } else {
        throw Exception('Network error: ${error.message}');
      }
    } catch (error) {
      // Other exceptions
      throw Exception('Failed to fetch data: $error');
    }
  }
}
