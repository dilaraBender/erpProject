class FinanceExpense {
  final int? id;
  final int userId;
  final double price;
  final String title;
  final String description;
  final String expenseDate;
  final String createdAt;

  FinanceExpense({
    this.id,
    required this.userId,
    required this.price,
    required this.title,
    required this.description,
    required this.expenseDate,
    required this.createdAt,
  });

  factory FinanceExpense.fromJson(Map<String, dynamic> json) => FinanceExpense(
    id: json['id'],
    userId: json['userId'],
    price: json['price'].toDouble(),
    title: json['title'] ?? '',
    description: json['description'] ?? '',
    expenseDate: json['date'],
    createdAt: json['createdAt'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'price': price,
    'title': title,
    'description': description,
    'date': expenseDate,
    'createdAt': createdAt,
  };
}
