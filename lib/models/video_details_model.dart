class VideoDetailsModel {
  final int userId;
  final int bayiId;
  final int videoId;
  final String title;
  final int watchedDuration;
  final int totalDuration;
  final double completionRate;
  final bool isCompleted;

  VideoDetailsModel({
    required this.userId,
    required this.bayiId,
    required this.videoId,
    required this.title,
    required this.watchedDuration,
    required this.totalDuration,
    required this.completionRate,
    required this.isCompleted,
  });

  factory VideoDetailsModel.fromJson(Map<String, dynamic> json) {
    return VideoDetailsModel(
      userId: json['userId'],
      bayiId: json['bayiId'],
      videoId: json['videoId'],
      title: json['title'] ?? '',
      watchedDuration: json['watchedDuration'] ?? 0,
      totalDuration: json['totalDuration'] ?? 0,
      completionRate: (json['completionRate'] ?? 0).toDouble(),
      isCompleted: json['isCompleted'] ?? false,
    );
  }
}
