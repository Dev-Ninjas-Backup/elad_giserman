class ProfileModel {
  final String name;
  final String email;
  final String username;
  final String avatarUrl;
  final String? mobile;

  ProfileModel({
    required this.name,
    required this.email,
    required this.username,
    required this.avatarUrl,
    this.mobile,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json["name"] ?? "Unnamed User",
      email: json["email"] ?? "",
      username: json["username"] ?? "",
      avatarUrl:
          json["avatarUrl"] ??
          "https://www.gravatar.com/avatar/000000000000000000000000000000?d=mp&f=y",
      mobile: json["mobile"],
    );
  }
}
