import 'package:flutter/foundation.dart';
import 'package:pre_assessment/model/user.dart';
import 'package:pre_assessment/repo/user_repo.dart';

class UserViewModel with ChangeNotifier {
  User? _user;
  String? _error;

  Future<bool> signUp(String email, String password) async {
    _user = User(
      email: email,
      password: password,
      photoUrl: "https://as1.ftcdn.net/v2/jpg/02/06/74/22/1000_F_206742233_sxv7K1GPkN5VaUcZwRd07gU8fQ63nhTV.jpg",
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
    try {
      _user = await UserRepo.getUser(email, password);
      if (_user != null) {
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

  Future<void> updatePhoto(String photoUrl) async {
    _user!.photoUrl = photoUrl;
    notifyListeners();
  }

  Future<void> addMessage(String message) async {
    _user!.messages?.add(message);
    notifyListeners();
  }

  get user => _user;
  get error => _error;
  get photoUrl => _user?.photoUrl;
  get messages => _user?.messages;
}
