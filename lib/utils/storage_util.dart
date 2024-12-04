import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageUtil {
  static final _storage = FlutterSecureStorage();

  // Save token
  static Future<void> saveToken(String key, String token) async {
    await _storage.write(key: key, value: token);
  }

  // Get token
  static Future<String?> getToken(String key) async {
    return await _storage.read(key: key);
  }

  // Delete token
  static Future<void> deleteToken(String key) async {
    await _storage.delete(key: key);
  }
}