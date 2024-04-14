import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:pre_assessment/model/user.dart';

class UserRepo {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get user data from Firebase
  static Future<User?> getUser(String uid) async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection("users").doc(uid).get();
      if (userDoc.exists) {
        return User.fromJson(userDoc.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      return null; // Cannot get user data
    }
  }

  // Create user data in Firebase
  static Future<User?> createUser(firebase.User firebaseUser) async {
    final User user = User(
      uid: firebaseUser.uid,
      lineId: "000",
      name: "anonymous",
      pictureUrl: "https://t3.ftcdn.net/jpg/05/11/52/90/360_F_511529094_PISGWTmlfmBu1g4nocqdVKaHBnzMDWrN.jpg",
      email: "",
    );
    await _firestore.collection("users").doc(user.uid).set(user.toJson());
    return user;
  }

  // Update user data in Firebase
  static Future<void> updateUser(User user) async {
    try {
      await _firestore.collection("users").doc(user.uid).update(user.toJson());
    } catch (e) {
      return; // Failed to update user data
    }
  }
}

// Structure of the user data in Firebase
// users (collection)
// │
// ├── {uid} (document)
// │   ├── uid (string)
// │   ├── lineId (string)
// │   ├── name (string)
// │   ├── pictureUrl (string)
// │   ├── email (string)
// │   └── ... 
// │
// └── ...
