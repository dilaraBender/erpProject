class AppointmentModel {
  final int appointmentId;

  final int? bayiId;
  final String? bayiName;

  final int? customerId;
  final String? customerName;

  final int? buildingId;
  final String? buildingTitle;

  final String? address;
  final String? phone;

  final DateTime? appDate;
  final String? appTime;

  final double? price;
  final String? description;
  final String? status;

  final int? rating;

  final double? latitude;
  final double? longitude;

  AppointmentModel({
    required this.appointmentId,
    this.bayiId,
    this.bayiName,
    this.customerId,
    this.customerName,
    this.buildingId,
    this.buildingTitle,
    this.address,
    this.phone,
    this.appDate,
    this.appTime,
    this.price,
    this.description,
    this.status,
    this.rating,
    this.latitude,
    this.longitude,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      appointmentId: json['appointmentId'],

      bayiId: json['bayiId'],
      bayiName: json['bayiName'],

      customerId: json['customerId'],
      customerName: json['customerName'],

      buildingId: json['buildingId'],
      buildingTitle: json['buildingTitle'],

      address: json['address'],
      phone: json['phone'],

      appDate: json['appDate'] != null
          ? (json['appDate'] is String
                ? DateTime.parse(json['appDate'])
                : json['appDate'])
          : null,

      appTime: json['appTime'],

      price: json['price'] != null ? (json['price'] as num).toDouble() : null,

      description: json['description'],
      status: json['status'],

      rating: json['rating'],

      latitude: json['latitude'] != null
          ? (json['latitude'] as num).toDouble()
          : null,

      longitude: json['longitude'] != null
          ? (json['longitude'] as num).toDouble()
          : null,
    );
  }
}
