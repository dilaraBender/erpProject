class CreateIncomeModel {
  int userId;
  int appointmentId;
  int paymentId;
  String incomeDate;
  double price;
  String description;
  String createdAt;

  CreateIncomeModel({
    required this.userId,
    required this.appointmentId,
    required this.paymentId,
    required this.incomeDate,
    required this.price,
    required this.description,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "appointmentId": appointmentId,
      "paymentId": paymentId,
      "incomeDate": incomeDate,
      "price": price,
      "description": description,
      "createdAt": createdAt,
    };
  }
}
