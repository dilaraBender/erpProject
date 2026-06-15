import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/url.dart';

// Video kaydını silmek için WebApi ile baglantı kurulan servis
class DeleteVideoService {
  static Future<bool> deleteVideo({required int videoId}) async {
    try {
      final response = await http.post(
        Uri.parse("${ApiConfig.baseUrl}/DeleteVideo/DeleteVideo"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"videoId": videoId}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Video silinemedi: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
