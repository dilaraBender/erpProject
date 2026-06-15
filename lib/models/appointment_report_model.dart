class AppointmentReportModel {
  final int appointmentId;
  final String customerName;
  final String dealerName;
  final String city;
  final DateTime appDateTime;
  final String status;

  final int totalAppointments;
  final int completedCount;
  final int pendingCount;
  final int cancelledCount;

  final int dailyCount;
  int? rating;

  AppointmentReportModel({
    required this.appointmentId,
    required this.customerName,
    required this.dealerName,
    required this.city,
    required this.appDateTime,
    required this.status,
    required this.totalAppointments,
    required this.completedCount,
    required this.pendingCount,
    required this.cancelledCount,
    required this.dailyCount,
    this.rating,
  });

  factory AppointmentReportModel.fromJson(Map<String, dynamic> json) {
    return AppointmentReportModel(
      appointmentId: json["appointmentId"],
      customerName: json["customerName"] ?? "",
      dealerName: json["dealerName"] ?? "",
      city: json["city"] ?? "",
      appDateTime: DateTime.parse(json["appDateTime"]),
      status: json["status"] ?? "",

      totalAppointments: json["totalAppointments"] ?? 0,
      completedCount: json["completedCount"] ?? 0,
      pendingCount: json["pendingCount"] ?? 0,
      cancelledCount: json["cancelledCount"] ?? 0,

      dailyCount: json["dailyCount"] ?? 0,
      rating: json["rating"] ?? 0,
    );
  }
}
