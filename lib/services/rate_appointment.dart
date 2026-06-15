import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/url.dart';
import '../models/rate_appointment_model.dart';

// Randevuyu değerlendirmek için WebApi ile bağlantı kurduğumuz servis
class RateAppointmentService {
  static Future<bool> rateAppointment(RateAppointmentModel model) async {
    final response = await http.post(
      Uri.parse("${ApiConfig.baseUrl}/RateAppointment/RateAppointment"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(model.toJson()),
    );

    return response.statusCode == 200;
  }
}
