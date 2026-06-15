class BuildingModel {
  final int buildingId;
  final int customerId;
  final String title;
  final String address;
  final String city;
  final double? latitude;
  final double? longitude;

  BuildingModel({
    required this.buildingId,
    required this.customerId,
    required this.title,
    required this.address,
    required this.city,
    required this.latitude,
    required this.longitude,
  });

  factory BuildingModel.fromJson(Map<String, dynamic> json) {
    return BuildingModel(
      buildingId: json['buildingId'] ?? 0,
      customerId: json['customerId'] ?? 0,
      title: json['title'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
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
      'BuildingId': buildingId,
      'CustomerId': customerId,
      'Title': title,
      'Address': address,
      'City': city,
      'Latitude': latitude,
      'Longitude': longitude,
    };
  }

  Future<void> updateBuildingFonk(BuildingModel updatedBuilding) async {}
}
