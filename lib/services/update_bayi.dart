import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/models/bayi_model.dart';
import 'package:ornek/url.dart';

// Bayi bilgilerini güncellemek için WebApi ile bağlantı kurduğumuz servis
class UpdateBayiService {
  static Future<bool> updateBayi(BayiModel model) async {
    final response = await http.post(
      Uri.parse("${ApiConfig.baseUrl}/UpdateBayi/UpdateBayi"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    }

    throw Exception("Bayi güncellenemedi: ${response.body}");
  }
}
