import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Obx(() => Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.surface.withAlpha(100),
                  ],
                  stops: const [0.0, 0.9],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(600),
                ),
              ),
              height: controller.leftContainerHeight.value,
              width: controller.leftContainerWidth.value,
            ),
          ),
          Center(
            child: Container(
              width: Get.width * 0.5,
              height: Get.height * 0.15,
              child: Image.asset(
                'assets/images/infood.png',
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).colorScheme.surface.withAlpha(240),
                    Theme.of(context).colorScheme.primary,
                  ],
                  stops: const [0.0, 0.9],
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(600),
                ),
              ),
              height: controller.rightContainerHeight.value,
              width: controller.rightContainerWidth.value,
            ),
          ),
        ],
      )),
    );
  }
}
