class NotificationModel {
  final int notId;
  final int userId;
  final String title;
  final String body;
  final bool isRead;
  final DateTime? createdAt;

  NotificationModel({
    required this.notId,
    required this.userId,
    required this.title,
    required this.body,
    required this.isRead,
    this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notId: json["notId"] ?? json["NotId"] ?? 0,
      userId: json["userId"] ?? json["UserId"] ?? 0,
      title: json["title"] ?? json["Title"] ?? "",
      body: json["body"] ?? json["Body"] ?? "",
      isRead:
          (json["isRead"] ?? json["IsRead"] ?? false) == true ||
          (json["isRead"] ?? json["IsRead"] ?? 0) == 1,
      createdAt: json["createdAt"] != null
          ? DateTime.parse(json["createdAt"])
          : json["CreatedAt"] != null
          ? DateTime.parse(json["CreatedAt"])
          : null,
    );
  }

  Map<String, dynamic> toJsonCreate() {
    return {"userId": userId, "title": title, "body": body};
  }
}
