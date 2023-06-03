import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SnackbarUtils {
  static void showSnackbar(
      String title, String message, SnackPosition position, Duration duration) {
    Get.snackbar(
      title,
      message,
      backgroundColor:
          Theme.of(Get.context!).colorScheme.surface.withOpacity(0.9),
      colorText: Theme.of(Get.context!).colorScheme.primary,
      duration: duration,
      snackPosition: position,
      boxShadows: [
        BoxShadow(
          color: Theme.of(Get.context!).colorScheme.onSurface.withOpacity(0.4),
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 1), // changes position of shadow
        ),
      ],
    );
  }

  static void dialog() {
    Get.dialog(CircularProgressIndicator());
    Future.delayed(Duration(seconds: 3), () {
      Get.back(closeOverlays: true);
    });
  }
}
