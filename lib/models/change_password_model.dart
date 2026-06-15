class ChangePasswordModel {
  final int userId;
  final String currentPassword;
  final String newPassword;

  ChangePasswordModel({
    required this.userId,
    required this.currentPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "currentPassword": currentPassword,
      "newPassword": newPassword,
    };
  }
}
