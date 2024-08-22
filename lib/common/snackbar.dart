// ignore_for_file: non_constant_identifier_names, file_names

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

getSnackBar(String message, {String? title, bool success = true}) {
  success
      ? MotionToast.success(
          borderRadius: 5,
          animationType: AnimationType.fromTop,
          position: MotionToastPosition.top,
          title: Text(title ?? "Success"),
          description: Text(message),
        ).show(Get.context!)
      : MotionToast.error(
          borderRadius: 5,
          animationType: AnimationType.fromTop,
          position: MotionToastPosition.top,
          title: Text(title ?? "Error"),
          description: Text(message),
        ).show(Get.context!);
}

errorMessage() => getSnackBar('No Internet Connection', success: false);
