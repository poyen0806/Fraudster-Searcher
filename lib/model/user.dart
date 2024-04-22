/// A model representing user information with methods to convert to and from JSON.
class User {
  // User email
  String email;
  // User password
  String password;
  // User photo URL
  String photoUrl;
  // List of messages
  List<dynamic>? messages;

  User({
    required this.email,
    required this.password,
    required this.photoUrl,
    this.messages,
  });

  /// Factory method to create a [User] instance from a JSON map.
  ///
  /// [json] is the map containing user information.
  /// Returns a [User] instance.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json["email"],
      password: json["password"],
      photoUrl: json["photo_url"],
      messages: json["messages"],
    );
  }

  /// Converts the [User] instance to a JSON map.
  ///
  /// Returns a map containing user information.
  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "photo_url": photoUrl,
      "messages": messages,
    };
  }
}
