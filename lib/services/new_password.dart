// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/url.dart';

// Yeni şifre oluşturmak için WebApi ile bağlantı kurduğumuz servis
class PasswordService {
  static Future<bool> changePassword(int userId, String newPassword) async {
    final url = Uri.parse("${ApiConfig.baseUrl}/NewPassword/NewPassword");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"userId": userId, "newPassword": newPassword}),
    );

    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");

    return response.statusCode == 200;
  }
}
