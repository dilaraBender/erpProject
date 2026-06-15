class ManagerProfileModel {
  final int userId;
  final String name;
  final String lastName;
  final String mail;
  final String phone;
  final double? latitude;
  final double? longitude;

  ManagerProfileModel({
    required this.userId,
    required this.name,
    required this.lastName,
    required this.mail,
    required this.phone,
    required this.latitude,
    required this.longitude,
  });

  factory ManagerProfileModel.fromJson(Map<String, dynamic> json) {
    return ManagerProfileModel(
      userId: json['userId'] ?? 0,
      name: json['name'] ?? '',
      lastName: json['lastName'] ?? '',
      mail: json['mail'] ?? '',
      phone: json['phone'] ?? '',
      latitude: json["latitude"] != null
          ? double.tryParse(json["latitude"].toString())
          : null,

      longitude: json["longitude"] != null
          ? double.tryParse(json["longitude"].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'lastName': lastName,
      'mail': mail,
      'phone': phone,
      'Latitude': latitude,
      'Longitude': longitude,
    };
  }
}
