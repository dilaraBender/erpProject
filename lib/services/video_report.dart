import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/url.dart';
import '../models/video_report_model.dart';

// Video raporlarını görmek için WebApi ile bağlantı kurduğumuz servis
class VideoReportService {
  static Future<List<VideoReportModel>> getVideoReport() async {
    final response = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/VideoReport/VideoReport"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data.map((e) => VideoReportModel.fromJson(e)).toList();
    }

    throw Exception("Video report alınamadı: ${response.body}");
  }
}
