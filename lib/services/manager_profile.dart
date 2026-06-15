import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/models/manager_profile_model.dart';
import 'package:ornek/url.dart';

// Yöneticinin profil bilgilerini güncellemek için WebApi ile baglantı kurulan servis
class ManagerProfileService {
  static Future<ManagerProfileModel> fetchProfile(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/ManagerProfile/ManagerProfile/$userId'),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ManagerProfileModel.fromJson(data);
      } else {
        throw Exception('Profil bilgisi alınamadı: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Profil bilgilerini güncellemek için
  static Future<bool> updateProfile(ManagerProfileModel profile) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/UpdateManager/UpdateManager'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(profile.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Profil güncellenemedi: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
