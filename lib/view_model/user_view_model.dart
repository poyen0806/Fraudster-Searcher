import 'package:flutter/foundation.dart';
import 'package:pre_assessment/model/user.dart';
import 'package:pre_assessment/repo/user_repo.dart';

class UserViewModel with ChangeNotifier {
  User? _user;
  get user => _user;

  Future<bool> signIn(String email, String password) async {
    _user = User(
      email: email,
      password: password,
    );

    await UserRepo.createUser(_user!);
    notifyListeners();

    return true;
  }

  Future<void> signOut() async {
    _user = null;
    notifyListeners();
  }
}
