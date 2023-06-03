import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? fbID;
  final String? phone;
  final String? address;
  final String? dob;
  final String? image;
  final String? role;
  final String? gender;
  final String? createdAt;
  final String? updatedAt;
  final bool? emailVerified;
  final bool? phoneVerified;

  UserModel( {
    this.fbID,
    this.id,
    this.name,
    this.email,
    this.dob,
    this.phone,
    this.address,
    this.image,
    this.gender,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.emailVerified,
    this.phoneVerified,
  });

  // factory UserModel.fromDocumentSnapshot(DocumentSnapshot doc) => UserModel(
  //   uid: doc["uid"],
  //   email: doc["email"],
  //   displayName: doc["displayName"],
  //   photoURL: doc["photoURL"],
  //   phoneNumber: doc["phoneNumber"],
  // );

  // Map<String, dynamic> toJson() => {
  //   "uid": uid,
  //   "email": email,
  //   "displayName": displayName,
  //   "photoURL": photoURL,
  //   "phoneNumber": phoneNumber,
  // };
  factory UserModel.fromDocumentSnapshot(DocumentSnapshot doc) => UserModel(
        id: doc['id'],
        name: doc['name'],
        email: doc['email'],
        fbID: doc['fbID'],
        dob: doc['dob'],
        phone: doc['phone'],
        address: doc['address'],
        gender: doc['gender'],
        image: doc['image'],
        role: doc['role'],
        createdAt: doc['created_at'],
        updatedAt: doc['updated_at'],
        emailVerified: doc['email_verified'],
        phoneVerified: doc['phone_verified'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'fbID': fbID,
        'dob': dob,
        'phone': phone,
        'gender': gender,
        'address': address,
        'image': image,
        'role': role,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'email_verified': emailVerified,
        'phone_verified': phoneVerified,
      };
}
