import 'package:flutter/foundation.dart';
import 'package:pre_assessment/model/user.dart';
import 'package:pre_assessment/repo/user_repo.dart';

class UserViewModel with ChangeNotifier {
  User? _user;
  get user => _user;
  String? _error;
  get error => _error;

  Future<bool> signUp(String email, String password) async {
    _user = User(
      email: email,
      password: password,
    );
    if (await UserRepo.createUser(_user!) != null) {
      notifyListeners();
      return true;
    }
    else {
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    _user = User(
      email: email,
      password: password,
    );
    try {
      if (await UserRepo.getUser(_user!.email, _user!.password) != null) {
        notifyListeners();
        return true;
      }
      else {
        throw "User not found";
      }
    }
    catch (e) {
      if (kDebugMode) {
        print(e);
      }
      _error = e.toString();
      return false;
    }
  }

  Future<void> signOut() async {
    _user = null;
    notifyListeners();
  }
}
