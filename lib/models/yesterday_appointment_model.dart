class YesterdayAppointmentModel {
  final int appointmentId;
  final String customerName;
  final String? bayiName;

  YesterdayAppointmentModel({
    required this.appointmentId,
    required this.customerName,
    this.bayiName,
  });

  factory YesterdayAppointmentModel.fromJson(Map<String, dynamic> json) {
    return YesterdayAppointmentModel(
      appointmentId: json["appointmentId"],
      customerName: json["customerName"],
      bayiName: json["bayiName"],
    );
  }
}
