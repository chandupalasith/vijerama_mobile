import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_constants.dart';
import '../utils/storage_util.dart';
import '../utils/jwt_util.dart';


class AuthService {
  // Login
  static Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': username, 'password': password}),
    );

    print('CODE');
    print(response.statusCode);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final token = data['token'];
      print('INFO : $data');

      // Save token securely
      await StorageUtil.saveToken('jwt', token);

      // Decode token and store user ID
      final payload = JwtUtil.decode(token);
      print('Payload : $payload');
      final userId = payload['id'];


      if (userId != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('user_id', userId);
      // Save user ID to shared preferences
        print('INFO: User ID $userId stored in SharedPreferences');
      } else {
        print('ERROR: User ID not found in token');
      }

      return true;
    } else {
      print('INFO :');
      return false; // Login failed
    }
  }

  // Logout
  static Future<void> logout() async {
    try {
      // Clear token from local storage
      await StorageUtil.deleteToken('jwt');
      print('INFO: Token cleared locally');

      // Clear user ID from shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_id');
      print('INFO: User ID cleared from SharedPreferences');
    } catch (error) {
      print('EXCEPTION during logout: $error');
    }
  }

  // Check if user is authenticated
  static Future<bool> isAuthenticated() async {
    final token = await StorageUtil.getToken('jwt');
    if (token == null || JwtUtil.isTokenExpired(token)) {
      return false;
    }
    return true;
  }

  // Get user ID from shared preferences
  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }
}