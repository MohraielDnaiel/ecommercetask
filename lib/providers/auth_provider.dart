import 'package:flutter/material.dart';
import 'package:flutterapp/domain/repositories/auth_repository.dart';
class AuthProvider with ChangeNotifier {
  final AuthRepository _authRepository;

  AuthProvider(this._authRepository);

  Future<String?> login(String username, String password) async {
    // Call the login method in AuthRepository
    return await _authRepository.login(username, password); // This should return the access token (String)
  }
}
