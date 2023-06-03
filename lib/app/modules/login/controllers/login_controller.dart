import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:in_food/app/Utils/snackbar_util.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  bool passwordVisible = false;
  bool checkedValue = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  final storage = const FlutterSecureStorage();
  bool signInLoading = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    // Load saved email and password on app start
    loadSavedCredentials();
  }

  bool isLoggingIn = false;

  Future<void> signIn() async {
    if (formKey.currentState!.validate() && !isLoggingIn) {
      try {
        // Set the login status to true
        isLoggingIn = true;
        // Show a loading dialog while the sign-in process is in progress
        Get.dialog(const Center(child: CircularProgressIndicator()));
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        user = userCredential.user;
        // Save the email and password if the checkbox is checked
        if (checkedValue) {
          saveCredentials(
              emailController.text.trim(), passwordController.text.trim());
        } else {
          // If the checkbox is not checked, delete any saved credentials
          deleteSavedCredentials();
        }
        // Dismiss the loading dialog
        Get.back();
        // Show a success snackBar
        if (user != null) Get.offAllNamed(Routes.DASHBOARD);
        SnackbarUtils.showSnackbar("Login Attempt!", "Login Success",
            SnackPosition.BOTTOM, Duration(milliseconds: 1500));
      } on FirebaseAuthException catch (e) {
        // Dismiss the loading dialog
        Get.back();
        print(e.code);
        if (e.code == 'user-not-found') {
          SnackbarUtils.showSnackbar(
              "Login Attempt!",
              "Incorrect email or password",
              SnackPosition.BOTTOM,
              Duration(milliseconds: 1500));
        } else {
          SnackbarUtils.showSnackbar("Login Attempt!", e.message!,
              SnackPosition.BOTTOM, Duration(milliseconds: 1500));
        }
      } finally {
        // Set the login status to false
        isLoggingIn = false;
      }
    }
  }

  Future<void> loadSavedCredentials() async {
    try {
      String? email = await storage.read(key: 'email');
      String? password = await storage.read(key: 'password');

      if (email != null && password != null) {
        emailController.text = email;
        passwordController.text = password;
        checkedValue = true;
        update();
      }
    } catch (e) {
      // Handle any errors
    }
  }

  Future<void> saveCredentials(String email, String password) async {
    try {
      await storage.write(key: 'email', value: email);
      await storage.write(key: 'password', value: password);
    } catch (e) {
      // Handle any errors
    }
  }

  Future<void> deleteSavedCredentials() async {
    try {
      await storage.delete(key: 'email');
      await storage.delete(key: 'password');
    } catch (e) {
      // Handle any errors
    }
  }

  onChanged(newValue) {
    checkedValue = newValue;
    update();
  }

  changeVisibility() {
    passwordVisible = !passwordVisible;
    update();
  }
}
