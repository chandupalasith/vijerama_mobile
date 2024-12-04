import 'dart:convert';

class JwtUtil {
  // Decode a JWT token and return the payload as a Map
  static Map<String, dynamic> decode(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception("Invalid JWT token format");
    }

    // Decode the payload
    final payloadBase64 = parts[1];
    final normalized = base64Url.normalize(payloadBase64);
    final payloadString = utf8.decode(base64Url.decode(normalized));

    return json.decode(payloadString) as Map<String, dynamic>;
  }

  // Check if the token is expired
  static bool isTokenExpired(String token) {
    try {
      final payload = decode(token);
      final exp = payload['exp'];
      if (exp == null) {
        throw Exception("Expiration ('exp') claim not found in token");
      }

      // Convert expiration time from seconds to DateTime
      final expiryDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);

      // Check if the current time is after the expiration time
      return DateTime.now().isAfter(expiryDate);
    } catch (error) {
      print("Error while checking token expiration: $error");
      return true; // Assume expired if an error occurs
    }
  }
}