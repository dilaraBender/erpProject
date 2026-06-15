import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/url.dart';

// Video ilerlemesini güncellemek için WebApi ile baglantı kurulan servis
class UpdateVideoProgressService {
  static Future<bool> updateVideoProgress({
    required int bayiId,
    required int videoId,
    required int watchedDuration,
    required int totalDuration,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
          "${ApiConfig.baseUrl}/UpdateVideoProgress/UpdateVideoProgress",
        ),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "bayiId": bayiId,
          "videoId": videoId,
          "watchedDuration": watchedDuration,
          "totalDuration": totalDuration,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Video ilerlemesi güncellenemedi: ${response.body}");
      }
    } catch (e) {
      rethrow;
    }
  }
}
