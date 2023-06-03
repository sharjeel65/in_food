import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:in_food/app/models/user_model.dart';

String error = '';
bool newUser = false;

class GoogleAuth {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  User? user;

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
    print("User Sign Out");
  }

  Future<User?> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      newUser = userCredential.additionalUserInfo!.isNewUser;
      if (newUser) {
        userCredential.user!.updateDisplayName(
            userCredential.additionalUserInfo!.profile!['name']);
        userCredential.user!.updatePhotoURL(
            userCredential.additionalUserInfo!.profile!['picture']);
        userCredential.user!
            .updateEmail(userCredential.additionalUserInfo!.profile!['email']);
        print(userCredential.additionalUserInfo!.profile!);
        print(userCredential);
      }
      user = userCredential.user;
    }
    return user;
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> initFirestore(User user) async {
    if (newUser) {
      firestore
          .collection('users')
          .doc(user.uid)
          .set(UserModel(
            fbID: '',
            email: user.email,
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
            emailVerified: user.emailVerified,
            phoneVerified: false,
          ).toJson())
          .then((_) => {print('success')});
    }
  }
}

class GoogleAuthErrors {
  String errorFunc() {
    return error;
  }
}
