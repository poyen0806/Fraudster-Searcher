/// A model, including user information and methods to convert user information to JSON
class User {
  String email;
  String password;
  String photoUrl;
  List<String>? messages;

  User({
    required this.email,
    required this.password,
    required this.photoUrl,
    this.messages,
  });

  // Line Login profile data
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json["email"],
      password: json["password"],
      photoUrl: json["photo_url"],
      messages: json["messages"],
    );
  }

  // Convert user information to JSON
  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "photo_url": photoUrl,
      "messages": messages,
    };
  }
}
