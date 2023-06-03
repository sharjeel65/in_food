import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height * 0.15,
              ),
              Center(
                child: Container(
                  width: Get.width * 0.34,
                  height: Get.height * 0.3,
                  child: Image.asset(
                    'assets/images/infood.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Text(
                "Welcome to InFood",
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.surface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              InkWell(
                onTap: () {
                  Get.find<HomeController>().onSignupTapped();
                },
                child: Container(
                  width: Get.width * 0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.surface,
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0.sp),
                    child: Center(
                      child: Text(
                        "Signup",
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              InkWell(
                onTap: () {
                  Get.find<HomeController>().onLoginTapped();
                },
                child: Container(
                  width: Get.width * 0.7,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.0.sp),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text("Or Login with",
                  style: GoogleFonts.montserrat(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimary
                        .withOpacity(0.8),
                  )),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: IconButton(
                      onPressed: () {
                         controller.onFacebookLoginTapped();
                      },
                      icon: Image.asset(
                        'assets/images/facebook.png',
                        height: 30.h,
                      ),
                    ),
                  ),
                  Container(
                    child: IconButton(
                      onPressed: () {
                        controller.onGoogleLoginTapped();
                      },
                      icon: Image.asset(
                        'assets/images/google.png',
                        height: 30.h,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
