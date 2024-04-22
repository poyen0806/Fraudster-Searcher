import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:pre_assessment/model/user.dart';

/// Repository class responsible for CRUD operations related to User data in Firestore.
class UserRepo {
  // Firestore instance for interacting with Firestore database.
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Fetches a user from Firestore by email and password.
  ///
  /// Returns a [User] object if user exists and password matches; otherwise returns null.
  static Future<User?> getUser(String email, String password) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection("users").doc(email).get();
      if (userDoc.exists) {
        var userData = userDoc.data() as Map<String, dynamic>;
        if (userData["password"] == password) {
          return User.fromJson(userData);
        }
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error getting user data: $e");
      }
      return null;
    }
    return null;
  }

  /// Creates a new user in Firestore.
  ///
  /// Returns the created [User] object if successful; otherwise returns null.
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

  /// Updates an existing user in Firestore.
  ///
  /// Does not return anything, but throws an error if the operation fails.
  static Future<void> updateUser(User user) async {
    try {
      await _firestore.collection("users").doc(user.email).update(user.toJson());
    } catch (e) {
      if (kDebugMode) {
        print("Error updating user: $e");
      }
    }
  }
}
