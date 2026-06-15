class RateAppointmentModel {
  final int appointmentId;
  final int rating;

  RateAppointmentModel({required this.appointmentId, required this.rating});

  Map<String, dynamic> toJson() {
    return {"appointmentId": appointmentId, "rating": rating};
  }
}
