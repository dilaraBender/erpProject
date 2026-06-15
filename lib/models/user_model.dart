class UserModel {
  final int userId;
  final String fullName;
  final String mail;
  final String? bayiPhone;
  final String? customerPhone;
  final String? registerDate;
  final String? lastLogin;
  final String role;
  final String status;
  final String? bayiTitle;
  final String? bayiTaxNo;
  final String? bayiCreatedAt;
  final bool passwordChanged;
  UserModel({
    required this.userId,
    required this.fullName,
    required this.mail,
    this.bayiPhone,
    this.customerPhone,
    this.registerDate,
    this.lastLogin,
    required this.role,
    required this.status,
    this.bayiTitle,
    this.bayiTaxNo,
    this.bayiCreatedAt,
    required this.passwordChanged,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      fullName: json['fullName'] ?? '',
      mail: json['mail'] ?? '',
      bayiPhone: json['bayiPhone'],
      customerPhone: json['customerPhone'],
      registerDate: json['registerDate'],
      lastLogin: json['lastLogin'],
      role: json['role'] ?? '',
      status: json['status'] ?? '',
      bayiTitle: json['bayiTitle'],
      bayiTaxNo: json['bayiTaxNo'],
      bayiCreatedAt: json['bayiCreatedAt'],
      passwordChanged: json['passwordChanged'] ?? false,
    );
  }
}
