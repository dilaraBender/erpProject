import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/models/yesterday_appointment_model.dart';
import 'package:ornek/url.dart';

// Dünki randevuyu görmek için WebApi ile bağlantı kurduğumuz servis
class YesterdayAppointmentService {
  static Future<YesterdayAppointmentModel?> getYesterday() async {
    final response = await http.get(
      Uri.parse(
        "${ApiConfig.baseUrl}/YesterdayAppointment/YesterdayAppointment",
      ),
    );

    if (response.statusCode == 200) {
      if (response.body.isEmpty || response.body == "null") {
        return null;
      }

      return YesterdayAppointmentModel.fromJson(jsonDecode(response.body));
    }

    return null;
  }
}
