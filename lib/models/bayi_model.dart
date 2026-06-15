class BayiModel {
  int bayiId;
  String name;
  String lastName;
  String title;
  String mail;
  String status;

  String? city;
  String? phone;
  String? address;
  String? tc;
  String? taxNo;
  String? tax;

  double? latitude;
  double? longitude;

  BayiModel({
    required this.bayiId,
    required this.name,
    required this.lastName,
    required this.title,
    required this.mail,
    required this.status,
    required this.city,
    required this.phone,
    required this.address,
    required this.tc,
    required this.taxNo,
    required this.tax,
    this.latitude,
    this.longitude,
    required String password,
  });

  factory BayiModel.fromJson(Map<String, dynamic> json) {
    return BayiModel(
      bayiId: json['bayiId'],
      name: json['name'] ?? "",
      lastName: json['lastName'] ?? "",
      title: json['title'] ?? "",
      mail: json['mail'] ?? "",
      status: json['status'] ?? "",
      city: json['city'],
      phone: json['phone'],
      address: json['address'],
      tc: json['tc'],
      taxNo: json['taxNo'],
      tax: json['tax'],
      latitude: json["latitude"] != null
          ? double.tryParse(json["latitude"].toString())
          : null,
      longitude: json["longitude"] != null
          ? double.tryParse(json["longitude"].toString())
          : null,
      password: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bayiId': bayiId,
      'name': name,
      'lastName': lastName,
      'title': title,
      'mail': mail,
      'status': status,
      'city': city,
      'phone': phone,
      'address': address,
      'tc': tc,
      'taxNo': taxNo,
      'tax': tax,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
