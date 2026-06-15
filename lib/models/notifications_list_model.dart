class NotificationsListModel {
  final int? notId;
  final int? userId;
  final String? title;
  final String? body;

  NotificationsListModel({
    required this.notId,
    required this.userId,
    required this.title,
    required this.body,
  });

  Map<String, dynamic> toJson() {
    return {
      if (notId != null) "notId": notId,
      if (userId != null) "userId": userId,
      if (title != null) "title": title,
      if (body != null) "body": body,
    };
  }
}
