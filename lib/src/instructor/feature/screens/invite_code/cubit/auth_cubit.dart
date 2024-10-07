import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:eat_fit/src/instructor/constant/retry_refresh_tokens/retry_refresh_tokens.dart';
import 'package:eat_fit/src/instructor/constant/storage.dart';
import 'package:eat_fit/src/instructor/constant/toaster.dart';
import 'package:eat_fit/src/instructor/feature/screens/invite_code/cubit/auth_service.dart';
import 'package:eat_fit/src/instructor/feature/screens/invite_code/cubit/auth_state.dart';
import 'package:eat_fit/src/instructor/feature/screens/splash/page/splash_screen.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.initial()) {
    _initDioInterceptor();
  }

  late Dio _dio;

  Future<bool> checkAuthentication() async {
    emit(AuthState.loading());
    final bool isAuthenticated = await SecureStorage.isAuthenticated();
    if (isAuthenticated) {
      emit(AuthState.authenticated());
      return true;
    } else {
      emit(AuthState.unauthenticated());
      return false;
    }
  }

  Future<void> accessCode(String email, String password) async {
    emit(AuthState.loading());
    try {
      final Map<String, dynamic> loginResponse =
          await ApiService.accessCode(email, password);
      final String accessToken = loginResponse['access'];
      final String refreshToken = loginResponse['refresh'];
      await SecureStorage.saveTokens(accessToken, refreshToken);
      _persistAuthenticationStatus(true);
      emit(AuthState.authenticated(responseData: loginResponse));
    } catch (e) {
      emit(AuthState.unauthenticated(error: 'Login failed'));
    }
  }

  Future<void> _persistAuthenticationStatus(bool isAuthenticated) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAuthenticated', isAuthenticated);
  }

  Future<void> _initDioInterceptor() async {
    _dio = Dio();
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final accessToken = await SecureStorage.getAccessToken();
          if (accessToken != null) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            try {
              await _refreshToken();
              final requestOptions = e.requestOptions;
              requestOptions.headers['Authorization'] =
                  'Bearer ${await SecureStorage.getAccessToken()}';
              final refreshedResponse = await _dio.request(
                requestOptions.path,
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
              return handler.resolve(refreshedResponse);
            } catch (error) {
              return handler.reject(e);
            }
          }
          return handler.next(e);
        },
      ),
    );
  }

  Future<void> _refreshToken() async {
    final String? refreshToken = await SecureStorage.getRefreshToken();
    if (refreshToken != null) {
      try {
        // final response = await ApiService.refreshToken();
        // final String newAccessToken = response['access'];
        RefreshTokenService.refreshAccessToken();
        _persistAuthenticationStatus(true);
      } catch (e) {
        await SecureStorage.clear();
        emit(AuthState.unauthenticated(error: 'Refresh token failed'));
        await logout();
        ToasterService.error(message: 'Session expired');
      }
    } else {
      emit(AuthState.unauthenticated(error: 'No refresh token found'));
      await logout();
      ToasterService.error(message: 'Session expired');
    }
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final SharedPreferences userType = await SharedPreferences.getInstance();
    final SharedPreferences userId = await SharedPreferences.getInstance();
    final SharedPreferences userName = await SharedPreferences.getInstance();
    final SharedPreferences number = await SharedPreferences.getInstance();
    final SharedPreferences boleanSeen = await SharedPreferences.getInstance();
    final SharedPreferences fcmTokenUser =
        await SharedPreferences.getInstance();
    await prefs.clear();
    await userType.clear();
    await userId.clear();
    await userName.clear();
    await number.clear();
    await fcmTokenUser.clear();
    await boleanSeen.clear();
    await SecureStorage.clear();

    emit(AuthState.unauthenticated());
    Get.offAll(() => const SplashScreenPage());
  }
}
