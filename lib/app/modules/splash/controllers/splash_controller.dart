import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_food/app/routes/app_pages.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  RxBool isLogoVisible = true.obs;
  RxDouble leftContainerWidth = (Get.width * 0.3).obs;
  RxDouble rightContainerWidth = (Get.width * 0.4).obs;
  RxDouble leftContainerHeight = (Get.height * 0.3).obs;
  RxDouble rightContainerHeight = (Get.height * 0.4).obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    await _controller.forward().whenComplete(() {
      leftContainerWidth.value = Get.width * 0.7;
      rightContainerWidth.value = Get.width;
      leftContainerHeight.value = Get.height * 0.7;
      rightContainerHeight.value = Get.height * 0.9 + 200;
    });
    await Future.delayed(Duration(milliseconds: 200));
    await _controller.reverse().whenComplete(() {
      leftContainerWidth.value = Get.width * 0.3;
      rightContainerWidth.value = Get.width * 0.4;
      leftContainerHeight.value = Get.height * 0.4;
      rightContainerHeight.value = Get.height * 0.4;
    }).then((value) => Get.offNamed(Routes.HOME));
  }

  @override
  void onClose() {
    _controller.dispose();
    super.onClose();
  }
}
