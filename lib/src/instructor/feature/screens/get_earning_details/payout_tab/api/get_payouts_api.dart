// ignore_for_file: use_rethrow_when_possible

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:eat_fit/src/instructor/constant/app_url.dart';
import 'package:eat_fit/src/instructor/constant/retry_refresh_tokens/retry_refresh_tokens.dart';
import 'package:eat_fit/src/instructor/constant/storage.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earning_details/payout_tab/models/get_payouts_models.dart';

class GetPayoutsApi {
  static final Dio _dio = Dio(BaseOptions(baseUrl: ApiUrl.kApiBaseUrl));

  static Future<List<GetPaymentModels>> getPayouts(
      {CancelToken? cancelToken}) async {
    final String endpoint = ApiUrl.kPostPayout;
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
        List<GetPaymentModels> data = (response.data as List).map((e) {
          return GetPaymentModels.fromJson(e as Map<String, dynamic>);
        }).toList();
        return data;
      } else if (response.statusCode == 401) {
        await RefreshTokenService.refreshAccessToken();
        return await getPayouts(cancelToken: cancelToken);
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
      return await getPayouts(cancelToken: cancelToken);
    } catch (error) {
      rethrow;
    }
  }
}