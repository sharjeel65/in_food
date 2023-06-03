import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_food/app/Services/validator.dart';
import 'package:in_food/app/Utils/snackbar_util.dart';

class ProfileController extends GetxController {
  User user = FirebaseAuth.instance.currentUser!;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  changePassword() {
    if (user.providerData[0].providerId != 'password') {
      SnackbarUtils.showSnackbar(
          'Error',
          'You are logged in with Google or Facebook. Please change your password from there.',
          SnackPosition.BOTTOM,
          Duration(milliseconds: 1500));
    } else {
      Get.dialog(GestureDetector(
        onTap: () {
          FocusScope.of(Get.context!).unfocus();
        },
        child: Container(
          child: AlertDialog(
            title: const Text('Change Password'),
            content: SingleChildScrollView(
              child: Form(
                key: key,
                child: ListBody(
                  children: <Widget>[
                    const Text('Enter your new password below.'),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        labelText: 'New Password',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: (value) => Validator.validatePassword(
                        value!,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: confirmPasswordController,
                      decoration: const InputDecoration(
                        labelText: 'Confirm New Password',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: (value) => Validator.validatePassword(
                        value!,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Get.back();
                },
              ),
              TextButton(
                  child: const Text('Change'),
                  onPressed: () {
                    if (key.currentState!.validate()) {
                      if (passwordController.text ==
                          confirmPasswordController.text) {
                        user.updatePassword(passwordController.text);
                        Get.back();
                        SnackbarUtils.showSnackbar(
                            'Success',
                            'Your password has been changed.',
                            SnackPosition.BOTTOM,
                            Duration(milliseconds: 1500));
                      } else {
                        SnackbarUtils.showSnackbar(
                            'Error',
                            'Your passwords do not match.',
                            SnackPosition.BOTTOM,
                            Duration(milliseconds: 1500));
                      }
                    }
                  }),
            ],
          ),
        ),
      ));
    }
    print(user.providerData[0].providerId);
  }
}
