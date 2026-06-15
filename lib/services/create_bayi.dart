import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/url.dart';
import '../models/bayi_model.dart';

// Bayi oluşturmak için WebApi ile bağlantı kurduğumuz servis
class CreateBayiService {
  static Future<String?> createBayi(BayiModel bayi) async {
    final url = Uri.parse("${ApiConfig.baseUrl}/CreateBayi/CreateBayi");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "mail": bayi.mail,
        "name": bayi.name.split(" ").first,
        "lastName": bayi.lastName.split(" ").length > 1
            ? bayi.lastName.split(" ")[1]
            : "",
        "phone": bayi.phone ?? "",
        "status": "active",
        "role": "bayi",
        "title": bayi.title,
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["password"];
    } else {
      throw Exception("Bayi oluşturulamadı: ${response.body}");
    }
  }
}
