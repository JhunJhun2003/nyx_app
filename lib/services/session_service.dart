// lib/services/session_service.dart
import 'package:flutter/material.dart';
import 'package:nyxproject/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SessionService extends ChangeNotifier {
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyUserData = 'user_data';
  static const String _keyUserToken = 'user_token';
  static const String _keyTokenExpiry = 'token_expiry';
  
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
    print(" Saving session - User: ${user.name}, ID: ${user.id}");
    
    final userJson = user.toJson();
    
    //  Calculate token expiry (e.g., 7 days from now)
    final expiryTime = DateTime.now().add(const Duration(days: 7)).millisecondsSinceEpoch;
    
    await _prefs!.setBool(_keyIsLoggedIn, true);
    await _prefs!.setString(_keyUserToken, token);
    await _prefs!.setString(_keyUserData, jsonEncode(userJson));
    await _prefs!.setInt(_keyTokenExpiry, expiryTime);
    
    _isLoggedIn = true;
    _currentUser = user;
    
    print(" Session saved, token expires at: ${DateTime.fromMillisecondsSinceEpoch(expiryTime)}");
    notifyListeners();
  }
  
  Future<void> saveToken(String token) async {
    await _prefs!.setString(_keyUserToken, token);
    //  Update expiry when token refreshes
    final expiryTime = DateTime.now().add(const Duration(days: 7)).millisecondsSinceEpoch;
    await _prefs!.setInt(_keyTokenExpiry, expiryTime);
    notifyListeners();
  }
  
  bool isLoggedIn() {
    final token = _prefs?.getString(_keyUserToken);
    final isLoggedIn = _prefs?.getBool(_keyIsLoggedIn) ?? false;
    final hasToken = token != null && token.isNotEmpty;
    
    //  Check if token is expired
    if (isTokenExpired()) {
      return false;
    }
    
    return isLoggedIn && hasToken;
  }
  
  //  Check if token is expired
  bool isTokenExpired() {
    final expiryTime = _prefs?.getInt(_keyTokenExpiry);
    if (expiryTime == null) return false;
    
    final expiryDate = DateTime.fromMillisecondsSinceEpoch(expiryTime);
    final isExpired = DateTime.now().isAfter(expiryDate);
    
    if (isExpired) {
      print(" Token expired at: $expiryDate");
    }
    
    return isExpired;
  }
  
  //  Get token expiry date
  DateTime? getTokenExpiry() {
    final expiryTime = _prefs?.getInt(_keyTokenExpiry);
    if (expiryTime == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(expiryTime);
  }
  
  User? getStoredUser() {
    final userData = _prefs?.getString(_keyUserData);

    if (userData != null && userData.isNotEmpty) {
      try {
        final jsonData = jsonDecode(userData);
        return User.fromJson(jsonData);
      } catch (e) {
        print(" Error parsing user data: $e");
        return null;
      }
    }
    return null;
  }
  
  String? getToken() {
    //  Check if token is expired before returning
    if (isTokenExpired()) {
      print(" Token is expired, returning null");
      return null;
    }
    return _prefs?.getString(_keyUserToken);
  }
  
  Future<void> logout() async {
    await _prefs?.remove(_keyIsLoggedIn);
    await _prefs?.remove(_keyUserData);
    await _prefs?.remove(_keyUserToken);
    await _prefs?.remove(_keyTokenExpiry);
    _isLoggedIn = false;
    _currentUser = null;
    notifyListeners();
  }
  
  Future<void> clearSession() async {
    await logout();
  }
}