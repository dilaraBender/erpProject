import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/models/bayi_filter_model.dart';
import 'package:ornek/models/bayi_model.dart';
import 'package:ornek/url.dart';

// Bayileri listelemek için WebApi ile bağlantı kurduğumuz servis
class BayiListService {
  static Future<List<BayiModel>> fetchBayiList(BayiFilter filter) async {
    final response = await http.post(
      Uri.parse("${ApiConfig.baseUrl}/BayiList/BayiList"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(filter.toJson()),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data.map((e) => BayiModel.fromJson(e)).toList();
    }

    throw Exception("Bayiler alınamadı: ${response.body}");
  }
}
