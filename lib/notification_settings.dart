import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool isEnabled = false;

  @override
  void initState() {
    super.initState();
    loadStatus();
  }

  Future<void> loadStatus() async {
    final status = await Permission.notification.status;

    setState(() {
      isEnabled = status.isGranted;
    });
  }

  Future<void> toggleNotification(bool value) async {
    if (value) {
      await Permission.notification.request();
    } else {
      await openAppSettings();
    }

    loadStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bildirim Ayarları")),

      body: SwitchListTile(
        title: const Text("Bildirimler"),
        subtitle: Text(isEnabled ? "Bildirimler açık" : "Bildirimler kapalı"),
        value: isEnabled,
        onChanged: toggleNotification,
      ),
    );
  }
}
