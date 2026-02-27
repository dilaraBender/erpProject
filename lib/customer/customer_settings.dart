import 'package:flutter/material.dart';
import 'package:ornek/widgets/app_bar.dart';
import 'package:ornek/widgets/settings.dart';

// CustomerSettings : müşteri paneli için ayarlar görünümü
class CustomerSettings extends StatefulWidget {
  const CustomerSettings({super.key});

  @override
  State<CustomerSettings> createState() => _CustomerSettingsState();
}

class _CustomerSettingsState extends State<CustomerSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: const AppBarWidget(), body: Settings());
  }
}
