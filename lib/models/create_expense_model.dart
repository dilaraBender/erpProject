class CreateExpenseModel {
  int userId;
  int paymentId;
  String title;
  String createdAt;
  double price;
  String description;
  String expenseDate;

  CreateExpenseModel({
    required this.userId,
    required this.paymentId,
    required this.title,
    required this.createdAt,
    required this.price,
    required this.description,
    required this.expenseDate,
  });

  Map<String, dynamic> toJson() {
    return {
      "bayiId": userId,
      "paymentId": paymentId,
      "title": title,
      "createdAt": createdAt,
      "price": price,
      "description": description,
      "expenseDate": expenseDate,
    };
  }
}
