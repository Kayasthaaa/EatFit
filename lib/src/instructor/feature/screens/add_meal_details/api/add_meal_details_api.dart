import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:eat_fit/src/instructor/constant/app_url.dart';
import 'package:eat_fit/src/instructor/constant/retry_refresh_tokens/retry_refresh_tokens.dart';
import 'package:eat_fit/src/instructor/constant/storage.dart';

class AddMealPlanApi {
  static final Dio _dio = Dio(BaseOptions(baseUrl: ApiUrl.kApiBaseUrl));

  static Future<dynamic> addMealPlan(Map<String, dynamic> payload) async {
    String endpoint = ApiUrl.kAddMealPlan;
    final RequestOptions requestOptions = RequestOptions(
      path: endpoint,
      method: 'POST',
      data: jsonEncode(payload),
    );

    final String? accessToken = await SecureStorage.getAccessToken();
    if (accessToken != null) {
      requestOptions.headers['Authorization'] = 'Bearer $accessToken';
    }

    try {
      final response = await _dio.request(
        endpoint,
        data: requestOptions.data,
        options: Options(
          method: requestOptions.method,
          headers: requestOptions.headers,
          responseType: requestOptions.responseType,
          contentType: requestOptions.contentType,
          validateStatus: requestOptions.validateStatus,
          receiveTimeout: requestOptions.receiveTimeout,
          sendTimeout: requestOptions.sendTimeout,
          extra: requestOptions.extra,
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else if (response.statusCode == 401) {
        await RefreshTokenService.refreshAccessToken();
        return await addMealPlan(payload);
      } else {
        final errorJson = json.decode(response.data.toString());
        throw DioException(
          requestOptions: response.requestOptions,
          error: errorJson,
          response: response,
        );
      }
    } catch (error) {
      if (error is DioException) {
        if (error.response?.statusCode == 401) {
          await RefreshTokenService.refreshAccessToken();
          return await addMealPlan(payload);
        } else {
          throw Exception('Failed to add meal plan: ${error.response?.data}');
        }
      } else {
        throw Exception('Failed to add meal plan: $error');
      }
    }
  }
}
