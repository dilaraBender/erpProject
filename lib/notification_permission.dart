import 'package:permission_handler/permission_handler.dart';

class NotificationPermissionService {
  static Future<bool> isGranted() async {
    final status = await Permission.notification.status;

    return status.isGranted;
  }

  static Future<void> request() async {
    await Permission.notification.request();
  }

  static Future<void> openSettings() async {
    await openAppSettings();
  }
}
