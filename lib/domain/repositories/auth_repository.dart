import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutterapp/core/network/api_services.dart';

class AuthRepository {
  final ApiService _apiService;

  AuthRepository(this._apiService);

Future<String?> login(String username, String password) async {
  try {
    final result = await _apiService.login(username, password);
    print('Login API response: $result');

    if (result.containsKey('accessToken')) {
      String accessToken = result['accessToken'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', accessToken);
      print('Access token stored successfully');
      return accessToken;
    } else {
      print('accessToken not found in response');
      return null;
    }
  } catch (e) {
    print('Login error: $e');
    return null;
  }
}


}
