import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/url.dart';
import '../models/appointment_report_model.dart';

// Randevu raporlarını görmek için WebApi ile bağlantı kurduğumuz servis
class AppointmentReportService {
  static Future<List<AppointmentReportModel>> getReport() async {
    final response = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/AppointmentReport/AppointmentReport"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data.map((e) => AppointmentReportModel.fromJson(e)).toList();
    }

    throw Exception("Randevu raporu alınamadı: ${response.body}");
  }
}
