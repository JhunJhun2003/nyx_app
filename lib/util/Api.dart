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
        return {'success': false, 'message': 'Empty response from server'};
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
          'message':
              responseData['message'] ??
              (isSuccess ? 'Login successful' : 'Login failed'),
        };
      }

      return {
        'success': response.statusCode >= 200 && response.statusCode < 300,
        'data': responseData,
        'message':
            'Login ${response.statusCode >= 200 && response.statusCode < 300 ? "successful" : "failed"}',
      };
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
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
  final Uri uri = Uri.parse("${Constant.API_URL}/auth/createUser");
  final String body = jsonEncode({
    "name": name,
    "email": email.trim(),
    "phone": phone,
    "dateOfBirth": dateOfBirth,
    "password": password,
  });

  try {
    print("Signup URL: $uri");
    print("Signup Body: $body");
    
    final http.Response response = await http.post(
      uri,
      headers: Constant.headers,
      body: body,
    ).timeout(const Duration(seconds: 30));

    print("Response Status: ${response.statusCode}");
    print("Response Body: ${response.body}");
    
    if (response.body.isEmpty) {
      return {
        'success': false,
        'message': 'Empty response from server',
      };
    }
    
    dynamic responseData;
    try {
      responseData = jsonDecode(response.body);
    } catch (e) {
      // If response is not JSON (e.g., HTML error page from backend)
      return {
        'success': false,
        'message': response.statusCode == 500 && response.body.contains("User already exist") 
            ? "User already exists with this email or phone number"
            : 'Server error: Invalid response format',
      };
    }

    if (responseData is Map<String, dynamic>) {
      // Check for 'status' field (API returns "status": "success")
      final bool isSuccess = (responseData['status'] == 'success') ||
                             (responseData['success'] == true) ||
                             (response.statusCode >= 200 && response.statusCode < 300);
      
      // Extract tempToken from nested token object
      String tempToken = '';
      if (responseData['token'] != null && responseData['token'] is Map<String, dynamic>) {
        tempToken = responseData['token']['tempToken']?.toString() ?? '';
      }
      
      return {
        'success': isSuccess,
        'data': responseData,
        'tempToken': tempToken,  // Add this
        'message': responseData['token']?['message']?.toString() ?? 
                   responseData['message']?.toString() ?? 
                   (isSuccess ? 'Signup successful' : 'Signup failed'),
      };
    }

    return {
      'success': response.statusCode >= 200 && response.statusCode < 300,
      'data': responseData,
      'message': 'Signup ${response.statusCode >= 200 && response.statusCode < 300 ? "successful" : "failed"}',
    };
  } catch (e) {
    print("Signup Error: $e");
    return {
      'success': false,
      'message': 'Network error, please try again.',
    };
  }
}
  static Future<Map<String, dynamic>> sendOtpCode({
    required String email,
  }) async {
    final Uri uri = Uri.parse("${Constant.API_URL}/auth/sendOtp");
    final String body = jsonEncode(<String, dynamic>{"email": email.trim()});

    try {
      final http.Response response = await http.post(
        uri,
        headers: Constant.headers,
        body: body,
      );

      if (response.body.isEmpty) {
        return <String, dynamic>{
          'success': response.statusCode >= 200 && response.statusCode < 300,
          'message': 'OTP sent',
        };
      }

      dynamic responseData;
      try {
        responseData = jsonDecode(response.body);
      } catch (e) {
        return <String, dynamic>{
          'success': false,
          'message': 'Server error: Invalid response format',
        };
      }

      if (responseData is Map<String, dynamic>) {
        final dynamic rawSuccess = responseData['success'];
        final bool success = rawSuccess is bool
            ? rawSuccess
            : response.statusCode >= 200 && response.statusCode < 300;
        return <String, dynamic>{
          'success': success,
          'data': responseData,
          'message':
              responseData['message'] ??
              (success ? 'OTP sent' : 'Failed to send OTP'),
        };
      }

      return <String, dynamic>{
        'success': response.statusCode >= 200 && response.statusCode < 300,
        'message': response.statusCode >= 200 && response.statusCode < 300
            ? 'OTP sent'
            : 'Failed to send OTP',
      };
    } catch (e) {
      return <String, dynamic>{'success': false, 'message': 'Error: $e'};
    }
  }

  static Future<Map<String, dynamic>> verifyOtp({
    required String otp,
    required String tempToken,
  }) async {
    final Uri uri = Uri.parse("${Constant.API_URL}/auth/verifyOtp");
    final String body = jsonEncode(<String, dynamic>{
      "otp": otp.trim(),
      "tempToken": tempToken.trim(),
    });

    try {
      final http.Response response = await http.post(
        uri,
        headers: Constant.headers,
        body: body,
      );

      if (response.body.isEmpty) {
        return <String, dynamic>{
          'success': false,
          'message': 'Empty response from server',
        };
      }

      dynamic responseData;
      try {
        responseData = jsonDecode(response.body);
      } catch (e) {
        return <String, dynamic>{
          'success': false,
          'message': 'Server error: Invalid response format',
        };
      }

      if (responseData is Map<String, dynamic>) {
        final dynamic rawStatus = responseData['status'];
        final dynamic rawSuccess = responseData['success'];
        final bool success =
            (rawStatus is String && rawStatus.toLowerCase() == "success") ||
            (rawSuccess is bool && rawSuccess) ||
            response.statusCode >= 200 && response.statusCode < 300;
        return <String, dynamic>{
          'success': success,
          'data': responseData,
          'message':
              responseData['message'] ??
              (success ? 'Verification successful' : 'Invalid OTP'),
        };
      }

      return <String, dynamic>{
        'success': response.statusCode >= 200 && response.statusCode < 300,
        'message': response.statusCode >= 200 && response.statusCode < 300
            ? 'Verification successful'
            : 'OTP verification failed',
      };
    } catch (e) {
      return <String, dynamic>{'success': false, 'message': 'Error: $e'};
    }
  }
}
