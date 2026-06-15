class FinanceIncome {
  final int? id;
  final int userId;
  final double price;
  final String description;
  final String incomeDate;
  final String createdAt;

  FinanceIncome({
    this.id,
    required this.userId,
    required this.price,
    required this.description,
    required this.incomeDate,
    required this.createdAt,
  });

  factory FinanceIncome.fromJson(Map<String, dynamic> json) => FinanceIncome(
    id: json['id'],
    userId: json['userId'],
    price: json['price'].toDouble(),
    description: json['description'] ?? '',
    incomeDate: json['date'],
    createdAt: json['createdAt'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'price': price,
    'description': description,
    'date': incomeDate,
    'createdAt': createdAt,
  };
}
