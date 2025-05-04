import 'dart:convert';

import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://dummyjson.com',
    headers: {'Content-Type': 'application/json'},
  ));

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final requestData = {
        'username': username,
        'password': password,
        'expiresInMins': 30,
      };

      final response = await _dio.post(
        '/auth/login',
        data: json.encode(requestData),
      );

      print('Response Status: ${response.statusCode}');
      print('Response Data: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        return response.data;
      } else {
        throw Exception('Failed to log in: ${response.data}');
      }
    } catch (e) {
      print('Login error: $e');
      rethrow;
    }
  }
}
