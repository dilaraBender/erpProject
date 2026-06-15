class CreateVideoModel {
  final String? title;
  final String? description;
  final int duration;
  final String? url;
  final String? videoType;
  final DateTime createdAt;
  final String status;

  CreateVideoModel({
    required this.title,
    required this.description,
    required this.duration,
    required this.url,
    required this.videoType,
    required this.createdAt,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "duration": duration,
      "url": url,
      "videoType": videoType,
      "createdAt": createdAt,
      "status": status,
    };
  }
}
