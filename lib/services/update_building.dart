import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/models/building_model.dart';
import 'package:ornek/url.dart';

// Bina bilgilerini güncellemek için WebApi ile baglantı kurulan servis
class UpdateBuildingService {
  static Future<String> updateBuilding(BuildingModel building) async {
    try {
      final response = await http.post(
        Uri.parse("${ApiConfig.baseUrl}/UpdateBuilding/UpdateBuilding"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(building.toJson()),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body).toString();
      } else {
        throw Exception("Bina güncellenemedi: ${response.body}");
      }
    } catch (e) {
      rethrow;
    }
  }
}
