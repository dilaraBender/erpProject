import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/url.dart';

// Randevu güncellemek için WebApi ile baglantı kurulan servis
class UpdateAppointmentService {
  static Future<bool> updateStatus({
    required int appointmentId,
    required String status,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
          "${ApiConfig.baseUrl}/UpdateStatusAppointment/UpdateStatusAppointment",
        ),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"appointmentId": appointmentId, "status": status}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Randevu durumu güncellenemedi: ${response.body}");
      }
    } catch (e) {
      rethrow;
    }
  }
}
