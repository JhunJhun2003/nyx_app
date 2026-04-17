import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nyxproject/util/Constant.dart';

class Api {
  // Login user - returns complete response data
  static Future<Map<String, dynamic>> loginUser({
    required String emailOrphone,
    required String password,
  }) async {
    final Uri uri = Uri.parse("${Constant.API_URL}/auth/login");
    final String body = jsonEncode({
      "emailOrphone": emailOrphone.trim(),
      "password": password,
    });

    try {
      final http.Response response = await http.post(
        uri,
        headers: Constant.headers,
        body: body,
      );

      if (response.body.isEmpty) {
        return {
          'success': false,
          'message': 'Empty response from server',
        };
      }
      
      final dynamic responseData = jsonDecode(response.body);

      if (responseData is Map<String, dynamic>) {
        // Check for success field
        bool isSuccess = false;
        if (responseData["success"] is bool) {
          isSuccess = responseData["success"];
        } else if (responseData["success"] is String) {
          isSuccess = responseData["success"].toLowerCase() == "true";
        } else if (response.statusCode >= 200 && response.statusCode < 300) {
          isSuccess = true;
        }

        return {
          'success': isSuccess,
          'data': responseData, // Return full response data
          'message': responseData['message'] ?? (isSuccess ? 'Login successful' : 'Login failed'),
        };
      }

      return {
        'success': response.statusCode >= 200 && response.statusCode < 300,
        'data': responseData,
        'message': 'Login ${response.statusCode >= 200 && response.statusCode < 300 ? "successful" : "failed"}',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

  // Signup user
  static Future<Map<String, dynamic>> signupUser({
    required String name,
    required String email,
    required String phone,
    required String dateOfBirth,
    required String password,
  }) async {
    final Uri uri = Uri.parse("${Constant.API_URL}/auth/createUser"); // Adjust endpoint as needed
    final String body = jsonEncode({
      "name": name,
      "email": email.trim(),
      "phone": phone,
      "dateOfBirth": dateOfBirth,
      "password": password,
    });

    try {
      final http.Response response = await http.post(
        uri,
        headers: Constant.headers,
        body: body,
      );

      if (response.body.isEmpty) {
        return {
          'success': false,
          'message': 'Empty response from server',
        };
      }
      
      final dynamic responseData = jsonDecode(response.body);

      if (responseData is Map<String, dynamic>) {
        bool isSuccess = responseData["success"] ?? (response.statusCode >= 200 && response.statusCode < 300);
        
        return {
          'success': isSuccess,
          'data': responseData,
          'message': responseData['message'] ?? (isSuccess ? 'Signup successful' : 'Signup failed'),
        };
      }

      return {
        'success': response.statusCode >= 200 && response.statusCode < 300,
        'data': responseData,
        'message': 'Signup ${response.statusCode >= 200 && response.statusCode < 300 ? "successful" : "failed"}',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }
}