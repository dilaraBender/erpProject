import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/models/create_video_model.dart';
import 'package:ornek/url.dart';

// Video oluşturmak için WebApi ile baglantı kurulan servis
class CreateVideoService {
  static Future<bool> createVideo(CreateVideoModel video) async {
    try {
      final response = await http.post(
        Uri.parse("${ApiConfig.baseUrl}/CreateVideo/CreateVideo"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(video.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Video oluşturulamadı: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
