// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/url.dart';
import '../models/active_appointment_model.dart';

// Aktif randevuyu görmek için WebApi ile bağlantı kurduğumuz servis
class ActiveAppointmentService {
  static Future<ActiveAppointmentModel?> getActiveAppointment(
    int userId,
  ) async {
    try {
      final response = await http.get(
        Uri.parse(
          "${ApiConfig.baseUrl}/ActiveAppointments/ActiveAppointments?userId=$userId",
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ActiveAppointmentModel.fromJson(data);
      } else {
        print("API HATA: ${response.body}");
        return null;
      }
    } catch (e) {
      print("SERVİS HATA: $e");
      return null;
    }
  }
}
