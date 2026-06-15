import 'package:flutter/material.dart';
import 'package:ornek/widgets/app_bar.dart';
import 'package:ornek/widgets/settings.dart';

// BayiSettings : bayi paneli için ayarlar görünümü
class BayiSettings extends StatefulWidget {
  final int userId;
  final int bayiId;
  const BayiSettings({super.key, required this.userId, required this.bayiId});

  @override
  State<BayiSettings> createState() => _BayiSettingsState();
}

class _BayiSettingsState extends State<BayiSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(userId: widget.userId),
      body: Settings(userId: widget.userId),
    );
  }
}
