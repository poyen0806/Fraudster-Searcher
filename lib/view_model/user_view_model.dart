import 'package:flutter/foundation.dart';
import 'package:pre_assessment/model/user.dart';
import 'package:pre_assessment/repo/user_repo.dart';

/// [UserViewModel] is a view model class responsible for handling user authentication and account management.
class UserViewModel with ChangeNotifier {
  // Current authenticated user
  User? _user;
  // Error message for user actions
  String? _error;

  /// Signs up a new user with the provided email and password.
  ///
  /// Returns true if sign up is successful; otherwise returns false.
  Future<bool> signUp(String email, String password) async {
    // Check if user already exists
    if (await UserRepo.getUser(email, password) != null) {
      _error = "User already exists";
      return false;
    }

    // Create a new user object
    _user = User(
      email: email,
      password: password,
      photoUrl:
          "https://as1.ftcdn.net/v2/jpg/02/06/74/22/1000_F_206742233_sxv7K1GPkN5VaUcZwRd07gU8fQ63nhTV.jpg",
      messages: ["Hello!"],
    );

    // Create user in Firestore
    if (await UserRepo.createUser(_user!) != null) {
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  /// Signs in a user with the provided email and password.
  ///
  /// Returns true if sign in is successful; otherwise returns false.
  Future<bool> signIn(String email, String password) async {
    try {
      _user = await UserRepo.getUser(email, password);
      if (_user != null) {
        notifyListeners();
        return true;
      } else {
        throw "User not found";
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      _error = e.toString();
      return false;
    }
  }

  /// Signs out the current user.
  Future<void> signOut() async {
    // Clear the current user
    _user = User(
      email: "email",
      password: "password",
      photoUrl: "https://as1.ftcdn.net/v2/jpg/02/06/74/22/1000_F_206742233_sxv7K1GPkN5VaUcZwRd07gU8fQ63nhTV.jpg",
      messages: ["messages"],
    );
    notifyListeners();
  }

  /// Updates the password of the current user.
  Future<void> updateAccount(String password) async {
    _user!.password = password;
    UserRepo.updateUser(_user!);
    notifyListeners();
  }

  /// Incomplete
  // Future<void> updatePhoto(String photoUrl) async {
  //   _user!.photoUrl = photoUrl;
  //   notifyListeners();
  // }

  /// Adds a new message to the current user's messages.
  Future<void> addMessage(String message) async {
    _user!.messages?.add(message);
    UserRepo.updateUser(_user!);
    notifyListeners();
  }

  // Getters for user properties
  get user => _user;
  get error => _error;
  get email => _user?.email;
  get password => _user?.password;
  get photoUrl => _user?.photoUrl;
  get messages => _user?.messages;
}
