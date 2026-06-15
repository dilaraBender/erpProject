import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/models/create_appointment_model.dart';
import 'package:ornek/url.dart';

// Randevu oluşturmak için WebApi ile baglantı kurulan servis
class CreateAppointmentService {
  static Future<bool> createAppointment(
    CreateAppointmentModel appointment,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("${ApiConfig.baseUrl}/CreateAppointment/CreateAppointment"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(appointment.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Randevu oluşturulamadı: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
