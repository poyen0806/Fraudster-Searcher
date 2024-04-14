/// A model, including user information and methods to convert user information to JSON
class User {
  String uid;
  String lineId;
  String name;
  String pictureUrl;
  String email;

  User({
    required this.uid,
    required this.lineId,
    required this.name,
    this.pictureUrl = "",
    this.email = "",
  });

  // Line Login profile data
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json["uid"],
      lineId: json["sub"],
      name: json["name"],
      pictureUrl: json["picture"],
      email: json["email"] ?? "", 
    );
  }

  // Convert user information to JSON
  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "sub": lineId,
      "name": name,
      "picture": pictureUrl,
      "email": email,
    };
  }
}
