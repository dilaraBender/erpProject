// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/url.dart';

// bildirim oluşturmak için WebApi ile bağlantı kurduğumuz servis
class NotificationService {
  static Future<bool> createNotification({
    required int userId,
    required String title,
    required String body,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("${ApiConfig.baseUrl}/CreateNotification/CreateNotification"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"userId": userId, "title": title, "body": body}),
      );

      print("CREATE STATUS: ${response.statusCode}");

      print("CREATE BODY: ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print("CREATE ERROR: $e");
      return false;
    }
  }

  static Future<bool> markAsRead(int notId) async {
    try {
      final response = await http.post(
        Uri.parse("${ApiConfig.baseUrl}/UpdateNotification/UpdateNotification"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"notId": notId}),
      );

      print("READ STATUS: ${response.statusCode}");
      print("READ BODY: ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print("READ ERROR: $e");
      return false;
    }
  }
}
