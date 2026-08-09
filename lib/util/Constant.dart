import 'package:nyxproject/models/User.dart';

class Constant {
  static const BASE_URL = "http://130.94.23.58:5001";
  // static const Tag_URL = "http://130.94.23.58:5000/api";
  
  static const API_URL = "$BASE_URL/api";
  static User? user = null;
  static Map<String, String> headers = {
    "content-type": "application/json",
  };
}