import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:eat_fit/src/instructor/constant/app_url.dart';
import 'package:eat_fit/src/instructor/constant/retry_refresh_tokens/retry_refresh_tokens.dart';
import 'package:eat_fit/src/instructor/constant/storage.dart';
import 'package:eat_fit/src/user/feature/screen/user_meal_plan_details/models/user_meal_details_models.dart';

class GetUserPlansDetailsApi {
  static final Dio _dio = Dio(BaseOptions(baseUrl: ApiUrl.kApiBaseUrl));

  static Future<UserMealDetailsModels> getUserPlansDetails(
      {required int id}) async {
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
        UserMealDetailsModels data =
            UserMealDetailsModels.fromJson(response.data);

        return data;
      } else if (response.statusCode == 401) {
        await RefreshTokenService.refreshAccessToken();
        return await getUserPlansDetails(id: id);
      } else {
        final errorJson = json.decode(response.data.toString());
        throw DioException(
          requestOptions: response.requestOptions,
          error: errorJson,
          response: response,
        );
      }
    } on DioException {
      await RefreshTokenService.refreshAccessToken();
      return await getUserPlansDetails(id: id);
    } catch (error) {
      throw Exception('Failed to fetch data: $error');
    }
  }
}
