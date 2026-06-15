import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/models/building_model.dart';
import 'package:ornek/url.dart';

// Müşterinin binalarının listelenmesi için WebApi ile baglantı kurulan servis
class BuildingListService {
  static Future<List<BuildingModel>> fetchBuildings(int userId) async {
    try {
      final response = await http.post(
        Uri.parse("${ApiConfig.baseUrl}/BuildingList/BuildingList"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'UserId': userId}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => BuildingModel.fromJson(e)).toList();
      } else {
        throw Exception("Binalar çekilemedi: ${response.body}");
      }
    } catch (e) {
      rethrow;
    }
  }
}
