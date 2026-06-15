import 'package:flutter/material.dart';
import 'package:ornek/models/notification_model.dart';
import 'package:ornek/services/notification.dart';
import 'package:ornek/services/notifications_list.dart';

class NotificationController extends ChangeNotifier {
  List<NotificationModel> unread = [];
  List<NotificationModel> read = [];
  bool loading = false;

  Future<void> load(int userId) async {
    loading = true;
    notifyListeners();

    try {
      unread = await NotificationsListService.getUnread(userId);
      read = await NotificationsListService.getRead(userId);
    } catch (e) {
      unread = [];
      read = [];
    }

    loading = false;
    notifyListeners();
  }

  Future<void> markAsRead(int itemId, int userId) async {
    try {
      final success = await NotificationService.markAsRead(itemId);

      if (success) {
        await load(userId);
      }
    } catch (e) {
      debugPrint("markAsRead error: $e");
    }
  }
}
