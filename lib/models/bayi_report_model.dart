class BayiReportModel {
  final int bayiId;
  final String bayiName;
  final String city;
  final String status;

  final int customerCount;
  final int appointmentCount;

  BayiReportModel({
    required this.bayiId,
    required this.bayiName,
    required this.city,
    required this.status,
    required this.customerCount,
    required this.appointmentCount,
  });

  factory BayiReportModel.fromJson(Map<String, dynamic> json) {
    int safeInt(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value;
      return int.tryParse(value.toString()) ?? 0;
    }

    return BayiReportModel(
      bayiId: safeInt(json['bayiId']),
      bayiName: json['bayiName'] ?? "",
      city: json['city'] ?? "",
      status: json['status'] ?? "",
      customerCount: safeInt(json['customerCount']),
      appointmentCount: safeInt(json['appointmentCount']),
    );
  }
}
