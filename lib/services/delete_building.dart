import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/url.dart';

// İlgili binayı silmek için WebApi ile baglantı kurulan servis
class DeleteBuildingService {
  static Future<String> deleteBuilding(int buildingId) async {
    try {
      final url = Uri.parse(
        "${ApiConfig.baseUrl}/DeleteBuilding/DeleteBuilding",
      );
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'BuildingId': buildingId}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body).toString();
      } else {
        throw Exception("Bina silinemedi: ${response.body}");
      }
    } catch (e) {
      rethrow;
    }
  }
}
