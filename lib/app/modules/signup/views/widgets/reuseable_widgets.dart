import 'package:flutter/material.dart';
import 'package:in_food/app/modules/signup/controllers/signup_controller.dart';
import 'package:get/get.dart';

class ReusedWidgets {
  static Widget getBackIcon(SignupController controller) {
    return Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Theme.of(Get.context!).colorScheme.onSurface),
          onPressed: () {
            controller.getBack();
          },
        ));
  }
}
