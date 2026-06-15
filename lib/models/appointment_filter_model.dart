class AppointmentFilterModel {
  final int? bayiId;
  final int? customerId;
  final int? buildingId;

  final String? status;

  final DateTime? startDate;
  final DateTime? endDate;

  AppointmentFilterModel({
    this.bayiId,
    this.customerId,
    this.buildingId,
    this.status,
    this.startDate,
    this.endDate,
  });

  Map<String, dynamic> toJson() {
    return {
      if (bayiId != null) "bayiId": bayiId,
      if (customerId != null) "customerId": customerId,
      if (buildingId != null) "buildingId": buildingId,
      if (status != null) "status": status,
      if (startDate != null) "startDate": startDate!.toIso8601String(),
      if (endDate != null) "endDate": endDate!.toIso8601String(),
    };
  }
}
