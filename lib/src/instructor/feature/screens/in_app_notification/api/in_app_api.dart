// ignore_for_file: use_rethrow_when_possible

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:eat_fit/src/instructor/constant/app_url.dart';
import 'package:eat_fit/src/instructor/constant/retry_refresh_tokens/retry_refresh_tokens.dart';
import 'package:eat_fit/src/instructor/constant/storage.dart';

class NotificationApi {
  static final Dio _dio = Dio(BaseOptions(baseUrl: ApiUrl.kApiBaseUrl));

  static Future<List<dynamic>> getNotifications(
      {CancelToken? cancelToken}) async {
    final String endpoint =
        ApiUrl.kGetNotificationMe; // Replace with your actual endpoint
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
        cancelToken: cancelToken,
      );

      if (response.statusCode == 200) {
        return response.data as List<dynamic>;
      } else if (response.statusCode == 401) {
        await RefreshTokenService.refreshAccessToken();
        return await getNotifications(cancelToken: cancelToken);
      } else {
        final errorJson = json.decode(response.data.toString());

        throw DioException(
          requestOptions: response.requestOptions,
          error: errorJson,
          response: response,
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        throw e; // Rethrow cancellation error
      }
      await RefreshTokenService.refreshAccessToken();
      return await getNotifications(cancelToken: cancelToken);
    } catch (error) {
      rethrow;
    }
  }
}
