class UserModel {
  final User user;
  final List<dynamic> menu;
  final String token;
  final bool success;
  final String message;

  UserModel({
    required this.user,
    required this.menu,
    required this.token,
    required this.success,
    required this.message,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      user: User.fromJson(json['user']),
      menu: json['menu'] ?? [],
      token: json['token'] ?? '',
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }
}

class User {
  final String email;
  final String userDisplayName;
  final String id;
  final String fullName;
  final String student;
  final UserType userType;

  User({
    required this.email,
    required this.userDisplayName,
    required this.id,
    required this.fullName,
    required this.student,
    required this.userType,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'] ?? '',
      userDisplayName: json['userDisplayName'] ?? '',
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      student: json['student'] ?? '',
      userType: UserType.fromJson(json['userType']),
    );
  }
}

class UserType {
  final String id;
  final String role;
  final String roleDisplayName;

  UserType({
    required this.id,
    required this.role,
    required this.roleDisplayName,
  });

  factory UserType.fromJson(Map<String, dynamic> json) {
    return UserType(
      id: json['_id'] ?? '',
      role: json['role'] ?? '',
      roleDisplayName: json['roleDisplayName'] ?? '',
    );
  }
}
