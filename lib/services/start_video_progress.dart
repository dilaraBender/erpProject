import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/url.dart';

// eğitim videoları izlenmeye başlandıgını kaydeden webApi servis
class StartVideoProgressService {
  static Future<bool> startVideoProgress({
    required int bayiId,
    required int videoId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
          "${ApiConfig.baseUrl}/CreateVideoProgress/CreateVideoProgress",
        ),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"bayiId": bayiId, "videoId": videoId}),
      );

      if (response.statusCode == 200) {
        return true;
      }

      throw Exception("Start başarısız: ${response.body}");
    } catch (e) {
      rethrow;
    }
  }
}
