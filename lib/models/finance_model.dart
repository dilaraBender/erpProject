class FinanceModel {
  int id;
  double price;
  String description;
  DateTime date;
  String type;

  FinanceModel({
    required this.id,
    required this.type,
    required this.date,
    required this.price,
    required this.description,
  });
  factory FinanceModel.fromJson(Map<String, dynamic> json) {
    return FinanceModel(
      id: json['id'],
      type: json['type'] ?? "",
      price: (json['price'] as num).toDouble(),
      description: json['description'] ?? "",
      date: DateTime.parse(json["date"]),
    );
  }
}
