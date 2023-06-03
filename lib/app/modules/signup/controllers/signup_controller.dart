import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:in_food/app/Services/firebase_service.dart';
import 'package:in_food/app/Services/firestore_helper.dart';
import 'package:in_food/app/Utils/snackbar_util.dart';
import 'package:intl/intl.dart';

import '../../../models/user_model.dart';

enum Gender {
  male,
  female,
  other,
}

class SignupController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController dobController = TextEditingController();
  final emailController = TextEditingController();
  final node = FocusNode();
  final emailFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  bool passwordVisible = false;
  bool progressIndicator = false;
  DateTime? selectedDate;
  Timer? buttonTimer;
  bool canResendEmail = false;
  Gender? selectedGender;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _startTimer() {
    const timeLimit = 30; // seconds
    update();
    buttonTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timer.tick >= timeLimit) {
        canResendEmail = true;
        buttonTimer?.cancel();
        timer.cancel();
      }
      update();
      print(timer.tick);
    });
  }

  maleSelected() {
    selectedGender = Gender.male;
    update();
  }

  femaleSelected() {
    selectedGender = Gender.female;
    update();
  }

  otherSelected() {
    selectedGender = Gender.other;
    update();
  }

  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: 'Select Date of Birth',
      confirmText: 'Select',
      cancelText: 'Cancel',
      fieldLabelText: 'Enter Date of Birth',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Theme.of(context).colorScheme.onPrimary,
              surface: Theme.of(context).colorScheme.surface,
              onSurface: Theme.of(context).colorScheme.onSurface,
            ),
            dialogBackgroundColor: Theme.of(context).colorScheme.surface,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dobController.text = DateFormat('dd/MM/yyyy').format(selectedDate!);
      update();
    }
  }

  //TODO: Implement SignupController
  int page = 0;

  void changePasswordVisibility() {
    passwordVisible = !passwordVisible;
    update();
  }

  resendEmail() async {
    canResendEmail = false;
    try {
      await _auth.currentUser?.sendEmailVerification();
      print("send email verification");
    } catch (e) {
      SnackbarUtils.showSnackbar(
          "Error", e.toString(), SnackPosition.BOTTOM, Duration(seconds: 2));
    }
    _startTimer();
    update();
  }

  checkUserEmailVerification() async {
    // listen to user changes stream
    Timer.periodic(const Duration(seconds: 2), (timer) {
      _auth.currentUser?.reload();
      print(_auth.currentUser?.emailVerified);
      if (_auth.currentUser?.emailVerified == true) {
        page = 3;
        update();
        timer.cancel();
      }
    });
  }

  void emailButtonTapped() {
    if (emailFormKey.currentState!.validate()) {
      navigateTo(1);
    }
  }

  Future<void> passwordButtonTapped() async {
    if (passwordFormKey.currentState!.validate() &&
        emailController.text.isNotEmpty) {
      progressIndicator = true;
      Get.dialog(const Center(child: CircularProgressIndicator()));
      update();
      String text = await FirebaseService()
          .signup(emailController.text, passwordController.text);
      SnackbarUtils.showSnackbar(
          "SignUp", text, SnackPosition.BOTTOM, const Duration(seconds: 3));
      if (text == 'Created successfully!') {
        FirestoreService().createUser(UserModel(
          id: _auth.currentUser!.uid,
          createdAt: DateTime.now().microsecondsSinceEpoch.toString(),
          email: emailController.text,
          role: 'user',
        ));
        progressIndicator = false;
        Get.back();
        update();
        await _auth.currentUser
            ?.sendEmailVerification()
            .then((value) => navigateTo(2));
      }
      Get.back();
      progressIndicator = false;
      update();
    }
  }

  void navigateTo(int index) {
    page = index;
    update();
  }

  void getBack() {
    page--;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    if (emailController.text.isEmpty && _auth.currentUser != null) {
      emailController.text = _auth.currentUser?.email ?? '';
      if (_auth.currentUser?.providerData[0].providerId != 'facebook.com' &&
          _auth.currentUser?.providerData[0].providerId != 'google.com' &&
          _auth.currentUser?.emailVerified == false) {
        resendEmail();
      }
      _startTimer();
      print(emailController.text);
    }
    super.onInit();
  }

  @override
  void onClose() {
    dobController.dispose();
    if (buttonTimer?.isActive ?? true) {
      buttonTimer?.cancel();
    }
    // TODO: implement onClose
    super.onClose();
  }

  void genderContinueTapped() {
    if (selectedGender != null) {
      navigateTo(5);
    } else {
      SnackbarUtils.showSnackbar("Error", "Please Select a Gender",
          SnackPosition.BOTTOM, const Duration(seconds: 3));
    }
  }

  void nameButtonTapped() {
    if (nameController.text.isNotEmpty) {
      navigateTo(4);
    }
  }
}
