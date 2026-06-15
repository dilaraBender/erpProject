import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/models/video_list_model.dart';
import 'package:ornek/url.dart';

// Video listelemek için WebApi ile baglantı kurulan servis
class VideoListService {
  static Future<List<VideoListModel>> fetchVideos() async {
    try {
      final response = await http.get(
        Uri.parse("${ApiConfig.baseUrl}/VideoList/VideoList"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => VideoListModel.fromJson(e)).toList();
      } else {
        throw Exception('Videolar alınamadı: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
