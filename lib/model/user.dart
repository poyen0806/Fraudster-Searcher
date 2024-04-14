/// A model, including user information and methods to convert user information to JSON
class User {
  String email;
  String password;

  User({
    required this.email,
    required this.password,
  });

  // Line Login profile data
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json["email"],
      password: json["password"],
    );
  }

  // Convert user information to JSON
  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
    };
  }
}
