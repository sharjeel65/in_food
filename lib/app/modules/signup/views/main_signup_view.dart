import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_food/app/routes/app_pages.dart';
import '../controllers/signup_controller.dart';

class MainSignupView extends GetView<SignupController> {
  const MainSignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: SingleChildScrollView(
          child: IntrinsicHeight(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: Get.height,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.08,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Spacer(
                        flex: 1,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10.h, right: 30.w),
                        child: Image.asset(
                          'assets/images/infood.png',
                          height: 50.sp,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: Get.width * 0.85,
                      minHeight: Get.height * 0.65,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GetBuilder<SignupController>(builder: (controller) {
                      return Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: Get.height * 0.04,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 25.w,
                                ),
                                child: Text(
                                  'Signup',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 30,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.04,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 28.w,
                                ),
                                child: Text(
                                  'NAME',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 10.sp,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.7),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              // focusNode: controller.emailFocusNode,
                              // controller: controller.emailController,
                              // validator: (value) => Validator.validateEmail(
                              //   value!,
                              // ),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  left: 5.w,
                                  right: 5.w,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withGreen(150),
                                  ),
                                  borderRadius: BorderRadius.circular(5.sp),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                    Theme.of(context).colorScheme.primary,
                                  ),
                                  borderRadius: BorderRadius.circular(5.sp),
                                ),
                                fillColor:
                                Theme.of(context).colorScheme.surface,
                                filled: true,
                                hintText: 'Name',
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15.sp,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.2),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                  borderRadius: BorderRadius.circular(5.sp),
                                ),
                                constraints: BoxConstraints(
                                  minHeight: 60.h,
                                  minWidth: 50.w,
                                  maxWidth: Get.width * 0.7,
                                  maxHeight: 80.h,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 28.w,
                                ),
                                child: Text(
                                  'EMAIL ADDRESS',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 10.sp,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.7),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              // focusNode: controller.emailFocusNode,
                              // controller: controller.emailController,
                              // validator: (value) => Validator.validateEmail(
                              //   value!,
                              // ),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  left: 5.w,
                                  right: 5.w,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withGreen(150),
                                  ),
                                  borderRadius: BorderRadius.circular(5.sp),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  borderRadius: BorderRadius.circular(5.sp),
                                ),
                                fillColor:
                                    Theme.of(context).colorScheme.surface,
                                filled: true,
                                hintText: 'Email Address',
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15.sp,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.2),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                  borderRadius: BorderRadius.circular(5.sp),
                                ),
                                constraints: BoxConstraints(
                                  minHeight: 60.h,
                                  minWidth: 50.w,
                                  maxWidth: Get.width * 0.7,
                                  maxHeight: 80.h,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 28.w,
                                ),
                                child: Text(
                                  'PASSWORD',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 10.sp,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.7),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            GetBuilder<SignupController>(builder: (controller) {
                              return TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                // focusNode: controller.passwordFocusNode,
                                controller: controller.passwordController,
                                obscureText: !controller.passwordVisible,
                                // validator: (value) =>
                                //     Validator.validatePassword(
                                //   value!,
                                // ),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                                decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                    ),
                                    borderRadius: BorderRadius.circular(5.sp),
                                  ),
                                  contentPadding: EdgeInsets.only(
                                    left: 5.w,
                                    right: 5.w,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withGreen(150),
                                    ),
                                    borderRadius: BorderRadius.circular(5.sp),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    borderRadius: BorderRadius.circular(5.sp),
                                  ),
                                  fillColor:
                                      Theme.of(context).colorScheme.surface,
                                  filled: true,
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15.sp,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.2),
                                  ),
                                  constraints: BoxConstraints(
                                    minHeight: 50.h,
                                    minWidth: 50.w,
                                    maxWidth: Get.width * 0.7,
                                    maxHeight: 80.h,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      controller.passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(0.4),
                                    ),
                                    onPressed: () {
                                      // controller.changeVisibility();
                                    },
                                  ),
                                  errorMaxLines: 3,
                                ),
                                textAlignVertical: TextAlignVertical.center,
                              );
                            }),
                            SizedBox(
                              height: Get.height * 0.04,
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //   children: [
                            //     GetBuilder<SignupController>(
                            //         builder: (controller) {
                            //       return Row(
                            //         mainAxisAlignment: MainAxisAlignment.center,
                            //         children: [
                            //           Checkbox(
                            //             checkColor: Theme.of(context)
                            //                 .colorScheme
                            //                 .surface,
                            //             fillColor: MaterialStateProperty.all(
                            //                 Theme.of(context)
                            //                     .colorScheme
                            //                     .primary),
                            //             materialTapTargetSize:
                            //                 MaterialTapTargetSize.shrinkWrap,
                            //             // value: controller.checkedValue,
                            //             onChanged: (newValue) {
                            //               // controller.onChanged(newValue);
                            //             }, value: true,
                            //           ),
                            //           Text("Remember Me",
                            //               style: GoogleFonts.montserrat(
                            //                 fontSize: 10.sp,
                            //                 fontWeight: FontWeight.w600,
                            //                 color: Theme.of(context)
                            //                     .colorScheme
                            //                     .primary,
                            //               )),
                            //         ],
                            //       );
                            //     }),
                            //     TextButton(
                            //       onPressed: () {
                            //         // Get.toNamed('/forgotPassword');
                            //       },
                            //       child: Text(
                            //         'Forgot Password?',
                            //         style: GoogleFonts.montserrat(
                            //           fontSize: 10.sp,
                            //           fontWeight: FontWeight.w600,
                            //           color: Theme.of(context)
                            //               .colorScheme
                            //               .primary
                            //               .withOpacity(0.8),
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            Container(
                              width: Get.width * 0.7,
                              child: ElevatedButton(
                                onPressed: () {
                                   // controller.signIn();
                                  Get.offAllNamed(Routes.DASHBOARD);
                                },
                                style: ElevatedButton.styleFrom(
                                  primary:
                                      Theme.of(context).colorScheme.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(
                                  'Signup',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16.sp,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              width: Get.width * 0.3,
                              height: 35.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                borderRadius: BorderRadius.circular(25.sp),
                                color: Theme.of(context).colorScheme.surface,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text("Cancel",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(0.8),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
