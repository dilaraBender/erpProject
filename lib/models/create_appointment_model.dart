class CreateAppointmentModel {
  int bayiId;
  int buildingId;
  String appDate;
  String appTime;
  double price;
  String description;
  String status;

  CreateAppointmentModel({
    required this.bayiId,
    required this.buildingId,
    required this.appDate,
    required this.appTime,
    required this.price,
    required this.description,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      "bayiId": bayiId,
      "buildingId": buildingId,
      "appDate": appDate,
      "appTime": appTime,
      "price": price,
      "description": description,
      "status": status,
    };
  }
}
