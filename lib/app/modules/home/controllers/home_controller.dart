import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../Services/facebook_service.dart';
import '../../../Services/google_service.dart';
import '../../../routes/app_pages.dart';
import '../../signup/controllers/signup_controller.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  late User? user;

  onLoginTapped() {
    Get.toNamed(Routes.LOGIN);
  }

  onSignupTapped() {
    Get.toNamed(Routes.SIGNUP);
  }

  onGoogleLoginTapped() async {
    user = await GoogleAuth().signInWithGoogle();
    if (user != null) {
      await GoogleAuth().initFirestore(user!);
      Get.offAllNamed(Routes.DASHBOARD);
    }
  }

  SignupController signupController = Get.put(SignupController());

  autoLogin() async {
    if (user != null) {
      if (user!.emailVerified ||
          user?.providerData[0].providerId == "facebook.com") {
        Get.offAllNamed(Routes.DASHBOARD);
        print("verified");
      } else if (user!.email != null) {
        user!.sendEmailVerification();
        Get.offAllNamed(Routes.SIGNUP);
        await Future.delayed(const Duration(seconds: 1));
        Get.find<SignupController>().navigateTo(2);
      }
    } else {
      print("user is null");
    }
  }

  onFacebookLoginTapped() async {
    User? user = await FbAuth.signInWithFacebook();
    if (user != null) {
      user.refreshToken;
      Get.offAllNamed(Routes.DASHBOARD);
    }
  }

  @override
  void onInit() {
    user = FirebaseAuth.instance.currentUser;
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    autoLogin();
    // TODO: implement onReady
    super.onReady();
  }
}
