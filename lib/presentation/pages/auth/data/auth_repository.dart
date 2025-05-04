import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutterapp/core/network/api_services.dart';

class AuthRepository {
  final ApiService _apiService;

  AuthRepository(this._apiService);

  Future<String?> login(String username, String password) async {
    try {
      final result = await _apiService.login(username, password);

      // Get access token from the response
      String accessToken = result['accessToken'];  // This should be a String

      // Store the access token in shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', accessToken);

      return accessToken;  // Return the access token (String)
    } catch (e) {
     
      return null;  // If login fails, return null
    }
  }
}
