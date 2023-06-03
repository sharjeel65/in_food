import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:in_food/app/models/user_model.dart';

import '../Utils/snackbar_util.dart';

class FbAuth {
  static Future<User?> signInWithFacebook() async {
    try {
      final LoginResult loginResult =
          await FacebookAuth.instance.login(permissions: [
        'public_profile',
        'email',
      ]);
      if (loginResult.status == LoginStatus.success) {
        final facebookAuthCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);
        final credential = await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);
        final userData = await FacebookAuth.instance.getUserData(
          fields: "name,email,picture.height(800),birthday,gender,link",
        );
        final user = credential.user;
        await FBFireStoreInit.updateUserData(user!, userData);
        return user;
      } else {
        throw Exception(loginResult.message!);
      }
    } catch (e) {
      SnackbarUtils.showSnackbar("Error", e.toString(), SnackPosition.BOTTOM,
          Duration(milliseconds: 1500));
    }
  }
}

class FBFireStoreInit {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<void> updateUserData(
      User user, Map<String, dynamic> userData) async {
    if (await _isUserDataMissing(user)) {
      await firestore.collection('users').doc(user.uid).set(UserModel(
            email: user.email,
            fbID: userData['id'],
            name: user.displayName,
            id: user.uid,
            dob: '',
            phone: user.phoneNumber,
            gender: '',
            address: '',
            image: user.photoURL,
            role: 'user',
            createdAt: DateTime.now().microsecondsSinceEpoch.toString(),
            updatedAt: '',
            emailVerified: true,
            phoneVerified: false,
          ).toJson());
    }
  }

  static Future<bool> _isUserDataMissing(User user) async {
    final doc1 = await firestore.collection('users').doc(user.uid).get();
    return doc1.data() == null;
  }
}

class FbAuthErrors {
  static String error(dynamic e) {
    return 'Error: $e';
  }
}

class DeAuth {
  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
