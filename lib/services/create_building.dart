import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/models/building_model.dart';
import 'package:ornek/url.dart';

// Bina oluşturmak için WebApi ile baglantı kurulan servis
class CreateBuildingService {
  static Future<String> createBuilding(BuildingModel building) async {
    try {
      final url = Uri.parse(
        "${ApiConfig.baseUrl}/CreateBuilding/CreateBuilding",
      );
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(building.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      } else {
        throw Exception("Bina eklenemedi: ${response.body}");
      }
    } catch (e) {
      rethrow;
    }
  }
}
