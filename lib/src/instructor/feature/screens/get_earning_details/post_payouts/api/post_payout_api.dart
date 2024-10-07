import 'package:dio/dio.dart';
import 'package:eat_fit/src/instructor/constant/app_url.dart';
import 'package:eat_fit/src/instructor/constant/retry_refresh_tokens/retry_refresh_tokens.dart';
import 'package:eat_fit/src/instructor/constant/storage.dart';
import 'package:eat_fit/src/instructor/feature/screens/get_earning_details/post_payouts/models/post_payouts_models.dart';

class PostPayoutApiClass {
  static final Dio _dio = Dio(BaseOptions(baseUrl: ApiUrl.kApiBaseUrl));

  static Future<PostPayoutModels> postPayout(String amount) async {
    final RequestOptions requestOptions =
        RequestOptions(path: ApiUrl.kPostPayout);
    final String? accessToken = await SecureStorage.getAccessToken();

    if (accessToken != null) {
      requestOptions.headers['Authorization'] = 'Bearer $accessToken';
    }

    try {
      final response = await _dio.request(
        ApiUrl.kPostPayout,
        options: Options(
          method: 'POST',
          headers: requestOptions.headers,
          responseType: ResponseType.json,
          contentType: Headers.jsonContentType,
          validateStatus: (status) => status! < 500,
        ),
        data: {'amount': amount},
      );

      if (response.statusCode == 201) {
        final responseData = response.data;
        if (responseData != null && responseData is Map<String, dynamic>) {
          final body = PostPayoutModels.fromJson(responseData);
          return body;
        } else {
          throw Exception('Invalid response data format');
        }
      } else if (response.statusCode == 401) {
        await RefreshTokenService.refreshAccessToken();
        return await postPayout(amount);
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
          final errorMessage = responseData['msg'] ?? 'Error, Please try again';
          throw Exception(errorMessage);
        } else {
          throw Exception('Invalid error response format');
        }
      } else {
        throw Exception('Network error: ${error.message}');
      }
    } catch (error) {
      throw Exception('Failed to fetch data: $error');
    }
  }
}
