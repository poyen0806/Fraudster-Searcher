import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:pre_assessment/model/user.dart';
import 'package:pre_assessment/repo/user_repo.dart';

/// A view model, to manage user information,
/// including create, sign in, sign out,  and update user information
class UserViewModel with ChangeNotifier {
  User? _user;
  get user => _user;

  UserViewModel() {
    FirebaseAuth.instance.authStateChanges().listen((firebaseUser) async {
      if (firebaseUser != null) {
        _user = await UserRepo.getUser(firebaseUser.uid);
        _user ??= await UserRepo.createUser(firebaseUser);
      }
      notifyListeners();
    });
  }

  Future<void> _initializeLineSDK() async {
    await LineSDK.instance.setup(
      "2004639543",
      universalLink: "https://poyen.page.link/preAssessment",
    );
  }

  // Line sign in
  Future<bool> signInWithLine() async {
    await _initializeLineSDK();

    try {
      final result = await LineSDK.instance.login();
      final lineProfile = result.userProfile!;
      User user = User(
        uid: FirebaseAuth.instance.currentUser!.uid,
        lineId: lineProfile.userId,
        name: lineProfile.displayName,
        pictureUrl: lineProfile.pictureUrl ?? "",
        email: "",
      );

      await UserRepo.updateUser(user);
      notifyListeners();

      return true;
    } catch (e) {
      notifyListeners();
      return false;
    }
  }
}
