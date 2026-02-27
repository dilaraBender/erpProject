import 'package:flutter/material.dart';
import 'package:ornek/widgets/app_bar.dart';
import 'package:ornek/widgets/settings.dart';

// ManagerSettings : yönetici paneli için ayarlar görünümü
class ManagerSettings extends StatefulWidget {
  const ManagerSettings({super.key});

  @override
  State<ManagerSettings> createState() => _ManagerSettingsState();
}

class _ManagerSettingsState extends State<ManagerSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: const AppBarWidget(), body: Settings());
  }
}
