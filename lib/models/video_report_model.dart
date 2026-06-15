class VideoReportModel {
  final int videoId;
  final String title;
  final int views;
  final double avgCompletion;
  final int completedCount;

  VideoReportModel({
    required this.videoId,
    required this.title,
    required this.views,
    required this.avgCompletion,
    required this.completedCount,
  });

  factory VideoReportModel.fromJson(Map<String, dynamic> json) {
    return VideoReportModel(
      videoId: json["videoId"],
      title: json["title"] ?? "",
      views: json["views"] ?? 0,
      avgCompletion: (json["avgCompletion"] ?? 0).toDouble(),
      completedCount: json["completedCount"] ?? 0,
    );
  }
}
