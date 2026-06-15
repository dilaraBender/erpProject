class ActiveAppointmentModel {
  final int appointmentId;
  final int bayiId;
  final int buildingId;

  final DateTime appointmentDate;
  final DateTime chatStart;
  final DateTime chatEnd;

  final bool canChat;

  ActiveAppointmentModel({
    required this.appointmentId,
    required this.bayiId,
    required this.buildingId,
    required this.appointmentDate,
    required this.chatStart,
    required this.chatEnd,
    required this.canChat,
  });

  factory ActiveAppointmentModel.fromJson(Map<String, dynamic> json) {
    return ActiveAppointmentModel(
      appointmentId: json["appointmentId"],
      bayiId: json["bayiId"],
      buildingId: json["buildingId"],
      appointmentDate: DateTime.parse(json["appointmentDate"]),
      chatStart: DateTime.parse(json["chatStart"]),
      chatEnd: DateTime.parse(json["chatEnd"]),
      canChat: json["canChat"],
    );
  }
}
