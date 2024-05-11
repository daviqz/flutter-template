import 'package:mobiletemplate/enums/toast.enum.dart';
import 'package:mobiletemplate/utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SystemToast {
  static void show(String message, ToastEnum type) {
    Color backgroundColor = ColorsUtils.black;
    String webBgColor = toHex(backgroundColor);
    switch (type) {
      case ToastEnum.error:
        backgroundColor = ColorsUtils.red;
        webBgColor = toHex(backgroundColor);
        break;
      case ToastEnum.success:
        backgroundColor = ColorsUtils.green;
        webBgColor = toHex(backgroundColor);
        break;
      case ToastEnum.info:
        backgroundColor = ColorsUtils.blue;
        webBgColor = toHex(backgroundColor);
        break;
      case ToastEnum.warning:
        backgroundColor = ColorsUtils.yellow;
        webBgColor = toHex(backgroundColor);
        break;
    }

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: ColorsUtils.white,
      webBgColor: webBgColor,
    );
  }
}

String toHex(Color color) {
  return '#${color.red.toRadixString(16).padLeft(2, '0')}${color.green.toRadixString(16).padLeft(2, '0')}${color.blue.toRadixString(16).padLeft(2, '0')}';
}
