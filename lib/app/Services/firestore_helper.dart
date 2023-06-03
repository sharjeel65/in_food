import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:in_food/app/models/user_model.dart';

class FirestoreService extends GetxService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(UserModel merchant) async {
    try {
      await _firestore
          .collection('users')
          .doc(merchant.id.toString())
          .set(merchant.toJson());
    } catch (e) {
      // Handle any errors that occur during the operation
      print('Error adding user: $e');
    }
  }

  Future<void> updateUser(UserModel merchant) async {
    try {
      await _firestore.collection('users').doc(merchant.id.toString()).update(
        {
          'name': merchant.name,
          'dob': merchant.dob,
          'updated_at': DateTime.now().microsecondsSinceEpoch.toString(),
          'gender': merchant.gender,
        },
      );
    } catch (e) {
      // Handle any errors that occur during the operation
      print('Error adding user: $e');
    }
  }
}
