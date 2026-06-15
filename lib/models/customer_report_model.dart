class CustomerReportModel {
  final int customerId;
  final String name;
  final String city;
  final int appointment;
  final String lastActive;
  final double score;

  CustomerReportModel({
    required this.customerId,
    required this.name,
    required this.city,
    required this.appointment,
    required this.lastActive,
    required this.score,
  });

  factory CustomerReportModel.fromJson(Map<String, dynamic> json) {
    return CustomerReportModel(
      customerId: json["customerId"] ?? 0,
      name: json["name"] ?? "",
      city: json["city"] ?? "",
      appointment: (json["appointment"] ?? 0) as int,
      lastActive: json["lastActive"] ?? "",
      score: (json["score"] ?? 0).toDouble(),
    );
  }
}
