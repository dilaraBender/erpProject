class DropDownCustomerModel {
  final int userId;
  final int customerId;
  final String fullName;

  DropDownCustomerModel({
    required this.userId,
    required this.customerId,
    required this.fullName,
  });
  factory DropDownCustomerModel.fromJson(Map<String, dynamic> json) {
    return DropDownCustomerModel(
      userId: json['userId'],
      customerId: json['customerId'],
      fullName: json['fullName'],
    );
  }
}
