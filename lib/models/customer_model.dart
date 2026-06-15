class CustomerModel {
  int? customerId;
  int? userId;

  String name;
  String lastName;
  String email;
  String phone;
  String status;

  double? latitude;
  double? longitude;

  bool? passwordChanged;
  String? password;

  CustomerModel({
    this.customerId,
    this.userId,
    required this.name,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.status,
    this.latitude,
    this.longitude,
    this.password,
    this.passwordChanged,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      customerId: json['customerId'],
      userId: json['userId'],
      name: json['name'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['mail'] ?? json['email'] ?? '',
      phone: json['phone'] ?? '',
      status: json['status'] ?? '',
      latitude: json['latitude'] != null
          ? double.tryParse(json['latitude'].toString())
          : null,
      longitude: json['longitude'] != null
          ? double.tryParse(json['longitude'].toString())
          : null,
      passwordChanged: json['passwordChanged'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'userId': userId,
      'name': name,
      'lastName': lastName,
      'mail': email,
      'phone': phone,
      'status': status,
      'latitude': latitude,
      'longitude': longitude,
      'password': password,
      'passwordChanged': passwordChanged,
    };
  }
}
