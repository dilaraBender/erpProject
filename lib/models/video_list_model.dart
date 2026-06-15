class VideoListModel {
  final int videoId;
  final String? title;
  final String? description;
  final int? duration;
  final String? url;
  final String? videoType;
  final DateTime? createdAt;
  final String? status;

  VideoListModel({
    required this.videoId,
    this.title,
    this.description,
    this.duration,
    this.url,
    this.videoType,
    this.createdAt,
    this.status,
  });

  factory VideoListModel.fromJson(Map<String, dynamic> json) {
    return VideoListModel(
      videoId: json['videoId'],
      title: json['title'],
      description: json['description'],
      duration: json['duration'],
      url: json['url'],
      videoType: json['videoType'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "videoId": videoId,
      if (title != null) "title": title,
      if (description != null) "description": description,
      if (duration != null) "duration": duration,
      if (url != null) "url": url,
      if (videoType != null) "videoType": videoType,
      if (createdAt != null) "createdAt": createdAt!.toIso8601String(),
      if (status != null) "status": status,
    };
  }
}
