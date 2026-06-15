class FinanceReportModel {
  final String title;
  final double amount;
  final String type;

  FinanceReportModel({
    required this.title,
    required this.amount,
    required this.type,
  });

  factory FinanceReportModel.fromJson(Map<String, dynamic> json) {
    return FinanceReportModel(
      title: json["title"] ?? "",
      amount: (json["amount"] ?? 0).toDouble(),
      type: json["type"] ?? "",
    );
  }
}
