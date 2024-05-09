import 'package:authorspace/enums/toast.enum.dart';
import 'package:authorspace/utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SystemToast {
  static void show(String message, ToastEnum type) {
    Color backgroundColor = ColorsUtils.black; // Initialized with a default value
    switch (type) {
      case ToastEnum.error:
        backgroundColor = ColorsUtils.red;
        break;
      case ToastEnum.success:
        backgroundColor = ColorsUtils.green;
        break;
      case ToastEnum.info:
        backgroundColor = ColorsUtils.blue;
        break;
      case ToastEnum.warning:
        backgroundColor = ColorsUtils.yellow;
        break;
    }

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: ColorsUtils.white,
    );
  }
}
