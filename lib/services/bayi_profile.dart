import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/models/bayi_model.dart';
import 'package:ornek/url.dart';

// İlgili bayi bilgilerini ve kişisel bilgilerini görmek için WebApi ile bağlantı kurduğumuz servis
class BayiProfileService {
  static Future<BayiModel> fetchProfile(int userId) async {
    final response = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/BayiProfile/BayiProfile/$userId"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return BayiModel.fromJson(jsonDecode(response.body));
    }

    throw Exception("Profil alınamadı: ${response.body}");
  }
}
