import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token'); 

    if (token != null) {
      return token;
    } else {
      throw Exception('No token found');
    }
  }
}
