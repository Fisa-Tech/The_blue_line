import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastService {
  static final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static GlobalKey<ScaffoldMessengerState> get scaffoldMessengerKey =>
      _scaffoldMessengerKey;

  static void showError(String message) {
    _showSnackBar(message, Colors.red);
  }

  static void showSuccess(String message) {
    _showSnackBar(message, Colors.green);
  }

  static void showInfo(String message) {
    _showSnackBar(message, Colors.blue);
  }

  static void _showSnackBar(String message, Color color) {
    final snackBar = SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
    );

    _scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }
}
