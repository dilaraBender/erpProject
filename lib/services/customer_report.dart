import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/models/customer_report_model.dart';
import 'package:ornek/url.dart';

//Müşteri raporlarını görmek için WebApi ile bağlantı kurduğumuz servis
class CustomerReportService {
  static Future<List<CustomerReportModel>> getCustomerReport() async {
    final response = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/CustomerReport/CustomerReport"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data.map((e) => CustomerReportModel.fromJson(e)).toList();
    }

    throw Exception("Customer report alınamadı");
  }
}
