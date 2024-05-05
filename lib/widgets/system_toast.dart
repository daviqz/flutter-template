import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SystemToast {
  static void show(String message, String type) {
    Color backgroundColor = Colors.black; // Initialized with a default value
    switch (type) {
      case 'error':
        backgroundColor = Colors.red;
        break;
      case 'success':
        backgroundColor = Colors.green;
        break;
      case 'info':
        backgroundColor = Colors.blue;
        break;
    }

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
    );
  }
}
