import 'package:flutter/material.dart';
import 'package:nyxproject/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SessionService extends ChangeNotifier {  // ✅ Add ChangeNotifier
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyUserData = 'user_data';
  static const String _keyUserToken = 'user_token';
  
  late SharedPreferences _prefs;
  
  // Initialize SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    notifyListeners();
  }
  
  // Save user session after login
  Future<void> saveSession(User user, String token) async {
    await _prefs.setBool(_keyIsLoggedIn, true);
    await _prefs.setString(_keyUserToken, token);
    await _prefs.setString(_keyUserData, jsonEncode(user.toJson()));
    notifyListeners();  // ✅ Notify listeners
  }
  
  // Save token only
  Future<void> saveToken(String token) async {
    await _prefs.setString(_keyUserToken, token);
    notifyListeners();  // ✅ Notify listeners
  }
  
  // Check if user is logged in
  bool isLoggedIn() {
    return _prefs.getBool(_keyIsLoggedIn) ?? false;
  }
  
  // Get stored user
  User? getStoredUser() {
    final userData = _prefs.getString(_keyUserData);
    if (userData != null) {
      return User.fromJson(jsonDecode(userData));
    }
    return null;
  }
  
  // Get token
  String? getToken() {
    return _prefs.getString(_keyUserToken);
  }
  
  // Clear session on logout
  Future<void> logout() async {
    await _prefs.remove(_keyIsLoggedIn);
    await _prefs.remove(_keyUserData);
    await _prefs.remove(_keyUserToken);
    notifyListeners();  // ✅ Notify listeners
  }
}