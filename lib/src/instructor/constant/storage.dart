import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _secureStorage = FlutterSecureStorage();
  static const _accessTokenKey = 'accessToken';
  static const _refreshTokenKey = 'refreshToken';

  static Future<void> saveTokens(
      String accessToken, String refreshToken) async {
    await _secureStorage.write(key: _accessTokenKey, value: accessToken);
    await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
  }

  static Future<bool> isAuthenticated() async {
    final accessToken = await _secureStorage.read(key: _accessTokenKey);
    final refreshToken = await _secureStorage.read(key: _refreshTokenKey);
    return accessToken != null && refreshToken != null;
  }

  static Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: _accessTokenKey);
  }

  static Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: _refreshTokenKey);
  }

  static Future<void> updateAccessToken(String newAccessToken) async {
    await _secureStorage.write(key: _accessTokenKey, value: newAccessToken);
  }

  static Future<void> clear() async {
    await _secureStorage.deleteAll();
  }
}
