import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/models/notification_model.dart';
import 'package:ornek/url.dart';

// Bildirimleri listelemek için WebApi ile bağlantı kurduğumuz servis
class NotificationsListService {
  static Future<List<NotificationModel>> getUnread(int userId) async {
    final response = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/GetNotifications/GetUnread/$userId"),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => NotificationModel.fromJson(e)).toList();
    } else {
      throw Exception("Okunmamış bildirimler alınamadı");
    }
  }

  static Future<List<NotificationModel>> getRead(int userId) async {
    final response = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/GetNotifications/GetRead/$userId"),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => NotificationModel.fromJson(e)).toList();
    } else {
      throw Exception("Okunmuş bildirimler alınamadı");
    }
  }
}
