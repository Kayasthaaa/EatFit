import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eat_fit/src/instructor/constant/app_url.dart';
import 'package:eat_fit/src/instructor/constant/retry_refresh_tokens/retry_refresh_tokens.dart';
import 'package:eat_fit/src/instructor/constant/storage.dart';
import 'package:eat_fit/src/instructor/feature/screens/update_profile/models/profile_update_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfileApiClass {
  static final Dio _dio = Dio(BaseOptions(baseUrl: ApiUrl.kApiBaseUrl));

  static Future<ProfileUpdate> updateProfile(
    String name,
    String bio,
    File? image,
  ) async {
    SharedPreferences userId = await SharedPreferences.getInstance();
    int? id = userId.getInt('id');
    String endpoint = '/user/$id/';
    final RequestOptions requestOptions = RequestOptions(path: endpoint);
    final String? accessToken = await SecureStorage.getAccessToken();

    if (accessToken != null) {
      requestOptions.headers['Authorization'] = 'Bearer $accessToken';
    }

    try {
      FormData formData = FormData.fromMap({
        'full_name': name,
        'bio': bio,
      });

      if (image != null) {
        String fileExtension = image.path.split('.').last;
        formData.files.add(MapEntry(
          'profile_picture',
          await MultipartFile.fromFile(
            image.path,
            filename: 'profile_picture.$fileExtension',
          ),
        ));
      }

      final response = await _dio.request(
        endpoint,
        options: Options(
          method: 'PATCH',
          headers: requestOptions.headers,
          contentType: Headers.formUrlEncodedContentType,
          validateStatus: (status) => status! < 500,
        ),
        data: formData,
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData != null && responseData is Map<String, dynamic>) {
          final body = ProfileUpdate.fromJson(responseData);

          return body;
        } else {
          throw Exception('Invalid response data format');
        }
      } else if (response.statusCode == 401) {
        await RefreshTokenService.refreshAccessToken();
        return await updateProfile(name, bio, image);
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
      throw Exception('Failed to fetch data: $error');
    }
  }
}
