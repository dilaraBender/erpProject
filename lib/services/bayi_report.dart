import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/models/bayi_report_model.dart';
import 'package:ornek/url.dart';

// Bayi raporlarını görmek için WebApi ile bağlantı kurduğumuz servis
class BayiReportService {
  static Future<List<BayiReportModel>> fetchReports() async {
    final response = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/BayiReport/BayiReport"),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data.map((e) => BayiReportModel.fromJson(e)).toList();
    }

    throw Exception("Bayi raporları alınamadı: ${response.body}");
  }
}
