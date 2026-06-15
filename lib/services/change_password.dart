// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/models/change_password_model.dart';
import 'package:ornek/url.dart';

// Şifre değiştirme için kullanılan webApi servisi
class ChangePasswordService {
  static Future<bool> changePassword(ChangePasswordModel model) async {
    final url = Uri.parse("${ApiConfig.baseUrl}/ChangePassword/ChangePassword");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(model.toJson()),
    );

    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");

    if (response.statusCode != 200) {
      return false;
    }

    final data = jsonDecode(response.body);

    return data["result"] == true;
  }
}
