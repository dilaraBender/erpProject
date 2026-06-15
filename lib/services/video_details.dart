import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/models/video_details_model.dart';
import 'package:ornek/url.dart';

// ilgili video hakkında detayları göstermek için WebApi ile baglantı kurulan servis
class VideoDetailsService {
  static Future<List<VideoDetailsModel>> fetchVideoDetails({
    required int videoId,
    int? bayiId,
    bool? isCompleted,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("${ApiConfig.baseUrl}/VideoDetails/VideoDetails"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "videoId": videoId,
          "bayiId": bayiId,
          "isCompleted": isCompleted,
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => VideoDetailsModel.fromJson(e)).toList();
      } else {
        throw Exception('Videolar alınamadı: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
