import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:pre_assessment/model/user.dart';

class UserRepo {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<User?> getUser(String email) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection("users").doc(email).get();
      if (userDoc.exists) {
        return User.fromJson(userDoc.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error getting user data: $e");
      }
      return null;
    }
  }

  static Future<User?> createUser(User user) async {
    try {
      await _firestore.collection("users").doc(user.email).set(user.toJson());
      return user;
    } catch (e) {
      if (kDebugMode) {
        print("Error creating user: $e");
      }
      return null;
    }
  }
}
