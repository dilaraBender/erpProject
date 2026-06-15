import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/url.dart';

// İlgili kullanıcıyı silmek için WebApi ile baglantı kurulan servis
class DeleteUserService {
  static Future<String> deleteUser(int userId) async {
    try {
      final url = Uri.parse("${ApiConfig.baseUrl}/DeleteUser/DeleteUser");
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'UserId': userId}),
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception("Kullanıcı silinemedi: ${response.body}");
      }
    } catch (e) {
      rethrow;
    }
  }
}
