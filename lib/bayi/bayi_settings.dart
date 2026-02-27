import 'package:flutter/material.dart';
import 'package:ornek/widgets/app_bar.dart';
import 'package:ornek/widgets/settings.dart';

// BayiSettings : bayi paneli için ayarlar görünümü
class BayiSettings extends StatefulWidget {
  const BayiSettings({super.key});

  @override
  State<BayiSettings> createState() => _BayiSettingsState();
}

class _BayiSettingsState extends State<BayiSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: const AppBarWidget(), body: Settings());
  }
}
