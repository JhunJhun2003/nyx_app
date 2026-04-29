// lib/services/session_service.dart
import 'package:flutter/material.dart';
import 'package:nyxproject/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SessionService extends ChangeNotifier {
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyUserData = 'user_data';
  static const String _keyUserToken = 'user_token';
  
  SharedPreferences? _prefs;
  bool _isLoggedIn = false;
  User? _currentUser;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _isLoggedIn = _prefs!.getBool(_keyIsLoggedIn) ?? false;
    _currentUser = getStoredUser();
    notifyListeners();
  }
  
  Future<void> saveSession(User user, String token) async {
    print("📝 Saving session - User: ${user.name}, ID: ${user.id}");
    
    final userJson = user.toJson();
    print("📝 User JSON: $userJson");
    
    await _prefs!.setBool(_keyIsLoggedIn, true);
    await _prefs!.setString(_keyUserToken, token);
    await _prefs!.setString(_keyUserData, jsonEncode(userJson));
    
    _isLoggedIn = true;
    _currentUser = user;
    
    print("✅ Session saved");
    notifyListeners();
  }
  
  Future<void> saveToken(String token) async {
    await _prefs!.setString(_keyUserToken, token);
    notifyListeners();
  }
  
  bool isLoggedIn() {
    final token = _prefs?.getString(_keyUserToken);
    final isLoggedIn = _prefs?.getBool(_keyIsLoggedIn) ?? false;
    final hasToken = token != null && token.isNotEmpty;
    return isLoggedIn && hasToken;
  }
  
  User? getStoredUser() {
    final userData = _prefs?.getString(_keyUserData);
    print("📖 Retrieving user data: $userData");
    
    if (userData != null && userData.isNotEmpty) {
      try {
        final jsonData = jsonDecode(userData);
        return User.fromJson(jsonData);
      } catch (e) {
        print("❌ Error parsing user data: $e");
        return null;
      }
    }
    return null;
  }
  
  String? getToken() {
    return _prefs?.getString(_keyUserToken);
  }
  
  Future<void> logout() async {
    await _prefs?.remove(_keyIsLoggedIn);
    await _prefs?.remove(_keyUserData);
    await _prefs?.remove(_keyUserToken);
    _isLoggedIn = false;
    _currentUser = null;
    notifyListeners();
  }
}