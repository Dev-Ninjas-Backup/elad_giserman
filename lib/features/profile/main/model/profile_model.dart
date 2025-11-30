class ProfileModel {
  final String name;
  final String email;
  final String username;
  final String avatarUrl;

  ProfileModel({
    required this.name,
    required this.email,
    required this.username,
    required this.avatarUrl,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json["name"] ?? "Unnamed User",
      email: json["email"] ?? "",
      username: json["username"] ?? "",
      avatarUrl:
          json["avatarUrl"] ??
          "https://www.gravatar.com/avatar/000000000000000000000000000000?d=mp&f=y",
    );
  }
}
