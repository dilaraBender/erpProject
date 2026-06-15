import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/models/finance_report_mdoel.dart';
import 'package:ornek/url.dart';

// Finans raporlarını görmek için WebApi ile bağlantı kurduğumuz servis
class FinanceReportService {
  static Future<List<FinanceReportModel>> getFinanceReport() async {
    final response = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/FinanceReport/FinanceReport"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data.map((e) => FinanceReportModel.fromJson(e)).toList();
    }

    throw Exception("Finance report alınamadı: ${response.body}");
  }
}
