import 'package:nyxproject/models/User.dart';

class Constant {
  static const BASE_URL = "http://38.60.216.25:5001";
  static const API_URL = "$BASE_URL/api";
  static User? user = null;
  static Map<String, String> headers = {
    "content-type": "application/json",
  };
}